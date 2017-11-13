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
<link href="${APP_PATH }/static/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<script src="${APP_PATH }/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建展示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<tr>
						<th>员工工号</th>
						<th>员工姓名</th>
						<th>员工性别</th>
						<th>员工邮箱</th>
						<th>员工部门</th>
						<th>操作</th>
					</tr>
					<c:forEach items="${pageInfo.list }" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender=="男"?"男":"女" }</td>
							<td>${emp.email }</td>
							<td>${emp.department.deptName }</td>
							<td>
								<button class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">当前${pageInfo.pageNum }页;共${pageInfo.pages }页;总${pageInfo.total }条记录</div>

			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				<ul class="pagination">
				<!-- 首页 -->
				<li><a href="${APP_PATH }/emps?pn=1">首页</a></li>
				
				<!-- 上一页 -->
				<c:if test="${pageInfo.hasPreviousPage}">
					<li><a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous"> <span
							aria-hidden="true">&laquo;</span>
					</a></li>
				</c:if>
					
					<c:forEach items="${pageInfo.navigatepageNums }" var="pageNum">
					<!-- 如果是当前页码则变色 -->
						<c:if test="${page_Num == pageInfo.pageNum }">
							<li class="active"><a href="${APP_PATH }/emps?pn=${pageNum }">${pageNum}</a></li>
						</c:if>
						<!-- 如果不是当前页码则正常显示 -->
						<c:if test="${page_Num != pageInfo.pageNum }">
							<li><a href="${APP_PATH }/emps?pn=${pageNum }">${pageNum }</a></li>
						</c:if>
					</c:forEach>
					
					<!-- 下一页 -->
					<c:if test="${pageInfo.hasNextPage }">
					<li><a href="${APP_PATH }/emps?pn=${pageNum+1 }" aria-label="Next"> <span
							aria-hidden="true">&raquo;</span>
					</a></li>
					</c:if>
					<!-- 末页 -->
					<li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">末页</a></li>
				</ul>
				</nav>
			</div>
		</div>
</body>
</html>