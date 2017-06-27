package com.jk.service.ztree;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.jk.model.User;

public interface UserService {
	
	
	public void insertUser(User user) throws SQLException;
	
	public void deleteUser(User user) throws SQLException;
	
	public void updateUser(User user) throws SQLException;
	
	
	public void deleteUsers(String ids) throws Exception;
	
	public List<User> pageUser(User user,Integer page,Integer rows) throws Exception;
	
	public Long countUser(User user) throws Exception;

	public User showById(User user) throws Exception;

	public User login(User user) throws Exception;
	
	
	
}
