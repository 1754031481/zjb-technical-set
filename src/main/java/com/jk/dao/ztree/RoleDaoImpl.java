package com.jk.dao.ztree;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.jk.model.Role;

@Repository
public class RoleDaoImpl implements RoleDao {
	
	@Autowired
	@Qualifier("sqlMapClient")
	private SqlMapClient sqlMapClient;

	@Override
	public List<Role> showPageRole(Map<String, Object> QUERY_NAME) throws Exception {
		List queryRole = sqlMapClient.queryForList("Role.showPageRole", QUERY_NAME);
		return queryRole;
	}

	@Override
	public Long countRole(Map<String, Object> QUERY_NAME) throws Exception {
		
		return (Long) sqlMapClient.queryForObject("Role.countRole", QUERY_NAME);
	}

	@Override
	public void deleteRole(List<Integer> List) throws Exception {
		sqlMapClient.delete("Role.deleteRole", List);
	}

	@Override
	public void insertRole(Role role) throws Exception {
		sqlMapClient.insert("Role.insertRole", role);
	}

	@Override
	public Role findRoleById(Role role) throws Exception {
		return (Role) sqlMapClient.queryForObject("Role.findRoleById", role);
	}

	@Override
	public void updateRole(Role role) throws Exception {
		sqlMapClient.update("Role.updateRole", role);
	}

	@Override
	public List<Role> getRoleZtree(Role role) throws Exception {
		List<Role> roleTreeList = sqlMapClient.queryForList("Role.getRoleZtree", role);
		return roleTreeList;
	}

	@Override
	public void addUserRoleRelation(List<Map<String, Object>> list) throws Exception {
		sqlMapClient.insert("Role.addUserRoleRelation",list);
	}

	@Override
	public void deleteUserRoleRelation(Integer userId) throws Exception {
		sqlMapClient.delete("Role.deleteUserRoleRelation", userId);
	}

	@Override
	public void addRoleResource(List<Map<String, Object>> list) throws Exception {
			sqlMapClient.insert("Role.addRoleResource",list);
	}

	@Override
	public void deleteRoleResource(Integer roleId) throws Exception {
		sqlMapClient.delete("Role.deleteRoleResource",roleId);
	}
	
}
