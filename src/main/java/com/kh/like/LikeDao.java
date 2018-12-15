package com.kh.like;


import java.util.Map;

import org.springframework.stereotype.Repository;
import com.kh.moduhome.AbstractDAO;

@Repository("likeDao")
public class LikeDao extends AbstractDAO{
        
	public void likeSNSReg(Map<String, Object> map)throws Exception{
		insert("like.likeReg",map);
	}
	
	public void likeSNSDel(Map<String, Object> map) {
		
		 delete("like.likeDel", map);
	}
	
	public String SNSLikeCount(String article_seq) {
		
		
		String like_count = (String) selectOne("like.snsLikeCount",article_seq);
		
		return like_count;
	}
	
	public String SNSLikeExist(Map<String, Object> map)throws Exception {
		
		return (String)selectOne("like.SNSLikeExist", map);
		
	}

		
	
}
