package com.kh.review;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface ReviewService {

	// 전체 리스트(Admin Page)
	List<Map<String, Object>> reviewList(Map<String, Object> map) throws Exception;

	// 리뷰 삭제(Admin Page)
	void reviewDelete(Map<String, Object> map) throws Exception;

	// 리뷰 검색
	public List<Map<String, Object>> searchReviewList0(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> searchReviewList1(Map<String, Object> map) throws Exception;

	public List<Map<String, Object>> searchReviewList2(Map<String, Object> map) throws Exception;


	// 리뷰 등록
	public void reviewWrite(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	public void reviewPoint(Map<String, Object> map) throws Exception;



}
