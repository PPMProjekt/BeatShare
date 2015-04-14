<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BeatShare</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<script type="text/javascript">
	$(function() {

		//Dropdown menu doesnt close with this
		//$('ul.dropdown-menu.mega-dropdown-menu').on('click', function(event) {
		//	event.stopPropagation();
		//});

		$('#inputPassword').on('click', function(event) {
			event.stopPropagation();
		});

		$('#inputUsername').on('click', function(event) {
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

	$(document).ready(function() {

		$("#jquery_jplayer_1").jPlayer({
			ready : function(event) {
				$(this).jPlayer("setMedia", {
					title : "Bubble",
					m4a : "http://jplayer.org/audio/mp3/Miaow-07-Bubble.mp3",
					oga : "http://jplayer.org/audio/ogg/Miaow-07-Bubble.ogg"
				});
			},
			swfPath : "http://jplayer.org/latest/dist/jplayer",
			supplied : "mp3, oga",
			wmode : "window",
			useStateClassSkin : true,
			autoBlur : false,
			smoothPlayBar : true,
			keyEnabled : true,
			remainingDuration : true,
			toggleDuration : true
		});
	});

	function loadAllUsers() {

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
				<li class="active"><a href="#">New</a></li>
				<li><a href="http://localhost:8080/BeatShare/best.jsp">Best</a></li>
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
								tabindex="-1" role="menuitem" /></li>
							<div style="padding-top: 8px"></div>
							<label for="exampleInputEmail1">Password</label>
							<li id="inputPassword" role="presentation"><input
								type="text" class="form-control" placeholder="Enter Password"
								tabindex="-1" role="menuitem" /></li> <br>
							<li id="submitLogin" role="presentation"><button
									type="submit" class="btn btn-default" tabindex="-1"
									role="menuitem">Login</button></li>
							<div style="padding-top: 6px"></div>
							<li role="presentation"><a herf="#" id="registerHere"
								tabindex="-1" role="menuitem" data-target="#modalRegister"
								data-toggle="modal">Register here </a></li>
						</div>
					</ul></li>

			</ul>
		</div>
	</div>
	</nav>
	<div class="modal fade" id="modalRegister" tabindex="-1" role="dialog"
		aria-labelledby="modalRegisterLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="modalRegisterLabel">Register</h4>
				</div>
				<div class="modal-body">
					<label for="exampleInputEmail1">Enter Username</label> <input
						type="text" class="form-control" placeholder="Enter Username" />
					<div style="padding-top: 20px"></div>
					<label for="exampleInputEmail1">Enter E-Mail</label> <input
						type="text" class="form-control" placeholder="Enter Email" />
					<div style="padding-top: 20px"></div>
					<label for="exampleInputEmail1">Enter Password</label> <input
						type="text" class="form-control" placeholder="Enter Password" />
					<div style="padding-top: 12px"></div>
					<label for="exampleInputEmail1">Repeat Password</label> <input
						type="text" class="form-control" placeholder="Repeat Password" />
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Register</button>
				</div>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<div class="row">
		<div class="col-xs-6 col-sm-4"></div>
		<div class="col-xs-6 col-sm-4">
			<div style="padding-top: 30px"></div>
			<div id="carousel-example-generic" class="carousel slide"
				data-ride="carousel" data-interval="false">


				<!-- Wrapper for slides -->

				<div class="carousel-inner" role="listbox">
					<div class="item active">

						<div class="carousel-caption">
							<p>
								<audio controls="controls" id="audiosource"> <source
									type="audio/mp3" /> Your browser does not support the audio
								element. </audio>
							</p>
							<p>
								<input id="fileinput" type="file" name="filechooser" size="10"
									accept="audio/*" onchange="fileSelected(this)"></input>
							</p>
							<p id="result"></p>
						</div>
					</div>
					<div class="item">
						<div class="carousel-caption">
							<p>
								<audio controls="controls" id="audiosource"> <source
									type="audio/mp3" /> Your browser does not support the audio
								element. </audio>
							</p>
							<p>
								<input id="fileinput" type="file" name="filechooser" size="10"
									accept="audio/*" onchange="fileSelected(this)"></input>
							</p>
							<p id="result"></p>
						</div>
					</div>

				</div>

				<!-- Controls -->
				<a class="left carousel-control" href="#carousel-example-generic"
					role="button" data-slide="prev"> <span
					class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
					<span class="sr-only">Previous</span>
				</a> <a class="right carousel-control" href="#carousel-example-generic"
					role="button" data-slide="next"> <span
					class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
					<span class="sr-only">Next</span>
				</a>
			</div>






			<div class="jp-details">
				<div class="jp-title" aria-label="title">&nbsp;</div>
			</div>
			<div class="jp-no-solution">
				<span>Update Required</span> To play the media you will need to
				either update your browser to a recent version or update your <a
					href="http://get.adobe.com/flashplayer/" target="_blank">Flash
					plugin</a>.
			</div>



		</div>
		<div class="clearfix visible-xs-block"></div>
		<div class="col-xs-6 col-sm-4"></div>
	</div>





</body>
</html>