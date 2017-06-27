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
<%@ include  file="/common/inc_ztree.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>给角色赋权限</title>
</head>
<body>
<fieldset>
		<legend>角色授权</legend>
	</fieldset>
		 <input name="id"  id="id"  value="${role.id}" readonly="readonly" type="hidden" />
		 <form id="addRoleForm">
			<div id="treeAddRole" class="ztree"></div>
		</form>
	
	<script type="text/javascript">
	
	var setting = {
			callback: {
				onCheck: zTreeOnCheck
			},
			check : {  
		        chkboxType:{"Y":"ps","N":"ps"},//勾选checkbox对于父子节点的关联关系  
		        chkStyle:"checkbox",  
		        enable : true   //是否复选框  
		    },  
			data: {
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "pid",
				},
				key: {
					url: "xUrl"
				}
			}
		};
	/* $(function() {
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/MenuController/getNodesResource.do",
			data : {"roleId" : id},
			dataType : "json",
			async : true,
			success : function(result) {
				$.fn.zTree.init($("#treeAddRole"), setting, result);
			},
			error : function() {
				alert("系统判定你长的太丑，所有功能一律不准使用！");
			}
		})
	}) */
	
	
	
 
	
 
	<%-- var submitForm = function($dialog, $grid, $pjq) {
		var nodes = $('#tree').tree('getChecked', [ 'checked', 'indeterminate' ]);
		var ids = [];
		for (var i = 0; i < nodes.length; i++) {
			ids.push(nodes[i].id);
		}
		$.post('<%=request.getContextPath()%>/tree/showResourcesRight.do', {
			id : $(':input[name="id"]').val(),
			ids : ids.join(',')
		}, function(result) {
			if (result.success) {
				$dialog.dialog('destroy');
			} else {
				$pjq.messager.alert('提示', result.msg, 'error');
			}
			$pjq.messager.alert('提示', '授权成功！', 'info');
		}, 'json');
	};
	$(function() {
		parent.$.messager.progress({
			text : '数据加载中....'
		});
		$('#tree').tree({
			url : '<%=request.getContextPath()%>/tree/showResourcesRight.do',
			parentField : 'pid',
			checkbox : true,
			formatter : function(node) {
				return node.name;
			},
			onLoadSuccess : function(node, data) {
				$.post('<%=request.getContextPath()%>/tree/showResourcesRight.do', {
					id : $(':input[name="id"]').val()
				}, function(result) {
					if (result) {
						for (var i = 0; i < result.length; i++) {
							var node = $('#tree').tree('find', result[i].id);
							if (node) {
								var isLeaf = $('#tree').tree('isLeaf', node.target);
								if (isLeaf) {
									$('#tree').tree('check', node.target);
								}
							}
						}
					}
					parent.$.messager.progress('close');
				}, 'json');
			}
		});
	}); --%>
</script>
</body>
</html>