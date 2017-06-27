<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript" src="<%=request.getContextPath()%>/jslib/style/syExtIcon.css"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<div>
			<input type = "radio" name = "r" value = "${pageContext.request.contextPath}/jslib/style/images/ext_icons/cd/cd_burn.png">
			<img  src="${pageContext.request.contextPath}/jslib/style/images/ext_icons/cd/cd_burn.png">
			<input type = "radio" name = "r" value = "${pageContext.request.contextPath}/jslib/style/images/ext_icons/arrow_green.png">
			<img  src="${pageContext.request.contextPath}/jslib/style/images/ext_icons/arrow_green.png">
		</div>
	</div>
</body>

</html>