package com.kh.order;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Service("orderService")
public class OrderServiceImpl implements OrderService {

	@Resource(name = "orderDAO")
	private OrderDAO orderDAO;

	@Autowired
	private DataSourceTransactionManager transactionManager;
	
	@Override
	public Map<String, Object> orderMember(Map<String, Object> map) throws Exception {
		return orderDAO.orderMember(map);
	}

	@Override
	public Map<String, Object> orderGoods(Map<String, Object> map) throws Exception {
		return orderDAO.orderGoods(map);
	}

	@Override
	public void orderGoodsAction(Map<String, Object> map) throws Exception {
		//트랜잭션 설정
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setName("GoodsOrderTx");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		//트랜잭션 시작
		TransactionStatus status = transactionManager.getTransaction(def);
		try {
		//배송 정보 생성
		orderDAO.createDeliveryList(map);
		//주문서 생성
		if(map.get("kinds[]") instanceof String) { //단품
			map.put("GOODS_KIND_NUMBER", map.get("kinds[]"));
			map.put("ORDER_AMOUNT", map.get("ea[]"));
			map.put("GOODS_NUMBER", map.get("GOODS_NUMBER[]"));
			List<BigDecimal> orderPrice = (List<BigDecimal>) map.get("ORDER_TOTAL_PRICE[]");
			map.put("ORDER_TOTAL_PRICE", orderPrice.get(0));
			orderDAO.createOrderList(map);
		} else { //여러개 상품
			String[] goodsKindNum = (String[]) map.get("kinds[]");
			String[] ea = (String[]) map.get("ea[]");
			String[] goodsNum = (String[]) map.get("GOODS_NUMBER[]");
			List<BigDecimal> orderPrices = (List<BigDecimal>) map.get("ORDER_TOTAL_PRICE[]");
			
			for(int i=0; i<goodsKindNum.length; i++) {
				map.put("GOODS_KIND_NUMBER", Integer.parseInt(goodsKindNum[i]));
				map.put("ORDER_AMOUNT", Integer.parseInt(ea[i]));
				map.put("GOODS_NUMBER", Integer.parseInt(goodsNum[i]));
				map.put("ORDER_TOTAL_PRICE", orderPrices.get(i));
				orderDAO.createOrderList(map);
			}
		}
		
		//상품 재고 수량 빼기
		orderDAO.goodsCountDown(map);
		//포인트 적립
		if (map.get("usePoint") != null) {
			if(!((String)map.get("usePoint")).isEmpty()){
				int usePoint = Integer.parseInt((String)map.get("usePoint"));
				if (usePoint != 0) {
					int POINT_POINT = -(usePoint);
					System.out.println("POINT_POINT" + POINT_POINT);
					map.put("POINT_POINT", POINT_POINT);
					map.put("POINT_CONTENT", "상품 구매");
					orderDAO.insertPoint(map);
				}
			  }
		}
		}catch (Exception ex) {
			transactionManager.rollback(status);
			System.out.println("#####주문 처리 중 에러발생");
			  throw ex;
			}
		//트랜잭션 종료
		transactionManager.commit(status);
	}

	@Override
	public Object createDeliveryList(Map<String, Object> map) throws Exception {
		
		return orderDAO.createDeliveryList(map);
	}

	@Override
	public Object createOrderList(Map<String, Object> map) throws Exception {
		return orderDAO.createOrderList(map);
	}

	@Override
	public Object goodsCountDown(Map<String, Object> map) throws Exception {
		return orderDAO.goodsCountDown(map);
	}

	@Override
	public Object insertPoint(Map<String, Object> map) throws Exception {
		return orderDAO.insertPoint(map);
	}
	
	@Override
	public String makeOrderCode() throws Exception {
		StringBuffer temp = new StringBuffer();
		Random rnd = new Random();
		for (int i = 0; i < 5; i++) {
			temp.append((char) ((rnd.nextInt(26)) + 65));
		}
		Date d = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String date = sdf.format(d);
		String ORDER_CODE = ("S" + date + temp);
		
		return ORDER_CODE;
	}
}
