package com.demo.app.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.demo.app.entity.DemoEntity;

import jakarta.persistence.EntityManager;

@Repository
@Transactional
public class DemoRepository  {
	@Autowired
	EntityManager entityManager;
	public void save(DemoEntity employee) {
		entityManager.persist(employee);
	}

	public List<DemoEntity> findAll() {
		return entityManager.createQuery("Select e from DemoEntity e",DemoEntity.class).getResultList();
		
	}

	public DemoEntity findById(Long id) {
		 return entityManager.find(DemoEntity.class, id);
	}
	
	public DemoEntity updateEmployee(DemoEntity employee) {
		DemoEntity existingEmployee = entityManager.find(DemoEntity.class, employee.getId());
        if (existingEmployee != null) {
            existingEmployee.setFirstName(employee.getFirstName());
            existingEmployee.setLastName(employee.getLastName());
            existingEmployee.setEmail(employee.getEmail());
            return entityManager.merge(existingEmployee);
        }else {
        	return null;
        }
	}
	
	public void deleteById(Long id) {
		 DemoEntity employee = entityManager.find(DemoEntity.class, id);
	        if (employee != null) {
	            entityManager.remove(employee);
	        }
	}
}
