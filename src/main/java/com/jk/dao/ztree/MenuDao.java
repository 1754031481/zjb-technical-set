package com.jk.dao.ztree;

import java.util.List;
import java.util.Map;

import com.jk.model.Menu;
import com.jk.model.Resource;
import com.jk.model.Role;
import com.jk.model.User;

public interface MenuDao {

	List<Menu> getMenuNodes(Menu menu) throws Exception;

	List<Menu> getMenuAsyncNodes(Menu menu) throws Exception;

	void addMenu(Menu menu) throws Exception;

	void deleteMenu(Menu menu) throws Exception;

	void updateAfterSave(Menu menu) throws Exception;

	List<Role> showRole(Map<String, Object> map) throws Exception;

	Long countRole(Map<String, Object> map) throws Exception;

	List<User> showUser(Map<String, Object> map) throws Exception;

	Long countUser(Map<String, Object> map) throws Exception;

	List<Resource> getNodesResource(Resource resource) throws Exception;

	List<Map<String, Object>> getResourceZtree(User user) throws Exception;

}
