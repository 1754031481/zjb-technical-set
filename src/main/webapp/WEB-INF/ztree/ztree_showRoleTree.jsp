<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/inc_ztree.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色列表的树形展示</title>
</head>
<body>
<div id="userList_div" style="width: 600px; height: 200px;">
	<form id="userList_form">
		<ul id="treeDemo" ></ul>
	</form>
</div>

</body>
</html>