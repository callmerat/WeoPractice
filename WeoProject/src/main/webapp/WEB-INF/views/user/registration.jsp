<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Registration!
</h1>


<table class="table table-striped">
	<tr>
		<td>아이디</td>
		<td>
			<input type="text" name="userId" value=""/>
		</td>
	</tr>
	<tr>
		<td>패스워드</td>
		<td>
			<input type="password" name="passwd" value=""/>
		</td>
	</tr>
	<tr>
		<td>이름</td>
		<td>
			<input type="text" name="name" value=""/>
		</td>
	</tr>
	<tr>
		<td>이메일</td>
		<td>
			<input type="email" name="email" value=""/>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="button" class="btn btn-primary" name="btnRegistration" value="등록"/>
		</td>
	</tr>
</table>









<link href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/blog/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>


<script>
$(document).ready(function () {
	
	$('[name="btnRegistration"]').on('click', function() {

		var registration = {
			'userId': $('[name="userId"]').val(),
			'passwd': $('[name="passwd"]').val(),
			'name': $('[name="name"]').val(),
			'email': $('[name="email"]').val()
		};

		$.ajax({
			type: "post",
			url: "/user/registrationProcess",
			data: JSON.stringify(registration),
			contentType: "application/json",
			success: function (response) {
				alert('회원가입완료');
				location.href='/user/login.do';
			}
		});
		
	})
});
</script>
</body>
</html>