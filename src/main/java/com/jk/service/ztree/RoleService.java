package com.jk.service.ztree;

import java.util.List;
import java.util.Map;

import com.jk.model.Resource;
import com.jk.model.Role;

public interface RoleService {
	
	public List<Role> showPageRole(Role role,Integer page,Integer rows) throws Exception;
	
	public Long countRole(Role role) throws Exception;
	
	public void deleteRole(String ids) throws Exception;

	public void insertRole(Role role) throws Exception;

	public Role findRoleById(Role role) throws Exception;

	public void updateRole(Role role) throws Exception;

	public List<Role> getRoleZtree(Role role) throws Exception;

	public void addUserRoleRelation(String id, Integer userId) throws Exception;

	public void addRoleResource(String id, Integer roleId) throws Exception;

}
