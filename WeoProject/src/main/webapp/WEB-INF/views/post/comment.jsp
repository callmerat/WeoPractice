<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Review !
</h1>

<div class="container">
    <div class="row">
    <!-- contents -->

        <input type="hidden" name="postId" value="${postId}"/>
        <table>
            <tr>
                <td>
                    <textarea name="commentText" cols="80" rows="3"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="button" name="btnComment" value="리뷰작성"/>
                </td>
            </tr>
        </table>

    </div>

    <div class="row">
        <ul>
            <c:forEach var="comment" items="${comments}">
            <li data-id="${comment.id }">
                ${comment.commentText} = ${comment.user[0].name} - ${comment.regDate }
                <input type="button" name="btnDeleeComment" value="삭제 "/>
            </li>
            
            </c:forEach>
        </ul>
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

    function loadData() {
        location.href = '/post/view.do?postId=${postId}';
    }
    $('[name="btnComment"]').click(function() {
        
        var comment = {
            commentText: $('[name="commentText"]').val(),
            postId: '${postId}'
        };

        $.ajax({
            type: "post",
            url: "/comment/insertProcess/${postId}",
            beforeSend: function(xhr) {
                xhr.setRequestHeader('method1', 'api')
            },
            data: JSON.stringify(comment),
            contentType: "application/json",
            success: function (response) {

               if (response.msg === 'NOT_LOGIN') {
            	   alert('로그인 후 리뷰 가능합니다');
                   $('[name="commentText"]').val('');
               } else {
            	   loadData(); 
               }
            },
            error: function (xhr) {
                alert(xhr);
            }
        });
    });


    $('[name="btnDeleeComment"]').on('click', function() {
        var commentId = $(event.currentTarget).closest('li').data('id');
        var postId = $('[name="postId"]').val();
        $.ajax({
            type: "delete",
            url: "/comment/deleteProcess/"+ postId +"/" + commentId,
            beforeSend: function(xhr) {
                xhr.setRequestHeader('method1', 'api')
            },
            success: function (response) {
            	
            	if (response.msg === 'NOT_LOGIN') {
             	   alert('로그인 후 리뷰 가능합니다');
                    $('[name="commentText"]').val('');
                } else {
             	   loadData(); 
                }
            }
        });
    })
});


</script>
</body>
</html>