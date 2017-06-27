<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/common/inc_ztree.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户页面</title>
</head>
<body>
	<table id="userShow"></table>
	<div id="addDialog"></div>
	
	
	 <div id="tb" style="padding:2px 5px;">
	
        <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-add" plain="true"  onclick="dialog('<%=request.getContextPath()%>/user/toAdd.do')">添加</a>
		<!-- <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-edit" plain="true"  onclick="updateUser()">编辑</a>
	    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-remove" plain="true"   onclick="deleteUser();">批量删除</a> -->
	    <a href="javascript:void(0);" class="easyui-linkbutton" iconCls="icon-reload" plain="true" onclick="refresh();" >刷新</a>
	 <br>
	 <form id="chong">
	 名称：<input id="name" class="easyui-validatebox"  />  
        创建时间: <input  class="Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\',{d:-1});}'})" id="startTime" style="width:110px">
        -- <input  class="Wdate" id="endTime" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\',{d:1});}'})"  style="width:110px">
         <a href="javascript:void(0);" onclick="findPage()"  class="easyui-linkbutton" iconCls="icon-search">查询</a>
         <a  href="javascript:void(0)" onclick="reset()" id="shuai" class="easyui-linkbutton" data-options="iconCls:'icon-search'" >重置</a> 
    </div>
    </form>
	
</body>
<script type="text/javascript">
/* 页面加载函数直接加载方法也ok */
	$(function(){
		findPage()
	})
	
	
	/* 用户角色 */
	function grantRoleFun(id){
		$('#addDialog').dialog({ 
		    title: '角色授权',    
		    width: 600,    
		    height: 500,    
		    href:'<%=request.getContextPath()%>/role/toRoleZtree.do',
		    modal: true ,
		    buttons : [ {
				text : '授权',
				handler:function(){
					 var data = $("#userList_form").serialize();
					alert(data)
					//点击授权按钮  实现给角色赋权限
					 $.ajax({
				        	type : "post",
				        	url : "${pageContext.request.contextPath}/role/addUserRoleRelation.do",
				        	data : data + "&userId=" + id,
				        	dataType : "json",
				        	aysnc : true,
				        	success : function(result) {
				        		if (result.success) {
				        			alert(result.msg);
				        		} else {
				        			alert(result.msg);
				        		}
				        		$("#addDialog").dialog("close");
				        	},
				        	error : function() {
				        		alert("用户赋角色失败！");
				        	}
				        })
				}
			} ]
		}); 
		
		
		$.ajax({
			type : "post",
			url : "<%=request.getContextPath()%>/role/getRoleZtree.do",
			data : {"userId" : id},
			dataType : "json",
			async : true,
			success : function(result) {
				if (result.success) {
					var str = "";
					for(var i = 0; i < result.object.list.length; i++) {
						var count = 0;
						for (var j = 0; j < result.object.roles.length; j++) {
							if (result.object.roles[j].id == result.object.list[i].id) {
								str = str + "<li><input type='checkbox' value='" + result.object.list[i].id + "' checked='checked' name='id'/>&nbsp;&nbsp;&nbsp;&nbsp;" + result.object.list[i].name + "</li>";
								count = 1;
								break;
							}
						}
						if (count != 1) {
							str = str + "<li><input type='checkbox' value='" + result.object.list[i].id + "' name='id'/>&nbsp;&nbsp;&nbsp;&nbsp;" + result.object.list[i].name + "</li>";
						}
					}
					$("#treeDemo").html(str);
				} else {
					alert(result.msg);	
				}
			},
			error : function() {
				alert("查询角色失败");
			}
		})

	}
/* 条件查询 */	
	function findPage(){
		$('#userShow').datagrid({   
		    title : "用户列表",
			url:'<%=request.getContextPath()%>/MenuController/showUser.do',  
			toolbar:'#tb',
			ctrlSelect:true,
			fit:true,
		    columns:[[    
		        {field:'id',title:'序号',width:100},    
		        {field:'name',title:'名称',width:100},    
		        {field:'imgname',title:'图片',width:100,
		        	 formatter:function(value,row,index){
			        		return   "<img title='图片' src='${pageContext.request.contextPath}"+value+"' width='100' height='100'>"

			          }  	
		        
		        },    
		        {field:'createdatetime',title:'创建时间',width:150,align:'right'},
		        {field:'modifydatetime',title:'修改时间',width:150,align:'right'},
		        {field:'操作',title:'操作',width:300,
		        	formatter : function(value, row) {
						var str = '';
							str +=('<input type="button" value="查看" onclick="findOneId('+row.id+')">');
							str +=('<input type="button" value="编辑" onclick="updateUser()">');
							str +=('<input type="button" value="用户角色" onclick="grantRoleFun('+row.id+')">');
							str +=('<input type="button" value="用户机构" onclick="grantOrganizationFun()">');
							str +=('<input type="button" value="删除" onclick="deleteUser()">');
						return str;
					}		        	
		        }
		    ]],
		    pagination : true,
		    pageSize: 3,   
       		pageList: [3,5,10],
       		/* 条件查询，没有表单，直接通过id */
       		queryParams: {
				name:$('#name').val(),
				startTime:$('#startTime').val(),
				endTime:$('#endTime').val(),
				
			}
		   
		});  
		
		$("#userShow").datagrid('getPager').pagination({
			beforePageText: '第',
	        afterPageText: '页    共 {pages} 页',     
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
	        showRefresh:false,
		});
		

		

	}
/* 添加用户 */
	function  dialog(url){
		$("#addDialog").dialog({
			title: '新增用户',
			 width: 800,    
			 height: 500, 
			 href:url,
			 closed: false, 
			 modal: true,
			 iconCls:"icon-save",
			 buttons:[{
					text:'OK',
					iconCls:"icon-ok",
					handler:function(){
						var dd = new FormData($("#userFrom")[0])
					$.ajax({
						type:"post",
						url:"<%=request.getContextPath()%>/user/insertUser.do",
						data:dd,
						async: false, 
						cache: false, 
						contentType: false, 	
						processData: false,
						success:function (msg){
							$.messager.alert('我的消息','提交成功！','info');
							$("#addDialog").dialog("close");	
							$('#userShow').datagrid("load");
						} 
					});
					}
				},{
					text:'关闭',
					iconCls:"icon-no",
					handler:function(){
						$("#addDialog").dialog("close");	
					}
				}],
		});
	}
		
/* 查看用户*/
	function  findOneId(id){
	
		$("#addDialog").dialog({
			title: '查看用户',
			 width: 900,    
			 height: 500, 
			 href:'<%=request.getContextPath()%>/user/toAdd.do?id='+id,
			 closed: false, 
			 modal: true,
			 iconCls:"icon-save",
			buttons:[{
				text:'关闭',
				iconCls:"icon-no",
				handler:function(){
					$("#addDialog").dialog("close");	
				}
			}]
		});
	}
		

	/* 批量删除 */
	function deleteUser(){
		$.messager.confirm('确认对话框', '您想要删除吗？', function(r){   //  true    false
			if (r){
				var rowsArray= $('#userShow').datagrid("getSelections");
				var ds="";
				$.each(rowsArray, function(i, row){
					ds+=row.id+",";
					});
				$.ajax({
					url:"<%=request.getContextPath()%>/user/deleteUser.do",
					type:"post",
					data:{
						"ids":ds
					},success:function (msg){
						$('#userShow').datagrid("load");
					}					
				});
			}
		});
	}
		
	
	/* 修改 */
	function updateUser(){
		var rowsArray= $('#userShow').datagrid("getSelections");
		if(rowsArray.length>1){
			$.messager.alert('我的消息','只能选择一个！','error');
		}else{
		var id=rowsArray[0].id;
		dialog("<%=request.getContextPath()%>/user/toAdd.do?id="+id);  //  调用  dialog  
		}
	}
//  刷新
	function refresh(){
		$('#userShow').datagrid("load");
	}
	
	/*重置表单  */
	function reset(){
		document.getElementById("chong").reset();
	}
</script>
</html>