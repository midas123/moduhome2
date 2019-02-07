package com.kh.order;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.kh.moduhome.AbstractDAO;

@Repository("orderDAO")

public class OrderDAO extends AbstractDAO {
	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> orderMember(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("goods.orderMember", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> orderGoods(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("goods.orderGoods", map);
	}

	public Object createDeliveryList(Map<String, Object> map) throws Exception {
		return  insert("goods.createDeliveryList", map);
	}
	
	public Object createOrderList(Map<String, Object> map) throws Exception {
		return  insert("goods.createOrderList", map);
	}
	
	public Object goodsCountDown(Map<String, Object> map) throws Exception {
		return  update("goods.goodsCountDown", map);
	}
	
	public Object insertPoint(Map<String, Object> map) throws Exception {
		return  insert("goods.insertPoint", map);
	}

	
}
