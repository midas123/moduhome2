package com.kh.cart;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import com.kh.moduhome.AbstractDAO;

@Repository("cartDAO")
public class CartDAO extends AbstractDAO {

	// 장바구니 등록
	public void insertCart(Map<String, Object> map) throws Exception {
		insert("cart.insertCart", map);
	}
	
	// 장바구니에 중복 상품 확인
	@SuppressWarnings("unchecked")
	public Map<String, Object> duplicateCart(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("cart.duplicateCart", map);
	}

	// 회원 개인의 장바구니 목록 
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMyCart(Map<String, Object> map) throws Exception {
		return selectList("cart.selectMyCart", map);
	}

	// 세션에서 장바구니 목록 정보 불러오기
	@SuppressWarnings("unchecked")
	public Map<String, Object> sessionCartList(Map<String, Object> map) throws Exception {
		return (Map<String, Object>) selectOne("cart.sessionCartList", map);
	}

	// 장바구니 삭제
	public void deleteMyCart(Map<String, Object> map) throws Exception {
		delete("cart.deleteMyCart", map);
	}

	// 장바구니 수정(옵션변경)
	public void updateCarts(Map<String, Object> map) throws Exception {
		update("cart.updateCarts", map);
	}

	//7일 이상 지난 장바구니 상품 삭제
	public void cleanUpCarts(Map<String, Object> map) throws Exception {
		delete("cart.cleanUpCarts", map);
	}

}
