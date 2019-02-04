package com.kh.qna;

import java.util.*;

import org.springframework.stereotype.Repository;
import com.kh.moduhome.AbstractDAO;


@Repository("qnaDAO")
public class QnaDAO extends AbstractDAO{
	//Q&A 작성
	public void insertModalQna(Map<String, Object> map) throws Exception {	
		insert("qna.insertModalQna", map);
	}
	
	//Q&A 삭제
	public void qnaDelete(Map<String, Object> map) throws Exception {
		delete("qna.qnaDelete", map);
	}

	//Q&A 목록
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectQNA(Map<String, Object> map) throws Exception{
		return selectList("qna.selectQNA",map);
	}
	
	//전체 리스트(Admin Page)
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> qnaList(Map<String, Object> map) throws Exception {
		return selectList("qna.qnaList", map);
	}
}
