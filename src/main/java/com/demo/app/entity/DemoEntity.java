package com.demo.app.entity;

import jakarta.persistence.*;

@Entity
@Table(name="employee")
public class DemoEntity {
	 	@Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
		@Column(name="emp_id")
	    private Long id;
		@Column(name="emp_firstName")
	    private String firstName;
		@Column(name="emp_lastName")
	    private String lastName;
		@Column(name="emp_email")
	    private String email;
		public Long getId() {
			return id;
		}
		public void setId(Long id) {
			this.id = id;
		}
		public String getFirstName() {
			return firstName;
		}
		public void setFirstName(String firstName) {
			this.firstName = firstName;
		}
		public String getLastName() {
			return lastName;
		}
		public void setLastName(String lastName) {
			this.lastName = lastName;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
}