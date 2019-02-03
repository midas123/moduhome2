package com.kh.cart;

import java.util.List;
import java.util.Map;

public interface CartService {

	//장바구니 목록 생성
	public List<Map<String, Object>> makeCart(Map<String, Object> map) throws Exception;

	//세션 장바구니 수량 변경
	public Map<String, Object> updateSessionCart(Map<String, Object> map, List<Map<String, Object>> cartSession) throws Exception;
	
	//세션 장바구니 결합
	public List<Map<String, Object>> sessionCartJoin(List<Map<String, Object>> oldCart, List<Map<String, Object>> newCart) throws Exception;
	
	//로그인시 세션 장바구니를 DB에 저장
	public void saveSessionCart(List<Map<String, Object>> sessionCart, String mem) throws Exception;
	
	//세션 장바구니 목록 생성
	public Map<String, Object> sessionCartList(Map<String, Object> map) throws Exception;
	
	//세션 장바구니 삭제
	public List<Map<String, Object>> deleteSessionCart(List<Map<String, Object>> sessionCart, Map<String, Object> map) throws Exception;
	
	//회원 장바구니 담기 
	public void cartInsert(Map<String, Object> cartIventroy) throws Exception;

	//회원 장바구니 목록
	public List<Map<String, Object>> selectMyCart(Map<String, Object> map) throws Exception;
	
	//회원 장바구니 삭제
	public void deleteMyCart(Map<String, Object> map) throws Exception;

	//회원 장바구니 수량 변경
	public void updateCart(Map<String, Object> map) throws Exception;

	//7일 이상 지난 장바구니 상품 삭제
	public void cleanUpCart(Map<String, Object> map) throws Exception;
	
	//회원 장바구니 중복 상품 확인
	public Map<String, Object> duplicateCart(Map<String, Object> map) throws Exception;
	
}
