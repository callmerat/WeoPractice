<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page session="false" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	${vo2.title_name}
</h1>
    <p>
        ${vo2.reg_date},
        ${vo2.reporter},
        ${vo2.newspaper}
    </p>
    <p>원문: ${vo2.link}</p>

    <p>${vo2.summary}</p>
    <p><img src="${vo2.thumbnail}" alt="${vo2.title_name}"/></p>
    <p style="line-height:160%;">${fn:replace(vo2.title_contents, newLineChar, "<br/>")}</p>

</body>
</html>
