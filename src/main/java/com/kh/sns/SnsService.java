package com.kh.sns;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface SnsService {


	// 스토리 삭제
	public void snsDelete(Map<String, Object> map) throws Exception;
	
	/*// 스토리 리스트
	public List<Map<String, Object>> snsList(Map<String, Object> map) throws Exception;*/
	
	// 스토리 등록
	public void snsInsert(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	//스토리 숨기기
	public void snsHide(String sns_num)throws Exception;

	public void snsHideCancel(String sns_num)throws Exception;

	public void updateLike(Map<String, Object> map)throws Exception;

	public List<Map<String, Object>> snsList(String MEMBER_NUMBER)throws Exception;
    
	/*좋아요 감소*/
	public void downLike(Map<String, Object> map)throws Exception;
	
	public int snsWriter(String sns_number) throws Exception;

	public List<Map<String, Object>> snsMyList(int mEMBER_NUMBER) throws Exception;
}
