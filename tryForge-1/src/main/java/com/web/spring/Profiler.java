package com.web.spring;

import java.io.IOException;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
@Aspect
@Component 
public class Profiler {
	@Around("execution(* com.web.spring..*.*(..))")
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
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("IOException 발생:"+e.getMessage());
		}catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("NumberFormatException 발생:"+e.getMessage());
		}
		catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("수행시 예외 발생:"+e.getMessage());
		}
		finally {
			long end = System.currentTimeMillis();
			System.out.println(signatureStr+"종료");
			System.out.println("수행 시간:"+(end-start)+"밀리 세컨드(millis)");
		}
		return obj;
	}
}
