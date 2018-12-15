package com.kh.adminQnA;

import java.util.List;
import java.util.Map;

public interface AdminQnaService {

	// Q&A 목록
	public List<Map<String, Object>> qnaList(Map<String, Object> map) throws Exception;
	
	// Q&A 상세보기
	public Map<String, Object> qnaDetail(Map<String, Object> map) throws Exception;
	
	// 관리자 페이지 답변달기
	public void updateReplyStep(Map<String, Object> map) throws Exception;
	
	// 관리자 Q&A 강제삭제
	public void adminQnaDelete(Map<String, Object> map) throws Exception;
	
	// 답변 삭제
	public void qnaReplyDelete(Map<String, Object> map) throws Exception;
	
	// 제목 & 카테고리 검색
	public List<Map<String, Object>> qnaTitleList(Map<String, Object> map) throws Exception;
	
	// 관리자 Q&A 카테고리 검색
	public List<Map<String, Object>> qnaCategoryList(Map<String, Object> map) throws Exception;
	
	// 관리자 Q&A 아이디 검색
	public List<Map<String, Object>> qnaSearchMemberList(Map<String, Object> map) throws Exception;
	
	// 관리자 Q&A 제목 검색
	public List<Map<String, Object>> qnaSearchTitleList(Map<String, Object> map) throws Exception;
	
	// 관리자 Q&A 답변 상태 검색
	public List<Map<String, Object>> qnaRepState(Map<String, Object> map) throws Exception; 
}
