package com.jk.controller.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jk.controller.BaseController;
import com.jk.model.RoleGrant;
import com.jk.model.User;
import com.jk.service.login.LoginService;
import com.jk.util.Json;
import com.sun.istack.internal.logging.Logger;

@Controller
@RequestMapping("LoginController")
public class LoginController extends BaseController{
	
	private static final Logger logger=Logger.getLogger(LoginController.class);
	
	@Autowired
	private LoginService loginService;
	
	/**
	 * 注销系统
	 */
	@RequestMapping("doNotNeedSessionAndSecurity_logout")
	public void doNotNeedSessionAndSecurity_logout(User user ,HttpServletResponse response,HttpServletRequest request) {
		request.getSession().invalidate();
		request.getSession().removeAttribute("user");
	}
	/**
	 * <pre>loginSystem(登录,权限，并且给用户赋角色的查询)   
	 */
	@RequestMapping("loginSystem")
	public void loginSystem(User user,HttpServletResponse response,HttpServletRequest request){
		Json j=new Json();
		try {
			User login = loginService.loginSystem(user);
			if(login!=null){
				User u=loginService.getResourcesList(login);
				request.getSession().setAttribute("user", u);
				j.setSuccess(true);
				j.setMsg("登录成功");
			}else{
				j.setSuccess(false);
				j.setMsg("用户名或密码错误，请重新输入");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("系统错误，请联系管理员");
		}
		super.writeJson(j, response);
	}
	
}
