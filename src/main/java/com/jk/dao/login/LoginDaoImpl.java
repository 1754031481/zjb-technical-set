package com.jk.dao.login;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.jk.model.User;

@Repository
public class LoginDaoImpl implements LoginDao{
	
	@Autowired
	@Qualifier("sqlMapClient")
	private SqlMapClient sqlMapClient;

	@Override
	public User loginSystem(User user) throws Exception {
		User login = (User) sqlMapClient.queryForObject("User.loginSystem",user);
		return login;
	}

	@Override
	public List<Map<String, Object>> getResourcesList(User user) throws Exception {
		return sqlMapClient.queryForList("User.getResourcesList", user);
	} 
	
}
