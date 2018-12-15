package com.kh.findMember;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("findDAO")
public class FindDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	
	// ���̵� ã��
	public String findID(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("find.findID",map);
	}
	
	// ��й�ȣ ã��
	public String findPW(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("find.findPW",map);
	}	
	
	
	// DB?��?�� ?��?��?��?�� 맞는 ?��메일�??��?���?
	public String findEmail(Map<String, Object> map) throws Exception{
		return sqlSession.selectOne("find.findEmail",map);
	}
	//DB?��?�� ?��?��?�� ?��?���? 비�?번호바꾸�?
	public void changePw(Map<String, Object> map) throws Exception{
		sqlSession.update("find.changePw",map);
	}

	
}
