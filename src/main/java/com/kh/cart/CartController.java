package com.kh.cart;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.moduhome.CommandMap;
import com.kh.order.OrderService;


@Controller
public class CartController {
	
	@Resource(name="cartService")
	private CartService cartService;
	
	@Resource(name="orderService")
	private OrderService orderService;
	
	
	//장바구니 담기
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/cart/cartAdd")
	public ModelAndView cartAdd(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("redirect:/cart/cartList");
		
		HttpSession session = request.getSession();
		
		//장바구니 상품 목록
		List<Map<String, Object>> cartIventory = new ArrayList<>(); 
		
		//회원 장바구니 담기 - DB
		if(session.getAttribute("MEMBER_NUMBER") != null) {
			//회원은 commandMap에 회원번호를 담아서 makeCartInventory로 전달
			commandMap.put("MEMBER_NUMBER", session.getAttribute("MEMBER_NUMBER"));
			
		} else {
			//비회원용 장바구니 담기 - 세션
			List<Map<String, Object>> cartInSession = new ArrayList<Map<String, Object>>();
			
			if(session.getAttribute("cartSession") != null) { 
				//세션에 존재하는 이전 장바구니
				cartInSession = (List<Map<String, Object>>) session.getAttribute("cartSession");
				//비회원은 commandMap에 세션 장바구니를 담아서 makeCartInventory로 전달
				commandMap.put("cartSession", cartInSession);
			}
		}
			
		//장바구니 상품 목록 생성
		cartIventory = cartService.makeCartInventory(commandMap.getMap());
		System.out.println("cartIventory:"+cartIventory);
		//비회원 세션에 장바구니 저장 
		if(session.getAttribute("MEMBER_NUMBER") == null) {
			session.setAttribute("cartSession", cartIventory);
		}
	
		
		return mv;
	}
	
	// 장바구니 리스트 불러오기
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/cart/cartList")
	public ModelAndView cartList(CommandMap commandMap, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("cartList");
		List<Map<String, Object>> cartList = new ArrayList<Map<String, Object>>();
		Calendar today = Calendar.getInstance();
		//Date d = new Date(today.getTimeInMillis());
		HttpSession session = request.getSession();
		List<Map<String, Object>> cartSession = new ArrayList<Map<String, Object>>();
		Map<String, Object> cartMap = new HashMap<String, Object>();

		if (session.getAttribute("MEMBER_NUMBER") != null) {
			commandMap.put("MEMBER_NUMBER", session.getAttribute("MEMBER_NUMBER"));
			cartList = cartService.selectMyCart(commandMap.getMap());
		} else {
			if (session.getAttribute("cartSession") != null) {
				cartSession = (List<Map<String, Object>>) session.getAttribute("cartSession");
				for (int i = 0; i < cartSession.size(); i++) {
					cartMap = new HashMap<String, Object>();
					cartMap.put("GOODS_KIND_NUMBER", cartSession.get(i).get("GOODS_KIND_NUMBER"));
					cartMap.put("GOODS_NUMBER", cartSession.get(i).get("GOODS_NUMBER"));
					cartMap = cartService.sessionCartList(cartMap);
					cartMap.put("CART_AMOUNT", cartSession.get(i).get("CART_AMOUNT"));
					cartList.add(cartMap);
				}
			}
		}
		mv.addObject("cartList", cartList);
	return mv;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/cart/cartDelete")
	public ModelAndView cartDelete(CommandMap commandMap, HttpServletRequest request, 
			@RequestParam(value="GOODS_KIND_NUMBER[]", required = false) String[] arrayParams) throws Exception {
		ModelAndView mv = new ModelAndView();
		HttpSession session = request.getSession();
		List<Map<String, Object>> cartSession = new ArrayList<Map<String, Object>>();//비회원 세션 장바구니
		List<Map<String, Object>> cartList = new ArrayList<Map<String, Object>>();
		List<String> GKN = new ArrayList<String>(); //비회원 장바구니 아이템 목록
		

		String[] cart_number= arrayParams;
		if(cart_number != null) {
			if(cart_number.length == 1) { //단품
				String a = cart_number[0];
				String[] total;
				total =a.split(",");
				GKN.add(total[0]);
			}
			else if(cart_number.length > 1) { //여러개
			for(int i=0; i<cart_number.length; i++) {
				GKN.add(cart_number[i]);
				}
			}
		}
		//상품 삭제 버튼으로 넘어온 상품번호 처리
		if(commandMap.get("GOODS_KIND_NUMBER") instanceof String) {
			String a =   (String) commandMap.get("GOODS_KIND_NUMBER");
			String[] total;
			total =a.split(",");
			GKN.add(total[0]);
		}
		//상품 삭제 시작
		//회원
		if (session.getAttribute("MEMBER_NUMBER") != null) {
			Map<String, Object> cartItem = new HashMap<String, Object>(); //회원 장바구니 아이템 저장
	         if (commandMap.get("GOODS_KIND_NUMBER") instanceof String) {//단품
	        	 cartItem = new HashMap<String, Object>();
	        	 cartItem.put("MEMBER_NUMBER", session.getAttribute("MEMBER_NUMBER"));
	        	 cartItem.put("GOODS_KIND_NUMBER", commandMap.get("GOODS_KIND_NUMBER"));
	             cartService.deleteMyCart(cartItem);
	            
    			commandMap.put("MEMBER_NUMBER", session.getAttribute("MEMBER_NUMBER"));
    			commandMap.put("MEMBER_NUMBER", session.getAttribute("MEMBER_NUMBER"));
	         } else { // 장바구니 여러개 선택 삭제
	            for (int j = 0; j < cart_number.length; j++) {
	            	cartItem = new HashMap<String, Object>();
	            	cartItem.put("MEMBER_NUMBER", session.getAttribute("MEMBER_NUMBER"));
	            	cartItem.put("GOODS_KIND_NUMBER", cart_number[j]);
	               cartService.deleteMyCart(cartItem);
		           commandMap.put("MEMBER_NUMBER", session.getAttribute("MEMBER_NUMBER"));
	            }
	         }
	         cartList = cartService.selectMyCart(cartItem);
	         
		} else {  //비회원 세션 장바구니
			cartSession = (List<Map<String, Object>>) session.getAttribute("cartSession");
			if (GKN.size()==1) { //단품
				cartSession = (List<Map<String, Object>>) session.getAttribute("cartSession");
				for (int i = 0; i < cartSession.size(); i++) {
					if (cartSession.get(i).get("GOODS_KIND_NUMBER").equals(GKN.get(0))) {
						cartSession.remove(i);
					}
				}
			} else {//여러 상품 삭제
				for (int j = 0; j < GKN.size(); j++) {
					cartSession = (List<Map<String, Object>>) session.getAttribute("cartSession");
					for (int i = 0; i < cartSession.size(); i++) {
						if (cartSession.get(i).get("GOODS_KIND_NUMBER").equals(GKN.get(j))) {
							cartSession.remove(i);}
					}
				}
			}
			Map<String, Object> Goods = new HashMap<String, Object>();
			for(int i=0; i<cartSession.size(); i++) {
				Goods.put("GOODS_NUMBER",cartSession.get(i).get("GOODS_NUMBER"));
				Goods.put("GOODS_KIND_NUMBER",cartSession.get(i).get("GOODS_KIND_NUMBER"));
				cartList.add(cartService.sessionCartList(Goods));
			}
		}
		
		mv.addObject("cartList",cartList);
		mv.setViewName("store/cart/cartList");
		return mv;
	    }
	
	@RequestMapping(value="/cart/modifyEa")
	@ResponseBody
	public Map<String, Object> modifyEa(CommandMap commandMap) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();

		cartService.updateCarts(commandMap.getMap());
		return param;
	}

}
