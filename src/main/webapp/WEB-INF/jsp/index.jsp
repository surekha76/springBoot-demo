<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<!-- Include Bootstrap CSS from WebJars -->
<link rel="stylesheet"
	href="/webjars/bootstrap/5.3.0/css/bootstrap.min.css">
<!-- Include jQuery from WebJars -->
<script src="/webjars/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container">
		<button type="button" class="btn btn-primary mt-3 mb-3" id="addEmployee">
			Add Employee</button>
		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>ID</th>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Email</th>
					<th>Update</th>
					<th>Delete</th>
				</tr>
			</thead>
			<tbody id="employeeTableBody"></tbody>
		</table>
		<div class="modal fade" id="addEmployeeModal" tabindex="-1"
			aria-labelledby="addEmployeeModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="addEmployeeModalLabel">Add
							Employee</h5>
						<h5 class="modal-title" id="updateEmployeeModalLabel" style="display:none;">Update
							Employee</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="employeeForm">
						<div class="mb-3">
							<input style="display: none;" type="text" class="form-control" id="id" name="id">
							</div>
							<div class="mb-3">
								<label for="name" class="form-label">First Name</label> 
								<input type="text" class="form-control" id="firstName" name="firstName" required>
							</div>
							<div class="mb-3">
								<label for="name" class="form-label">Last Name</label> <input
									type="text" class="form-control" id="lastName" name="lastName"
									required>
							</div>
							<div class="mb-3">
								<label for="name" class="form-label">Email</label> <input
									type="email" class="form-control" id="email" name="email"
									required>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="addEmployeeButton">Add</button>
    					<button type="button" class="btn btn-primary" id="updateEmployeeButton" style="display: none;">Update</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script>
     	$(document).ready(function() {
            fetchEmployees();
        });
     	$("#addEmployee").on("click", function() {
            $("#employeeForm")[0].reset();
            $("#addEmployeeButton").show();
            $("#updateEmployeeButton").hide();
            $("#addEmployeeModalLabel").show();
            $("#updateEmployeeModalLabel").hide();
            $("#addEmployeeModal").modal("show");
        });
     	function validateForm(){
     		var firstName = document.getElementById('firstName').value;
            var lastName = document.getElementById('lastName').value;
            var email = document.getElementById('email').value;

            if (firstName.trim() === '') {
                alert('First Name is required.');
                event.preventDefault(); // Prevent form submission
                return false;
            }else if (lastName.trim() === '') {
                alert('Last Name is required.');
                event.preventDefault(); // Prevent form submission
                return false;
            }else if (email.trim() === '') {
                alert('Email is required.');
                event.preventDefault(); // Prevent form submission
                return false;
            }else{
            	return true;
            }
     	}
        function fetchEmployees() {
        	var index = 1;
            $.ajax({
                url: "/getAllEmployee",
                type: "GET",
                success: function(data) {
                	console.log(data);
                    var tbody = $("#employeeTableBody");
                    tbody.empty();
                    data.forEach(function(employee) {
                    	console.log(employee);
                     	var row = "<tr data_id="+employee.id+">" +
                            "<td style='display:none;'>" + employee.id + "</td>" +
                            "<td>" + index + "</td>" +
                            "<td>" + employee.firstName + "</td>" +
                            "<td>" + employee.lastName + "</td>" +
                            "<td>" + employee.email + "</td>" +
                            "<td>" + "<button onclick='updateEmployee(" + employee.id + ")'>View</button>" + "</td>" +
                            "<td>" + "<button onclick='deleteEmployee(" + employee.id + ")'>Delete</button>" + "</td>" +
                            "</tr>";
                        tbody.append(row); 
                        index++;
                    }); 
                },
                error: function(error) {
                	console.log(error);
                    alert("Error fetching employees");
                }
            });
        }
        $("#addEmployeeButton").on("click", function () {
        	var validate = validateForm();
            var formData = new FormData($("#employeeForm")[0]);
            var employee = {};
            formData.forEach(function(value, key) {
            	employee[key] = value;
            });
            if(validate){
            	$.ajax({
                    url: "/saveEmployee", 
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(employee),
                    success: function(response) {
                    	console.log(response);
                        $("#addEmployeeModal").modal("hide");
                        fetchEmployees(); 
                        alert(response);
                    },
                    error: function(error) {
                    	$("#addEmployeeModal").modal("hide");
                    	alert(error);
                    	console.log(error);
                    }
                }); 	
            }else{
            	alert(nullField);
            }
        });
        function deleteEmployee(id) {
        	console.log(id);
            $.ajax({
                url: "/deleteEmployee?id=" + id,
                type: "POST",
                success: function(data) {
                    fetchEmployees();
                    alert(data);
                },
                error: function(error) {
                    alert(error);
                }
            });
        }
        function updateEmployee(id){
        	console.log(id);
        	 //var row = $("td:contains(" + id + ")").closest("tr");
			 var row = $("tr[data_id='" + id + "']");
             var id = row.find("td:eq(0)").text();
             var firstName = row.find("td:eq(2)").text(); 
             var lastName = row.find("td:eq(3)").text(); 
             var email = row.find("td:eq(4)").text(); 
             console.log(firstName)
             $("#id").val(id);
             $("#firstName").val(firstName);
             $("#lastName").val(lastName);
             $("#email").val(email);
			
             $("#addEmployeeButton").hide();
             $("#updateEmployeeButton").show();
             $("#addEmployeeModalLabel").hide();
             $("#updateEmployeeModalLabel").show();
             $("#addEmployeeModal").modal("show");
        }
        $("#updateEmployeeButton").on("click", function () {
        	var validate = validateForm();
            var formData = new FormData($("#employeeForm")[0]);
            var employee = {};
            formData.forEach(function(value, key) {
            	employee[key] = value;
            });
            console.log(employee);
            if(validate){
            	$.ajax({
                    url: "/updateEmployee", 
                    method: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(employee),
                    success: function(data) {
                    	console.log(data);
                        $("#addEmployeeModal").modal("hide");
                        fetchEmployees();    
                        document.getElementById("employeeForm").reset();
                        alert(data);
                    },
                    error: function(error) {
                    	$("#addEmployeeModal").modal("hide");
                    	console.log(error);
                    	alert(error);
                    }
                }); 	
            }
        });
     	</script>
	</body>
</html>