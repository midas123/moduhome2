package com.kh.cart;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

public class CartServiceImplTest2 {

	@Test
	public void test() {
		
		@Test
		void testmakeCartInventory() throws Exception {
			
			 /*이미 존재하는 세션 장바구니(BeforesessionCart)에는 2개의 상품이 있습니다. 
			 *새로 추가되는 상품 3개중 2개와 중복 됩니다. 
		     *중복 상품 2개는 수량을 합하고 새로운 상품은 새로 추가되는지를 확인하기 위해서, 
		     *추가 이후에 상품을 담고 있는 세션 장바구니(AftersessionCart)를 만들어서 테스트하였습니다.
		     *
		     *BeforesessionCart: 새로운 상품 추가 전 장바구니
		     *AftersessionCart: 새로운 상품 추가 후 장바구니
		     */
			
			 //비회원 세션 장바구니 시작
			 List<Map<String, Object>> BeforesessionCart = new ArrayList<>();
			 Map<String, Object> cartMap4 = new HashMap<>();
			 cartMap4.put("GOODS_KIND_NUMBER", "344");
			 cartMap4.put("CART_AMOUNT", "3");
			 cartMap4.put("GOODS_NUMBER", "500");
			 BeforesessionCart.add(cartMap4);
			 
			 Map<String, Object> cartMap5 = new HashMap<>();
			 cartMap5.put("GOODS_KIND_NUMBER", "345");
			 cartMap5.put("CART_AMOUNT", "5");
			 cartMap5.put("GOODS_NUMBER", "500");
			 BeforesessionCart.add(cartMap5);
			 
			 //새로운 상품 추가후 세션 장바구니
			 List<Map<String, Object>> AftersessionCart = new ArrayList<>();
			 Map<String, Object> cartMap = new HashMap<>();
			 cartMap.put("GOODS_KIND_NUMBER", "344");
			 cartMap.put("CART_AMOUNT", "5"); //중복 상품은 수량증가 +2
			 cartMap.put("GOODS_NUMBER", "500");
			 AftersessionCart.add(cartMap);
			 
			 Map<String, Object> cartMap2 = new HashMap<>();
			 cartMap2.put("GOODS_KIND_NUMBER", "345");
			 cartMap2.put("CART_AMOUNT", "9"); //중복 상품은 수량증가 +4
			 cartMap2.put("GOODS_NUMBER", "500");
			 AftersessionCart.add(cartMap2);
			 
			 Map<String, Object> cartMap3 = new HashMap<>();
			 cartMap3.put("GOODS_KIND_NUMBER", "350");
			 cartMap3.put("CART_AMOUNT", "1");
			 cartMap3.put("GOODS_NUMBER", "500");
			 AftersessionCart.add(cartMap3);
			 //비회원 세션 장바구니 끝
			 
		     
		     //비회원 장바구니 담기(3개 상품)
		     Map<String, Object> NotMemberGoods = new HashMap<>();
		     NotMemberGoods.put("optno[]", new String[] {"1", "2", "3"}); //선택 옵션 인덱스
		     NotMemberGoods.put("ea[]", new String[] {"2", "4", "1"});//상품 수량
		     NotMemberGoods.put("kinds[]", new String[] {"344", "345", "350" });//상품 종류 번호
		     NotMemberGoods.put("goodsno", "500"); //상품 번호
		     NotMemberGoods.put("cartSession", BeforesessionCart); //장바구니 담기 기능 실행 전 세션 카트(컨트롤러에서 map 객채에 저장합니다.)
		     CartServiceImpl ddd = new CartServiceImpl();
			CartServiceImpl arrayCheck = new CartServiceImpl();
			assertFalse(AftersessionCart == arrayCheck.makeCartInventory(NotMemberGoods));
			
			
			 //회원 장바구니 담기
			 Map<String, Object> MemberGood = new HashMap<>();
		     MemberGood.put("optno[]", "1");
		     MemberGood.put("ea[]", "1");
		     MemberGood.put("kinds[]", "550");
		     MemberGood.put("goodsno", "600");
		     MemberGood.put("MEMBER_NUMBER", 1);
			
			 Map<String, Object> MemberGoods = new HashMap<>();
		     MemberGoods.put("optno[]", new String[] {"1", "2"});
		     MemberGoods.put("ea[]", new String[] {"2", "5"});
		     MemberGoods.put("kinds[]", new String[] {"400", "401"});
		     MemberGoods.put("goodsno", "600");
		     MemberGoods.put("MEMBER_NUMBER", 1);
			
	}

}
