package com.kh.findMember;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

@Service("findService")
public class FindServiceImpl implements FindService{
	
	@Resource(name="findDAO")
	private FindDAO findDAO;
	
	//���̵� ã��
	@Override 
	public String findID(Map<String, Object> map) throws Exception {
		return findDAO.findID(map);
	}
	
	//��й�ȣ ã��
	@Override 
	public String findPW(Map<String, Object> map) throws Exception {
		return findDAO.findPW(map);
	}	

	@Override //?��?��?��?�� 맞는 ?��메일불러?���?
	public String findEmail(Map<String, Object> map) throws Exception {
		return findDAO.findEmail(map);
	}


	@Override //?��?��?�� ?��?���? 비�?번호바꾸�?
	public void changePw(Map<String, Object> map) throws Exception {
		findDAO.changePw(map);
	}

}
