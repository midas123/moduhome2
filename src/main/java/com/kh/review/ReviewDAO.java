package com.kh.review;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.kh.moduhome.AbstractDAO;

@Repository("reviewDAO")
public class ReviewDAO extends AbstractDAO {

	//리뷰 등록
	public void reviewWrite(Map<String, Object> map) throws Exception {
		insert("review.insertReview", map);
	}
	//리뷰 포인트 적립
	public void reviewPoint(Map<String, Object> map) throws Exception {
		insert("review.reviewPoint", map);
	}

	//리뷰 이미지 등록
	public void reviewImageWrite(Map<String, Object> map) throws Exception {
		update("review.insertReviewImage", map);
	}

	//리뷰 삭제
	public void reviewDelete(Map<String, Object> map) throws Exception {
		delete("review.reviewDelete", map);
	}

	//리뷰 목록
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectReview(Map<String, Object> map) throws Exception{
		return selectList("review.selectReview",map);
	}
	
	//리뷰 작성 여부 확인
	public int reviewCheck(Map<String, Object> map) throws Exception {
		return (int) selectOne("review.checkReview", map);
	}
	
	//전체 리스트(Admin Page)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> reviewList(Map<String, Object> map) throws Exception {
		return selectList("review.reviewList", map);
	}
	
	//리뷰 검색(회원 ID)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchReviewList0(Map<String, Object> map) throws Exception {
		return selectList("review.searchReviewList0", map);
	}
	
	//리뷰 검색(상품 이름)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchReviewList1(Map<String, Object> map) throws Exception {
		return selectList("review.searchReviewList1", map);
	}
	
	//리뷰 검색(상품 번호)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> searchReviewList2(Map<String, Object> map) throws Exception {
		return selectList("review.searchReviewList2", map);
	}
}


