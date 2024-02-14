package com.web.spring;

import java.io.IOException;

import com.web.spring.admin.dao.AOPDao;
import com.web.spring.vo.AOP_Error;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
@Aspect
@Component 
public class Profiler {
	@Autowired(required = false)
	private AOPDao dao;

	@Around("execution(* com.web.spring.admin.service.*.*(..))")
	public Object trace(ProceedingJoinPoint jointPoint) {
		Object obj = null;
		// 1. 수행 정보 출력
		String signatureStr = jointPoint.getSignature().toShortString();
		System.out.println(signatureStr + "시작!");
		//	1) 처리하는 수행의 부하를 파악하는 시작/마지막 시간 check
		long start =System.currentTimeMillis();
		
		try {
			obj = jointPoint.proceed();
		} catch (NullPointerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("NullPointerException 발생:"+e.getMessage());
			// e.getStackTrace의 타입이 void 이기에 배열을 통해 받아 for 문으로 String 타입으로 변경
			StackTraceElement[] stackTrace = e.getStackTrace();

			String error_path ="";
			for(StackTraceElement element : stackTrace){
				error_path+= "class 경로["+element.getClassName()+"] // ";
				//error_path+= "method 경로["+element.getMethodName()+"] // ";
				//error_path+= "File 이름["+element.getFileName()+"] // ";
				error_path+= "라인 위치["+element.getLineNumber()+"]";
			}
			AOP_Error critical = new AOP_Error("NullPointerException",e.getMessage(),error_path);
			dao.insCriticalError(critical);

		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("IOException 발생:"+e.getMessage());
			StackTraceElement[] stackTrace = e.getStackTrace();
			String error_path ="";
			for(StackTraceElement element : stackTrace){
				error_path+= "class 경로["+element.getClassName()+"] // ";
				//error_path+= "method 경로["+element.getMethodName()+"] // ";
				//error_path+= "File 이름["+element.getFileName()+"] // ";
				error_path+= "라인 위치["+element.getLineNumber()+"]";
			}
			AOP_Error critical = new AOP_Error("IOException",e.getMessage(),error_path);
			dao.insCriticalError(critical);

		}catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("NumberFormatException 발생:"+e.getMessage());
			StackTraceElement[] stackTrace = e.getStackTrace();
			String error_path ="";
			for(StackTraceElement element : stackTrace){
				error_path+= "class 경로["+element.getClassName()+"] // ";
				//error_path+= "method 경로["+element.getMethodName()+"] // ";
				//error_path+= "File 이름["+element.getFileName()+"] // ";
				error_path+= "라인 위치["+element.getLineNumber()+"]";
			}
			AOP_Error critical = new AOP_Error("NumberFormatException",e.getMessage(),error_path);
			dao.insCriticalError(critical);
		}
		catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("수행시 예외 발생:"+e.getMessage());
			StackTraceElement[] stackTrace = e.getStackTrace();
			String error_path ="";
			for(StackTraceElement element : stackTrace){
				error_path+= "class 경로["+element.getClassName()+"] // ";
				//error_path+= "method 경로["+element.getMethodName()+"] // ";
				//error_path+= "File 이름["+element.getFileName()+"] // ";
				error_path+= "라인 위치["+element.getLineNumber()+"]";
			}
			AOP_Error normal = new AOP_Error("Exception",e.getMessage(),error_path);
			dao.insNormalError(normal);
		}
		finally {
			long end = System.currentTimeMillis();
			System.out.println(signatureStr+"종료");
			System.out.println("수행 시간:"+(end-start)+"밀리 세컨드(millis)");
		}
		return obj;
	}
}
