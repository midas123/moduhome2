package com.kh.Faq;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.Notice.NoticeService;
import com.kh.moduhome.CommandMap;


@Controller
public class FaqController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "faqService")
	private FaqService faqService;
	
	@Resource(name = "noticeService")
	private NoticeService noticeService;	
	
	//����Ʈ ���� ��Ʈ�ѷ� �ڵ�
	@RequestMapping(value="/faqList")
	public ModelAndView openFaqList(CommandMap commandMap) throws Exception {
		ModelAndView mv= new ModelAndView("faqList");
		
		List<Map<String,Object>> faqList = faqService.selectFaqList(commandMap.getMap());
		mv.addObject("faqList", faqList);
		System.out.println(faqList.get(1));
		
		List<Map<String,Object>> noticeList = noticeService.selectNoticeList(commandMap.getMap());
		mv.addObject("noticeList", noticeList);	
		
		return mv;
	}
	
	@RequestMapping(value="/admin/faqList")
	public ModelAndView adminOpenFaqList(CommandMap commandMap) throws Exception {
		ModelAndView mv= new ModelAndView("adminFaqList");
		
		List<Map<String,Object>> faqList = faqService.selectFaqList(commandMap.getMap());
		mv.addObject("faqList", faqList);
		System.out.println(faqList.get(1));
		
		List<Map<String,Object>> noticeList = noticeService.selectNoticeList(commandMap.getMap());
		mv.addObject("noticeList", noticeList);	
		
		return mv;
	}
	
	@RequestMapping(value="/faqWriteForm")
	public ModelAndView openFaqWrite(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("faqWriteForm");
		
		return mv;
	}
	
	@RequestMapping(value="/admin/faqWriteForm")
	public ModelAndView adminOpenFaqWrite(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("adminFaqWriteForm");
		
		return mv;
	}
	
	@RequestMapping(value="/faqWrite")
	public ModelAndView insertFaq(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/faqList");
		
		faqService.insertFaq(commandMap.getMap());
		
		return mv;
	}
	
	@RequestMapping(value="/admin/faqWrite")
	public ModelAndView adminInsertFaq(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("redirect:/admin/faqList");
		
		faqService.insertFaq(commandMap.getMap());
		
		return mv;
	}
	
	//�󼼺��� ���� ��Ʈ�ѷ� �ڵ�
	@RequestMapping(value="/faqDetail")
	public ModelAndView openFaqDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("faqDetail");
		
		Map<String, Object> map = faqService.selectFaqDetail(commandMap.getMap());
		mv.addObject("map", map);
		
		return mv;
	}
	
	@RequestMapping(value="/admin/faqDetail")
	public ModelAndView adminOpenFaqDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("adminFaqDetail");
		
		Map<String, Object> map = faqService.selectFaqDetail(commandMap.getMap());
		mv.addObject("map", map);
		
		return mv;
	}
	
	//�����ϱ� ���� ��Ʈ�ѷ� �ڵ�
	@RequestMapping(value="/faqModifyForm")
	public ModelAndView openFaqUpdate(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("faqModifyForm");
		
		Map<String, Object> map = faqService.selectFaqDetail(commandMap.getMap());
		mv.addObject("map",map);
		
		return mv;
	}
	
	@RequestMapping(value="/admin/faqModifyForm")
	public ModelAndView adminOpenFaqUpdate(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView("adminFaqModifyForm");
		
		Map<String, Object> map = faqService.selectFaqDetail(commandMap.getMap());
		mv.addObject("map",map);
		
		return mv;
	}
	
	@RequestMapping(value="/faqModify")
	public ModelAndView updateFaq(CommandMap commandMap) throws Exception {
		ModelAndView mv= new ModelAndView("redirect:/faqDetail");
		
		faqService.updateFaq(commandMap.getMap());
		
		mv.addObject("NOTICE_NUMBER", commandMap.get("NOTICE_NUMBER"));
		return mv;
	}
	
	@RequestMapping(value="/admin/faqModify")
	public ModelAndView adminUpdateFaq(CommandMap commandMap) throws Exception {
		ModelAndView mv= new ModelAndView("redirect:/admin/faqDetail");
		
		faqService.updateFaq(commandMap.getMap());
		
		mv.addObject("NOTICE_NUMBER", commandMap.get("NOTICE_NUMBER"));
		return mv;
	}
	
	@RequestMapping(value="/faqDelete")
	public ModelAndView deleteFaq(CommandMap commandMap) throws Exception {
		ModelAndView mv= new ModelAndView("redirect:/faqList");
		
		faqService.deleteFaq(commandMap.getMap());
		
		return mv;
	}
	
	@RequestMapping(value="/admin/faqDelete")
	public ModelAndView adminDeleteFaq(CommandMap commandMap) throws Exception {
		ModelAndView mv= new ModelAndView("redirect:/admin/faqList");
		
		faqService.deleteFaq(commandMap.getMap());
		
		return mv;
	}
	


}
