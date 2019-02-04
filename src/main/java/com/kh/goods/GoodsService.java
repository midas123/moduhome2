package com.kh.goods;

import java.util.List;
import java.util.Map;

public interface GoodsService {

	//스토어 메인, 상품 판매순 정렬
	public List<Map<String, Object>> bestSellAll(Map<String, Object> map) throws Exception;
	
	//스토어 메인, 상품 판매순 정렬
	public List<Map<String, Object>> newItemAll(Map<String, Object> map) throws Exception;
	
	//메인 카테고리 목록	
	public List<String> getMainCategory() throws Exception;

	//서브 카테고리 목록	
	public List<String> getSubCategory(String category) throws Exception;
	
	//상품 목록(카테고리,정렬 순서)
	public List<Map<String, Object>> goodsListOrdered(Map<String, Object> map) throws Exception;
	
	//상품 상세페이지의 상품 정보
	public List<Map<String, Object>> selectOneGood(Map<String, Object> map) throws Exception;
	
	//상품 상세페이지 이미지
	public List<Map<String, Object>> selectImage(Map<String, Object> map) throws Exception;
	
	//추천 상품 목록
	public List<Map<String, Object>> selectRelatedGoods(Map<String, Object> map) throws Exception;
	
	//상품검색
	public List<Map<String, Object>> goodsSearchList(Map<String, Object> map) throws Exception;

	//마이페이지 - 주문내역
	public List<Map<String, Object>> selectOrderList(String memberNum) throws Exception;

	public void OrderStateModi(Map<String, Object> map)throws Exception;

}
