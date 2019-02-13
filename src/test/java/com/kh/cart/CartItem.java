package com.kh.cart;

import java.util.HashMap;
import java.util.Map;

public class CartItem {
	private String GOODS_NUMBER;
	private String GOODS_KIND_NUMBER;
	private String CART_AMOUNT;
	private Map<String, Object> Item = new HashMap<>();
	
	public CartItem(String GOODS_KIND_NUMBER, String CART_AMOUNT, String GOODS_NUMBER) {
		this.GOODS_NUMBER = GOODS_NUMBER;
		this.GOODS_KIND_NUMBER = GOODS_KIND_NUMBER;
		this.CART_AMOUNT = CART_AMOUNT;
	}
	
	public Map<String, Object> makeItem(){
		Item.put("GOODS_NUMBER", getGOODS_NUMBER());
		Item.put("CART_AMOUNT", getCART_AMOUNT());
		Item.put("GOODS_KIND_NUMBER", getGOODS_KIND_NUMBER());
		return Item;
	}
	

	public String getGOODS_NUMBER() {
		return GOODS_NUMBER;
	}
	public void setGOODS_NUMBER(String gOODS_NUMBER) {
		GOODS_NUMBER = gOODS_NUMBER;
	}
	public String getGOODS_KIND_NUMBER() {
		return GOODS_KIND_NUMBER;
	}
	public void setGOODS_KIND_NUMBER(String gOODS_KIND_NUMBER) {
		GOODS_KIND_NUMBER = gOODS_KIND_NUMBER;
	}
	public String getCART_AMOUNT() {
		return CART_AMOUNT;
	}
	public void setCART_AMOUNT(String cART_AMOUNT) {
		CART_AMOUNT = cART_AMOUNT;
	}

	public Map<String, Object> getItem() {
		return Item;
	}

	public void setItem(Map<String, Object> item) {
		Item = item;
	}
	
}
