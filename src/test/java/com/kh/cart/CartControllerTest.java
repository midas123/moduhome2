package com.kh.cart;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;

class CartControllerTest {

	@Test
	void testCartAdd() {
		 //비회원 세션 장바구니
		 List<Map<String, Object>> list1 = new ArrayList<>();
		 List<Map<String, Object>> list2 = new ArrayList<>();
		 Map<String, Object> cartMap = new HashMap<>();
		 cartMap.put("GOODS_KIND_NUMBER", "344");
		 cartMap.put("CART_AMOUNT", "3");
		 cartMap.put("GOODS_NUMBER", "500");
		 list1.add(cartMap);
		 
		 Map<String, Object> cartMap2 = new HashMap<>();
		 cartMap2.put("GOODS_KIND_NUMBER", "345");
		 cartMap2.put("CART_AMOUNT", "5");
		 cartMap2.put("GOODS_NUMBER", "500");
		 list1.add(cartMap2);
		 
	
		 
		 //회원 장바구니 담기
		 Map<String, Object> map = new HashMap<>();
	     map.put("optno[]", "1");
	     map.put("ea[]", "1");
	     map.put("kinds[]", "344");
	     map.put("goodsno", "500");
	     map.put("MEMBER_NUMBER", 1);
	     
	     //비회원 장바구니 담기
	     Map<String, Object> map2 = new HashMap<>();
	     map2.put("optno[]", new String[] {"1", "2", "3", "4"});
	     map2.put("ea[]", new String[] {"2", "4", "1", "5"});
	     map2.put("kinds[]", new String[] {"344", "345", "346" ,"347"});
	     map2.put("goodsno", "500");
	    // map2.put("GOODS_KIND_NUMBER", "344");
	     map2.put("SESSION_CART", list1);
	     
	     CartController cartCon = new CartController();
	     
	     
	     
	     
	}

}
