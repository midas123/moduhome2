package com.kh.cart;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("cartService")
public class CartServiceImpl implements CartService {

	@Resource(name = "cartDAO")
	private CartDAO cartDAO;

	// 장바구니 등록
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> makeCartInventory(Map<String, Object> map) throws Exception {
	/*	단품 or 여러개 상품 추가(종류만 다른 같은 상품)
		비어있는 장바구니에 상품 추가
		상품이 있는 장바구니에 상품 추가 (상품 종류까지 같은 중복 상품은 등록X)*/
		List<Map<String, Object>> cartIventory = new ArrayList<>(); //새로운 장바구니
		Map<String, Object> cartItemOld = new HashMap<>(); //이전 장바구니 품목
		
		List<Map<String, Object>> sessionCart = new ArrayList<>();
		sessionCart = (List<Map<String, Object>>) map.get("cartSession"); //이전 세션 장바구니
		int goodsNum = Integer.parseInt(map.get("goodsno").toString()); //상품번호
		
		if (map.get("optno[]") instanceof String) { //단품 주문
			String goodsKind = (String) map.get("kinds[]"); 
			String goodsAmount = (String) map.get("ea[]"); 
			Map<String, Object> cartItem = new HashMap<String, Object>();
				cartItem.put("GOODS_NUMBER", goodsNum);
				cartItem.put("CART_AMOUNT", goodsAmount);
				cartItem.put("GOODS_KIND_NUMBER", goodsKind);
				
				if(map.get("MEMBER_NUMBER") != null) {
					cartItem.put("MEMBER_NUMBER", map.get("MEMBER_NUMBER"));
					cartInsert(cartItem);
				}	

				cartItemOld = sessionCartCheck(cartItem, sessionCart);
				if(cartItemOld == null) {
					cartIventory.add(cartItem);
				} else {
					cartItem = cartItemOld;
					cartIventory.add(cartItem);
				}
				
		} else { // 여러개 주문
			String[] goodsKind = (String[]) map.get("kinds[]"); 
			String[] goodsAmount = (String[]) map.get("ea[]"); 
			for(int i=0; i<goodsKind.length; i++) {
				Map<String, Object> cartItem = new HashMap<String, Object>();
					cartItem.put("GOODS_NUMBER", goodsNum);
					cartItem.put("GOODS_KIND_NUMBER", goodsKind[i]);
					cartItem.put("CART_AMOUNT", goodsAmount[i]);
					
					if(map.get("MEMBER_NUMBER") != null) {
						cartItem.put("MEMBER_NUMBER", map.get("MEMBER_NUMBER"));
						cartInsert(cartItem);
					} 
					
					cartItemOld = sessionCartCheck(cartItem, sessionCart);
					if(cartItemOld == null) {
						cartIventory.add(cartItem);
					} else {
						cartItem = cartItemOld;
						cartIventory.add(cartItem);
					}
			}
		}
		
		//이전 세션 카트에서 중복 상품을 제거하고 새로운 카트 리스트와 결합
		if(sessionCart != null) {
		for(int i=0; i<cartIventory.size(); i++) {
			for(int j=0; j<sessionCart.size(); j++) {
				if(cartIventory.get(i).get("GOODS_KIND_NUMBER").equals(sessionCart.get(j).get("GOODS_KIND_NUMBER"))) {
			 		sessionCart.remove(j);
				}
			}	
		}
		List<Map<String, Object>> finalCartInventory = new ArrayList<>(cartIventory);
		finalCartInventory.addAll(sessionCart);
		
		return finalCartInventory;
		}
		
		return cartIventory;
	}
	
	public Map<String, Object> sessionCartCheck(Map<String, Object> map, List<Map<String, Object>> cartSession) throws Exception{
		//세션에 이미 장바구니가 저장되어 있을 경우
		if(cartSession != null) {
			List<Map<String, Object>> cartOldSession = new ArrayList<>();
			cartOldSession = cartSession;
			for(int i=0; i<cartOldSession.size(); i++) {
				//중복 상품의 수량을 업데이트
				if(cartOldSession.get(i).get("GOODS_KIND_NUMBER").equals(map.get("GOODS_KIND_NUMBER"))){ //같은 상품 일 경우
//					int oldEA = Integer.parseInt((String)cartOldSession.get(i).get("CART_AMOUNT"));//이전에 저장된 상품 수량
					int oldEA = Integer.parseInt((String) cartOldSession.get(i).get("CART_AMOUNT"));//이전에 저장된 상품 수량
					int newEA = Integer.parseInt((String) map.get("CART_AMOUNT")); //새로 추가된 상품 수량
					//수량 더하기 
					map.replace("CART_AMOUNT", (oldEA + newEA));
					//수량 합산한 상품을 세션 장바구니에서 제거, 업데이트 된 상품은 map에 저장됨
					cartOldSession.remove(i);
				} 
			}
			return map;
		} 
		return null;
	}
		
	@Override
	public void cartInsert(Map<String, Object> map) throws Exception {
		
		if(map.get("MEMBER_NUMBER") != null) { 
			Map<String, Object> cartOld = new HashMap<>();
			//DB에 저장된 이전 장바구니 목록
			cartOld = cartDAO.confirmCart(map);
			
			if(cartOld != null) {
				//이전 장바구니 삭제
				cartDAO.deleteMyCart(map);
				
				//장바구니 상품 수량 업데이트
				int OldEa = ((BigDecimal)cartOld.get("CART_AMOUNT")).intValue();
				int NewEa = Integer.parseInt((String) map.get("CART_AMOUNT"));
				map.put("CART_NUMBER", cartOld.get("CART_NUMBER"));
				map.put("CART_AMOUNT", Integer.toString(OldEa + NewEa));
				//DB 저장
				cartDAO.cartInsertDB(map);
			} else {
				//이전 장바구니에 없는 상품은 바로 DB에 저장
				cartDAO.cartInsertDB(map);
			}
		}
	}

	// 회원 장바구니 목록
	@Override
	public List<Map<String, Object>> selectMyCart(Map<String, Object> map) throws Exception {
		return cartDAO.selectMyCart(map);
	}
	
	@Override
	public void cartInsert2(Map<String, Object> map) throws Exception {
		if (cartDAO.confirmCart(map) != null)
			return;
		else
			cartDAO.cartInsertDB(map);
	}

	// 비회원 장바구니 목록
	@Override
	public Map<String, Object> sessionCartList(Map<String, Object> map) throws Exception {
		return cartDAO.sessionCartList(map);
	}

	// 장바구니 삭제
	@Override
	public void deleteMyCart(Map<String, Object> map) throws Exception {
		cartDAO.deleteMyCart(map);
	}

	// 장바구니 옵션에서 해당 상품에 대한 정보 불러오기
	@Override
	public Map<String, Object> selectOption(Map<String, Object> map) throws Exception {
		return cartDAO.selectOption(map);
	}

	@Override
	public Map<String, Object> sessionOption(Map<String, Object> map) throws Exception {
		return cartDAO.sessionOption(map);
	}

	@Override
	public void updateCarts(Map<String, Object> map) throws Exception {
		cartDAO.updateCarts(map);
	}

	// 3일이상된 장바구니 목록 삭제
	@Override
	public void deleteCarts(Map<String, Object> map) throws Exception {
		cartDAO.deleteCarts(map);
	}
	
	@Override
	public Map<String, Object> buyInCart(Map<String, Object> map) throws Exception {
		return cartDAO.buyInCart(map);
	}


}
