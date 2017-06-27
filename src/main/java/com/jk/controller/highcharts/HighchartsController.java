package com.jk.controller.highcharts;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jk.controller.BaseController;
import com.jk.model.Member;
import com.jk.service.highcharts.HighchartsService;
import com.jk.util.Json;

@Controller
@RequestMapping("HighchartsController")
public class HighchartsController extends BaseController{
	
	@Autowired
	private HighchartsService highchartsService; 
	
	
	@SuppressWarnings("all")
	@RequestMapping("showMember")
	@ResponseBody
	public void showMember(String endTime, String startTime ,HttpServletResponse response){
		Json j=new Json();
		Member member = new Member();
		member.setStartTime(startTime);
		member.setEndTime(endTime);
		List<Map<String, Object>> list=null;;
		try {
			list = highchartsService.showMember(member);
			j.setSuccess(true);
			j.setObject(list);
		} catch (Exception e) {
			e.printStackTrace();
			j.setSuccess(false);
			j.setMsg("失败");
		}
		super.writeJson(j, response);
		
		
	}
	
	@RequestMapping("toHighcharts")
	public String toHighcharts(){
		return "/WEB-INF/highcharts/line-basic-member";
	}
}
