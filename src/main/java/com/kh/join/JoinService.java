package com.kh.join;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface JoinService {
	
	//회원가입 폼으로 이동
    //회원가입시, ID중복체크 폼으로 이동
	
	//회원정보를 DB에 등록
	
	void insertMember(Map<String,Object> map, HttpServletRequest request)throws Exception;
	//회원탈퇴시 회원비밀번호 확인후, 회원정보를 DB에서 OFF로 수정(회원탈퇴)
   
	//회원가입 ID중복체크
	int checkId(String mem_id)throws Exception;

	
	int checkMember(Map<String, Object> map)throws Exception;

	
	
	
	
}
