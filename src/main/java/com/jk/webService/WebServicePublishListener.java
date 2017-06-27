package com.jk.webService;

import javax.servlet.ServletContextEvent;
import javax.xml.ws.Endpoint;

public class WebServicePublishListener {
	 public void contextInitialized(ServletContextEvent sce) {
		        //WebService的发布地址
		        String address = "http://192.168.1.143:8080/WS_Server/Webservice";
		        //发布WebService，WebServiceImpl类是WebServie接口的具体实现类
		        Endpoint.publish(address , new WebServiceImpl());
		        System.out.println("使用WebServicePublishListener发布webservice成功!");
		    }
}
