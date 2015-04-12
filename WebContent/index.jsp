<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script type="text/javascript">
	$(function() {
		

		$(function() {
			loadAllUsers();
		})

		$("#deleteUser").click(function() {
			var value;
			value = $('#list option:selected').val();
			deleteuser(value);
		})
		
		$('#editUser').click(function(){
			var value;
			var text;
			value = $('#list option:selected').val();
			text = $('#list option:selected').text();
			editField = $('#newName');
			editField.val(text);
			
			if(value != null){
				fadeEditBar(text);
			}else{
				alert("No users selected")
			}
		})
		
		$('#editUserSubmit').click(function(){
			edituser();
		})
		
		$('#add').click(function() {
			adduser();
			editFieldAdd = $('#addUser');
			editFieldAdd.val('');
		})

	})

	function loadAllusers() {
	
		$('#showInsertBarEditUser').fadeOut(0);
		
		$.ajax({
			headers : {
				Accept : 'application/json'
			},
			type : 'GET',
			url : 'http://localhost:8080/BeatShare/rest/users',

			success : function(data) {

				var code;
				for (i = 0; i < data.user.length; i++) {
					code = code + "<option value='" + data.user[i].id + "'> "
							+ data.user[i].username + data.user[i].password + data.user[i].email "</option>";
				}
				$("#list").html(code);
				//alert("users abgerufen");
			},
			error : function(e) {
				console.log(e);
			}
		});

	}

	function deleteuser(id) {
		$.ajax({
			headers : {
				Accept : 'application/json'
			},
			type : 'DELETE',
			url : 'http://localhost:8080/BeatShare/rest/users/' + id,

			success : function(data) {
				loadAllusers();

			},
			error : function(e) {
				console.log(e);
			}
		});

	}

	function adduser() {
		var user = {}
		user.name = $('#adduser').val();

		$.ajax({
			headers : {
				Accept : 'application/json'
			},
			contentType : 'application/json',
			type : 'POST',
			url : 'http://localhost:8080/BeatShare/rest/users',
			data : JSON.stringify(user),
			success : function(data) {
				loadAllusers();
			},
			error : function(e) {
				console.log(e);
			}
		});
	}

	function edituser() {
		var user = {};
		var id = $('#list option:selected').val();
		
		user.name = $('#newName').val();
		
		$.ajax({
			headers : {
				Accept : 'application/json'
			},
			contentType : 'application/json',
			type : 'PUT',
			url : 'http://localhost:8080/BeatShare/rest/users/' + id,
			data : JSON.stringify(user),
			success : function(data) {
				loadAllusers();
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	
	
	function fadeEditBar(text){
		$('#showInsertBarEditUser').fadeIn('slow');
		$('edituser').val(text);
		
	}
</script>
</head>


<body>




	<div class="row">
		<div class="col-xs-6 col-sm-4"></div>
		<div class="col-xs-6 col-sm-4">
			<button class="btn" id="load"></button>
			<div class="form-group">
				<label for="exampleInputEmail1">Neuer user</label> <input
					type="text" class="form-control" id="addUser" width="50%"
					placeholder="Enter user">
				<button type="button" class="btn btn-success" id="add">+</button>
			</div>

			<select multiple class="form-control" id="list">
				<label for="exampleInputEmail1">users</label>
			</select>
			<button type="button" class="btn btn-danger" id="deleteUser">Delete</button>
			<button type="button" class="btn btn-warning" id="editUser">Edit</button>
			<div id="showInsertBarEditUser">
				<div class="form-group">

					<input type="text" class="form-control" id="newName" width="50%"
						placeholder="Enter new Name">
					<button type="button" class="btn btn-warning" id="editUserSubmit">Add</button>
				</div>
			</div>
		</div>
		<div class="clearfix visible-xs-block"></div>
		<div class="col-xs-6 col-sm-4"></div>
	</div>





</body>
</html>