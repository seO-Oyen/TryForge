package com.web.spring.file.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.spring.file.dao.UploadDao;
import com.web.spring.vo.FileStorage;


@Service
public class UploadService {
	@Autowired(required = false)
	private UploadDao dao;
	
@Value("${file.upload}")
private String path;
	
	public String uploadFile(FileStorage upload) {
		int chk = 0;
		String msg = "";
		MultipartFile[] mpfs = upload.getFiles();
		
		if(mpfs!=null && mpfs.length>0) {
			
			try {
				for(MultipartFile mpf:mpfs) {
				
					String originfname = mpf.getOriginalFilename(); // 이름추출
					String uniqueID = UUID.randomUUID().toString();
					String fname = originfname + "_" + uniqueID;

					String ftype = mpf.getContentType(); // image/jpeg 형식으로 추출
					long fsizeByte = mpf.getSize(); // 파일크기 추출(byte)
					
					// 확장자만 추출
					String extension = "";
					if(ftype!=null) {
						int idx = ftype.lastIndexOf('/'); // '/'의 순서 저장
						if(idx > 0) {
							extension = ftype.substring(idx + 1);
						}
					}
					
					
					double fsizeMB = (double)fsizeByte / (1024 * 1024); // byte --> mb
					
					String fsize; // 0.01보다 작으면 kb로 표현
					if(fsizeMB < 0.01) {
						double fsizeKB = (double)fsizeByte / 1024; // byte --> kb
						fsize = String.format("%.2f KB", fsizeKB);
					} else {
						fsize = String.format("%.2f MB", fsizeMB);
					}
					
					
					// File 경로 지정해서 MultipartFile에 담긴 파일 저장
					mpf.transferTo(new File(path+fname));
					chk += dao.uploadFile(new FileStorage(fname, path, extension, fsize, upload.getProject_key(), upload.getMember_key(), originfname));
				}
			} catch (IllegalStateException e) {
				System.out.println("#파일업로드 예외1:"+e.getMessage());
				msg+="#파일업로드 예외1:"+e.getMessage()+"\\n";
			} catch (IOException e) {
				System.out.println("#파일업로드 예외2:"+e.getMessage());
				msg+="#파일업로드 예외2:"+e.getMessage()+"\\n";
			} catch(Exception e) {
				System.out.println("#기타 예외3:"+e.getMessage());
				msg+="#기타 예외3:"+e.getMessage()+"\\n";
			}
		}
		msg = "파일 "+ chk+"건 등록 완료";
		return msg;
	}
}
