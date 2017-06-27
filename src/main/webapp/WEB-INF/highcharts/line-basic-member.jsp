<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/common/inc_ztree.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>基本折线图-会员管理</title>
</head>
<body>
	<form id="member_form">
		起始日期<input type="text" id="startTime" name="link['startTime']"  onclick="WdatePicker()">
		结束日期<input type="text" id="endTime" name="link['endTime']"  onclick="WdatePicker()">
		  <input type="button" value="确定" onclick="getDatas()">
	</form>
	
	<div id="container" style="min-width: 400px; height: 400px;"></div>
</body>



 <script type="text/javascript">

		var timeArray = new Array();  
		var step;  
		var chart;  
		var series = [];  
		var titleY = "";  
		var titleX = "";  
		$(function(){  
		  reDrawLine(0);  
		}); 
		function reDrawLine(id){  
		    timeArray = new Array();  
		    step = 0;  
		    series = [];  
		    getDatas(id);  
		    chart = null;  
		    drawLine();  
		  }  
		  //获取数据  
		  function getDatas(id){  
		       var startTime = $("#startTime").val();  //页面上设置好的日历控件  开始时间  id为startTime  
		       var endTime = $("#endTime").val();  
		       $.ajax({  
		       type:'post',  
		       url:'<%=request.getContextPath()%>/HighchartsController/showMember.do?endTime='+endTime+'&startTime='+startTime,  
		          async : false,  
		          success : function(result){  
		        	  console.log(result);
		        	  console.log(result.object);
		              var countArray = new Array();  
		              var resultDate = result.object;  
		              var count = "";  
		              if(resultDate != null){  
		                  for(var j=0;j<resultDate.length;j++){  
		                      timeArray.push(resultDate[j].nameValue);  
		                      countArray.push(resultDate[j].countArray);  
		                  } //for  
		                  series[0] = {  
		                     name: timeArray,  
		                     marker: {  
		                         symbol: 'circle'  
		                     },  
		                     data: countArray   
		                  };  
		              } //if  
		          } //function  
		      }); //ajax  
		        
		  }   
		 //画折线图  
		  function drawLine(){  
		      chart = $("#container").highcharts({  
		          title:{  
		              text : titleX  
		          },  
		          xAxis:{  
		              categories : []  
		          },  
		          yAxis:{  
		              title:{  
		                  text:titleY  
		              }  
		          },  
		          plotOptions:{  
		              series:{  
		                  cursor:'pointer',  
		                  events:{  
		                      click:function(event){  
		                            
		                      },  
		                      legendItemClick:function(){  
		                          return false;  
		                      }  
		                  }  
		              }  
		          },  
		          tooltip:{  
		              crosshairs:true,  
		              shared:true  
		          },  
		          credits:{  
		              enabled:false  //禁用版权信息  
		          },  
		          series:series  
		      }).highcharts();  
		  }  
</script> 
<%-- <script type="text/javascript">
		/**
		 * Highcharts 在 4.2.0 开始已经不依赖 jQuery 了，直接用其构造函数既可创建图表
		**/
		
		
		$(function(){
			getDatas();
		})
		
		function getDatas(){
			var now = new Date();
			 var startTime = $("#startTime").val();  //页面上设置好的日历控件  开始时间  id为startTime  
		       var endTime = $("#endTime").val();  
			$.ajax({
				type : "post",
				url:'<%=request.getContextPath()%>/HighchartsController/showMember.do?endTime='+endTime+'&startTime='+startTime,  
				dataType : "json",
				success : function(result){
					  console.log(result);
		        	  console.log(result.object);
					var chart = new Highcharts.Chart('container', {
						chart: {
				            type: 'areaspline'
				        },
						title: {
					       text: '会员统计',
					       x: -20
					   },
					   subtitle: {
					       text: '数据来源: WorldClimate.com',
					       x: -20
					   },
					   xAxis: {
						   type: 'datetime', 
						   categories :result.object  ,
						   labels:{
							   formatter: function () {  
		                            return Highcharts.dateFormat('%m-%d', this.value);  
		                        },
						   },
					       gridLineWidth: 1,

					   
					   },
					   yAxis: {
					       title: {
					           text: '温度 (°C)'
					       },
					       plotLines: [{
					           value: 0,
					           width: 1,
					           color: '#808080'
					       }]
					   },
					   credits:{  
				              enabled:false  //禁用版权信息  
				          },  
					   tooltip: {
					       valueSuffix: '°C'
					   },
					   legend: {
					       layout: 'vertical',
					       align: 'right',
					       verticalAlign: 'middle',
					       borderWidth: 0
					   },
					    series: [{
					       name: '东京',
					       data: result.object,
					       pointInterval: 24 * 3600 * 1000*2,
				           pointStart: Date.UTC(now.getFullYear(), now.getMonth(), now.getDay()),
					   }] 
					});
				},
				error : function(){
					
				}
			})
		}
		
	</script> --%>


</html>