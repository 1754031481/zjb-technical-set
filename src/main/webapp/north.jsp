<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%  
 response.setHeader("Pragma","No-cache");  
 response.setHeader("Cache-Control","No-cache");  
 response.setDateHeader("Expires", -1);  
 response.setHeader("Cache-Control", "No-store");  
%> 
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/inc_ztree.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>top</title>
</head>
<body>

	<a href="#" onclick="logoutFun()" >退出系统</a>



</body>
 <script type="text/javascript" charset="utf-8">
	function logoutFun() {
		$.ajax({
			type:'post',
			url:'<%=request.getContextPath()%>/LoginController/doNotNeedSessionAndSecurity_logout.do',
			success:function(){
				 window.parent.location.href = "<%=request.getContextPath()%>/login.jsp"; 	
			}
		})
	}	
</script> 
</html>