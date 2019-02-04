package com.kh.qna;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface QnaService {
	//Q&A 작성
	void insertModalQna(Map<String, Object> map, HttpServletRequest request) throws Exception;

	//Q&A 삭제
	void qnaDelete(Map<String, Object> map) throws Exception;
	
	//Q&A 목록
    public List<Map<String, Object>> selectQNA(Map<String, Object> map) throws Exception;
		
}
