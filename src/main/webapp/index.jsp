<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/common/inc_ztree.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>frameset-ztree</title>
</head>
<frameset rows="10%, *,10%">
    <frame id="topFrame" name="topFrame" src="<%=request.getContextPath()%>/north.jsp">
    <frameset cols="20%, *">
    	<frame id="leftFrame" name="leftFrame" src="<%=request.getContextPath()%>/ztree.jsp">
    	<frame id="mainFrame" name="mainFrame" src="">
    </frameset>
    <frame id="bottomFrame" name="bottomFrame" src="">
    <noframes>
    <body>
    </body>
    </noframes>
</frameset>
</html>