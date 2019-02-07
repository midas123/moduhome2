package com.kh.order;

import java.util.Map;

public interface OrderService {
	//주문자 정보 가져오기
	Map<String, Object> orderMember(Map<String, Object> map) throws Exception;
	//주문 상품 정보 가져오기
	Map<String, Object> orderGoods(Map<String, Object> map) throws Exception;
	//주문 트랜잭션 처리
	public void orderGoodsAction(Map<String, Object> map) throws Exception;
	//배송 정보 생성
	public Object createDeliveryList(Map<String, Object> map) throws Exception;
	//주문 정보 생성
	public Object createOrderList(Map<String, Object> map) throws Exception;
	//상품 재고 차감
	public Object goodsCountDown(Map<String, Object> map) throws Exception;
	//포인트 사용 및 적립
	public Object insertPoint(Map<String, Object> map) throws Exception;
	//주문 코드 생성
	public String makeOrderCode() throws Exception;
}
