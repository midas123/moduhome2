package com.kh.police;

import java.util.List;
import java.util.Map;

public interface PoliceService {

	void policeReg(Map<String, Object> map)throws Exception;

	List<Map<String, Object>> policelist() throws Exception;

	void Policedelete(String police_seq)throws Exception;

	String selectSNSnum(String string)throws Exception;

	void policeUpdateHide(String sns_num)throws Exception;

	void UpdateHideCancle(String sns_num)throws Exception;

}
