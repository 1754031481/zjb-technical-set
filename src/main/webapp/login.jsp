<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/inc_ztree.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>login页面</title>
</head>
</head>
<body>
	<div id="login_div">
		<form id="login_form">
			用户名：<input type="text" name="name" style="width: 182px;" value="admin"><br><br>
			密&nbsp;&nbsp;&nbsp;&nbsp;码：<input type="password" name="pwd" value="123" style="width: 182px;"><br><br>
		</form>
	</div>
</body>
<script type="text/javascript">
	$(function() {
		var d = dialog({
		    title: '用户登录',
		    content: $("#login_div").html($("#login_div").html()),
		    okValue: '登录',
		    ok: function () {
		       var data = $("#login_form").serialize();
		       $.ajax({
		    	   type : "post",
		    	   url : "${pageContext.request.contextPath}/LoginController/loginSystem.do",
		    	   data : data,
		    	   dataType: "json",
		    	   aysnc : true,
		    	   success : function(result) {
		    		   if(result.success){
		    			   window.location.href="<%=request.getContextPath()%>/index.jsp"
		    		   }else{
		    			   alert(result.msg)
		    		   }
		    	   },
		    	   error : function() {
		    		   alert("系统错误，请联系管理员！");
		    	   }
		       })
		    }
		});
		d.showModal();
	})
</script>
</html>