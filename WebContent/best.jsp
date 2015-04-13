<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script type="text/javascript">
	$(function() {

		//Dropdown menu doesnt close with this
		$('ul.dropdown-menu.mega-dropdown-menu').on('click', function(event) {
			event.stopPropagation();
		});

		$(function() {
			loadAllUsers();
		})

		$("#deleteUser").click(function() {
			var value;
			value = $('#list option:selected').val();
			deleteuser(value);
		})

		$('#editUser').click(function() {
			var value;
			var text;
			value = $('#list option:selected').val();
			text = $('#list option:selected').text();
			editField = $('#newName');
			editField.val(text);

			if (value != null) {
				fadeEditBar(text);
			} else {
				alert("No users selected")
			}
		})

		$('#editUserSubmit').click(function() {
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
							+ data.user[i].username + data.user[i].password
							+ data.user[i].email
					"</option>";
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

	function fadeEditBar(text) {
		$('#showInsertBarEditUser').fadeIn('slow');
		$('edituser').val(text);

	}
</script>
</head>


<body>


	<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<div class="navbar-haeder">
			<button class="navbar-toggle collapsed"
				data-target=".bs-example-js-navbar-collapse" data-toggle="collapse"
				type="button"></button>
			<a class="navbar-brand"
				href="http://localhost:8080/BeatShare/index.jsp"><p
					style="font-family: Georgia, 'Times New Roman', serif;">©BeatShare</p></a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li><a href="http://localhost:8080/BeatShare/index.jsp">New</a></li>
				<li class="active"><a href="#">Best</a></li>
			</ul>

			<div class="col-sm-3 col-md-3 pull-left">
				<form class="navbar-form">
					<div style="padding-top: 3px"></div>
					<div class="input-group">
						<input class="search-query mac-style" type="text"
							placeholder="Search">
						<div class="input-group-btn">
							<button id="submitSearch" class="btn btn-dafault" type="submit">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</div>
						</span>
					</div>
				</form>
			</div>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown mega-dropdown" id="fat-menu"><a
					id="navLogin" class="dropdown-toggle" aria-expanded="false"
					role="button" aria-haspopup="true" data-toggle="dropdown" href="#">Login<span
						class="caret"></span></a>
					<ul class="dropdown-menu mega-dropdown-menu" role="menu"
						aria-labelledby="navLogin">
						<div class="col-sm-12">
							<label for="exampleInputEmail1">Username</label>
							<li id="inputUsername" role="presentation"><input
								type="text" class="form-control" placeholder="Enter Username"
								href="#" tabindex="-1" role="menuitem" /></li>
							<div style="padding-top: 8px"></div>
							<label for="exampleInputEmail1">Password</label>
							<li id="inputPassword" role="presentation"><input
								type="text" class="form-control" placeholder="Enter Password"
								href="#" tabindex="-1" role="menuitem" /></li> <br>
							<li id="submitLogin" role="presentation"><button
									type="submit" class="btn btn-default" tabindex="-1"
									role="menuitem">Login</button></li>
							<div style="padding-top: 6px"></div>
							<li role="presentation"><a href="#" tabindex="-1"
								role="menuitem">Register here </a></li>
						</div>
					</ul></li>

			</ul>
		</div>
	</div>
	</nav>
	<br>
	<br>
	<br>
	<div class="row">
		<div class="col-xs-6 col-sm-4"></div>
		<div class="col-xs-6 col-sm-4">

			
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
			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br> <br> <br> <br>
			<br> <br> <br> <br>sdsd
		</div>
		<div class="clearfix visible-xs-block"></div>
		<div class="col-xs-6 col-sm-4"></div>
	</div>





</body>
</html>