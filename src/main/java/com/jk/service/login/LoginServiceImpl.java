package com.jk.service.login;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jk.dao.login.LoginDao;
import com.jk.model.Role;
import com.jk.model.User;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	private LoginDao loginDao;

	@Override
	public User loginSystem(User user) throws Exception {
		User login = loginDao.loginSystem(user);
		return login;
	}

	@Override
	public User getResourcesList(User user) throws Exception {
		Set<String> set=new HashSet<>();
		Set<Role> roles=new HashSet<>();
		List<Map<String, Object>> resourcesList=loginDao.getResourcesList(user);
		for (Map<String, Object> map : resourcesList) {
			if(map.get("url")!=null && !"".equals(map.get("url"))){
				set.add(map.get("url").toString());
			}
			Role role=new Role();
			role.setId((Integer)map.get("ID"));
			role.setName(map.get("NAME").toString());
			roles.add(role);
		}
		user.setResources(set);
		user.setRoles(roles);
		return user;
	}

}
