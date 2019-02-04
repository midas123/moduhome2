package com.kh.goods;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.kh.moduhome.AbstractDAO;

@Repository("goodsDAO")
public class GoodsDAO extends AbstractDAO{

	
	//스토어 메인, 상품 판매순 정렬
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> bestSellAll(Map<String, Object> map) throws Exception{
		return selectList("goods.bestSellAll", map);
	}
	
	//스토어 메인, 신상품순 정렬
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> newItemAll(Map<String, Object> map) throws Exception{
			return selectList("goods.newItemAll", map);
		}
	
	//스토어 세부 카테고리
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> goodsListOrdered(Map<String, Object> map) throws Exception{
		return selectList("goods.goodsListOrdered", map);
	}

	// 카테고리별 상품 정렬 소트 동적쿼리 (기본값  판매량수
	/*@SuppressWarnings("unchecked")
	public List<Map<String, Object>> sortGoodsCategory(Map<String, Object> map) throws Exception{
		return selectList("goods.sortGoodsCategory",map);
	}
	*/
	   
	/*@SuppressWarnings("unchecked")
	public List<Map<String, Object>> BestgoodsSubCategory(Map<String, Object> map) throws Exception {
	    return selectList("goods.bestGoods" , map);
	}
	*/
	//마이페이지 - 주문내역
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOrderList(String memberNum) throws Exception{
		return selectList("goods.selectOrderList", memberNum);
	}
	
	//소분류 카테고리 리스트
	@SuppressWarnings("unchecked")
	public List<String> getSubCategory(String category) throws Exception {
	    return selectList("goods.getSubCategory" , category);
	}
	
	//대분류 카테고리 리스트
	@SuppressWarnings("unchecked")
	public List<String> getMainCategory() throws Exception {
	    return selectList("goods.getMainCategory");
	}
	   
	   
	
	
	///////////////상세보기 (트랜잭션 묶음-->추후 추가)//////////////////
	//조회수증가
	public int goodsCountUp(Map<String, Object> map) throws Exception{
		return (int)update("goods.goodsCountUp",map);
	}
	//상품정보
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOneGood(Map<String, Object> map) throws Exception{
		return selectList("goods.selectOneGood",map);
	}
	//상품이미지
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectImage(Map<String, Object> map) throws Exception{
		return selectList("goods.selectImage",map);
	}
	
	//구매 여부 확인
	public int checkBuy(Map<String, Object> map) throws Exception{
		return (int)selectOne("goods.checkBuy",map);
	}
	
	//코디상품
	@SuppressWarnings("unchecked")
	  public Map<String, Object> selectRelatedGoods(Map<String, Object> map) throws Exception{
	      return selectOne1("goods.selectRelatedGoods",map);
	   }
	
	
	//리뷰평점
/*	@SuppressWarnings("unchecked")
	public int reviewScore(Map<String, Object> map) throws Exception{
		return (int)selectOne("goods.reviewScore",map);
	}*/
	//////////////////////////////상품 디테일 끝 //////////////////////////////////////////////
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> goodsSearchList(Map<String, Object> map) throws Exception{
	    return selectList("goods.goodsSearchList",map);
    }
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> goodsColorSearchList(Map<String, Object> map) throws Exception{
	    return selectList("goods.goodsColorSearchList",map);
    }
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> goodsSizeSearchList(Map<String, Object> map) throws Exception{
	    return selectList("goods.goodsSizeSearchList",map);
    }
	
	
	@SuppressWarnings("unchecked")
	public List<Map<String,Object>> selectCategoryCount(String category1) throws Exception{
	    return selectList("goods.selectCategoryCount",category1);
    }
	
	 void cancle_order(Map<String, Object> map) throws Exception{
		 update("goods.cancelOrder", map);
	 }
	 
	 void confirm_order(Map<String, Object> map) throws Exception{
		 update("goods.confirmOrder", map);
	 }

	public void Modify_Order(Map<String, Object> map)throws Exception {
		update("goods.ModiOrder",map);
		
	}
	
	

}
