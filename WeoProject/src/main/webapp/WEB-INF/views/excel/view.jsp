<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
	display: flex;
	justify-content: center;
	width: 100%;
}
</style>
</head>
<body>
	<h1>월간 음주율</h1>
	<p>1) 월간 음주율 : 최근 1년 동안 한 달에 1회 이상 음주한 분율</p>
	<p>2) 만19세이상 분석대상자 수</p>
	<p>3) 표준화 : 2005년 추계인구(장래인구추계, 2016.12. 공표)로 연령표준화</p>
	<p>4) 소득수준 : 월가구균등화소득(월가구소득/√가구원수)을 성별·연령대별(5세단위) 오분위로 분류</p>

	<hr>






	<table>
		<tr>
			<td>연도</td>
			<td>나이</td>
			<td>전체</td>
			<td>남성</td>
			<td>여성</td>
		</tr>

		<c:forEach var="vo" items="${list}">
			<tr>
				<td>${vo.time}</td>
				<td>${vo.age}</td>
				<td>${vo.total}</td>
				<td>${vo.male}</td>
				<td>${vo.female}</td>
			</tr>
		</c:forEach>
	</table>
</html>