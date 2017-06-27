package com.jk.dao.ztree;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.jk.model.Menu;
import com.jk.model.Resource;
import com.jk.model.Role;
import com.jk.model.User;

@Repository
public class MenuDaoImpl implements MenuDao {
	
	@Autowired
	@Qualifier("sqlMapClient")
	private SqlMapClient sqlMapClient;

	/**
	 * ztree同步树
	 */
	@Override
	public List<Menu> getMenuNodes(Menu menu) throws Exception {
		List<Menu> queryForMenuNodes = sqlMapClient.queryForList("Menu.getMenuNodes", menu);
		return queryForMenuNodes;
	}

	@Override
	public List<Menu> getMenuAsyncNodes(Menu menu) throws Exception {
		List queryAsyncMenuList = sqlMapClient.queryForList("Menu.getMenuAsyncNodes", menu);
		return queryAsyncMenuList;
	}

	@Override
	public void addMenu(Menu menu) throws Exception {
		sqlMapClient.insert("Menu.addMenu", menu);
	}

	@Override
	public void deleteMenu(Menu menu) throws Exception {
		sqlMapClient.delete("Menu.deleteMenu", menu);
	}

	@Override
	public void updateAfterSave(Menu menu) throws Exception {
		sqlMapClient.update("Menu.updateAfterSave", menu);
	}

	@Override
	public List<Role> showRole(Map<String, Object> map) throws Exception {
		List<Role> roleList = sqlMapClient.queryForList("Role.showRole", map);
		return roleList;
	}

	@Override
	public Long countRole(Map<String, Object> map) throws Exception {
		
		return (Long) sqlMapClient.queryForObject("Role.countRole", map);
	}

	@Override
	public List<User> showUser(Map<String, Object> map) throws Exception {
		List<User> UserList = sqlMapClient.queryForList("User.showUser", map);
		return UserList;
	}

	@Override
	public Long countUser(Map<String, Object> map) throws Exception {
		return (Long) sqlMapClient.queryForObject("User.countUser", map);
	}

	@Override
	public List<Resource> getNodesResource(Resource resource) throws Exception {
		List<Resource> resourceList = sqlMapClient.queryForList("Role.getNodesResource", resource);
		return resourceList;
	}

	@Override
	public List<Map<String, Object>> getResourceZtree(User user) throws Exception {
		return sqlMapClient.queryForList("Resource.getResourceZtree", user);
	}

	
}
