package com.jk.service.highcharts;

import java.util.List;
import java.util.Map;

import com.jk.model.Member;

public interface HighchartsService {

	List<Map<String,Object>> showMember(Member member) throws Exception;

}
