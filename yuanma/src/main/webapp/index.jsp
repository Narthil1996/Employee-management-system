<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>首页</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-2.1.1.min.js"></script>
<link rel="stylesheet"
	href="${APP_PATH }/static/bootstrap/css/bootstrap.min.css">
<script src="${APP_PATH }/static/bootstrap/js/bootstrap.min.js"></script>
<style>
	#page_info_area{
		margin-top:30px;
	}
</style>
</head>
<body>

	<!-- 搭建展示页面 -->
	<div class="container-fluid">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		
			
		<!-- 导航条显示 -->
		<div class="container-fluid">
		
			<div class="row">
				<!-- 导航条 -->
				<div class="col-md-3">
					<ul id="main-nav" class="nav nav-tabs nav-stacked">
						<!--一级菜单-->
					<li>
						<a class="collapsed" data-toggle="collapse" data-target="#content">
							系统管理
							<span class="pull-right glyphicon glyphicon-chevron-down"></span>
						</a>
						<!--二级菜单-->
						<ul  id="content" class="nav nav-list collapse ">
							<li><a href="#" onclick="guanli();">员工管理界面</a></li>
							<li><a href="#">员工管理</a></li>
							<li><a href="#">员工管理</a></li>
						</ul>
					</li>
				</ul>
				</div>
			
		<!-- 右侧内容 -->
		<div class="main_content"></div>		
		
</body>

<script type="text/javascript">

        $(function(){
            $(".collapsed").click(function(e){
                /*切换折叠指示图标*/
                $(this).find("span").toggleClass("glyphicon-chevron-down");
                $(this).find("span").toggleClass("glyphicon-chevron-up");
            });
        });
        
       
        $(".collapsed").click(function(){
        	$(".collapsed").prop("aria-expanded","false");
        });
        
        	 function guanli(){
        	$(".main_content").load("${APP_PATH }/views/list.jsp");
        };  
        
        
        
		</script>
</html>