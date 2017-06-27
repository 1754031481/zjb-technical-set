package com.jk.controller.ztree;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jk.controller.BaseController;
import com.jk.model.Menu;
import com.jk.model.Resource;
import com.jk.model.Role;
import com.jk.model.User;
import com.jk.service.ztree.MenuService;
import com.jk.service.ztree.RoleService;
import com.jk.util.DataGrid;
import com.jk.util.Json;
/**
 * 
 * <pre>项目名称：zjb-technical-set    
 * 类名称：MenuController    
 * 类描述：用户管理和角色管理的列表查询在这里面    
 * 创建人：赵俊彪    
 * 创建时间：2017年6月14日 下午8:05:17    
 * 修改人：赵俊彪     
 * 修改时间：2017年6月14日 下午8:05:17    
 * 修改备注：       
 * @version </pre>
 */
@Controller
@RequestMapping("MenuController")
public class MenuController extends BaseController{
	
	@Autowired
	private MenuService menuService;
	@Autowired 
	private RoleService roleService;
	/**
	 * 根据不同的用户查询出来不同的菜单表  ztree.jsp里面  0：展示菜单  1:权限  不展示
	 */
	@RequestMapping("getResourceZtree")
	public void getResourceZtree(HttpServletResponse response,HttpServletRequest request){
		Json j=new Json();
		User user=(User) request.getSession().getAttribute("user");
		try {
			Set<Map<String, Object>> getResourceZtree = menuService.getResourceZtree(user);
			j.setSuccess(true);
			j.setObject(getResourceZtree);
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("查询菜单失败");
		}
		super.writeJson(j, response);
	}
	/**
	 * 给角色赋权限
	 */
	@RequestMapping("getNodesResource")
	public void getNodesResource(Resource resource,Integer roleId,HttpServletRequest request,HttpServletResponse response){
		Json j=new Json();
		List<Resource> resourceList= new ArrayList<>();
		/*User user = (User) request.getSession().getAttribute("user");
		user.setResourcess();*/
		resource.setId(roleId);
		try {
			resourceList=menuService.getNodesResource(resource);
			j.setSuccess(true);
			j.setObject(resourceList);
			j.setMsg("查询权限成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("查询权限失败");
		}
		super.writeJson(j, response);
	}
	
	/**
	 * <pre>showUser(用户列表查询)   
	 */
	@RequestMapping("showUser")
	public void showUser(User user,Integer page,Integer rows,String q,String startTime,String endTime,HttpServletResponse response){
		DataGrid grid=new DataGrid();
		SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd");
		List<User> userList=null;
		try {
			if (null != startTime && !"".equals(startTime)) {
				user.setStartDate(sim.parse(startTime));
			}
			if (null != endTime && !"".equals(endTime)) {
				user.setEndDate(sim.parse(endTime));
			}
			if(null!=q && !"".equals(q)){
				user.setName(q);
			}
			userList = menuService.showUser(user,page,rows);
			Long countUser=menuService.countUser(user);
			grid.setRows(userList);
			grid.setTotal(countUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		super.writeJson(grid, response);
	}
	/**
	 * <pre>showRole(角色列表查询)   
	 */
	@RequestMapping("showRole")
	public void showRole(Integer page,Integer rows,Role role,String map,HttpServletResponse response){
		DataGrid dataGrid=new DataGrid();
		role.setName(map);
		try {
			List<Role> roleList=menuService.showRole(page,rows,role);
			Long countRole=menuService.countRole(role);
			dataGrid.setRows(roleList);
			dataGrid.setTotal(countRole);
		} catch (Exception e) {
			e.printStackTrace();
		}
		super.writeJson(dataGrid, response);
	}
	
	/**
	 * <pre>getMenuNodes(作用：ztree同步树  ztree.jsp)   
	 */
	@RequestMapping("getMenuNodes")
	public void getMenuNodes(Menu menu,HttpServletResponse response){
			List<Menu> menuList=new ArrayList<>();
		try {
			menuList=menuService.getMenuNodes(menu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		super.writeJson(menuList, response);
		
	}
	/**
	 * <pre>getMenuAsyncNodes(作用：ztree异步树加载)   
	 */
	@RequestMapping("getMenuAsyncNodes")
	public void getMenuAsyncNodes(Menu menu,HttpServletResponse response){
		List<Menu> menuAsyncList=new ArrayList<>();
		try {
			menuAsyncList=menuService.getMenuAsyncNodes(menu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		super.writeJson(menuAsyncList, response);
	}
	/**
	 * <pre>addMenu(作用：添加ztree树节点)   
	 * @param response</zjb>
	 */
	@RequestMapping("addMenu")
	public void addMenu(Menu menu,HttpServletResponse response){
		Json j=new Json();
		try {
			if(null!=menu.getId()){
				menuService.updateAfterSave(menu);
				j.setSuccess(true);
				j.setObject(menu);
				j.setMsg("恭喜你，你已经成功的装了一逼");
			}else{
				menuService.addMenu(menu);
				j.setSuccess(true);
				j.setObject(menu);
				j.setMsg("恭喜你，你已经成功的装了一逼");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("装逼不成功，跪安吧");
		}
		super.writeJson(j, response);
	}
	
	@RequestMapping("deleteMenu")
	public void deleteMenu(Menu menu,HttpServletResponse response){
		Json json=new Json();
		try {
			menuService.deleteMenu(menu);
			json.setSuccess(true);
			json.setMsg("成功了，小伙子");
		} catch (Exception e) {
			e.printStackTrace();
		json.setSuccess(false);
		json.setMsg("添加失败了，丢人啊");
		}
		super.writeJson(json, response);
	}
	
	/**
	 * 添加小图标的页面跳转
	 */
	@RequestMapping("toAddInco")
	public String toAddInco(){
		return "img";
	}
/**
 * <pre>toRole(跳转到角色页面)   
 */
	@RequestMapping("toRole")
	public String toRole(){
		return "/WEB-INF/ztree/ztree_juese";
	}
	/**
	 * <pre>toRole(跳转到用户页面)
	 */
	@RequestMapping("toUser")
	public String toUser(){
		return "/WEB-INF/ztree/ztree_user";
	}
}
