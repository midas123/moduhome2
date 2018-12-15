package com.kh.like;

import java.util.Map;


public interface LikeService {
	
	void likeSNSReg(Map<String,Object> map) throws Exception;

	String snsLikeCount(String article_seq) throws Exception;

	String snsLikeExist(Map<String,Object> map) throws Exception;

	void likeSNSDel(Map<String, Object> map) throws Exception;
	

}
