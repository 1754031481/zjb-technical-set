<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include  file="/common/inc_ztree.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理</title>
</head>
<body>
	<table id="role_datagrid"></table>
	<div id="role_dialog"></div>
	<div id="role_tb">
	<form id="reset">
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-note_add',plain:true" onclick="addRole('<%=request.getContextPath()%>/role/toAddOrUpdateRole.do');">添加</a>
		<input id="reset_form" class="easyui-searchbox" style="width: 150px" data-options="searcher:function(value,name){$('#role_datagrid').datagrid('load',{'map':value});},prompt:'搜索角色名称'"></input>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'ext-icon-zoom_out',plain:true" onclick="$('#reset_form').searchbox('setValue','');$('#role_datagrid').datagrid('load',{});">清空查询</a>
	</form>
	</div>
</body>
<script type="text/javascript">


/* 修改 */
function updateRole(){
	var rowsArray= $('#role_datagrid').datagrid("getSelections");
	if(rowsArray.length>1){
		$.messager.alert('我的消息','只能选择一个！','error');
	}else{
	var id=rowsArray[0].id;
	addRole("<%=request.getContextPath()%>/role/toAddOrUpdateRole.do?id="+id);  //  调用  dialog  
	}
}

/* 添加角色  */
function addRole(url){
	$("#role_dialog").dialog({
		title: '新增角色',
		 width: 900,    
		 height: 500, 
		 href:url,
		 closed: false, 
		 modal: true,
		 iconCls:"icon-save",
		 buttons:[{
				text:'OK',
				iconCls:"icon-ok",
				handler:function(){
				$.ajax({
					type:"post",
					url:"<%=request.getContextPath()%>/role/insertRole.do",
					data:$("#role_form").serialize(),
					async: false, 
					cache: false, 
					contentType: false, 	
					processData: false,
					success:function (msg){
						$.messager.alert('我的消息','提交成功！','info');
						$("#role_dialog").dialog("close");	
						$('#role_datagrid').datagrid("load");
					} 
				});
				}
			},{
				text:'关闭',
				iconCls:"icon-no",
				handler:function(){
					$("#role_dialog").dialog("close");	
				}
			}],
	});
}

/* 查看角色 */
function  findOneRoleId(id){
	alert(id)
	$("#role_dialog").dialog({
		title: '查看角色',
		 width: 900,    
		 height: 500, 
		 href:'<%=request.getContextPath()%>/role/toAddOrUpdateRole.do?id='+id,
		 closed: false, 
		 modal: true,
		 iconCls:"icon-save",
		buttons:[{
			text:'关闭',
			iconCls:"icon-no",
			handler:function(){
				$("#role_dialog").dialog("close");	
			}
		}]
	});
}
/* 批量删除 */
function deleteRole(){
	$.messager.confirm('确认对话框', '您想要删除吗？', function(r){   //  true    false
		if (r){
			var rowsArray= $('#role_datagrid').datagrid("getSelections");
			var ds="";
			$.each(rowsArray, function(i, row){
				ds+=row.id+",";
				});
			$.ajax({
				url:"<%=request.getContextPath()%>/role/deleteRole.do",
				type:"post",
				data:{
					"ids":ds
				},success:function (msg){
					$('#role_datagrid').datagrid("load");
				}					
			});
		}
	});
}

	$(function(){
		$('#role_datagrid').datagrid({   
		    title : "角色列表",
			url:'<%=request.getContextPath()%>/MenuController/showRole.do',  
			toolbar:'#role_tb',
			ctrlSelect:true,
			fit:true,
		    columns:[[    
		        {field:'id',title:'序号',width:100},    
		        {field:'name',title:'角色名称',width:100},    
		        {field:'description',title:'资源描述',width:100},    
		        {field:'iconCls',title:'图标',width:100},    
		        {field:'createdatetime',title:'创建时间',width:150,align:'right'},
		        {field:'updatedatetime',title:'修改时间',width:150,align:'right'},
		        {field:'操作',title:'操作',width:200,
		        	formatter : function(value, row) {
		        		 var str = '';
							str +=('<input type="button" value="查看"  onclick="findOneRoleId('+row.id+')">');
							str +=('<input type="button" value="编辑"  onclick="updateRole()">');
							str +=('<input type="button" value="授权"  onclick="grantFun('+row.id+')">');
							str +=('<input type="button" value="删除"  onclick="deleteRole()">');
						return str; 
					}		        	
		        }
		    ]],
		    pagination : true,
		    pageSize: 10,   
       		pageList: [10,20,30],
		});  
		
		$("#role_datagrid").datagrid('getPager').pagination({
			beforePageText: '第',
	        afterPageText: '页    共 {pages} 页',     
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
	        showRefresh:false,
		});
	})
	var ids=""
	function zTreeOnCheck(event, treeId, treeNode) {
		 var treeObj=$.fn.zTree.getZTreeObj("treeAddRole");
		 treeNode=treeObj.getCheckedNodes(true);//所有选中的节点
	      for(var i=0;i<treeNode.length;i++){
              if(treeNode[i].id!=null){
                  ids+="&id="+treeNode[i].id;//获取选中节点的值
              }
          } 
	}; 
	function grantFun(id){
		$('#role_dialog').dialog({    
		    title: '角色授权',    
		    width: 600,    
		    height: 500,    
		    href :'<%=request.getContextPath()%>/role/toRoleGrant.do?id='+id,
		    modal: true ,
		    buttons : [ {
				text : '授权',
				handler:function(){
					//点击授权按钮  实现给角色赋权限
					 $.ajax({
				        	type : "post",
				        	url : "${pageContext.request.contextPath}/role/addRoleResource.do",
				        	data : ids + "&roleId=" + id,
				        	dataType : "json",
				        	aysnc : true,
				        	success : function(result) {
				        		if (result.success) {
				        			alert(result.msg);
				        		} else {
				        			alert(result.msg);
				        		}
				        		$("#role_dialog").dialog("close");
				        	},
				        	error : function() {
				        		alert("角色赋权限失败！--页面");
				        	}
				        })
				}
			} ]
		});    
			
		
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/MenuController/getNodesResource.do",
			data : {"roleId" : id},
			dataType : "json",
			async : true,
			success : function(result) {
				if(result.success){
					$.fn.zTree.init($("#treeAddRole"), setting, result.object);
					var treeObj = $.fn.zTree.getZTreeObj("treeAddRole");
					
				}
				
			},
			error : function() {
				alert("权限树查询失败");
			}
		})
	}
	/* 这个方法可以拿到选中的复选框的值 */
	 
</script>
</html>