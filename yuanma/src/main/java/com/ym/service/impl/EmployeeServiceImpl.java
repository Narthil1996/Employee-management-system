package com.ym.service.impl;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ym.bean.Department;
import com.ym.bean.Employee;
import com.ym.bean.EmployeeExample;
import com.ym.bean.EmployeeExample.Criteria;
import com.ym.dao.EmployeeMapper;
import com.ym.service.EmployeeService;
import com.ym.util.ExcelUtil;

@Service
public class EmployeeServiceImpl implements EmployeeService{
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAllEmps() {
		return employeeMapper.selectByExampleWithDept(null);
	}
	
	/**
	 * 员工保存
	 * @param employee
	 */
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}
	
	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return true 代表当前姓名可用，false 不可用
	 */
	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 根据员工id查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * 员工更新
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	
	/**
	 * 删除员工
	 */
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}
	
	/**
	 * 批量删除
	 */
	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

	
	/**
	 * 导出excel表
	 */
	public void exportExcel(List<Employee> reqs, HttpServletResponse response) throws IOException {
		  List<Map<String,Object>> list= createExcelRecord(reqs);
	      String columnNames[]={"员工工号","员工姓名","员工性别","员工邮箱","关联部门"};//列名
	      String keys[] = {"empId","empName","gender","email","department"};//map中的key
	      ByteArrayOutputStream os = new ByteArrayOutputStream();
	      try {
	          ExcelUtil.createWorkBook(list,keys,columnNames).write(os);
	      } catch (IOException e) {
	          e.printStackTrace();
	      }
	      byte[] content = os.toByteArray();
	      InputStream is = new ByteArrayInputStream(content);
	      String fileName="excel文件";
	      // 设置response参数，可以打开下载页面
	      response.reset();
	      response.setContentType("application/vnd.ms-excel;charset=utf-8");
	      response.setHeader("Content-Disposition", "attachment;filename="+ new String((fileName + ".xls").getBytes(), "iso-8859-1"));
	      ServletOutputStream out = response.getOutputStream();
	      BufferedInputStream bis = null;
	      BufferedOutputStream bos = null;
	      try {
	          bis = new BufferedInputStream(is);
	          bos = new BufferedOutputStream(out);
	          byte[] buff = new byte[2048];
	          int bytesRead;
	          // Simple read/write loop.
	          while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
	              bos.write(buff, 0, bytesRead);
	          }
	      } catch (final IOException e) {
	          throw e;
	      } finally {
	          if (bis != null)
	              bis.close();
	          if (bos != null)
	              bos.close();
	      }
	}
	private List<Map<String, Object>> createExcelRecord(List<Employee > outReqList) {
	      List<Map<String, Object>> listmap = new ArrayList<Map<String, Object>>();
	      Map<String, Object> map = new HashMap<String, Object>();
	      map.put("sheetName", "sheet1");
	      listmap.add(map);
	      Employee outReq=null;
	      for (int j = 0; j < outReqList.size(); j++) {
	    	  outReq=outReqList.get(j);
	          Map<String, Object> mapValue = new HashMap<String, Object>();
	          mapValue.put("empId", outReq.getEmpId());
	          mapValue.put("empName", outReq.getEmpName());
	          mapValue.put("gender", outReq.getGender());
	          mapValue.put("email", outReq.getEmail());
	          mapValue.put("department", outReq.getDepartment().getDeptName());
	          listmap.add(mapValue);
	      }
	      return listmap;
		}

	/**
	 * 根据数据模糊查询员工信息
	 */
	public List<Employee> searchEmpByNum(int searchNum) {
		List<Employee> eList = employeeMapper.searchEmpByNum(searchNum);
		return eList;
	}

	/**
	 * 根据字符串模糊查询员工信息
	 */
	public List<Employee> searchEmpByStr(String searchStr) {
		List<Employee> eList = employeeMapper.searchEmpByStr(searchStr);
		return eList;
	}

		
	}
