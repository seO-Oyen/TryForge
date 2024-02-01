package com.web.spring.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component("downloadViewer")
public class DownloadViewer extends AbstractView {
	@Value("${file.upload}")
	private String path;
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest req, HttpServletResponse res)
			throws Exception {
//		Controller 단에서 모델명으로 전달한 파일명 가져오기
		String fileName = (String)model.get("downloadFile");
		File file = new File(path+fileName);

		String originFileName = (String)model.get("originFileName");
		originFileName = URLEncoder.encode(originFileName, "utf-8").replaceAll("\\+"," ");
//		파일전송용 contentType
		res.setContentType("application/download;charset=utf-8");
//		파일 길이 설정
		res.setContentLengthLong(file.length());

//		파일명 지정(Content-Disposition),
		res.setHeader("Content-Disposition", "attachment;filename=\""+originFileName+"\"");
//		binary 데이터 처리(Content-Transfer_Encoding)
		res.setHeader("Content-Transfer-Encoding", "binary");
//		파일을 FileInputStream에 탑제
		FileInputStream fis = new FileInputStream(file);

//		FileInputStream(파일저장)을 OutputStream(전송)으로 복사
		OutputStream out = res.getOutputStream();
		FileCopyUtils.copy(fis, out);

//		response의 buffer를 flush
		out.flush();
//		outputstream 자원해제/fileinputstream 자원해제
		out.close();
		fis.close();
	}
}
