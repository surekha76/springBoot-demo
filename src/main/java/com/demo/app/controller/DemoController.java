package com.demo.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.demo.app.entity.DemoEntity;
import com.demo.app.service.DemoService;

@RestController
public class DemoController {
	
	@RequestMapping(value = "/")
	public ModelAndView hello() {
		System.out.println("//hiii");
	    return new ModelAndView("index");
	 }
	@Autowired
    private DemoService demoService;

	    @PostMapping("/saveEmployee")
	    @ResponseBody
	    public String addEmployee(@RequestBody DemoEntity employee) {
	    	try {
	    		 demoService.saveEmployee(employee);
	    		 String response = "Employee Inserted Successfuly";
	             return response;
	    	}catch(Exception e) {
	    		return e.getMessage();
	    	}
	    }
	    
	    @GetMapping("/getAllEmployee")
	    @ResponseBody
	    public  List<DemoEntity> getAllEmployee() {
	    	return demoService.getAllEmployees();
	    }
	    
	    @GetMapping("/getEmployee")
	    @ResponseBody
	    public DemoEntity getEmployee(@RequestParam Long id) {
	    	return demoService.getEmployeeById(id);
	    }

	    @PostMapping("/updateEmployee")
	    @ResponseBody
	    public String updateEmployee(@RequestBody DemoEntity employee) {
	    	try {
	    		demoService.updateEmployee(employee);
	    		String response = "Employee Updated Successfuly";
	            return response;
	    	}catch(Exception e) {
	    		return e.getMessage();
	    	}
	    }
    
	    @PostMapping("/deleteEmployee")
	    @ResponseBody
	    public String deleteEmployee(@RequestParam Long id) {
	    	try {
	    		demoService.deleteEmployee(id);
	    		String response = "Employee Deleted Successfuly";
	            return response;
	    	}catch(Exception e) {
	    		return e.getMessage();
	    	}
	    }
}