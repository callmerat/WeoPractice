<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Login!
</h1>

    <div class="container">
        <div class="row">
            <input type="text" name="userId" value=""/>
            <input type="password" name="passwd" value=""/>


        </div>
        <div class="row">
        <br/>
            <input type="button" name="btnLogin" value="로그인"/>
        <br/>
        <br/>
            <input type="button" name="btnRegistration" value="회원가입"/>
        </div>
    </div>
<link href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/blog/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script>
$(document).ready(function () {

	$('[name="btnRegistration"]').on('click', function() {
	    location.href = '/user/registation.do';
	});

	$('[name="btnLogin"]').on('click', function() {
		var login = {
			'userId': $('[name="userId"]').val(),
			'passwd': $('[name="passwd"]').val()
		}

		$.ajax({
			type: "post",
			url: "/user/loginProcess",
			data: JSON.stringify(login),
			contentType: "application/json",
			success: function (response) {
				location.href='/post/list.do';
			}
		});
		//--------------------------------
	})
});
</script>
</body>
</html>