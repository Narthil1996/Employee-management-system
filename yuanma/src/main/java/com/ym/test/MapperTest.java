package com.ym.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ym.bean.Department;
import com.ym.bean.Employee;
import com.ym.dao.DepartmentMapper;
import com.ym.dao.EmployeeMapper;

/**
 * 
 * @author tt
 * @date 2017/09/29
 * @description 测试mapper接口是否能正常运行
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
// 1.导入SpringTest模块
// 2.@ContextConfiguration指定Spring配置文件的位置
// 3.自动创建IOC容器
// 4.直接Autowired要使用的组件即可
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	SqlSession sqlSession;

	/**
	 * 测试方法1
	 */
//	@Test
//	public void Test() {
//		// 1.根据配置文件创建SpringIOC容器会调用构造器方法，对配置文件中的Bean进行初始化，同时会调用set方法注入实例
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		// 2.从容器中获取mapper代理对象
//		DepartmentMapper departmentMapper = ioc.getBean(DepartmentMapper.class);
//		System.out.println(departmentMapper);
//	}

	
	/**
	 * 测试方法2
	 */
	//测试插入部门数据
	@Test
	public void testDeptInsert() {
		System.out.println(departmentMapper);
		Department dept = new Department();
		dept.setDeptId(1);
		dept.setDeptName("开发部");
		departmentMapper.insertSelective(dept);
	}
	
	//测试插入员工信息
	@Test
	public void testEmpInsert() {
		System.out.println(employeeMapper);
		Employee emp = new Employee();
		emp.setEmpId(1);
		emp.setEmpName("CN");
		emp.setGender("女");
		emp.setEmail("CN@sina.com");
		emp.setdId(1);
		employeeMapper.insertSelective(emp);
	}
	
	//测试批量插入员工
	@Test
	public void testSqlSessionInsert() {
		// 批量插入多个员工，使用执行批量操作的sqlSession
		EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 500; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			String empName = UUID.randomUUID().toString().substring(0, 5);
			employeeMapper.insertSelective(new Employee(null,empName,"男",uid+"@sina.com",1));
		}
	}
}