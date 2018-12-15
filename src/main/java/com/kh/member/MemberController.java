package com.kh.member;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kh.moduhome.CommandMap;

@Controller
public class MemberController {
       
	@Resource(name="memberService")
	private MemberService memberService;
	
	/*회원본인인증폼*/
	@RequestMapping(value="/MemberAuthForm") 
	public ModelAndView MemberAuthForm(HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();		
		String MEMBER_NUMBER = session.getAttribute("MEMBER_NUMBER").toString();
		
		mv.addObject("MEMBER_NUMBER", MEMBER_NUMBER);
		mv.setViewName("MemberAuthForm");
		return mv;	
   }
	
	/*인증확인*/
	@RequestMapping(value="/AuthConfirm",method=RequestMethod.POST) 
	public ModelAndView AuthConfirm(HttpSession session,CommandMap Map) throws Exception{
		ModelAndView mv = new ModelAndView();		
		String MEMBER_ID = Map.get("MEMBER_ID").toString();
		
		String check = memberService.checkPassword(Map.getMap());
		
		mv.addObject("MEMBER_ID",MEMBER_ID);
		mv.addObject("check",check);
		mv.setViewName("AuthConfirm");
		return mv;
	 }
	/*회원정보수정폼*/
	@RequestMapping(value="memModify")
	public ModelAndView memModify(HttpSession session)throws Exception{
	   ModelAndView mv = new ModelAndView();	
	   String MEMBER_NUMBER = session.getAttribute("MEMBER_NUMBER").toString();
	   
	    Map<String, Object> member = new HashMap<String,Object>();
	    System.out.println("프로필 사진 : "+member.get("STORED_FILE_NAME"));
	    member = memberService.memberInfo(MEMBER_NUMBER);
	    mv.addObject("MEMBER_ID",member.get("MEMBER_ID"));
	    mv.addObject("member",member);
	    mv.setViewName("memModify");
	    
	    return mv;
	}
	/*회원정보수정기능*/
	@RequestMapping(value="/ModifyMemComplete", method=RequestMethod.POST) //step2사용자 회원가입의 폼의 데이터를 받아서 처리 
	public ModelAndView updateMemComplete(CommandMap commandMap, HttpServletRequest request) throws Exception{
		ModelAndView mv = new ModelAndView();		
		Map<String, Object> memberMap=new HashMap<String, Object>();
		memberMap=commandMap.getMap();
		
		memberService.ModifyMember(memberMap, request);
		System.out.print("개인정보수정 DB");
		mv.setViewName("ModifyComplete");
		return mv;
		
	}
	
	/*본인인증폼*/
	@RequestMapping(value="/MemberdeleteForm") 
	public ModelAndView MemberdeleteForm(HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();		
		mv.setViewName("MemberdeleteForm");
		return mv;
	
   }
	/*회원탈퇴확인*/
	@RequestMapping(value="/memDeleteConfirm",method=RequestMethod.POST) 
	public ModelAndView memDeleteConfirm(HttpSession session,CommandMap Map) throws Exception{
		ModelAndView mv = new ModelAndView();		
		String MEMBER_ID = Map.get("MEMBER_ID").toString();
		String MEMBER_PASSWORD = Map.get("MEMBER_PASSWORD").toString();
		
		String check = memberService.checkPassword(Map.getMap());
		
		mv.addObject("MEMBER_ID",MEMBER_ID);
		mv.addObject("check",check);
		mv.setViewName("MemberdeleteConfirm");
		return mv;
	 }
	
	/*회원탈퇴기능*/
	@RequestMapping(value="/MemberDelete") 
	public ModelAndView MemberDelete(HttpSession session) throws Exception{
		ModelAndView mv = new ModelAndView();		
		System.out.println("회원탈퇴 콘트롤러?");
		String MEMBER_NUMBER = session.getAttribute("MEMBER_NUMBER").toString();
		System.out.println("멤버넘버 : "+MEMBER_NUMBER);
	    memberService.deleteMember(MEMBER_NUMBER);
	    if (session != null) {
	         session.invalidate();
	    }
	    mv.setViewName("MemberdeleteSuc");
		return mv;
	
   }
}
	
