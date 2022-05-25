<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ page session="false" %>
<html>
<head>
	<title>Naver News</title>
</head>
<body>

    <div class="container">
        <div class="row">

            <h1>
                Naver News
            </h1>

<a href="/home/home.do">메인 가기</a>

            <h2>전체 : ${totalCount} 건</h2>
            <div style="position: relative; top: -41px; left:700px;">
                <button name="btnExcel">엑셀다운로드</button>
                <button name="btnExcel2">엑셀업로드</button>
                <input type="file" name="fileObject" style="display:none;"/>
            </div>
            <table class="pure-table pure-table-bordered">
                <tr>
                    <th>썸네일</th>
                    <th>제목</th>
                    <th>매체</th>
                    <th>등록일</th>
                    <th>편집보기</tn>
                    <th>기사원문<th>
                </tr>
                <c:forEach var="vo" items="${list}">
                <tr>
                    <td>
                        <img src="${vo.thumbnail}" alt="${vo.title_name}" width="70"/>
                    </td>
                    <td><a href="/naver_news/form/${vo.id}">${vo.title_name}</a></td>
                    <td>${vo.newspaper}</td>
                    <td>${vo.reg_date}</td>
                    <td>
                        <a href="/popup/news/view/${vo.id}" target="_blank">앱뷰</a>
                    </td>
                    <td>
                        <a href="${vo.link}" target="_blank">원문보기</a>
                    </td>
                </tr>
                </c:forEach>
            </table>

            <tags:pagination cpage="${param.pageIndex}" pageSize="10" groupSize="${pageVO.groupSize}" totalCount="${totalCount}"/>

            <div style="margin:0 auto; width: 500px; margin-top: 50px;">
                <input type="button" name="btn_newform" value="신규작성">
            </div>


        </div>
    </div>
    <iframe src="about:blank" id="hframe" width="0" height="0"></iframe>

<link href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/blog/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){
    $('[name="btn_newform"]').on('click', function(){
        location.href = '/news/form';
    });

    $('[name="btnExcel"]').on('click', function() {
        document.querySelector('#hframe').src  = '/naver_news/download';
    });

    $('[name="btnExcel2"]').on('click', function() {
        document.querySelector('[name="fileObject"]').click();
    });

    $('[name="fileObject"]').on('change', function() {
        var data = new FormData();
        data.append('fileObject', $(this)[0].files[0]);

         $.ajax({
             type: "POST",
             url: "/naver_news/upload",
             data: data,
             processData: false,
             contentType: false,
             dataType: 'json',
             success: function (data) {
                location.reload();
             },
               complete: function() {
                 var _clone = document.querySelector('[name="fileObject"]').cloneNode();
                document.querySelector('[name="fileObject"]').replaceWith(_clone);
                document.querySelector('[name="fileObject"]').value = '';
               }
         });

    });
});

function goPage(cpage) {
    location.href='/naver_news/naver_news.do?page='+cpage;
}
</script>
</body>
</html>
