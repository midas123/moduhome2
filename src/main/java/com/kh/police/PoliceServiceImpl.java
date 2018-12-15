package com.kh.police;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;


@Service("policeService")
public class PoliceServiceImpl implements PoliceService {
         
	@Resource(name = "policeDao")
	private  PoliceDao policeDao;
	
	@Override
	public void policeReg(Map<String,Object> map) throws Exception{
		policeDao.policeReg(map); 
	}

	@Override
	public List<Map<String, Object>> policelist() throws Exception {
		
		List<Map<String, Object>> policeList = policeDao.policeList();
	      return policeList;
	}

	@Override
	public void Policedelete(String police_seq) throws Exception {
		policeDao.PoliceDelete(police_seq);
		
	}
    
	/*police테이블에서 sns_number 가져오기*/
	@Override
	public String selectSNSnum(String police_num) throws Exception {
		return policeDao.selectSNSnum(police_num); 
	}

	@Override
	public void policeUpdateHide(String sns_num) throws Exception {
		policeDao.updateHide(sns_num);
		
	}

	@Override
	public void UpdateHideCancle(String sns_num) throws Exception {
		policeDao.updateHideCancle(sns_num);
		
	}
	
	
}
