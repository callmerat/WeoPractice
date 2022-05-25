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
	${vo.title_name}
</h1>


    <p>
        ${vo.reg_date},
        ${vo.reporter},
        ${vo.newspaper}
    </p>
    <p>원문: ${vo.link}</p>

    <p>${vo.summary}</p>
    <p><img src="${vo.thumbnail}" alt="${vo.title_name}"/></p>
    <p style="line-height:160%;">${fn:replace(vo.title_contents, newLineChar, "<br/>")}</p>

</body>
</html>
