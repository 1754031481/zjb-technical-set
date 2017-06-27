package com.jk.controller.ztree;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.jk.controller.BaseController;
import com.jk.model.Mechanism;
import com.jk.service.mechanism.MechanismService;

@Controller
@RequestMapping("mechanism")
public class MechanismController extends BaseController{
	
	@Autowired
	private MechanismService mechanismService;
	
//	添加跳页面 or 回显
	@RequestMapping("addTo")
	public ModelAndView addTo(Mechanism mechanism,HttpServletResponse response){
		ModelAndView mv=new ModelAndView();
		Mechanism showMechanismById;
		try {
			showMechanismById = mechanismService.showMechanismById(mechanism);
			mv.addObject("mechanism",showMechanismById);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.setViewName("/WEB-INF/mechanism/addMechanism");
		return mv;
	}
	
//	跳转到机构列表
	@RequestMapping("toShowMechanism")
	public String toShowMechanism(){
		return "/WEB-INF/mechanism/mechanism";
	}
	/**
	 * <pre>deleteMechanism(删除)   
	 */
	@RequestMapping("deleteMechanism")
	public void deleteMechanism(Mechanism mechanism,HttpServletResponse response) throws Exception{
		mechanismService.deleteMechanism(mechanism);
		
	}
	/**
	 * <pre>addMechanism(添加or修改)   
	 */
	@RequestMapping("addMechanism")
	public void addMechanism(Mechanism mechanism,HttpServletResponse response){
		
		try {
			if(null!=mechanism.getId()){
				mechanism.setUpdatetime(new Date());
				mechanismService.updateMechanism(mechanism);
			}else{
				mechanism.setCreatedatetime(new Date());
				mechanism.setUpdatetime(new Date());
				mechanismService.addMechanism(mechanism);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * <pre>showMechanism(查询)   
	 */
	@RequestMapping("showMechanism")
	public void showMechanism(Mechanism mechanism,HttpServletResponse response){
		Set<Mechanism> showMechanism=new HashSet<>();
		try {
			showMechanism = mechanismService.showMechanism(mechanism);
		} catch (Exception e) {
			e.printStackTrace();
		}
		super.writeJson(showMechanism, response);
	}
	/**
	 * <pre>toAddMechanism(查看)   
	 */
	@RequestMapping("toAddMechanism")
	public ModelAndView toAddMechanism(Mechanism mechanism,HttpServletResponse response){
		ModelAndView mv=new ModelAndView();
		Mechanism mechanism12=new Mechanism();
		if(null!=mechanism.getId()){
			try {
				mechanism12=mechanismService.showMechanismById(mechanism);
				mv.addObject("mechanism", mechanism12);
			} catch (Exception e) {
				e.printStackTrace();
			}
			mv.setViewName("/WEB-INF/mechanism/addMechanism");
		}
		return mv;
	}
}
