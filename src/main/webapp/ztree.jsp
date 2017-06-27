<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%--  <%@taglib uri="/struts-tags" prefix="s"%>  --%>
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
<title>ztree同步树</title>
</head>
<body>
		<div id="treeDemo" class="ztree"></div>
</body>
<script type="text/javascript">
var setting = {
		data: {
			key: {
				name: "name"
			},
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid",
			}
		}
	};
$(function() {
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/MenuController/getResourceZtree.do",
		data: "",
		dataType : "json",
		async : true,
		success : function(result) {
			$.fn.zTree.init($("#treeDemo"), setting, result.object);
		},
		error : function() {
			alert("系统判定你长的太丑，所有功能一律不准使用！");
		}
	})
})
		
		  
</script>
</html>