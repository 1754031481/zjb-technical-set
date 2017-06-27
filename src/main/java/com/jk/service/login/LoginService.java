package com.jk.service.login;

import com.jk.model.User;

public interface LoginService {

	User loginSystem(User user) throws Exception;

	User getResourcesList(User user) throws Exception;


}
