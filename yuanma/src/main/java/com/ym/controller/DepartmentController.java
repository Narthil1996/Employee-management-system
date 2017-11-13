package com.ym.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ym.bean.Department;
import com.ym.bean.MsgReturn;
import com.ym.service.DepartmentService;

/**
 * 处理和部门相关的请求
 * @author Administrator
 *
 */
@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 返回所有部门信息
	 */
	@RequestMapping(value="/depts")
	@ResponseBody
	public MsgReturn getDepts() {
		//查处所有部门信息
		List<Department> list = departmentService.getDepts();
		return MsgReturn.success().add("depts", list);
	}
}
