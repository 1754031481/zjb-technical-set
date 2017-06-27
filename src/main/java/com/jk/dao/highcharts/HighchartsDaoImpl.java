package com.jk.dao.highcharts;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

@Repository
public class HighchartsDaoImpl implements HighchartsDao {
	
	@Autowired
	@Qualifier("sqlMapClient")
	private SqlMapClient sqlMapClient;

	@SuppressWarnings("all")
	@Override
	public Integer showMember(Integer start) throws Exception {
		Integer count = (Integer) sqlMapClient.queryForObject("Member.showMember",start);
		
		return count;
	}
}
