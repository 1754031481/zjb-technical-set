<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/common/inc_ztree.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ztree异步树</title>
</head>
<body>

<div style="width: 300px; height: 600px; border: 1px solid #FF0000; float: left; margin-left: 3px; margin-top: 3px; padding-left: 5px;">
	<ul id="treeDemo" class="ztree"></ul>
</div>

<div style="width: 600px; height: 600px; border: 1px solid #00ff00; float: left; margin-left: 3px; margin-top: 3px; padding-left: 5px;">
	<div style="margin-top: 5px;">
		<input id="updateSaveBtn" type="button" value="修改后保存" onclick="updateAfterSave()" />
		<input id="addMenuBtn" type="button" value="新建菜单" onclick="addMenu()" />
		<input id="deleteMenuBtn" type="button" value="删除菜单" onclick="deleteMenuNode()">
		<input id="saveMenuBtn" type="button" value="新建菜单保存" onclick="addMenuNode()">
	</div>
	<div style="margin-top: 10px;">
		<form id="ztreeAsync_addMenu">
			父节点ID:<span id="demo4_span_pid" ></span><br><br>
			父节点名称:<span id="demo4_span_pname" ></span><br><br>
					<input id="id" type="hidden" name="id" value="${menu.id}">
					<input id="pid" type="hidden" name="pid"  value="${menu.pid}">
			节点名称:<input id="name" name="name" type="text"    maxlength="100" style="width: 182px;"><br><br>
			节点图标:<input type="text" name="icon" id="icon" value="${menu.icon}" maxlength="255" style="width: 182px;">
					<input type="button"  value="添加图标" onclick="showIcons()">
				<img  id="img" src=""  />
			<br><br>
			URL:<input type="text" name="url" id="url" maxlength="100" style="width: 182px;"><br><br>
			展开方式:<select id="target" name="target" style="width: 187px;">
						<option value="_blank">_blank</option>
						<option value="_parent">_parent</option>
						<option value="_top">_top</option>
						<option value="_self">_self</option>
						<option value="mainFrame">mainFrame</option>
					</select><br><br>
			菜单类型：<select id="type" name="type" style="width: 187px;">
						<option value="0">菜单</option>
						<option value="1">功能</option>
					</select>
		</form>
	</div>
</div>
<script type="text/javascript">

function showIcons(){
	var add_from = dialog({
        title: '增加图标',
        content:getDivByUrl("MenuController/toAddInco.do"),
        okValue: '添加图标',
        ok: function () {
        	var r = $("input[type='radio']").val();
        	$("#icon").val(r);
			$("#img").attr("src",r);
        }, 
        cancelValue: '取消',
        cancel: function () {
        }
    });
	
	//调用展示
    add_from.show();
}

/* function showIcons(){
		 var add_from = dialog({
		        title: '小图标',
		        content:getDivByUrl("MenuController/toAddInco.do"),
		        okValue: '添加',
		       
		        cancelValue: '取消',
		        cancel: function () {
		        }
		    });
			
		//调用展示
	    add_from.show();
	} */


	

/* 加载数据 */
$(document).ready(function(){
	 $.fn.zTree.init($("#treeDemo"), setting);
	 $('#saveMenuBtn').hide();
	
});
/* 回显父节点id和父节点名称 */
function zTreeOnClick(event, treeId, treeNode) {
    if (treeNode.getParentNode() != null) {
    	//给父节点ID赋值
	    $("#demo4_span_pid").text(treeNode.getParentNode().id);
	    //给父节点名称赋值
	    $("#demo4_span_pname").text(treeNode.getParentNode().name);	
    } else {
    	//给父节点ID赋值
	    $("#demo4_span_pid").text("");
	    //给父节点名称赋值
	    $("#demo4_span_pname").text("");	
    }
    $("#name").val(treeNode.name);
    $("#icon").val(treeNode.icon);
    $("#url").val(treeNode.url);
	$("#id").val(treeNode.id);
	$("#target").val(treeNode.target);
	$("#type").val(treeNode.type);
	$("#updateSaveBtn").show();
	$("#addMenuBtn").show();
	$("#deleteMenuBtn").show();
	$("#saveMenuBtn").hide();
};


/* 添加树节点 */
function addMenu(){
	$.ajax({
		type:'post',
		data:$('#ztreeAsync_addMenu').serialize(),
		url:'${pageContext.request.contextPath }/MenuController/addMenu.do',
		success:function(result){
			 $.fn.zTree.init($("#treeDemo"), setting);
				$('#updateSaveBtn').show();
				$('#addMenuBtn').show();
				$('#deleteMenuBtn').show();
				$('#saveMenuBtn').hide();
				document.getElementById("ztreeAsync_addMenu").reset();
				
		}
	})
}

//删除菜单节点
function deleteMenuNode() {
	//获得整个树形节点
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	//获得所有选中的节点
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length > 0) {
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/MenuController/deleteMenu.do",
			data : {"id" : nodes[0].id},
			dataType : "json",
			async : true,
			success : function(result) {
				if (result.success) {
					alert(result.msg);
					treeObj.removeNode(nodes[0]);
					$("#name").val("");
					$("#id").val("");
				    $("#icon").val("");
				    $("#url").val("");
					$("#target").val("");
					$("#type").val("");
					$("#demo4_span_pid").text("");
					$("#pid").val("");
					$("#demo4_span_pname").text("");
				} else {
					alert(result.msg);
				}
			},
			error : function() {
				alert("系统错误，请联系管理员！");
			}
		})
	}
}






/* 新建菜单 */
	function addMenu() {
		//获得整个树形节点
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		//获得所有选中的节点
		var nodes = treeObj.getSelectedNodes();
		$("#updateSaveBtn").hide();
		$("#addMenuBtn").hide();
		$("#deleteMenuBtn").hide();
		$("#saveMenuBtn").show();
		if (nodes.length > 0) {
			$("#name").val("");
		    $("#icon").val("");
		    $("#url").val("");
			$("#target").val("");
			$("#type").val("");
			$("#demo4_span_pid").text(nodes[0].id);
			$("#pid").val(nodes[0].id);
			$("#demo4_span_pname").text(nodes[0].name);
		}
	}


	//新建菜单保存
	function addMenuNode() {
		//获得整个树
		var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
		//获得所有选中的节点
		var nodes = treeObj.getSelectedNodes();
		var data = $("#ztreeAsync_addMenu").serialize();
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/MenuController/addMenu.do",
			data : data,
			dataType : "json",
			async : true,
			success : function(result) {
				if (result.success) {
					alert(result.msg);
					if (nodes.length > 0) {
						treeObj.addNodes(nodes[0], result.object);
					} else {
						treeObj.addNodes(null, result.object);
					}
					$("#name").val("");
					$("#id").val("");
				    $("#icon").val("");
				    $("#url").val("");
					$("#target").val("");
					$("#type").val("");
					$("#demo4_span_pid").text("");
					$("#pid").val("");
					$("#demo4_span_pname").text("");
					$("#updateSaveBtn").show();
					$("#addMenuBtn").show();
					$("#deleteMenuBtn").show();
					$("#saveMenuBtn").hide();
				} else {
					alert(result.msg);
				}
			},
			error : function() {
				alert("装逼不成功，跪安吧!");
			}
		})
	}
	
	
	var setting = {
		async: {
			enable: true,
			url: "${pageContext.request.contextPath }/MenuController/getMenuAsyncNodes.do",
			autoParam: ["id"]
		},
		data: {
			simpleData: {
				enable: true,
				idKey: "id",
				pIdKey: "pid",
				},
				key:{
					url:"kurl",
				}
			},
		callback: {
			onClick: zTreeOnClick
		}
	};
	
/* 修改以后保存 */	
function updateAfterSave() {
	//获得整个树形节点
	var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	//获得所有选中的节点
	var nodes = treeObj.getSelectedNodes();
	if (nodes.length > 0) {
		var data = $("#ztreeAsync_addMenu").serialize();
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/MenuController/addMenu.do",
			data : data,
			dataType : "json",
			async : true,
			success : function(result) {
				if (result.success) {
					nodes[0].name = result.object.name;
					nodes[0].icon = result.object.icon;
					nodes[0].url = result.object.url;
					nodes[0].target = result.object.target;
					nodes[0].type = result.object.type;
					treeObj.updateNode(nodes[0]);
				} else {
					alert(result.msg);
				}
			},
			error : function() {
				alert("系统错误，请联系管理员！");
			}
		})
	} else {
		alert("请选择一个需要修改的节点");
	}
}

</script>
</body>
</html>