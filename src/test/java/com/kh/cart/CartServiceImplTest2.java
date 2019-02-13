package com.kh.cart;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;


public class CartServiceImplTest2 {
	private List<Map<String, Object>> BeforeCart; //이전 세션 장바구니
	private List<Map<String, Object>> expectedCart; //장바구니 담기 후 세션 장바구니
	private Map<String, Object> newGoods; //장바구니에 새로 추가될 상품
	private CartItem item; //장바구니 상품
	private CartItem item2;
	private CartItem item3;
	
	@Before
	public void setup() {
		BeforeCart = new ArrayList<>(); //상품 추가 전 장바구니
		item = new CartItem("344", "3", "500");
		item2 = new CartItem("345", "5", "500");
		BeforeCart.add((Map<String, Object>) item.makeItem());
		BeforeCart.add((Map<String, Object>) item2.makeItem());
		
		expectedCart = new ArrayList<>(); //상품 추가 후 장바구니
		item = new CartItem("344", "5", "500");
		item2 = new CartItem("345", "9", "500");
		item3 = new CartItem("350", "1", "500");
		expectedCart.add((Map<String, Object>) item.makeItem());
		expectedCart.add((Map<String, Object>) item2.makeItem());
		expectedCart.add((Map<String, Object>) item3.makeItem());
		
		//비회원 세션 장바구니 담기 요청 데이터(3개 상품)
		String goodsNum = "500"; //상품번호
		String[] ea = {"2", "4", "1"};//상품 수량
		String[] kinds = {"344", "345", "350"}; //상품 종류 번호
		newGoods.put("ea[]", ea);
		newGoods.put("GOODS_KIND_NUMBER[]",kinds );
		newGoods.put("GOODS_NUMBER", goodsNum);
		newGoods.put("cartSession", BeforeCart); //makeCart() 실행 전 이전 세션 카트 저장
	}
	
	@Test
	public void testMakeCartInventory() throws Exception {
			CartServiceImpl cartService = new CartServiceImpl();
			List<Map<String, Object>> AfterMakeCart = cartService.makeCart(newGoods);//추가 상품으로 장바구니 생성
			
			//makeCart() 실행 후 실제로 리턴한 장바구니와 미리 세팅한 상품 추가 후 장바구니(expectedCart 객체)의 값이 동일한지 확인
			assertTrue(expectedCart.get(0).values().toString().equals(AfterMakeCart.get(0).values().toString()));
			assertTrue(expectedCart.get(1).values().toString().equals(AfterMakeCart.get(1).values().toString()));
			assertTrue(expectedCart.get(2).values().toString().equals(AfterMakeCart.get(2).values().toString()));
	}

}
