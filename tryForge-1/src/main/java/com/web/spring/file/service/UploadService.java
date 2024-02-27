package com.web.spring.file.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.web.spring.file.dao.UploadDao;
import com.web.spring.vo.FileStorage;

import jakarta.servlet.http.HttpSession;


@Service
public class UploadService {
	@Autowired(required = false)
	private UploadDao dao;
	
@Value("${file.upload}")
private String path;

	public List<String> uploadFile(FileStorage upload) {
		List<String> fileKeys = new ArrayList<>();
		MultipartFile[] mpfs = upload.getFiles();
		
		if(mpfs!=null && mpfs.length>0) {
			try {
				for(MultipartFile mpf:mpfs) {
					String fname = mpf.getOriginalFilename(); // 이름추출
					String ftype = mpf.getContentType(); // image/jpeg 형식 추출
					long fsizeByte = mpf.getSize(); // 파일크기 추출(byte)

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
					String fkey = "FILE-"+dao.getFileSeq();
					
					if (upload.getDescription().equals("프로필 사진")) {
						mpf.transferTo(new File(path+fkey + "." + extension));
					} else {
						mpf.transferTo(new File(path+fkey));
					}

					dao.uploadFile(new FileStorage(fkey, fname, path, extension, fsize,
							upload.getProject_key(), upload.getMember_key(), upload.getDescription()));

					fileKeys.add(fkey);
				}
			} catch (IllegalStateException e) {
				System.out.println("#파일업로드 예외1:"+e.getMessage());
			} catch (IOException e) {
				System.out.println("#파일업로드 예외2:"+e.getMessage());
			} catch(Exception e) {
				System.out.println("#기타 예외3:"+e.getMessage());
			}
		}
		return fileKeys;
	}
}
