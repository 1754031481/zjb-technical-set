package com.jk.service.ztree;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jk.dao.ztree.MenuDao;
import com.jk.model.Menu;
import com.jk.model.Resource;
import com.jk.model.Role;
import com.jk.model.User;

@Service
public class MenuServiceImpl implements MenuService {
	
	@Autowired
	private MenuDao menuDao;

	/**
	 * 同步树
	 * @throws Exception 
	 */
	@Override
	public List<Menu> getMenuNodes(Menu menu) throws Exception {
		List<Menu> menuNodes=menuDao.getMenuNodes(menu);
		return menuNodes;
	}

	/**
	 * 异步树
	 * @throws Exception 
	 */
	@Override
	public List<Menu> getMenuAsyncNodes(Menu menu) throws Exception {
		List<Menu> menuAsyncNodes=new ArrayList<>();
		if(null!=menu && null!=menu.getId()){
			menuAsyncNodes= menuDao.getMenuNodes(menu);
		}else{
			menuAsyncNodes=menuDao.getMenuAsyncNodes(menu);
		}
		List<Menu> list=new ArrayList<>();
		for (Menu menu2 : menuAsyncNodes) {
			if(isExsitChildrenNode(menu2)){
				menu2.setIsParent("true");
			}
			list.add(menu2);
		}
		return list;
	}

	public boolean isExsitChildrenNode(Menu menu) throws Exception {
		boolean flag=false;
		List<Menu> menuNodes = menuDao.getMenuNodes(menu);
		if (menuNodes != null && menuNodes.size() > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public void addMenu(Menu menu) throws Exception {
		menuDao.addMenu(menu);
	}

	@Override
	public void deleteMenu(Menu menu) throws Exception {
		menuDao.deleteMenu(menu);
	}

	@Override
	public void updateAfterSave(Menu menu) throws Exception {
		menuDao.updateAfterSave(menu);
	}

	@Override
	public List<Role> showRole(Integer page, Integer rows,Role role) throws Exception {
		Map<String, Object> map=new HashMap<>();
		map.put("name", role.getName());
		map.put("description", role.getDescription());
		map.put("iconCls", role.getIconCls());
		map.put("seq", role.getSeq());
		map.put("createdatetime", role.getCreatedatetime());
		map.put("updatedatetime", role.getUpdatedatetime());
		map.put("page", (page-1)*rows);
		map.put("rows", rows);
		return menuDao.showRole(map);
	}

	@Override
	public Long countRole(Role role) throws Exception {
		Map<String, Object> map=new HashMap<>();
		map.put("name", role.getName());
		Long countRole=menuDao.countRole(map);
		return countRole;
	}

	@Override
	public List<User> showUser(User user, Integer page, Integer rows) throws Exception {
		Map<String, Object> map=new HashMap<>();
		map.put("name", user.getName());
		map.put("pwd", user.getPwd());
		map.put("startDate", user.getStartDate());
		map.put("endDate", user.getEndDate());
		map.put("page", (page-1)*rows);
		map.put("rows", rows);
		return menuDao.showUser(map);
	}

	@Override
	public Long countUser(User user) throws Exception {
		Map<String, Object> map=new HashMap<>();
		map.put("name", user.getName());
		map.put("startDate", user.getStartDate());
		map.put("endDate", user.getEndDate());
		Long countUser=menuDao.countUser(map);
		return  countUser; 
	}

	@Override
	public List<Resource> getNodesResource(Resource resource) throws Exception {
		List<Resource> resourceList= menuDao.getNodesResource(resource);
		return resourceList;
	}

	@Override
	public Set<Map<String, Object>> getResourceZtree(User user) throws Exception {
		List<Map<String, Object>> getResourceZtree = menuDao.getResourceZtree(user);
		Set<Map<String, Object>> set = new HashSet<>();
		for (Map<String, Object> map : getResourceZtree) {
			set.add(map);
		}
		return set;
	}
}
