package com.jk.service.highcharts;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.jk.dao.highcharts.HighchartsDao;
import com.jk.model.Member;

@Service
public class HighchartsServiceImpl implements HighchartsService{
	
	@Autowired
	private HighchartsDao highchartsDao;
	
	@SuppressWarnings("all")
	@Override
	public List<Map<String,Object>> showMember(Member member )throws Exception {
		List<Map<String,Object>> resList = new ArrayList<>();
		if ( member.getStartTime()!=null &&  !member.getStartTime().equals("") && member.getEndTime()!=null &&  !member.getEndTime().equals("")) {
		String startMonth =  member.getStartTime().substring(5, 7);
		String endMonth =  member.getEndTime().substring(5, 7);
		if (startMonth.substring(0,1).equals("0")) {
			startMonth = startMonth.substring(1,2);
		}
		if (endMonth.substring(0,1).equals("0")) {
			endMonth = endMonth.substring(1,2);
		}
		List list =  equalsSE(Integer.valueOf(startMonth),Integer.valueOf(endMonth));
		Map map =new HashMap<>();
		for (int i = 0; i < list.size(); i++) {
			Integer count =  highchartsDao.showMember((Integer) list.get(i));
			map.put("X", list.get(i));
			map.put("Count", count);
			resList.add(map);
		}
	}
		return resList;
	}
	
	
	public void iterater(Integer start,Integer end  ){
		 Integer starts = start+1;
		 equalsSE(starts,end);
	}
	
	public List equalsSE(Integer start ,Integer end ){
		List list = new ArrayList<>();
		 list.add(start);
		if (start != end ) {
			iterater(start,end);
		}
			return list;
	}
	
}
