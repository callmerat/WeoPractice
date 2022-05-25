<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Home</title>
<style>
.container2 {
	display: flex;
	justify-content: space-around;
}

h1{
text-align: center; 
width:100%;
}
</style>
</head>
<body>
	<h1>메인 페이지~ 좋은 하루 보내세요</h1>${sessionScope.loginVO}
	${userId} ${sessionScope.userId} ${userVO} ${id} ${email}
	<hr>
	<div class="container2">
		<c:choose>
			<c:when test="${sessionScope.loginVO == null}">
									로그인 안 했음
									<a href="/user/login.do">로그인 하기</a>
				<a href="/user/registation.do">회원가입 하기</a>
			</c:when>
			<c:when test="${sessionScope.loginVO != null}">
								로그인 했음
								<input type="button" name="btnLogout" value="logout"
					class="btn btn-parimary" />
			</c:when>
		</c:choose>
	</div>

	<hr>

	<div class="container">
		<div class="row">
			<p>
				<a href="/news/news.do">뉴스</a>
			</p>
			<p>
				<a href="/post/list.do">게시판</a>
			</p>
			<p>
				<a href="/news/news.do">소주 매출</a>
			</p>
			<p>
				<a href="/category/crud.do">카테고리 crud</a>
			</p>
			<p>
				<a href="test.do">vue.js 연습</a>
			</p>

		</div>
	</div>

	<link
		href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css"
		rel="stylesheet" type="text/css" />
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
		rel="stylesheet" type="text/css" />
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

	<script type="text/javascript"
		src="/blog/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script>
		$(document).ready(function() {
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