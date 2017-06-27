package com.jk.service.ztree;

import java.util.List;
import java.util.Map;
import java.util.Set;

import com.jk.model.Menu;
import com.jk.model.Resource;
import com.jk.model.Role;
import com.jk.model.User;

public interface MenuService {

	List<Menu> getMenuNodes(Menu menu) throws Exception;

	List<Menu> getMenuAsyncNodes(Menu menu) throws Exception;

	void addMenu(Menu menu) throws Exception;

	void deleteMenu(Menu menu) throws Exception;

	void updateAfterSave(Menu menu) throws Exception;

	List<Role> showRole(Integer page, Integer rows,Role role) throws Exception;

	Long countRole(Role role) throws Exception;

	List<User> showUser(User user, Integer page, Integer rows) throws Exception;

	Long countUser(User user) throws Exception;

	List<Resource> getNodesResource(Resource resource) throws Exception;

	Set<Map<String, Object>> getResourceZtree(User user) throws Exception;

}
