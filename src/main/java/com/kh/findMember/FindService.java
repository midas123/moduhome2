package com.kh.findMember;

import java.util.Map;

public interface FindService {

	
	//���̵� ã��
	String findID(Map<String, Object> map) throws Exception;

	//��й�ȣ ã��
	String findPW(Map<String, Object> map) throws Exception;
	
	// DB?��?�� ?��?��?��?�� 맞는 ?��메일�??��?���?
	String findEmail(Map<String, Object> map) throws Exception;
	
	// DB?��?�� ?��?��?�� ?��?���? 비�?번호 바꾸�?
	void changePw(Map<String, Object> map) throws Exception;
}
