package com.ym.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
/**
 * 
 * @author tt
 * @date 2017/09/29
 * @description 使用Spring测试模块提供的测试请求功能测试
 * 使用spring 4测试时，需要Servlet3.0的支持，所以检查你的pom.xml
 *
 */
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.ym.bean.Employee;
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
//需要spring的配置文件和springmvc的配置文件
@ContextConfiguration(locations = {"classpath:applicationContext.xml",
		"classpath:spring-mvc.xml"})
public class MvcTest {
	
	//springmvc的IOC
	@Autowired
	WebApplicationContext context;
	
	//虚拟mvc请求，获取处理结果
	MockMvc mockMvc;
	
	//初始化
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	//模拟请求，拿到查询的数据
	@Test
	public void testPage() throws Exception {
		//模拟url请求，传入页码
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		//请求成功以后，请求域中会有pageinfo，我们可以去除pageinfo 进行验证
				MockHttpServletRequest request = result.getRequest();
				PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
				System.out.println("当前页码"+pi.getPageNum());
				System.out.println("总页码"+pi.getPages());
				System.out.println("总记录数"+pi.getTotal());
				System.out.println("在页面需要连续显示的页码");
				int [] nums = pi.getNavigatepageNums();
				for(int i : nums) {
					System.out.print(" "+i);
				}
				
				//获取员工数据
				List<Employee> list = pi.getList();
				for(Employee employee : list) {
					System.out.println("ID:"+employee.getEmpId()+"==>Name:"+employee.getEmpName());
				}
	}
}
