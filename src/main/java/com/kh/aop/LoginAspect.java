package com.kh.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;


import com.kh.moduhome.CommandMap;


//로그인체크 AOP
@Repository("loginAspect")
public class LoginAspect {
	ModelAndView mav = new ModelAndView();
	   public Object trace(ProceedingJoinPoint joinPoint) throws Throwable {
		      System.out.println("Login AOP 시작 ");
		      HttpServletRequest request = null;
		      CommandMap map = new CommandMap();
		      for (Object o : joinPoint.getArgs()) {
		         if (o instanceof HttpServletRequest) {
				      System.out.println("request 맞음");
		        	 request = (HttpServletRequest) o;
		         }else if (o instanceof CommandMap){
		        	 map = (CommandMap)o;
		         }
		      }
		      if (request != null) {		    	  
		    	  String viewName = request.getRequestURI(); 
		    	  int SubInt = request.getContextPath().length();
		    	  viewName = viewName.substring(SubInt);
		    	  HttpSession session = request.getSession();
	              String idNumber = String.valueOf(session.getAttribute("MEMBER_NUMBER"));              
			      System.out.println("멤버넘버는 = " + idNumber);			    
		            if (idNumber == null || idNumber.equals("") || idNumber.equals("null")) {
		            	if(map.get("guestEmail") == null) {
		                //뷰네임 추출
		            		if(request.getQueryString() != null ) {
		            			//쿼리를 포함한다면
			    	    	viewName = viewName+"?"+request.getQueryString();
			    	    	System.out.println(viewName); 
			    	    }
		  		      System.out.println("Login안됌");
		  		      mav.addObject("viewName",viewName);
		  		      //요청 뷰네임 전송
		  		      mav.setViewName("loginForm");
		  		      System.out.println(mav.getViewName());
		              return mav;
		             } 
		            	System.out.println("비회원로그인됌");
		          }
				      System.out.println("로그인됌");
		         }
		      Object result = joinPoint.proceed();
		      return result;
		   }
		}

