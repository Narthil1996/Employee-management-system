package com.ym.dao;

import com.ym.bean.Employee;
import com.ym.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);
    
    //通过id寻找员工
    Employee selectByPrimaryKey(Integer empId);
    
    //查询员工信息时顺带查询部门和职位(在映射xml中重写resultMap和sql语句)
    List<Employee> selectByExampleWithDept(EmployeeExample example);
    
	// 根据数据模糊查询员工信息
	List<Employee> searchEmpByNum(Integer empId);
	
	//根据字符串模糊查询员工信息
	List<Employee> searchEmpByStr(String empName);

    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);
    
    //员工更新
    int updateByPrimaryKeySelective(Employee record);

    int updateByPrimaryKey(Employee record);
    
    //查询所有员工
    //List<Employee> selectAll();
    
    
    //List<Employee> selectEmpById(Employee employee);
}