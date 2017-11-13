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

</head>
<body>

	<!-- 员工新增模态框 -->
	<div class="modal fade" id="empaddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="请输入员工姓名"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">员工邮箱</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add_input" placeholder="请输入正确的邮箱格式"> <span
									class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">员工性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_add_input" value="男"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_add_input" value="女"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">员工部门</label>
							<div class="col-sm-4">
								<!-- 部门提交部门id即可 -->
								<select class="form-control" name="dId" id="empDept_select">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- ------------------------------------------------------------------------- -->
	<!-- 员工修改模态框 -->
	<div class="modal fade" id="empupdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">员工邮箱</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update_input" placeholder="请输入正确的邮箱格式"> <span
									class="help-block"></span>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">员工性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1_update_input" value="男"
									checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender2_update_input" value="女"> 女
								</label>
							</div>
						</div>

						<div class="form-group">
							<label class="col-sm-2 control-label">员工部门</label>
							<div class="col-sm-4">
								<!-- 部门提交部门id即可 -->
								<select class="form-control" name="dId" id="empDept_select">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
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
				<button class="btn btn-primary" id="emp_add_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
						<th>
							<input type="checkbox" id="check_all">
						</th>
							<th>员工工号</th>
							<th>员工姓名</th>
							<th>员工性别</th>
							<th>员工邮箱</th>
							<th>员工部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<!-- 员工数据 -->
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>

			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
</body>
<script type="text/javascript">
		//定义总页数
		var totalRecords;
		//定义当前页
		var currentPage;
		/* 1.页面加载完成之后，直接发送一个ajax请求，要到分页数据 */
		$(function () {
			//去首页
			to_page(1)
		});
		
		function to_page(pn){
			$(function () {
				$.ajax({
					url:"${APP_PATH}/emps",
					data:"pn="+pn,
					type:"GET",
					success:function(result){
						/* console.log(result); */
						//1.解析并显示员工数据
						build_emps_table(result);
						//2.解析并显示分页信息
						build_page_info(result);
						//3.解析并显示分页条
						build_page_nav(result);
					}
				});
			});
		}
		
		
		function build_emps_table(result) {
			//清空表格数据
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				var checkboxTd = $("<td><input type='checkbox' class='check_item'/></td>")
				var empIdTd = $("<td></td>").append(item.empId)
				var empNameTd = $("<td></td>").append(item.empName)
				var genderTd = $("<td></td>").append(item.gender == "男"?"男":"女")
				var emailTd = $("<td></td>").append(item.email)
				var deptNameTd = $("<td></td>").append(item.department.deptName)
				/**
				<button class="btn btn-primary btn-sm">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
				</button>
				*/
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
				.append($("<span></span>")).addClass("glyphicon glyphicon-pencil")
				.append("编辑")
				//为编辑按钮添加自定义属性，来表示当前员工ID
				editBtn.attr("edit-id",item.empId)
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
				.append($("<span></span>")).addClass("glyphicon glyphicon-trash")
				.append("删除")
				delBtn.attr("del-id",item.empId)
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(checkboxTd)
				.append(empIdTd)
				.append(empNameTd)
				.append(genderTd)
				.append(emailTd)
				.append(deptNameTd)
				.append(btnTd)
				.appendTo("#emps_table tbody");
			});
		}
		
		//解析显示分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页;共"+result.extend.pageInfo.pages+"页;总"+result.extend.pageInfo.total+"条记录")
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		
		//解析显示分页条,点击分页触发事件
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			//page_nav_area
			var ul = $("<ul></ul>").addClass("pagination")
			
			//构建元素
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"))
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"))
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//添加首页，上一页的点击事件
				firstPageLi.click(function () {
					to_page(1)
				});
				prePageLi.click(function () {
					to_page(result.extend.pageInfo.pageNum-1)
				});
			}
		
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"))
			var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"))
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				//添加末页，下一页的点击事件
				nextPageLi.click(function () {
					to_page(result.extend.pageInfo.pageNum+1)
				});
				lastPageLi.click(function () {
					to_page(result.extend.pageInfo.pages)
				});
			}
			
		
		
			//添加首页和上一页
			ul.append(firstPageLi)
			.append(prePageLi)
			
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				//加判断
				var numLi = $("<li></li>").append($("<a></a>").append(item))
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active")
				}
				//调用to_page()跳转，记得要清空数据，不然会重复
				numLi.click(function () {
					to_page(item)
				});
				
				ul.append(numLi)
			});
			
			//添加下一页和末页
			ul.append(nextPageLi)
			.append(lastPageLi)
			
			//把ul加入到nav
			var navEle = $("<nav></nav>").append(ul)
			
			navEle.appendTo("#page_nav_area")
		}
		
		//清空表单样式及内容
		function reset_form(ele) {
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success")
			$(ele).find(".help-block").text("")
		}
		
		//点击新增按钮弹出模态框
		$("#emp_add_btn").click(function () {
			//清除表单数据（表单完整重置,包括数据及样式）
			 reset_form("#empaddModal form")
			//[0]代表取出dom对象，因为jquery没有reset()方法
			//$()[0].reset();
			//清除表单数据
			$("#empDept_select option").remove();
			//发送ajax请求，弹出部门信息，显示在下拉列表中
			getDepts("#empaddModal select")
			//弹出模态框
			$("#empaddModal").modal({
				backstrop:"static"
			});
		});
		
		//查出所有部门信息现在在列表中
		function getDepts(ele) {
			//清空之前下拉列表的值
			$(ele).empty()
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result);
					//显示部门信息在下拉列表中
					/* $("#empaddModal select").append("") */
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele)
					});
				}
			});
		}
		
		//校验表单数据
		function validate_add_form() {
			//1.拿到需要校验的数据
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名只能为2-5位中文或者6-16位英文和数字的组合");
				//应该清空元素之前的样式
				show_validate_msg("#empName_add_input","error","用户名只能为2-5位中文或者6-16位英文和数字的组合")
				/* $("#empName_add_input").parent().addClass("has-error")
				$("#empName_add_input").next("span").text("用户名只能为2-5位中文或者6-16位英文和数字的组合") */
				return false;
			} else {
				show_validate_msg("#empName_add_input","success","")
			}
			//2.校验邮箱
			var email = $("#email_add_input").val();
			/* 只允许英文字母、数字、下划线、英文句号、以及中划线组成 */
			var regEmail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				show_validate_msg("#email_add_input","error","邮箱格式不正确")
				/* $("#email_add_input").parent().addClass("has-error")
				$("#email_add_input").next("span").text("邮箱格式不正确") */
				return false;
			} else {
				show_validate_msg("#email_add_input","success","")
				/* $("#email_add_input").parent().addClass("has-success")
				$("#email_add_input").next("span").text("") */
			}
				return true;
		}
		
		//显示校验结果的提示信息及校验逻辑判断
		function show_validate_msg(ele,status,msg) {
			//清除当前元素校验状态
			$(ele).parent().removeClass("has-success has-error")
			$(ele).next("span").text()
			if("success"==status){
				$(ele).parent().addClass("has-success")
				$(ele).next("span").text(msg)
			} else if ("error"==status){
				$(ele).parent().addClass("has-error")
				$(ele).next("span").text(msg)
			}
		}
		
		//校验用户名是否可用
		$("#empName_add_input").change(function () {
			//发送ajax请求校验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkUser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用")
						$("#emp_save_btn").attr("ajax-va","success")
					} else {
						show_validate_msg("#empName_add_input","error",result.extend.va_msg)
						$("#emp_save_btn").attr("ajax-va","error")
				}
				}
			});
		});
		
		//点击保存员工
		$("#emp_save_btn").click(function () {
			//1.模态框中填写的表单数据提交给服务器进行保存
			//1.先对要提交给服务器的数据进行校验
			if(!validate_add_form()){
				return false;
			}
			
			//1.判断之前的ajax用户名校验是否成功，如果成功，才继续走
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//2.发送ajax请求保存员工
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empaddModal form").serialize(),
				success:function(result){
					/* alert(result.msg) */
					if(result.code==100){
						//1.关闭模态框
						$("#empaddModal").modal("hide")	
						//2.来到最后一页，显示刚才保存的数据
					//发送ajax请求显示最后一页数据
					//可将总记录数当作页码
					to_page(totalRecord)
					} else {
						//显示失败信息
						//console.log(result)
						//有哪个字段的错误信息就显示哪个字段
						if(undefined != result.extend.errorFields.email){
							//显示邮箱错误信息
							show_validate_msg("#email_add_input","error","result.extend.errorFields.email")
						}
						if(undefined != result.extend.errorFields.empName){
							//显示员工姓名信息
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName)
						}
					}
				}
			}); 
		});
		
		//单个删除
		$(document).on("click",".del_btn",function(){
			//1。弹出确认删除对话框
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			if(confirm("确认删除【"+empName+"】吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg)
						//回到本页
						to_page(currentPage)
					}
				});
			}
		});
		//1.按钮创建之前绑定click，所以绑定不上
		//1.创建按钮时绑定事件 2.绑定单机事件 live() 
		//jquery新版没有live，所以使用on替代
		$(document).on("click",".edit_btn",function () {
			//alert("点击成功")
			//1.查出部门信息，并显示部门列表
			getDepts("#empupdateModal select")
			//2.查出员工信息，显示员工信息
			getEmp($(this).attr("edit-id"))
			//3、把员工的id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empupdateModal").modal({
				backstrop:"static"
			});
		});
		
		function getEmp(id) {
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result)
					var empData = result.extend.emp
					$("#empName_update_static").text(empData.empName)
					$("#email_update_input").val(empData.email)
					$("#empupdateModal input[name=gender]").val([empData.gender])
					$("#empupdateModal select").val([empData.dId])
				}
			});
		}
		
		//点击更新
		$("#emp_update_btn").click(function () {
			//校验邮箱
			var email = $("#email_update_input").val();
			/* 只允许英文字母、数字、下划线、英文句号、以及中划线组成 */
			var regEmail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_update_input","error","邮箱格式不正确")
				return false;
			} else {
				show_validate_msg("#email_update_input","success","")
			}
			
			//发送ajax请求，保存数据
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				data:$("#empupdateModal form").serialize(),
				success:function(result){
					//1.关闭对话框
					$("#empupdateModal").modal("hide");
					//2.回到本页面
					to_page(currentPage)
				}
			})
		});
		
		//完成全选/全不选
		$("#check_all").click(function () {
			//attr获取checked是undefined
			//原生的属性,attr获取自定义的属性
			//prop修改和读取dom原生属性的值
			$(".check_item").prop("checked",$(this).prop("checked"))
		});
		
		//.check_item
		$(document).on("click",".check_item",function(){
			//判断当前选择中的元素是否5个
			var flag = $(".check_item:checked").length==$(".check_item").length
			$("#check_all").prop("checked",flag)
		});
		
		//点击全部删除，就批量删除
		$("#emp_delete_all_btn").click(function () {
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				//this
				empNames += $(this).parents("tr").find("td:eq(2)").text()+","
				//组装员工ID字符串
				//请求中的员工id以-分割
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-"
			});
			//去除empNames多余的,
			empNames = empNames.substring(0,empNames.length-1)
			//删除id多余的-
			del_idstr = del_idstr.substring(0,del_idstr.length-1)
			if(confirm("确认删除【"+empNames+"】吗？")){
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						to_page(currentPage)
					}
				});
			}
		});
		</script>
</html>