package com.jk.filter;
 
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.jk.model.User;

public class SessionFilter implements Filter {

	//日志记录
	private static final Logger logger = Logger.getLogger(SessionFilter.class);
 
    @Override
    public void init(FilterConfig cfg) throws ServletException {
    	
    }
 
    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
      
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String servletPath = request.getServletPath();
        logger.info("请求路径过滤信息路径为：" + servletPath);
        // 如果请求的路径与forwardUrl相同，或请求的路径是排除的URL时，则直接放行
        if (servletPath.equals("/login.jsp") || servletPath.equals("/error/error.jsp")) {
            chain.doFilter(req, res);
            return;
        }
 
        User account = (User) request.getSession().getAttribute("user");
        // 如果Session为空，则跳转到指定页面
        if (account == null) {
            String contextPath = request.getContextPath();
//            response.sendRedirect(contextPath + "/login.jsp");
            response.setCharacterEncoding("utf-8");
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html");
			PrintWriter pw = response.getWriter();
			pw.print("<script>window.top.location.href='"+contextPath + "/login.jsp'"+";</script>");
        } else {
            chain.doFilter(req, res);
        }
    }
 
    @Override
    public void destroy() {
    	
    }

}
