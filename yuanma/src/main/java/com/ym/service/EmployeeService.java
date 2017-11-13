package com.ym.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;


import com.ym.bean.Employee;

public interface EmployeeService {
	//查询所有员工
	public List<Employee> getAllEmps();
	//员工保存
	public void saveEmp(Employee employee);
	//根据员工id查询员工
	public Employee getEmp(Integer id);
	//员工更新
	public void updateEmp(Employee employee);
	//删除员工
	public void deleteEmp(Integer id);
	//批量删除
	public void deleteBatch(List<Integer> ids);
	//根据数据模糊查询员工信息
	public List<Employee> searchEmpByNum(int searchNum);
	//根据字符串模糊查询员工信息
	List<Employee> searchEmpByStr(String searchStr);
	//导出excel表
	public void exportExcel(List<Employee> reqs,HttpServletResponse response) throws IOException;
}
