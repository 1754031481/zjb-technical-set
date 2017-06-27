package com.jk.dao.login;

import java.util.List;
import java.util.Map;

import com.jk.model.User;

public interface LoginDao {

	User loginSystem(User user) throws Exception;

	List<Map<String, Object>> getResourcesList(User user) throws Exception;

}
