<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title></title>
<jsp:include page="/common/inc_ztree.jsp"></jsp:include>
<script type="text/javascript">
	var selectIcon = function($dialog, $input) {
		$input.val($(':radio:checked').val()).attr('class', $(':radio:checked').val());
		$dialog.dialog('destroy');
	};
	$(function() {

		$(':radio').each(function(index) {//初始化小图标
			$(this).after('<img class="iconImg ' + $(this).val() + '"/>');
		});
		$('.iconImg').attr('src', sy.pixel_0);

		$('td').click(function() {//绑定点击td事件，作用是点击td的时候，就可以选中，不一定非得点击radio组件
			$(this).find(':radio').attr('checked', 'checked');
		});

	});
</script>
</head>
<body>
	<table style="width: 100%;">
	
	<tr>
			<td><input name="r" value="<%=request.getContextPath()%>/jslib/style/images/ext_icons/anchor.png" type="radio" /></td>
			<td><input name="r" value="ext-icon-arrow_green" type="radio" /></td>
			<td><input name="r" value="ext-icon-asterisk_orange" type="radio" /></td>
			<td><input name="r" value="ext-icon-asterisk_yellow" type="radio" /></td>
			<td><input name="r" value="ext-icon-attach" type="radio" /></td>
			<td><input name="r" value="ext-icon-bell" type="radio" /></td>
			<td><input name="r" value="ext-icon-bell_add" type="radio" /></td>
			<td><input name="r" value="ext-icon-bell_delete" type="radio" /></td>
		</tr>
		<!-- <tr>
			<td><input name="r" value="ext-icon-anchor" type="radio" /></td>
			<td><input name="r" value="ext-icon-arrow_green" type="radio" /></td>
			<td><input name="r" value="ext-icon-asterisk_orange" type="radio" /></td>
			<td><input name="r" value="ext-icon-asterisk_yellow" type="radio" /></td>
			<td><input name="r" value="ext-icon-attach" type="radio" /></td>
			<td><input name="r" value="ext-icon-bell" type="radio" /></td>
			<td><input name="r" value="ext-icon-bell_add" type="radio" /></td>
			<td><input name="r" value="ext-icon-bell_delete" type="radio" /></td>
		</tr>
		<tr>
			<td><input name="r" value="ext-icon-bell_error" type="radio" /></td>
			<td><input name="r" value="ext-icon-bell_go" type="radio" /></td>
			<td><input name="r" value="ext-icon-bell_link" type="radio" /></td>
			<td><input name="r" value="ext-icon-bin" type="radio" /></td>
			<td><input name="r" value="ext-icon-bin_closed" type="radio" /></td>
			<td><input name="r" value="ext-icon-bin_empty" type="radio" /></td>
			<td><input name="r" value="ext-icon-bomb" type="radio" /></td>
			<td><input name="r" value="ext-icon-book" type="radio" /></td>
		</tr>
		<tr>
			<td><input name="r" value="ext-icon-book_add" type="radio" /></td>
			<td><input name="r" value="ext-icon-book_addresses" type="radio" /></td>
			<td><input name="r" value="ext-icon-book_delete" type="radio" /></td>
			<td><input name="r" value="ext-icon-book_edit" type="radio" /></td>
			<td><input name="r" value="ext-icon-book_error" type="radio" /></td>
			<td><input name="r" value="ext-icon-book_go" type="radio" /></td>
			<td><input name="r" value="ext-icon-book_key" type="radio" /></td>
			<td><input name="r" value="ext-icon-book_link" type="radio" /></td>
		</tr>
		<tr>
			<td><input name="r" value="ext-icon-book_next" type="radio" /></td>
			<td><input name="r" value="ext-icon-book_open" type="radio" /></td>
			<td><input name="r" value="ext-icon-book_previous" type="radio" /></td>
			<td><input name="r" value="ext-icon-box" type="radio" /></td>
			<td><input name="r" value="ext-icon-brick" type="radio" /></td>
			<td><input name="r" value="ext-icon-bricks" type="radio" /></td>
			<td><input name="r" value="ext-icon-brick_add" type="radio" /></td>
			<td><input name="r" value="ext-icon-brick_delete" type="radio" /></td>
		</tr>
		<tr>
			<td><input name="r" value="ext-icon-brick_edit" type="radio" /></td>
			<td><input name="r" value="ext-icon-brick_error" type="radio" /></td>
			<td><input name="r" value="ext-icon-brick_go" type="radio" /></td>
			<td><input name="r" value="ext-icon-brick_link" type="radio" /></td>
			<td><input name="r" value="ext-icon-briefcase" type="radio" /></td>
			<td><input name="r" value="ext-icon-building" type="radio" /></td>
			<td><input name="r" value="ext-icon-building_add" type="radio" /></td>
			<td><input name="r" value="ext-icon-building_delete" type="radio" /></td>
		</tr>
		<tr>
			<td><input name="r" value="ext-icon-building_edit" type="radio" /></td>
			<td><input name="r" value="ext-icon-building_error" type="radio" /></td>
			<td><input name="r" value="ext-icon-building_go" type="radio" /></td>
			<td><input name="r" value="ext-icon-building_key" type="radio" /></td>
			<td><input name="r" value="ext-icon-building_link" type="radio" /></td>
			<td><input name="r" value="ext-icon-bullet_add" type="radio" /></td>
			<td><input name="r" value="ext-icon-bullet_arrow_bottom" type="radio" /></td>
			<td><input name="r" value="ext-icon-bullet_arrow_down" type="radio" /></td>
		</tr>


 -->

	</table>
</body>
</html>