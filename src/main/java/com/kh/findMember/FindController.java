package com.kh.findMember;

import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.moduhome.CommandMap;

@Controller
public class FindController {
	
	@Resource(name="findService")
	private FindService findService;
	
	
	
	//아이디,비밀번호찾기로 이동
	@RequestMapping(value="/login/findForm")
	public ModelAndView findForm(){
		ModelAndView mv = new ModelAndView("findForm");
		return mv;
	}
	
	
	//아이디 찾기 로직
	@RequestMapping(value="/login/findID", method=RequestMethod.POST)
	public ModelAndView findID(HttpServletResponse response, HttpServletRequest request, CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("findForm");
		mv.addObject("state", "id");
		
		String MEMBER_NAME = (String) commandMap.getMap().get("MEMBER_NAME");
		String MEMBER_EMAIL = (String) commandMap.getMap().get("MEMBER_EMAIL");	
		
		
    	String findID = findService.findID(commandMap.getMap());
		if (findID == null) {
			mv.addObject("message", "입력하신 정보와 일치하는 ID가 없습니다.");
			return mv;
		} 
		else {
			mv.addObject("message", "찾은 ID : <strong>"+findID+"</strong>");
			return mv;
		}
    	
	}
	
	//비밀번호 찾기 로직
	@RequestMapping(value="/login/findPW", method=RequestMethod.POST)
	public ModelAndView findPW(HttpServletResponse response, HttpServletRequest request, CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("findForm");
		mv.addObject("state", "pw");
		
		String MEMBER_ID = (String) commandMap.getMap().get("MEMBER_ID");	
		String MEMBER_NAME = (String) commandMap.getMap().get("MEMBER_NAME");
		String MEMBER_EMAIL = (String) commandMap.getMap().get("MEMBER_EMAIL");	
		
		
    	String findPW = findService.findPW(commandMap.getMap());
    	if (findPW == null) {
			mv.addObject("message", "입력하신 정보와 일치하는 PW가 없습니다.");
			return mv;
		} 
    	else {
			mv.addObject("message", "찾은 PW : <strong>"+findPW+"</strong>");
			return mv;
		}
    	
	}	
	
	//아이디,비민번호찾기 로직
    @RequestMapping(value="/login/find")
    public @ResponseBody String clickMethod(HttpServletResponse response, HttpServletRequest request, CommandMap map) throws Exception   {
    	String idemail = (String) map.getMap().get("idemail");
    	String idname = (String) map.getMap().get("idname");
    	String pwname = (String) map.getMap().get("pwname");
    	String check_find = (String) map.getMap().get("check_find");
    	String pwemail = (String) map.getMap().get("pwemail");
    	String mid = (String) map.getMap().get("mid");
    	String authNUm ="";
    	String str ="";
    	
    	System.out.println("id?��?�� : "+idname+" pw?��?�� :" + pwname + "id?��메일 :"+idemail +" pwemail"+pwemail+" check_find :" +check_find +" ?��?��?�� : "+mid);
    	
    	
    	if(check_find.equals("i")){
    		System.out.println("?��?��?�� 찾기 ?��?��");
        	map.getMap().put("MEMBER_EMAIL_FIND", idemail);
        	map.getMap().put("MEMBER_NAME", idname);
        	
        	//String findId = findService.findId(map.getMap());
        	
        	//System.out.println("findId="+findId);
        	
        	
           // return findId;
    	}
		return str;
    }
    
	private void sendPwEmail(String email,String authNum){
		String host ="smtp.gmail.com";
		String subject = "MODA ?���? 번호 ?��?��";
		String fromName ="MODA �?리자";
		String from="khiclass@gmail.com";//보내?��메일
		String to1 = email;
		
		String content = "초기?�� ?�� 비�?번호 [" + authNum +"]";
		
		try{
			Properties props = new Properties();
			
			props.put("mail.smtp,starttls.enable","true");
			props.put("mail.transport.protocol", "smtp");
			props.put("mail.smtp.host",host);
			props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			
			props.put("mail.smtp.port", "465");
			props.put("mail.smtp.user", from);
			props.put("mail.smtp.auth", "true");
			
			Session mailSession = Session.getInstance(props,new javax.mail.Authenticator(){
					@Override
					protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication("khiclass@gmail.com","khacademy");
			}
			});
			
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from,MimeUtility.encodeText(fromName,"UTF-8","B"))); //보내?��?��?��?��?��
			
			InternetAddress[] address1 = {new InternetAddress(to1)};
			
			msg.setRecipients(Message.RecipientType.TO, address1); //받는?��?��?��?��1
			msg.setSubject(subject); //?��목설?��
			msg.setSentDate(new java.util.Date()); //보내?�� ?��짜설?��
			msg.setContent(content,"text/html;charset=utf-8"); //?��?��?��?��
			
			Transport.send(msg);
		}catch (MessagingException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
			
		}
	}
	
	
	public String RandomNum(){
		StringBuffer buffer = new StringBuffer();
		for(int i = 0;i<=6;i++){
			int n= (int)(Math.random() * 10);
			buffer.append(n);
		}
		return buffer.toString();
	}
	
}
