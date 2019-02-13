package com.kh.cart;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("cartService")
public class CartServiceImpl implements CartService {

	@Resource(name = "cartDAO")
	private CartDAO cartDAO;

	// 장바구니 등록
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> makeCart(Map<String, Object> map) throws Exception {
	/*	단품 or 여러개 상품 추가(종류만 다른 같은 상품)
		비어있는 장바구니에 상품 추가
		상품이 있는 장바구니에 상품 추가 (상품 종류까지 같은 중복 상품은 수량 업데이트)*/
		List<Map<String, Object>> newCart = new ArrayList<>(); //새로운 장바구니
		Map<String, Object> updatedCartItem = new HashMap<>(); //이전 장바구니 상품
		
		List<Map<String, Object>> oldSessionCart = (List<Map<String, Object>>) map.get("cartSession"); //이전 세션 장바구니
		int goodsNum = Integer.parseInt(map.get("GOODS_NUMBER").toString()); //상품번호
		
		if (map.get("optno[]") instanceof String) { //단품 주문
			String goodsKind = map.get("GOODS_KIND_NUMBER[]").toString(); 
			String goodsAmount = map.get("ea[]").toString(); 
			Map<String, Object> cartItem = new HashMap<String, Object>();
				cartItem.put("GOODS_NUMBER", goodsNum);
				cartItem.put("CART_AMOUNT", goodsAmount);
				cartItem.put("GOODS_KIND_NUMBER", goodsKind);
				//회원
				if(map.get("MEMBER_NUMBER") != null) {
					cartItem.put("MEMBER_NUMBER", map.get("MEMBER_NUMBER"));
					//DB에 장바구니 상품 저장
					cartInsert(cartItem);
				} else {//비회원	
					updatedCartItem = updateSessionCart(cartItem, oldSessionCart);
					if(updatedCartItem == null) {
						newCart.add(cartItem);
					} else {
						cartItem = updatedCartItem;
						newCart.add(cartItem);
					}
				}
				
		} else { // 여러개 주문
			String[] goodsKind = (String[]) map.get("GOODS_KIND_NUMBER[]"); 
			String[] goodsAmount = (String[]) map.get("ea[]"); 
			for(int i=0; i<goodsKind.length; i++) {
				Map<String, Object> cartItem = new HashMap<String, Object>();
					cartItem.put("GOODS_NUMBER", goodsNum);
					cartItem.put("GOODS_KIND_NUMBER", goodsKind[i]);
					cartItem.put("CART_AMOUNT", goodsAmount[i]);
					//회원
					if(map.get("MEMBER_NUMBER") != null) {
						cartItem.put("MEMBER_NUMBER", map.get("MEMBER_NUMBER"));
						//DB에 장바구니 상품 저장
						cartInsert(cartItem);
					} else {//비회원
						updatedCartItem = updateSessionCart(cartItem, oldSessionCart);
						if(updatedCartItem == null) {
							newCart.add(cartItem);
						} else {
							cartItem = updatedCartItem;
							newCart.add(cartItem);
						}
					}
			}
		}
		System.out.println("newCart"+newCart);
		//이전 세션 카트에서 중복 상품을 제거하고 새로운 카트 리스트와 결합
		if(oldSessionCart != null) {
			newCart = sessionCartJoin(oldSessionCart, newCart);
		}
		
		return newCart;
	}
	
	@Override
	public Map<String, Object> updateSessionCart(Map<String, Object> map, List<Map<String, Object>> cartSession) throws Exception{
		//세션에 이미 장바구니가 저장되어 있을 경우
		if(cartSession != null) {
			List<Map<String, Object>> cartOldSession = new ArrayList<>();
			cartOldSession = cartSession;
			for(int i=0; i<cartOldSession.size(); i++) {
				//중복 상품의 수량을 업데이트
				if(cartOldSession.get(i).get("GOODS_KIND_NUMBER").equals(map.get("GOODS_KIND_NUMBER"))){ //같은 상품 일 경우
					int oldEA = Integer.parseInt(cartOldSession.get(i).get("CART_AMOUNT").toString());//이전에 저장된 상품 수량
					int newEA = Integer.parseInt(map.get("CART_AMOUNT").toString()); //새로 추가된 상품 수량
					//수량 더하기 
					map.replace("CART_AMOUNT", (oldEA + newEA));
					//수량 합산한 상품을 세션 장바구니에서 제거, 업데이트 된 상품은 map에 저장됨
					cartOldSession.remove(i);
				} 
			}
			return map;
		} else {
			
		return null;
		}
	}
	
	@Override
	public List<Map<String, Object>> sessionCartJoin(List<Map<String, Object>> oldCart, List<Map<String, Object>> newCart) throws Exception {
		for(int i=0; i<newCart.size(); i++) {
			for(int j=0; j<oldCart.size(); j++) {
				if(newCart.get(i).get("GOODS_KIND_NUMBER").equals(oldCart.get(j).get("GOODS_KIND_NUMBER"))) {
					oldCart.remove(j);
				}
			}	
		}
		//이전 세션 장바구니
		List<Map<String, Object>> finalCart = new ArrayList<>(oldCart);
		//새로운 장바구니 결합
		finalCart.addAll(newCart);
		
		return finalCart;
	}
	
	@Override
	public void saveSessionCart(List<Map<String, Object>> sessionCart, String mem) throws Exception {
		if(sessionCart != null) {
			List<Map<String, Object>> cartList = new ArrayList<Map<String, Object>>();
			cartList = sessionCart;
			
		  for(int i=0; i<cartList.size(); i++ ){
			  Map<String, Object> cartItem = cartList.get(i);
			  cartItem.put("MEMBER_NUMBER", mem);
			  cartInsert(cartList.get(i));
		  }
		}
	}
	
		
	@Override
	public void cartInsert(Map<String, Object> map) throws Exception {
		if(map.get("MEMBER_NUMBER") != null) { 
			Map<String, Object> cartOld = new HashMap<>();
			//DB에 이전 장바구니에 있는 중복 상품 확인
			cartOld = cartDAO.duplicateCart(map);
			
			//중복 상품이 있을 경우
			if(cartOld != null) {
				//이전 장바구니 중복 상품 삭제
				cartDAO.deleteMyCart(map);
				
				//장바구니 상품 수량 업데이트
				int OldEa = ((BigDecimal)cartOld.get("CART_AMOUNT")).intValue();
				int NewEa = Integer.parseInt(map.get("CART_AMOUNT").toString());
				map.put("CART_NUMBER", cartOld.get("CART_NUMBER"));
				map.put("CART_AMOUNT", Integer.toString(OldEa + NewEa));
				//DB에 장바구니 저장
				cartDAO.insertCart(map);
			} else {
				//이전 장바구니에 중복 상품이 없는 경우 바로 DB에 저장
				cartDAO.insertCart(map);
			}
		}
	}

	//회원 장바구니 목록
	@Override
	public List<Map<String, Object>> selectMyCart(Map<String, Object> map) throws Exception {
		return cartDAO.selectMyCart(map);
	}

	//비회원 세션 장바구니 목록
	@Override
	public Map<String, Object> sessionCartList(Map<String, Object> map) throws Exception {
		return cartDAO.sessionCartList(map);
	}

	//장바구니 삭제
	@Override
	public void deleteMyCart(Map<String, Object> map) throws Exception {
		Map<String, Object> cartItem = new HashMap<String, Object>(); //회원 장바구니 아이템
        if (map.get("GOODS_KIND_NUMBER") instanceof String) {//장바구니 단품 삭제
       	 cartItem.put("MEMBER_NUMBER", map.get("MEMBER_NUMBER"));
       	 cartItem.put("GOODS_KIND_NUMBER", map.get("GOODS_KIND_NUMBER"));
       	 cartDAO.deleteMyCart(cartItem);
           
        } else { // 장바구니 여러개 상품 삭제
        	String[] cart_number = (String[]) map.get("cart_number");
        	for (int j = 0; j < cart_number.length; j++) {
	           	cartItem = new HashMap<String, Object>();
	           	cartItem.put("MEMBER_NUMBER", map.get("MEMBER_NUMBER"));
	           	cartItem.put("GOODS_KIND_NUMBER", cart_number[j]);
	           	cartDAO.deleteMyCart(cartItem);
           }
        }
	}
	
	//세션 장바구니 삭제
	@Override
	public List<Map<String, Object>> deleteSessionCart(List<Map<String, Object>> sessionCart, Map<String, Object> map) throws Exception {
		List<Map<String, Object>> cartList = new ArrayList<Map<String, Object>>();//장바구니
		if (map.get("GOODS_KIND_NUMBER") instanceof String) { //단품 삭제
			for (int i = 0; i < sessionCart.size(); i++) {
				if (sessionCart.get(i).get("GOODS_KIND_NUMBER").equals(map.get("GOODS_KIND_NUMBER").toString())) {
					sessionCart.remove(i);
				}
			}
		} else {//여러 상품 삭제
			String[] cart_number = (String[]) map.get("cart_number");
			for (int j = 0; j < cart_number.length; j++) {
				for (int i = 0; i < sessionCart.size(); i++) {
					if (sessionCart.get(i).get("GOODS_KIND_NUMBER").equals(cart_number[j])) {
						sessionCart.remove(i);}
				}
			}
		}
		
		for(int i=0; i<sessionCart.size(); i++) {
			Map<String, Object> cartItem = new HashMap<String, Object>();
			cartItem.put("GOODS_NUMBER",sessionCart.get(i).get("GOODS_NUMBER"));
			cartItem.put("GOODS_KIND_NUMBER",sessionCart.get(i).get("GOODS_KIND_NUMBER"));
			cartItem = sessionCartList(cartItem);
			cartItem.put("CART_AMOUNT", sessionCart.get(i).get("CART_AMOUNT"));
			cartList.add(cartItem);
		}
		
		return cartList;
		
	}

	//장바구니 상품 수량변경
	@Override
	public void updateCart(Map<String, Object> map) throws Exception {
		cartDAO.updateCarts(map);
	}

	//7일 이상 지난 장바구니 상품 삭제
	@Override
	public void cleanUpCart(Map<String, Object> map) throws Exception {
		cartDAO.cleanUpCarts(map);
	}
	
	//장바구니 중복 상품 확인
	@Override
	public Map<String, Object> duplicateCart(Map<String, Object> map) throws Exception {
		return cartDAO.duplicateCart(map);
	}
	

}
