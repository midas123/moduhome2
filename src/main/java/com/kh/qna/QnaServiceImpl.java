package com.kh.qna;


import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;
import com.kh.moduhome.GoodsImageUtils;

@Service("qnaService")
public class QnaServiceImpl implements QnaService {
	@Resource(name = "qnaDAO")
	private QnaDAO qnaDAO;
	
	//Q&A 작성
	@Override
	public void insertModalQna(Map<String, Object> map, HttpServletRequest request) throws Exception {
		qnaDAO.insertModalQna(map);
	}
	
	//Q&A 삭제
	@Override
	public void qnaDelete(Map<String, Object> map) throws Exception {
		qnaDAO.qnaDelete(map);

	}
	//Q&A 목록
	@Override
	public List<Map<String, Object>> selectQNA(Map<String, Object> map) throws Exception {
		return qnaDAO.selectQNA(map);
	}

	
	
}
