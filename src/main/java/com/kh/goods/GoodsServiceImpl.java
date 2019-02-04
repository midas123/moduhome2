package com.kh.goods;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService{
	
	@Resource(name="goodsDAO")
	private GoodsDAO goodsDAO;
	
	//스토어 메인, 상품 판매순 정렬
	@Override
	public List<Map<String, Object>> bestSellAll(Map<String, Object> map) throws Exception {
		return goodsDAO.bestSellAll(map);
	}
	
	//스토어 메인, 상품 판매순 정렬
	@Override
	public List<Map<String, Object>> newItemAll(Map<String, Object> map) throws Exception {
		return goodsDAO.newItemAll(map);
	}
	
	//스토어 세부 카테고리
	@Override
	public List<Map<String, Object>> goodsListOrdered(Map<String, Object> map) throws Exception {
		return goodsDAO.goodsListOrdered(map);
	}

	@Override
	public List<String> getSubCategory(String category) throws Exception {
	    return goodsDAO.getSubCategory(category);
	}
	
	@Override
	public List<String> getMainCategory() throws Exception {
	    return goodsDAO.getMainCategory();
	}
        
	@Override
	public List<Map<String, Object>> selectOneGood(Map<String, Object> map) throws Exception {
		return goodsDAO.selectOneGood(map);
	}

	@Override
	public List<Map<String, Object>> selectImage(Map<String, Object> map) throws Exception {
		return goodsDAO.selectImage(map);
	}

	@Override
	public List<Map<String, Object>> selectRelatedGoods(Map<String, Object> map) throws Exception {
		
	      List<Map<String, Object>> relatedGoodsList = new ArrayList<Map<String, Object>>();
	      Map<String, Object> goodsNum = new HashMap<String, Object>();

	         if (map.get("GOODS_RELEVANT") != null) {
	            String coordi = (String) map.get("GOODS_RELEVANT");
	              String[] coordis = coordi.split(",");
	              System.out.println("GOODS_RELEVANT :" +coordis);

	              for(String a : coordis) {
	                 goodsNum.put("GOODS_NUMBER", a);
	                 System.out.println("goodsNum.GOODS_NUMBER :" +goodsNum.get("GOODS_NUMBER"));
	                 Map<String, Object> related = goodsDAO.selectRelatedGoods(goodsNum);
	                 if (related != null) {
	                   relatedGoodsList.add(related);
	                }
	                 
	              }
	         }
	           return relatedGoodsList;
	}
	
	@Override
	public List<Map<String, Object>> goodsSearchList(Map<String, Object> map) throws Exception {
		return goodsDAO.goodsSearchList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectOrderList(String memberNum) throws Exception {
		return goodsDAO.selectOrderList(memberNum);
	}
		
	
	@Override
	public void OrderStateModi(Map<String, Object> map) throws Exception {
		goodsDAO.Modify_Order(map);
		
	}
	

}
