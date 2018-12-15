package com.kh.adminQnA;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.moduhome.CommandMap;
import com.kh.paging.AdminQNAPaging;

@Controller
public class AdminQnaController {

	@Resource(name = "adminQnaService")
	private AdminQnaService adminQnaService;
	
	private int totalCount;
	private int searchNum;
	private Integer categoryNum;
	private Integer repState;
	
	private String isSearch;
	private int currentPage = 1;
	private int blockCount = 10;
	private int blockPage = 10;
	private String pagingHtml;
	private AdminQNAPaging page;
	
	// Q&A 목록
	@RequestMapping(value = "/qna/adminQnaList")
	public ModelAndView adminQnaList(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		if (request.getParameter("currentPage") == null || request.getParameter("currentPage").trim().isEmpty() 
				|| request.getParameter("currentPage").equals("0")) {
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		List<Map<String, Object>> adminQnaList = adminQnaService.qnaList(commandMap.getMap());
		totalCount = adminQnaList.size();
		
		isSearch = request.getParameter("isSearch");
		
		if (isSearch != null) {
			searchNum = Integer.parseInt(request.getParameter("searchNum").trim());
			isSearch = request.getParameter("isSearch");
			
			if (searchNum == 0) {
				commandMap.put("MEMBER_ID", isSearch);
				adminQnaList = adminQnaService.qnaSearchMemberList(commandMap.getMap());
				totalCount = adminQnaList.size();
			} else if (searchNum == 1) {
				commandMap.put("QNA_TITLE", isSearch);
				adminQnaList = adminQnaService.qnaSearchTitleList(commandMap.getMap());
				totalCount = adminQnaList.size();
			}
			
			page = new AdminQNAPaging(currentPage, totalCount, blockCount, blockPage, "adminQnaList", searchNum, isSearch);
			pagingHtml = page.getPagingHtml().toString();
			
			int lastCount = totalCount;
			
			if (page.getEndCount() < totalCount)
				lastCount = page.getEndCount() + 1;
			
			adminQnaList = adminQnaList.subList(page.getStartCount(), lastCount);
			
			mv.addObject("isSearch", isSearch);
			mv.addObject("searchNum", searchNum);
			mv.addObject("adminQnaList", adminQnaList);
			mv.addObject("totalCount", totalCount);
			mv.addObject("pagingHtml", pagingHtml);
			mv.addObject("currentPage", currentPage);
			mv.setViewName("qnaList");
			
			return mv;
		}
		
		try {
			categoryNum = Integer.parseInt(request.getParameter("categoryNum"));
			if (categoryNum != null) {
				if (categoryNum == 1) {
					commandMap.put("QNA_CATEGORY", "상품문의");
					adminQnaList = adminQnaService.qnaCategoryList(commandMap.getMap());
					totalCount = adminQnaList.size();
				} else if (categoryNum == 2) {
					commandMap.put("QNA_CATEGORY", "배송문의");
					adminQnaList = adminQnaService.qnaCategoryList(commandMap.getMap());
					totalCount = adminQnaList.size();
				} else if (categoryNum == 3) {
					commandMap.put("QNA_CATEGORY", "입금문의");
					adminQnaList = adminQnaService.qnaCategoryList(commandMap.getMap());
					totalCount = adminQnaList.size();
				} else if (categoryNum == 4) {
					commandMap.put("QNA_CATEGORY", "교환&반품 문의");
					adminQnaList = adminQnaService.qnaCategoryList(commandMap.getMap());
					totalCount = adminQnaList.size();
				} else if (categoryNum == 5) {
					commandMap.put("QNA_CATEGORY", "기타문의");
					adminQnaList = adminQnaService.qnaCategoryList(commandMap.getMap());
					totalCount = adminQnaList.size();
				}
				
				page = new AdminQNAPaging(currentPage, totalCount, blockCount, blockPage, "adminQnaList", categoryNum, request);
				pagingHtml = page.getPagingHtml().toString();
				
				int lastCount = totalCount;
				
				if (page.getEndCount() < totalCount)
					lastCount = page.getEndCount() + 1;
				
				adminQnaList = adminQnaList.subList(page.getStartCount(), lastCount);
				
				mv.addObject("categoryNum", categoryNum);
				mv.addObject("pagingHtml", pagingHtml);
				mv.addObject("currentPage", currentPage);
				mv.addObject("adminQnaList", adminQnaList);
				mv.addObject("totalCount", totalCount);
				mv.setViewName("qnaList");
				
				return mv;
			}
		} catch (Exception ex) {
			
		}
		
		try {
			repState = Integer.parseInt(request.getParameter("repState"));
			if (repState != null) {
				if (repState == 1) {
					commandMap.put("QNA_REPSTATE", "답변대기");
					adminQnaList = adminQnaService.qnaRepState(commandMap.getMap());
					totalCount = adminQnaList.size();
				} else if (repState == 2) {
					commandMap.put("QNA_REPSTATE", "답변완료");
					adminQnaList = adminQnaService.qnaRepState(commandMap.getMap());
					totalCount = adminQnaList.size();
				} else if (repState == 3) {
					commandMap.put("QNA_REPSTATE", "문의종료");
					adminQnaList = adminQnaService.qnaRepState(commandMap.getMap());
					totalCount = adminQnaList.size();
				}
			}
			
			page = new AdminQNAPaging(currentPage, totalCount, blockCount, blockPage, request, "adminQnaList", repState);
			pagingHtml = page.getPagingHtml().toString();
			
			int lastCount = totalCount;
			
			if (page.getEndCount() < totalCount)
				lastCount = page.getEndCount() + 1;
			
			adminQnaList = adminQnaList.subList(page.getStartCount(), lastCount);
			
			mv.addObject("repState", repState);
			mv.addObject("pagingHtml", pagingHtml);
			mv.addObject("currentPage", currentPage);
			mv.addObject("adminQnaList", adminQnaList);
			mv.addObject("totalCount", totalCount);
			mv.setViewName("qnaList");
			
			return mv;
		} catch (Exception ex) {
			
		}
		
		page = new AdminQNAPaging(currentPage, totalCount, blockCount, blockPage, "adminQnaList");
		pagingHtml = page.getPagingHtml().toString();
		
		int lastCount = totalCount;
		
		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;
		
		adminQnaList = adminQnaList.subList(page.getStartCount(), lastCount);
		
		mv.addObject("pagingHtml", pagingHtml);
		mv.addObject("currentPage", currentPage);
		mv.addObject("adminQnaList", adminQnaList);
		mv.addObject("totalCount", totalCount);
		mv.setViewName("qnaList");
		
		return mv;
	}
	
	// Q&A 상세보기
	@RequestMapping(value = "/qna/adminQnaDetail")
	public ModelAndView adminQnaDetail(CommandMap commandMap) throws Exception {
		ModelAndView mv = new ModelAndView();

		Map<String, Object> qnaDetail = adminQnaService.qnaDetail(commandMap.getMap());
		
		mv.addObject("qnaDetail", qnaDetail);
		mv.setViewName("qnaDetail");
		
		return mv;
	}
	
	// Q&A 답변달기 폼
	@RequestMapping(value = "/qna/adminQnaReplyForm")
	public ModelAndView adminQnaReplyForm(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		if (request.getParameter("QNA_NUMBER") != null) {
			Map<String, Object> qnaDetail = adminQnaService.qnaDetail(commandMap.getMap());
			mv.addObject("qnaDetail", qnaDetail);
		}
		mv.setViewName("qnaReply");
		return mv;
	}
	
	// Q&A 답변 달기
	@RequestMapping(value = "/qna/adminQnaReply")
	public ModelAndView adminQnaReply(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		adminQnaService.updateReplyStep(commandMap.getMap());
		mv.setViewName("redirect:/qna/adminQnaDetail?QNA_NUMBER=" + commandMap.get("QNA_NUMBER"));
		
		return mv;
	}
	
	// Q&A 관리자 강제 삭제
	@RequestMapping(value = "/qna/adminQnaDelete")
	public ModelAndView adminQnaDelete(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		String filePath ="C:\\Users\\Youheejae\\eclipse-workspace\\MODA\\src\\main\\webapp\\file\\qnaFile\\";
		String image1 = null;
		
		if (request.getParameter("QNA_IMAGE1") != null) {
			image1 = request.getParameter("QNA_IMAGE1");
			
			File imageFile1= new File(filePath + image1);
			
			if (imageFile1.isFile()) {
				imageFile1.delete();
			}
		}
		
		adminQnaService.adminQnaDelete(commandMap.getMap());
		mv.setViewName("redirect:/qna/adminQnaList");
		
		return mv;
	}
	
	// Q&A 답변 삭제
	@RequestMapping(value = "/qna/adminQnaReplyDelete")
	public ModelAndView adminQnaReplyDelete(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		adminQnaService.qnaReplyDelete(commandMap.getMap());
		mv.setViewName("redirect:/qna/adminQnaDetail?QNA_NUMBER=" + commandMap.get("QNA_NUMBER"));
		
		return mv;
	}
}