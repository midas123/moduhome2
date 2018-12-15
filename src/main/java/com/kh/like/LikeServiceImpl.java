package com.kh.like;


import java.util.Map;

import javax.annotation.Resource;


import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;


@Service("likeService")
public class LikeServiceImpl implements LikeService {
        
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "likeDao")
	private LikeDao likeDao;
	
	@Override
	public void likeSNSReg(Map<String,Object> map) throws Exception{
		likeDao.likeSNSReg(map); 
	}
	
	@Override
	public void likeSNSDel(Map<String, Object> map)throws Exception{
		likeDao.likeSNSDel(map);
	}
	
	@Override
	public String snsLikeCount(String article_seq) throws Exception{
	     
		    return likeDao.SNSLikeCount(article_seq);  
	}
	
	@Override
	public String snsLikeExist(Map<String,Object> map) throws Exception{
	     
		    return likeDao.SNSLikeExist(map); 
	}


	
	
}
