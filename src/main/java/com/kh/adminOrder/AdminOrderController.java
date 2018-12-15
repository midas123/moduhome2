package com.kh.adminOrder;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.adminGoods.AdminGoodsService;
import com.kh.moduhome.CommandMap;
import com.kh.paging.Paging;

@Controller
public class AdminOrderController {

	@Resource(name = "adminGoodsService")
	private AdminGoodsService adminGoodsService;

	@Resource(name = "adminOrderService")
	private AdminOrderService adminOrderService;

	// 페이징 변수
	private int searchNum;
	private String isSearch;

	private int currentPage = 1;
	private int totalCount;
	private int blockCount = 20;
	private int blockPage = 10;
	private String pagingHtml;
	private Paging page;

	// 주문 리스트
	@RequestMapping(value = "/admin/orderList")
	public ModelAndView orderList(CommandMap commandMap, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("adminOrderList");

		if (request.getParameter("currentPage") == null || request.getParameter("currentPage").trim().isEmpty()
				|| request.getParameter("currentPage").equals("0")
				|| request.getParameter("currentPage").equals("null")) {
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}

		List<Map<String, Object>> orderList = adminOrderService.allOrderList(commandMap.getMap());

		Map<String, Object> isSearchMap;

		if (request.getParameterMap().get("isSearch") != null && request.getParameterMap().get("isSearch") != "") {
			System.out.println("서치페이징");
			isSearch = request.getParameter("isSearch");
			isSearchMap = new HashMap<String, Object>();
			searchNum = Integer.parseInt(request.getParameter("searchNum"));
			isSearchMap.put("isSearch", isSearch);

			if (searchNum == 1)// 결제상태 검색
				orderList = adminOrderService.adminOrderSearch0(isSearchMap);
			else if (searchNum == 2)// 상품주문상태 검색
				orderList = adminOrderService.adminOrderSearch1(isSearchMap);
			else if (searchNum == 3)// 배송상태
				orderList = adminOrderService.adminOrderSearch2(isSearchMap);
			else if (searchNum == 4)// 주문코드
				orderList = adminOrderService.adminOrderSearch3(isSearchMap);
			else if (searchNum == 5)// 상품명
				orderList = adminOrderService.adminOrderSearch4(isSearchMap);
			else if (searchNum == 6)// 회원
				orderList = adminOrderService.adminOrderSearch5(isSearchMap);
			else if (searchNum == 7)// 브랜드
				orderList = adminOrderService.adminOrderSearch6(isSearchMap);
			else
				orderList = adminOrderService.allOrderList(commandMap.getMap());

			totalCount = orderList.size();
			page = new Paging(currentPage, totalCount, blockCount, blockPage, "orderList", searchNum, isSearch);
			pagingHtml = page.getPagingHtml().toString();

			int lastCount = totalCount;

			if (page.getEndCount() < totalCount)
				lastCount = page.getEndCount() + 1;

			orderList = orderList.subList(page.getStartCount(), lastCount);

			mv.addObject("isSearch", isSearch);
			mv.addObject("searchNum", searchNum);
			mv.addObject("totalCount", totalCount);
			mv.addObject("pagingHtml", pagingHtml);
			mv.addObject("currentPage", currentPage);
			mv.addObject("orderList", orderList);
			mv.setViewName("adminOrderList");
			return mv;
		}

		totalCount = orderList.size();
		page = new Paging(currentPage, totalCount, blockCount, blockPage, "orderList");
		pagingHtml = page.getPagingHtml().toString();

		int lastCount = totalCount;

		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		orderList = orderList.subList(page.getStartCount(), lastCount);

		mv.addObject("totalCount", totalCount);
		mv.addObject("pagingHtml", pagingHtml);
		mv.addObject("currentPage", currentPage);
		mv.addObject("orderList", orderList);

		return mv;
	}

	// 주문상태 변경
	@RequestMapping(value = "/admin/orderStateModify")
	public ModelAndView orderListModify(CommandMap commandMap, HttpServletRequest request) throws Exception {
		System.out.println("commandMap : " + commandMap.getMap());

		ModelAndView mv = new ModelAndView();

		Map<String, Object> stateMap = new HashMap<String, Object>();

		String path;

		if (commandMap.get("currentPage") == null) {
			if (commandMap.get("isSearch") != null && !commandMap.get("isSearch").equals("null")
					&& commandMap.get("isSearch") != "") {
				if (commandMap.get("cancel") != null) {
					path = "/admin/cancelList?currentPage=1&isSearch=" + commandMap.get("isSearch") + "&searchNum="
							+ commandMap.get("searchNum");
				} else if (commandMap.get("exchange") != null) {
					path = "/admin/exchangeList?currentPage=1&isSearch=" + commandMap.get("isSearch") + "&searchNum="
							+ commandMap.get("searchNum");
				} else {
					path = "orderList?currentPage=1&isSearch=" + commandMap.get("isSearch") + "&searchNum="
							+ commandMap.get("searchNum");
				}
			} else {
				path = "orderList?currentPage=1";
			}
		} else {
			if (commandMap.get("isSearch") != null && !commandMap.get("isSearch").equals("null")
					&& commandMap.get("isSearch") != "") {
				if (commandMap.get("cancel") != null) {
					path = "/admin/cancelList?currentPage=" + commandMap.get("currentPage") + "&isSearch="
							+ commandMap.get("isSearch").toString() + "&searchNum="
							+ commandMap.get("searchNum").toString();
				} else if (commandMap.get("exchange") != null) {
					path = "/admin/exchangeList?currentPage=" + commandMap.get("currentPage") + "&isSearch="
							+ commandMap.get("isSearch").toString() + "&searchNum="
							+ commandMap.get("searchNum").toString();
				} else {
					path = "orderList?currentPage=" + commandMap.get("currentPage") + "&isSearch="
							+ commandMap.get("isSearch").toString() + "&searchNum="
							+ commandMap.get("searchNum").toString();
				}
			} else {
				if (commandMap.get("cancel") != null) {
					path = "/admin/cancelList?currentPage=" + commandMap.get("currentPage");
				} else if (commandMap.get("exchange") != null) {
					path = "/admin/exchangeList?currentPage=" + commandMap.get("currentPage");
				} else {
					path = "orderList?currentPage=" + commandMap.get("currentPage");
				}
			}
		}

		if (commandMap.get("ORDER_PAY_STATE") != null) {

			String a = (String) commandMap.get("ORDER_CODE");
			String b = (String) commandMap.getMap().get("ORDER_PAY_STATE");

			stateMap.put("ORDER_PAY_STATE", b);
			stateMap.put("ORDER_CODE", a);
			adminOrderService.updateGoodsPayState(stateMap);

			if (stateMap.get("ORDER_PAY_STATE").equals("결제대기")) {
				stateMap.put("ORDER_DELIVERY_STATE", "결제대기");
			} else {
				stateMap.put("ORDER_DELIVERY_STATE", "배송준비중");
			}
			adminOrderService.updateDeliveryState(stateMap);
		} else if (commandMap.get("ORDER_DELIVERY_STATE") != null) {

			String a = (String) commandMap.get("ORDER_CODE");
			String b = (String) commandMap.getMap().get("ORDER_DELIVERY_STATE");

			stateMap.put("ORDER_DELIVERY_STATE", b);
			stateMap.put("ORDER_CODE", a);
			adminOrderService.updateDeliveryState(stateMap);
		} else if (commandMap.get("ORDER_STATE") != null) {

			String a = (String) commandMap.get("ORDER_CODE");
			String b = (String) commandMap.getMap().get("ORDER_STATE");
			stateMap.put("ORDER_CODE", a);
			stateMap.put("ORDER_STATE", b);

			List<Map<String, Object>> cancelComplete = new ArrayList<Map<String, Object>>();
			cancelComplete = adminOrderService.orderDetail(stateMap);

			for (int i = 0; i < cancelComplete.size(); i++) {
				adminGoodsService.addAmount(cancelComplete.get(i));
			}

			adminOrderService.updateGoodsState(stateMap);
		}

		mv.setViewName("redirect:" + path);
		return mv;
	}

	// 주문 상세보기
	@RequestMapping(value = "/admin/orderDetail")
	public ModelAndView orderDetail(CommandMap commandMap, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView();
		List<Map<String, Object>> orderDetail = new ArrayList<Map<String, Object>>();

		orderDetail = adminOrderService.orderDetail(commandMap.getMap());
		mv.addObject("orderDetail", orderDetail);
		mv.addObject("size", orderDetail.size());
		mv.addObject("orderBasic", orderDetail.get(0));

		Map<String, Object> confirmCancel = new HashMap<String, Object>();
		confirmCancel = adminOrderService.confirmCancel(commandMap.getMap());
		if (confirmCancel != null) {
			mv.addObject("orderCancel", confirmCancel);
		}

		mv.setViewName("adminOrderDetail");
		return mv;
	}

	// 주문 삭제
	@RequestMapping(value = "/admin/orderDelete")
	public ModelAndView adminOrderDelete(CommandMap commandMap) throws Exception {

		ModelAndView mv = new ModelAndView("redirect:orderList");

		adminOrderService.orderDelete(commandMap.getMap());

		return mv;
	}

	// 주문취소 목록
	@RequestMapping(value = "/admin/cancelList")
	public ModelAndView allCancelList(CommandMap commandMap, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("adminCancelList");

		if (request.getParameter("currentPage") == null || request.getParameter("currentPage").trim().isEmpty()
				|| request.getParameter("currentPage").equals("0")
				|| request.getParameter("currentPage").equals("null")) {
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}

		List<Map<String, Object>> cancelList = adminOrderService.allCancelList(commandMap.getMap());

		Map<String, Object> isSearchMap;

		if (request.getParameterMap().get("isSearch") != null && request.getParameterMap().get("isSearch") != "") {

			isSearch = request.getParameter("isSearch");
			isSearchMap = new HashMap<String, Object>();
			searchNum = Integer.parseInt(request.getParameter("searchNum"));
			isSearchMap.put("isSearch", isSearch);

			System.out.println("isSearch : " + isSearchMap);
			if (searchNum == 1)// 결제상태 검색
				cancelList = adminOrderService.allCancelSearch1(isSearchMap);
			else if (searchNum == 2)// 상품주문상태 검색
				cancelList = adminOrderService.allCancelSearch2(isSearchMap);
			else if (searchNum == 3)// 배송상태
				cancelList = adminOrderService.allCancelSearch3(isSearchMap);
			else if (searchNum == 4)// 주문코드
				cancelList = adminOrderService.allCancelSearch4(isSearchMap);
			else if (searchNum == 5)// 브랜드이름
				cancelList = adminOrderService.allCancelSearch5(isSearchMap);
			else
				cancelList = adminOrderService.allCancelList(commandMap.getMap());

			totalCount = cancelList.size();
			page = new Paging(currentPage, totalCount, blockCount, blockPage, "cancelList", searchNum, isSearch);
			pagingHtml = page.getPagingHtml().toString();

			int lastCount = totalCount;

			if (page.getEndCount() < totalCount)
				lastCount = page.getEndCount() + 1;

			cancelList = cancelList.subList(page.getStartCount(), lastCount);

			mv.addObject("isSearch", isSearch);
			mv.addObject("searchNum", searchNum);
			mv.addObject("totalCount", totalCount);
			mv.addObject("pagingHtml", pagingHtml);
			mv.addObject("currentPage", currentPage);
			mv.addObject("cancelList", cancelList);
			mv.setViewName("adminCancelList");
			return mv;
		}

		totalCount = cancelList.size();
		page = new Paging(currentPage, totalCount, blockCount, blockPage, "cancelList", searchNum, isSearch);
		pagingHtml = page.getPagingHtml().toString();

		int lastCount = totalCount;

		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		cancelList = cancelList.subList(page.getStartCount(), lastCount);

		mv.addObject("totalCount", totalCount);
		mv.addObject("pagingHtml", pagingHtml);
		mv.addObject("currentPage", currentPage);

		mv.addObject("cancelList", cancelList);

		return mv;
	}

	// 교환,반품 신청 목록
	@RequestMapping(value = "/admin/exchangeList")
	public ModelAndView allExchangeList(CommandMap commandMap, HttpServletRequest request) throws Exception {

		ModelAndView mv = new ModelAndView("adminChangeOrderList");

		if (request.getParameter("currentPage") == null || request.getParameter("currentPage").trim().isEmpty()
				|| request.getParameter("currentPage").equals("0")
				|| request.getParameter("currentPage").equals("null")) {
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}

		List<Map<String, Object>> exchangeList = adminOrderService.allExchangeList(commandMap.getMap());

		Map<String, Object> isSearchMap;

		if (request.getParameterMap().get("isSearch") != null && request.getParameterMap().get("isSearch") != "") {

			isSearch = request.getParameter("isSearch");
			isSearchMap = new HashMap<String, Object>();
			searchNum = Integer.parseInt(request.getParameter("searchNum"));
			isSearchMap.put("isSearch", isSearch);

			if (searchNum == 1)// 결제상태 검색
				exchangeList = adminOrderService.allExchangeSearch1(isSearchMap);
			else if (searchNum == 2)// 상품주문상태 검색
				exchangeList = adminOrderService.allExchangeSearch2(isSearchMap);
			else if (searchNum == 3)// 배송상태
				exchangeList = adminOrderService.allExchangeSearch3(isSearchMap);
			else if (searchNum == 4)// 주문코드
				exchangeList = adminOrderService.allExchangeSearch4(isSearchMap);
			else if (searchNum == 5)// 상품명
				exchangeList = adminOrderService.allExchangeSearch5(isSearchMap);
			else if (searchNum == 6)// 브랜드명
				exchangeList = adminOrderService.allExchangeSearch6(isSearchMap);

			totalCount = exchangeList.size();
			page = new Paging(currentPage, totalCount, blockCount, blockPage, "exchangeList", searchNum, isSearch);
			pagingHtml = page.getPagingHtml().toString();

			int lastCount = totalCount;

			if (page.getEndCount() < totalCount)
				lastCount = page.getEndCount() + 1;

			exchangeList = exchangeList.subList(page.getStartCount(), lastCount);

			mv.addObject("isSearch", isSearch);
			mv.addObject("searchNum", searchNum);
			mv.addObject("totalCount", totalCount);
			mv.addObject("pagingHtml", pagingHtml);
			mv.addObject("currentPage", currentPage);
			mv.addObject("exchangeList", exchangeList);
			mv.setViewName("adminChangeOrderList");
			return mv;
		}

		totalCount = exchangeList.size();
		page = new Paging(currentPage, totalCount, blockCount, blockPage, "exchangeList", searchNum, isSearch);
		pagingHtml = page.getPagingHtml().toString();

		int lastCount = totalCount;

		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		exchangeList = exchangeList.subList(page.getStartCount(), lastCount);

		mv.addObject("totalCount", totalCount);
		mv.addObject("pagingHtml", pagingHtml);
		mv.addObject("currentPage", currentPage);

		mv.addObject("exchangeList", exchangeList);

		return mv;
	}

	// 주문취소 삭제
	@RequestMapping(value = "/admin/cancelDelete")
	public ModelAndView adminCancelDelete(CommandMap commandMap) throws Exception {

		ModelAndView mv = new ModelAndView("redirect:adminCancelList");

		adminOrderService.orderDelete(commandMap.getMap());

		return mv;
	}

	// 교환,반품 삭제
	@RequestMapping(value = "/admin/exchangeDelete")
	public ModelAndView adminExchangeDelete(CommandMap commandMap) throws Exception {

		ModelAndView mv = new ModelAndView("redirect:adminChangeOrderList");

		adminOrderService.orderDelete(commandMap.getMap());

		return mv;
	}
}
