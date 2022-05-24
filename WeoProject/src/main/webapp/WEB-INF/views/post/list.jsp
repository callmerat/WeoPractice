<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>

</head>
<body>
<h1>메인 페이지~ 좋은 하루 보내세요</h1>${sessionScope.userID}

						<c:choose>
							<c:when
								test="${sessionScope.userID == null}">
									로그인 안 했음
									<a href="/user/login.do">로그인 하기</a>
									<a href="/user/registation.do">회원가입 하기</a>
							</c:when>
							<c:when
								test="${sessionScope.userID != null}">
								로그인 했음
								           <input type="button" name="btnLogout" value="logout" class="btn btn-parimary"/>
							</c:when>
						</c:choose>


    <div class="container">
        <div class="row">
            <h1>
                List!
            </h1>
        </div>
        <div class="row">
            <input type="button" name="btnWrite" value="글작성"/>
				 <a href="/news/view.do">뉴스</a>
				 <a href="/news/list.do">뉴스</a>
            <ul id='post'>
                <c:forEach var="post" items="${posts}">
                    <li data-id="${post.id}" style="margin: 10px 0;cursor: pointer;">
                        <c:out value="${post.title}"/> :: ${post.regDate}
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
    $('#post li').on('click', function() {
        var postId = $(event.currentTarget).data('id');
        location.href = '/post/view.do?postId=' + postId;
    });

    $('[name="btnWrite"]').on('click', function() {
        location.href = '/post/write.do';
    });
    $('[name="btnLogout"]').on('click', function() {
        location.href = '/user/logout.do';
    });
});
</script>
</body>
</html>