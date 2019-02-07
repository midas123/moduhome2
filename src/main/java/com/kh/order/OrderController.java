package com.kh.order;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.adminOrder.AdminOrderService;
import com.kh.goods.GoodsService;
import com.kh.moduhome.CommandMap;


@Controller
public class OrderController {
	@Resource(name="orderService")
	private OrderService orderService;
	
	@Resource(name="goodsService")
	private GoodsService goodsService;

	@Resource(name = "adminOrderService")
	private AdminOrderService adminOrderService;
	//구매하기
	@RequestMapping(value="/order")
	public ModelAndView orderForm(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("orderForm");
		HttpSession session = request.getSession();
		String memn = session.getAttribute("MEMBER_NUMBER").toString();
		commandMap.getMap().put("MEMBER_NUMBER", memn);
		//주문자 정보
		Map<String, Object> orderMember = orderService.orderMember(commandMap.getMap());
		mv.addObject("orderMember", orderMember);
		
		//주문코드 생성
		String ORDER_CODE = orderService.makeOrderCode();
		mv.addObject("ORDER_CODE", ORDER_CODE);
		
		//상품 종류 및 수량
		String[] goods_kinds_number = request.getParameterValues("GOODS_KIND_NUMBER[]");
		String[] ea = request.getParameterValues("ea[]");
		String[] goods_no = request.getParameterValues("GOODS_NUMBER[]");
		String[] goods_Name = request.getParameterValues("GOODS_NAME");
		mv.addObject("GOODS_NAME", goods_Name[0]);
		mv.addObject("GOODS_NUMBER", goods_no);
		
		List<Map<String, Object>> goods = new ArrayList<Map<String, Object>>(); //주문 상품 목록
		for (int i = 0; i < goods_kinds_number.length; i++) {
				commandMap.put("GOODS_NUMBER", goods_no[i]);
				commandMap.put("GOODS_KIND_NUMBER", goods_kinds_number[i]);
				commandMap.put("EA", ea[i]);
				//주문 상품 정보
				Map<String, Object> orderGoods = orderService.orderGoods(commandMap.getMap());
				orderGoods.put("EA", ea[i]);
				goods.add(orderGoods);
		}
		mv.addObject("goods", goods);
		
		return mv;
	
	}
	
	
	@RequestMapping(value="/orderEnd")
	public ModelAndView orderEnd(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("orderEnd");
		commandMap.put("MEMBER_NUMBER", request.getParameter("MEMBER_NUMBER"));
	
		String[] goods_kinds_number = request.getParameterValues("kinds[]");
		String[] ea = request.getParameterValues("ea[]");
		String[] goods_number = request.getParameterValues("GOODS_NUMBER[]");
		List<BigDecimal> goods_Disprice = new ArrayList<>();
		
		//현재 날짜와 시각
		Date date = new Date();
		//SimpleDateFormat 생성자에 날짜 형식을 포함한다.
		SimpleDateFormat sf  = new SimpleDateFormat("YY/MM/dd");
		//SimpleDateFormat 클래스의 format 메소드로 타입을 Date -> String으로 변환
		String orderDate = sf.format(date);
		
		//주문완료 페이지에서 출력할 상품 정보 저장
		List<Map<String, Object>> GoodsList = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < goods_kinds_number.length; i++) {
			Map<String, Object> orderGoods = new HashMap<>();
			orderGoods.put("GOODS_KIND_NUMBER", goods_kinds_number[i]);
			orderGoods.put("EA", ea[i]); 
			orderGoods.put("GOODS_NUMBER", goods_number[i]);
			orderGoods = orderService.orderGoods(orderGoods);
			orderGoods.put("GOODS_KIND_NUMBER", goods_kinds_number[i]);
			orderGoods.put("EA", ea[i]); 
			orderGoods.put("GOODS_NUMBER", goods_number[i]);
			goods_Disprice.add((BigDecimal) orderGoods.get("GOODS_DISPRICE"));
			GoodsList.add(orderGoods);
		}
		mv.addObject("goodsList", GoodsList);
		
		//주문완료 페이지에서 출력할 주문자 정보
		Map<String, Object> orderMember = orderService.orderMember(commandMap.getMap());
		mv.addObject("orderMember", orderMember);
		
		//주문서에 포함될 상품가격을 객체에 저장
		commandMap.put("ORDER_TOTAL_PRICE[]", goods_Disprice);
		
		//주문 코드
		String ORDER_CODE = request.getParameter("ORDER_CODE");
		mv.addObject("ORDER_CODE", ORDER_CODE);
		
		commandMap.put("ORDER_CODE", ORDER_CODE);
		commandMap.put("BUYER_ZIPCODE", orderMember.get("MEMBER_ZIPCODE"));
		commandMap.put("BUYER_ADDRESS1", orderMember.get("MEMBER_ADDRESS1"));
		commandMap.put("BUYER_ADDRESS2", orderMember.get("MEMBER_ADDRESS2"));
		commandMap.put("BUYER_NAME", orderMember.get("MEMBER_NAME"));
		commandMap.put("BUYER_EMAIL", orderMember.get("MEMBER_EMAIL"));
		commandMap.put("BUYER_NUMBER", orderMember.get("MEMBER_PHONE"));
		
		if (request.getParameter("DELIVERY_MESSAGE").isEmpty()) {
			commandMap.put("DELIVERY_MESSAGE", " ");
		}

		commandMap.put("RECEIVER_NAME", request.getParameter("RECEIVER_NAME"));
		commandMap.put("RECEIVER_ZIPCODE", request.getParameter("RECEIVER_ZIPCODE"));
		commandMap.put("RECEIVER_ADDRESS1", request.getParameter("RECEIVER_ADDRESS1"));
		commandMap.put("RECEIVER_ADDRESS2", request.getParameter("RECEIVER_ADDRESS2"));
		commandMap.put("RECEIVER_NUMBER", request.getParameter("RECEIVER_NUMBER"));
		commandMap.put("DELIVERY_MESSAGE", request.getParameter("DELIVERY_MESSAGE"));
		commandMap.put("RECEIVER_NUMBER", request.getParameter("RECEIVER_PHONE"));
		commandMap.put("TOTALPRICE", request.getParameter("TOTALPRICE"));
		commandMap.put("ORDER_DATE", orderDate);
		
		//상품 구매 트랜잭션 처리
		orderService.orderGoodsAction(commandMap.getMap());

		mv.addObject("goods_kind_number", goods_kinds_number);
		mv.addObject("ea", ea);
		
		//포인트
		if (commandMap.getMap().get("usePoint") != null) {
		int usePoint = Integer.parseInt((String) commandMap.getMap().get("usePoint"));
		mv.addObject("usePoint", usePoint);
		}
		
		mv.addObject("ORDER_INFO", commandMap);
		mv.addObject("BUYER_NUMBER", commandMap.get("BUYER_NUMBER"));
		mv.addObject("TOTALPRICE", commandMap.get("TOTALPRICE"));
		mv.addObject("RECEIVER_NAME", commandMap.get("RECEIVER_NAME"));
		mv.addObject("RECEIVER_ZIPCODE", commandMap.get("RECEIVER_ZIPCODE"));
		mv.addObject("RECEIVER_ADDRESS1", commandMap.get("RECEIVER_ADDRESS1"));
		mv.addObject("RECEIVER_ADDRESS2", commandMap.get("RECEIVER_ADDRESS2"));
		mv.addObject("DELIVERY_MESSAGE", commandMap.get("DELIVERY_MESSAGE"));
		mv.addObject("RECEIVER_PHONE", commandMap.get("RECEIVER_NUMBER"));
		mv.addObject("orderDate", orderDate);
		
		return mv;
	}
	
	@RequestMapping(value="/MyOrderList")
	public ModelAndView MyOrderList(HttpServletRequest request,HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("myorder");
		
		//String memberNum = (String)request.getAttribute("MEMBER_NUMBER");
		String memberNum = session.getAttribute("MEMBER_NUMBER").toString();

	List<Map<String, Object>> myOrderList = goodsService.selectOrderList(memberNum);
		mv.addObject("myOrderList", myOrderList);	
		
		return mv;
	}
	
	@RequestMapping(value="/payUpdate")
	public @ResponseBody String myOrderpayUpdate(CommandMap commandMap, HttpServletRequest request) throws Exception {
		System.out.println("오더넘 : "+commandMap.get("ORDER_NUMBER"));
		System.out.println("오더스테이트 : "+commandMap.get("ORDER_STATE"));	
		goodsService.OrderStateModi(commandMap.getMap());
	     return "1";
	}
	
	@RequestMapping(value="/myOrderDetail")
	public ModelAndView myOrderDetail(CommandMap commandMap, HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		
		String memberNum = session.getAttribute("MEMBER_NUMBER").toString();
		List<Map<String, Object>> myOrderList = goodsService.selectOrderList(memberNum);
		
		System.out.println(("order code = "+ (myOrderList.get(0)).get("ORDER_CODE")));
		mv.addObject("myOrderList", myOrderList);
		

		Map<String, Object> orderCode = new HashMap<String, Object>();
		orderCode.put("ORDER_CODE", (myOrderList.get(0)).get("ORDER_CODE"));
		System.out.println(orderCode);
		//Object orderCode= commandMap.get("ORDER_CODE").toString();
		
		
		System.out.println("오더코드"+commandMap.get("ORDER_CODE"));
		
		List<Map<String, Object>> myOrderDetail = new ArrayList<Map<String, Object>>();
		myOrderDetail = adminOrderService.orderDetail(orderCode);
		//OrderDetail = adminOrderService.orderDetail(commandMap.getMap());
		
		int total_price = 0;
		int total_amount = 0;

		for(int i=0;i<myOrderList.size(); i++) {
			total_price= Integer.parseInt((((myOrderDetail.get(i)).get("ORDER_TOTAL_PRICE")).toString()));
			String total = (((myOrderDetail.get(i)).get("ORDER_TOTAL_PRICE")).toString());
			
			total_amount = Integer.parseInt((((myOrderDetail.get(i)).get("ORDER_AMOUNT")).toString()));
			String amount = (((myOrderDetail.get(i)).get("ORDER_AMOUNT")).toString());
			
			total_price += Integer.parseInt(total) * Integer.parseInt(amount) ;
			System.out.println(total_price);
		}
		
		mv.addObject("total_price", total_price);
		
		Map<String, Object> myOrderDetail2 =  myOrderDetail.get(0);
		mv.addObject("myOrderDetail2", myOrderDetail2);
		System.out.println(myOrderDetail2);
		
		mv.setViewName("/mypage/myOrderDetail");
		
		return mv;
		
	}
		
	
}
