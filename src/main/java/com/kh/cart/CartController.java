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
			//회원은 commandMap에 회원번호를 담아서 makeCart로 전달
			commandMap.put("MEMBER_NUMBER", session.getAttribute("MEMBER_NUMBER"));
			
		} else {
			//비회원용 장바구니 담기 - 세션
			List<Map<String, Object>> cartInSession = new ArrayList<Map<String, Object>>();
			
			if(session.getAttribute("cartSession") != null) { 
				//세션에 존재하는 이전 장바구니
				cartInSession = (List<Map<String, Object>>) session.getAttribute("cartSession");
				//비회원은 commandMap에 이전 세션 장바구니를 담아서 makeCart로 전달
				commandMap.put("cartSession", cartInSession);
			}
		}
			
		//추가한 상품으로 장바구니 생성, 회원은 makeCart에서 바로 DB에 저장
		cartIventory = cartService.makeCart(commandMap.getMap());
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
		HttpSession session = request.getSession();
		List<Map<String, Object>> cartList = new ArrayList<Map<String, Object>>();//장바구니

		if (session.getAttribute("MEMBER_NUMBER") != null) {//회원
			String memberNum = session.getAttribute("MEMBER_NUMBER").toString();
			commandMap.put("MEMBER_NUMBER", memberNum);
			cartService.cleanUpCart(commandMap.getMap()); //장바구니에서 7일 지난 상품 정리
			cartList = cartService.selectMyCart(commandMap.getMap()); //회원 장바구니 목록
		} else { //비회원
			if (session.getAttribute("cartSession") != null) {
				List<Map<String, Object>> cartSession = new ArrayList<Map<String, Object>>();//세션 장바구니
				Map<String, Object> cartItem = new HashMap<String, Object>(); //장바구니 상품
				cartSession = (List<Map<String, Object>>) session.getAttribute("cartSession");
				for (int i = 0; i < cartSession.size(); i++) {//세션 저장된 상품 번호로 DB에서 상품 정보를 하나씩 불러옴
					cartItem = new HashMap<String, Object>();
					cartItem.put("GOODS_KIND_NUMBER", cartSession.get(i).get("GOODS_KIND_NUMBER"));//상품 종류 번호
					cartItem.put("GOODS_NUMBER", cartSession.get(i).get("GOODS_NUMBER"));//상품번호
					cartItem = cartService.sessionCartList(cartItem);//상품 정보
					cartItem.put("CART_AMOUNT", cartSession.get(i).get("CART_AMOUNT"));//장바구니 상품 수량
					cartList.add(cartItem);
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
		List<Map<String, Object>> cartList = new ArrayList<Map<String, Object>>();

		String[] cart_number= arrayParams; //삭제 요청으로 넘어온 상품 종류 번호
		commandMap.getMap().put("cart_number", cart_number);
		
		//상품 삭제 시작
		if (session.getAttribute("MEMBER_NUMBER") != null) {//회원
			commandMap.getMap().put("MEMBER_NUMBER", session.getAttribute("MEMBER_NUMBER"));
			cartService.deleteMyCart(commandMap.getMap()); //장바구니 상품 삭제
	        cartList = cartService.selectMyCart(commandMap.getMap());//새로운 장바구니 목록
	         
		} else {  //비회원 세션 장바구니
			List<Map<String, Object>> cartSession = new ArrayList<Map<String, Object>>();
			cartSession = (List<Map<String, Object>>) session.getAttribute("cartSession");
			cartList = cartService.deleteSessionCart(cartSession, commandMap.getMap());
		
		}
		mv.addObject("cartList",cartList);
		mv.setViewName("store/cart/cartList");
		return mv;
	    }
	
	@RequestMapping(value="/cart/modifyEa")
	@ResponseBody
	public Map<String, Object> modifyEa(CommandMap commandMap, HttpServletRequest request) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		HttpSession session = request.getSession();
		//회원 장바구니 상품 수량변경
		if(session.getAttribute("MEMBER_NUMBER") != null) {
			System.out.println(commandMap.getMap());
			cartService.updateCart(commandMap.getMap());
		} else {
			//비회원 장바구니 상품 수량변경
			int goodKind = Integer.parseInt(commandMap.get("GOODS_KIND_NUMBER").toString());
			System.out.println("goodKind:"+goodKind);
			
			List<Map<String, Object>> sessionCart = (List<Map<String, Object>>) session.getAttribute("cartSession");
			for(int i=0; i<sessionCart.size(); i++) {
				int session_goodKind = Integer.parseInt(sessionCart.get(i).get("GOODS_KIND_NUMBER").toString()); 
				if(session_goodKind == goodKind) {
					//int cart_amount = Integer.parseInt(sessionCart.get(i).get("CART_AMOUNT").toString());
					int cart_amount = Integer.parseInt(commandMap.get("CART_AMOUNT").toString());
					System.out.println("cart_amount:"+cart_amount);
					//cart_amount += 1;
					sessionCart.get(i).replace("CART_AMOUNT", cart_amount);
				}
			}
			session.removeAttribute("cartSession");
			session.setAttribute("cartSession", sessionCart);
		}
		
		return param;
	}

}
