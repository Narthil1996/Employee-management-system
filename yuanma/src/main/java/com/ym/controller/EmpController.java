package com.ym.controller;


import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
import org.aspectj.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ym.bean.Employee;
import com.ym.bean.MsgReturn;
import com.ym.service.impl.EmployeeServiceImpl;


/**
 * 
 * @author tt
 * @date 2017/09/29
 * @description 员工controller
 *
 */
@Controller
public class EmpController {
	
	private static Logger logger = Logger.getLogger(EmpController.class);
	
	@Autowired
	private EmployeeServiceImpl employeeService;
	
	/**
	 * 单个批量二合一
	 * 批量删除1-2-3
	 * 单个删除1
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public MsgReturn deleteEmpById(@PathVariable("ids")String ids) {
		//判断是处理多个员工删除还是多个员工删除
		if(ids.contains("-")) {
			// 批量删除
			// 分割元素
			List<Integer> del_ids = new ArrayList<Integer>();
			String [] str_ids = ids.split("-");
			//组装id的集合
			for(String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			 employeeService.deleteBatch(del_ids);
		}else {
			// 单个删除
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		
		return MsgReturn.success();
	}
	/**
	 * 员工更新方法
	 * @param employee
	 * 
	 * 问题：
	 * 直接以PUT方式发送
	 * 请求体中有数据；
	 * 但是Employee对象封装不上；
	 * update tbl_emp  where emp_id = 1014;
	 * 
	 * 原因：
	 * Tomcat：
	 * 		1、将请求体中的数据，封装一个map。
	 * 		2、request.getParameter("empName")就会从这个map中取值。
	 * 		3、SpringMVC封装POJO对象的时候。
	 * 				会把POJO中每个属性的值，request.getParamter("email");
	 * AJAX发送PUT请求引发的血案：
	 * 		PUT请求，请求体中的数据，request.getParameter("empName")拿不到
	 * 		Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
	 * org.apache.catalina.connector.Request--parseParameters() (3111);
	 * 
	  * 解决方案；
	 * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
	 * 1、配置上HttpPutFormContentFilter；
	 * 2、他的作用；将请求体中的数据解析包装成一个map。
	 * 3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
	 */
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public MsgReturn saveEmp(Employee employee,HttpServletRequest request) {
		System.out.println(request.getParameter("gender"));
		System.out.println("将要跟新的员工数据"+employee);
		employeeService.updateEmp(employee);
		return MsgReturn.success();
	}
	/**
	 * 根据id查询员工
	 * @PathVariable用于id从路径中取出
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public MsgReturn getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		return MsgReturn.success().add("emp", employee);
	}
	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkUser")
	@ResponseBody
	public MsgReturn checkUser(@RequestParam("empName")String empName) {
		//判断用户名是否为合法表达式
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regx)){
			return MsgReturn.fail().add("va_msg", "用户名只能为2-5位中文或者6-16位英文和数字的组合或者2-5位中文");
		}
		//用户名重复校验
		boolean flag = employeeService.checkUser(empName);
		if(flag) {
			return MsgReturn.success();
		} else {
			return MsgReturn.fail().add("va_msg", "用户名不可用");
		}
	}
	
	/**
	 * 员工保存
	 * 1.支持jsr303校验
	 * 2.导入Hibernate-Validator jar
	 * BindingResult 封装校验结果
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public MsgReturn saveEmp(@Valid Employee employee,BindingResult result) {
		if(result.hasErrors()){
			//校验失败，应该返回失败，在模态框中显示失败的错误信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError : errors) {
				System.out.print("错误的字段名"+fieldError.getField());
				System.out.print("错误信息"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return MsgReturn.fail().add("errorFields", map);
		} else {
			employeeService.saveEmp(employee);
			return MsgReturn.success();
		}
	}
	
	
	
	/**
	 * 
	 * @author：tt
	 * @description：用json字符串返回查询到的所有员工带部门和职位的信息
	 * @return：PageInfo
	 */
	@RequestMapping(value = "/emps")
	// @ResponseBody注解可以将返回对象转为JSon对象
	// 需要导入jackson的jar包
	@ResponseBody
	public MsgReturn getEmpsWithJson(
			@RequestParam(value = "pn",defaultValue = "1")Integer pn) {
		//引入PageHelper分页插件(mybatis自带)
		//查询之前调用,传入页码和每页的记录数
		PageHelper.startPage(pn, 8);
		//获得所有的员工数据
		List<Employee> empLists = employeeService.getAllEmps();
		//用PageInfo对结果进行包装
		//封装了详细的分页信息，包括我们查询出来的数据，只需要将PageInfo传入页面
		//要想实现页面出现的页码数,只需要调用有两个参数的构造方法即可
		PageInfo page = new PageInfo(empLists, 5);
		return MsgReturn.success().add("pageInfo",page);
	}
	
	
	/**
	 * 查询所有员工带部门的信息
	 */
//	@RequestMapping(value = "/emps")
	public String getAllEmps(
			@RequestParam(value = "pn",defaultValue = "1")Integer pn,
			ModelMap modelMap) {
		//引入PageHelper分页插件(mybatis自带)
		//查询之前调用,传入页码和每页的记录数
		PageHelper.startPage(pn, 5);
		//获得所有的员工数据
		List<Employee> empLists = employeeService.getAllEmps();
		//用PageInfo对结果进行包装
		//封装了详细的分页信息，包括我们查询出来的数据，只需要将PageInfo传入页面
		//要想实现页面出现的页码数,只需要调用有两个参数的构造方法即可
		PageInfo page = new PageInfo(empLists, 5);
		modelMap.addAttribute("pageInfo",page);
		//视图解析器拼装
		return "list";
	}
	
	/**
	 * 导出excel表
	 */
	@RequestMapping("/export")
	  public String download(HttpServletRequest request,HttpServletResponse response) throws IOException{
	      //填充excel数据
	      List<Employee > reqs = employeeService.getAllEmps();
	      employeeService.exportExcel(reqs, response);
	      return null;
	  }	  
	
	/**
	 * 模糊查询
	 */
	@RequestMapping(value="/search/{searchData}",method=RequestMethod.GET)
	@ResponseBody
	public MsgReturn searchEmp(@PathVariable("searchData")String searchData) throws Exception{
		//处理中文乱码
		String searchStr = new String(searchData.getBytes("iso8859-1"),"UTF-8");
		//查询之前调用，传入页码和每页的记录数
		PageHelper.startPage(1,8);
		//获取搜索条件
		System.out.println("搜索条件为"+searchStr);
		//定义查询到的员工集合
		List<Employee> eList = new ArrayList<>();
		//数字和汉字的正则表达式
		String numReg = "^[1-9]\\d*$";
		String strReg = "^[\u4E00-\u9FFF]+$";
		//处理搜索条件
		//如果为数字，搜索条件为工号,邮箱
		if (searchStr.matches(numReg)) {
			eList = employeeService.searchEmpByNum(Integer.parseInt(searchStr));
			PageInfo page = new PageInfo(eList,10);
			return MsgReturn.success().add("pageInfo", page);
		//搜索条件为姓名，部门
		} else {
			eList = employeeService.searchEmpByStr(searchStr);
			PageInfo page = new PageInfo(eList,10);
			return MsgReturn.success().add("pageInfo", page);
		}
	}
}
