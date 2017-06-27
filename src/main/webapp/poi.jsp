<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- jquery AND  easyui -->
<script type="text/javascript" src="${pageContext.request.contextPath }/jslib/jquery-2.1.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jslib/jquery-easyui-1.4.4/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/jslib/jquery-easyui-1.4.4/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/jslib/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jslib/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/jslib/artDialog/common-artdiag.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/jslib/artDialog/css/ui-dialog.css">
<script src="${pageContext.request.contextPath }/jslib/artDialog/dist/dialog-plus-min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>poi导入导出</title>
</head>
<body>
<!-- 导出excel -->
	<form id="index_form" >
			<input type="checkbox" name="checks" value="序号"/>序号
			<input type="checkbox" name="checks" value="名称"/>名称
			<input type="checkbox" name="checks" value="图标"/>图标
			<input type="checkbox" name="checks" value="路径"/>路径
			<input type="checkbox" name="checks" value="展开方式"/>展开方式
			<input type="button" value="导出Excel" onclick="exportExcel();">
			<input type="button" value="导入Excel" onclick="importExcel();">
	</form>
	<!-- 导入excel到数据库中 -->
	<div id="index_div" style="display: none;">
		<form id="index_form1" action="${pageContext.request.contextPath }/poiController/importExcel.do" method="post" enctype="multipart/form-data">
			<input type="file" name="file" />
			<input type="submit" value="开始导入" />
		</form>
	</div>
	<!-- 条件查询 -->
	<input type="text"  id="name" name="name">
	<input type="button" value="搜索" onclick="findMneuPoi()" >
	<!-- datagrid -->
	<table id="poi_datagrid"></table>
</body>
<script type="text/javascript">

//导入excel
function importExcel() {
	var d = dialog({
	    title: '欢迎',
	    content: $("#index_div").html($("#index_div").html())
	});
	d.show();
}
/* 导出excel */
function exportExcel(){
	var data=$("#index_form").serialize();
	window.location.href="${pageContext.request.contextPath}/poiController/exportExcel.do?"+data;
}
/* 查询list */
$(function(){
	findMneuPoi();
})
  
  /* 条件查询 */
  function findMneuPoi(){
	$('#poi_datagrid').datagrid({    
	    url:'<%=request.getContextPath()%>/poiController/showListPoi.do', 
	    async : true,
	    columns:[[    
	        {field:'id',title:'序号',width:100},    
	        {field:'name',title:'名称',width:100},    
	        {field:'icon',title:'图标',width:100},
	        {field:'url',title:'地址',width:100},    
	        {field:'target',title:'展开方式',width:100}
	    ]],
	    queryParams: {
   			name:$('#name').val(),
   		} 
	});
	

}
</script>
</html>