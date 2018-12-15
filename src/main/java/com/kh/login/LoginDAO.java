package com.kh.login;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.kh.moduhome.AbstractDAO;

@Repository("loginDAO")
public class LoginDAO extends AbstractDAO {
     
	   //로그인 정보 불러오기
 	   @SuppressWarnings("unlocked")
 	   public Map<String, Object>selectId(Map<String,Object> map)throws Exception{
 		   return (Map<String, Object>)selectOne("member.loginGo", map);
 	   }
}
