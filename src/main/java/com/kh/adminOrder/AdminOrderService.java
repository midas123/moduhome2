package com.kh.adminOrder;

import java.util.List;
import java.util.Map;

public interface AdminOrderService {

	// 전체 주문리스트
	public List<Map<String, Object>> allOrderList(Map<String, Object> map) throws Exception;

	// 결제 상태 변경
	public void updateGoodsPayState(Map<String, Object> map) throws Exception;

	// 상품 구매확정/주문취소/교환,반품 상태변경
	public void updateGoodsState(Map<String, Object> map) throws Exception;

	// 배송 상태 변경
	public void updateDeliveryState(Map<String, Object> map) throws Exception;

	// 주문내역 수정폼(디테일)
	public List<Map<String, Object>> orderDetail(Map<String, Object> map) throws Exception;

	// 주문삭제
	public void orderDelete(Map<String, Object> map) throws Exception;

	// 카테고리 검색
	public List<Map<String, Object>> adminOrderSearch0(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> adminOrderSearch1(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> adminOrderSearch2(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> adminOrderSearch3(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> adminOrderSearch4(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> adminOrderSearch5(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> adminOrderSearch6(Map<String, Object> map) throws Exception;

	// 해당 주문에 대한 캔슬있나 확인
	public Map<String, Object> confirmCancel(Map<String, Object> map) throws Exception;

	// 주문취소 목록
	public List<Map<String, Object>> allCancelList(Map<String, Object> map) throws Exception;

	// 주문반품/교환목록
	public List<Map<String, Object>> allExchangeList(Map<String, Object> map) throws Exception;

	// 주문취소 검색
	public List<Map<String, Object>> allCancelSearch1(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> allCancelSearch2(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> allCancelSearch3(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> allCancelSearch4(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> allCancelSearch5(Map<String, Object> map) throws Exception;

	// 교환/반품 검색
	public List<Map<String, Object>> allExchangeSearch1(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> allExchangeSearch2(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> allExchangeSearch3(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> allExchangeSearch4(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> allExchangeSearch5(Map<String, Object> map) throws Exception;
	
	public List<Map<String, Object>> allExchangeSearch6(Map<String, Object> map) throws Exception;
}
