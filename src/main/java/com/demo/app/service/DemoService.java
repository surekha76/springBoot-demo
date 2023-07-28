package com.demo.app.service;

import org.springframework.stereotype.Service;
import com.demo.app.entity.DemoEntity;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import com.demo.app.repository.DemoRepository;

@Service
public class DemoService {
	@Autowired
    private DemoRepository demoRepository;
	
	public void saveEmployee(DemoEntity employee) {
         demoRepository.save(employee);
    }

    public List<DemoEntity> getAllEmployees() {
        return demoRepository.findAll();
    }

    public DemoEntity getEmployeeById(Long id) {
        return demoRepository.findById(id);
    }
    
    public DemoEntity updateEmployee(DemoEntity employee) {
        return demoRepository.updateEmployee(employee);
    }
    
    public void deleteEmployee(Long id) {
    	demoRepository.deleteById(id);
    }




}
