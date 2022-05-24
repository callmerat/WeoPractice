<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>

<div class="container">
    <div class="row">
        <h1>
            View !
        </h1>
    </div>
    <div class="row">
    <!-- contents -->

        <ul style="list-style: none;">
            <li style="float: left;">
                <input type="button" name="btnList" value="목록"/>
            </li>
            <li>
                <input type="button" name="btnEdit" value="수정" data-id="${post.id}"/>
            </li>
        </ul>

        <ul style="list-style: none;">
            <li>${post.title}</li>
            <li>${post.category.name}</li>
            <li>${post.regDate}</li>
            <li>${post.content}</li>
        </ul>

        <div id="commentList"></div>
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
    $('[name="btnList"]').on('click', function() {
        location.href='/post/list.do';
    });

    $('[name="btnEdit"]').on('click', function() {
        var postId = $(event.currentTarget).data('id');
        location.href='/post/write.do?postId=' + postId;
    });

    function loadData() {
        $('#commentList').load('/comment/list/${post.id}');
    }
    loadData();
});


</script>
</body>
</html>