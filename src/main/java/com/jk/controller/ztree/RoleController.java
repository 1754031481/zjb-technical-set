package com.jk.controller.ztree;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.jk.controller.BaseController;
import com.jk.model.Resource;
import com.jk.model.Role;
import com.jk.model.RoleGrant;
import com.jk.model.User;
import com.jk.service.login.LoginService;
import com.jk.service.ztree.RoleService;
import com.jk.util.DataGrid;
import com.jk.util.Json;

@Controller
@RequestMapping("role")
public class RoleController extends BaseController {
	
	@Autowired
	private RoleService roleService;
	@Autowired
	private LoginService loginService;
	
	/**
	 * <pre>getRoleZtree(给角色授权)
	 */
	@RequestMapping("addRoleResource")
	public void addRoleResource(String id,Integer roleId,HttpServletResponse response){
		Json j=new Json();
		try {
			roleService.addRoleResource(id,roleId);
			j.setSuccess(true);
			j.setMsg("角色授权成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("角色授权失败");
		}
		super.writeJson(j, response);
	}
//角色列表的树形展示
	@RequestMapping("getRoleZtree")
	public void getRoleZtree(Role role,Integer userId,Resource resource,HttpServletResponse response,HttpServletRequest request){
		Json j=new Json();
		List<Role> roleTreeList=new ArrayList<>();
		try {
			User user=new User();
			user.setId(userId);
			 User resourcesList = loginService.getResourcesList(user);
			List<Role> roleZtree = roleService.getRoleZtree(role);
			//List<Resource> ResourceZtree=roleService.getResourceZtree(resource);
			RoleGrant roleGrant=new RoleGrant();
			roleGrant.setList(roleZtree);
			roleGrant.setRoles(resourcesList.getRoles());
			j.setSuccess(true);
			j.setObject(roleGrant);
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("查询失败");
		}
		super.writeJson(j, response);
	}
//	给用户赋角色
	@RequestMapping("addUserRoleRelation")
	public void addUserRoleRelation(String id,Integer userId,HttpServletResponse response){
		Json j=new Json();
		try {
			roleService.addUserRoleRelation(id,userId);
			j.setSuccess(true);
			j.setMsg("给用户赋角色成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("给用户赋角色失败");
		}
		super.writeJson(j, response);
	}
//	添加 or 修改
	@RequestMapping("insertRole")
	public void insertRole(Role role,HttpServletResponse response){
		try {
				if(role.getId()!=null){
					role.setUpdatedatetime(new Date());
					roleService.updateRole(role);
				}else{
					role.setCreatedatetime(new Date());
					role.setUpdatedatetime(new Date());
					roleService.insertRole(role);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	
//	dialog 添加 or  回显
	@RequestMapping("toAddOrUpdateRole")
	public ModelAndView toAddOrUpdateRole(Role role,HttpServletResponse response,HttpServletRequest request) {
		ModelAndView mv=new ModelAndView();
		if(null!=role.getId()){
			try {
				role=roleService.findRoleById(role);
			} catch (Exception e) {
				e.printStackTrace();
			}
			mv.addObject("role",role);
		}
		mv.setViewName("/WEB-INF/ztree/ztree_addRole");
		return mv;
	}
//删除
	@RequestMapping("deleteRole")
	public void deleteRole(String ids,HttpServletResponse response){
		try {
			roleService.deleteRole(ids);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
//	分页查询角色
	@RequestMapping("showPageRole")
	public void showPageRole(Role role,Integer page,Integer rows,String QUERY_NAME ,HttpServletResponse response){
		DataGrid datagrid=new DataGrid();
		role.setName(QUERY_NAME);
		try {
			List<Role> showPageRole = roleService.showPageRole(role, page, rows);
			Long countRole = roleService.countRole(role);
			datagrid.setRows(showPageRole);
			datagrid.setTotal(countRole);
		} catch (Exception e) {
			e.printStackTrace();
		}
		super.writeJson(datagrid, response);
	}
	
//	角色授权跳转
	@RequestMapping("toRoleGrant")
	public String toRoleGrant(){
		return "/WEB-INF/ztree/ztree_roleGrant";
	}
	
//	用户角色跳转
	@RequestMapping("toRoleZtree")
	public String toRoleZtree(){
		return "/WEB-INF/ztree/ztree_showRoleTree";
	}
}
