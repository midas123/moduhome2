package com.kh.cart;

import java.util.List;
import java.util.Map;

public interface CartService {

	//장바구니 상품 담기
	public List<Map<String, Object>> makeCart(Map<String, Object> map) throws Exception;

	//세션 장바구니 수량 업데이트
	public Map<String, Object> sessionCartCheck(Map<String, Object> map, List<Map<String, Object>> cartSession) throws Exception;
	
	//세션 장바구니 결합
	public List<Map<String, Object>> sessionCartJoin(List<Map<String, Object>> oldCart, List<Map<String, Object>> newCart) throws Exception;
	
	//로그인시 세션 장바구니를 DB에 저장
	public void getSessionCart(List<Map<String, Object>> sessionCart, String mem) throws Exception;
	
	//장바구니 담기 DB
	public void cartInsert(Map<String, Object> cartIventroy) throws Exception;

	//회원 장바구니 목록
	public List<Map<String, Object>> selectMyCart(Map<String, Object> map) throws Exception;
	
	//세션에서 장바구니 목록 불러오기
	public Map<String, Object> sessionCartList(Map<String, Object> map) throws Exception;

	//장바구니 삭제
	public void deleteMyCart(Map<String, Object> map) throws Exception;

	//장바구니 수정(옵션변경)
	public void updateCarts(Map<String, Object> map) throws Exception;

	//7일 이상 지난 장바구니 상품 삭제
	public void cleanUpCarts(Map<String, Object> map) throws Exception;
	
	//장바구니 중복 상품 확인
	public Map<String, Object> duplicateCart(Map<String, Object> map) throws Exception;
	
	
	
}
