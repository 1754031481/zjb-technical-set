package com.jk.dao.ztree;

import java.util.List;
import java.util.Map;

import com.jk.model.Role;

public interface RoleDao {
	public List<Role> showPageRole(Map<String, Object> QUERY_NAME) throws Exception;
	
	public Long countRole(Map<String, Object> QUERY_NAME) throws Exception;
	
	public void deleteRole(List<Integer> List) throws Exception;

	public void insertRole(Role role) throws Exception;

	public Role findRoleById(Role role) throws Exception;

	public void updateRole(Role role) throws Exception;

	public List<Role> getRoleZtree(Role role) throws Exception;

	public void addUserRoleRelation(List<Map<String, Object>> list) throws Exception;

	public void deleteUserRoleRelation(Integer userId) throws Exception;

	public void addRoleResource(List<Map<String, Object>> list) throws Exception;

	public void deleteRoleResource(Integer roleId) throws Exception;
}
