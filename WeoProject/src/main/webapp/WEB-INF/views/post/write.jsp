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
                Write!
            </h1>

            <input type="hidden" name="id" value=""/>

            <table class="table table-striped" style="max-width: 1000px;">
                <colgroup>
                    <col width="120"/>
                    <col width="*"/>
                </colgroup>
                <tr>
                    <td colspan="2" align="right">
                    <input type="button" name="btnList" value="목록"/>
                        <input type="button" name="btnWrite" value="저장" data-id="${post.id}"/>
                    </td>
                </tr>
                <tr>
                    <td>카테고리</td>
                    <td>
                        <select name="categoryId">
                        <option value="">select option</option>
                        <c:forEach var="vo" items="${category}">
                            <option value="${vo.id}">${vo.name}</option>
                        </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>제목</td>
                    <td>
                        <input type="text" name="title" value="${post.title}" size="90"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <textarea id="ir1" name="content" cols="110" rows="20">${post.content}</textarea>
                    </td>
                </tr>
            </table>
        </div>
    </div>



<link href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/blog/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
var oEditors = [];

var sLang = "ko_KR";	// 언어 (ko_KR/ en_US/ ja_JP/ zh_CN/ zh_TW), default = ko_KR

// 추가 글꼴 목록
//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "ir1",
	sSkinURI: "/blog/smarteditor2/SmartEditor2Blog.html",
	htParams : {
		bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		bSkipXssFilter : true,		// client-side xss filter 무시 여부 (true:사용하지 않음 / 그외:사용)
		//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		fOnBeforeUnload : function(){
			//alert("완료!");
		},
		I18N_LOCALE : sLang
	}, //boolean
	fOnAppLoad : function(){
		//예제 코드
		//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	},
	fCreator: "createSEditor2"
});
</script>
<script>
$(document).ready(function () {

    $('[name="btnList"]').on('click', function() {
        location.href='/post/list.do';
    });

    $('[name="btnWrite"]').on('click', function() {
        oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);

        var postId = $(event.currentTarget).data('id');
        var blog = {
            'id': postId,
            'categoryId': $('[name="categoryId"]').val(),
            'title': $('[name="title"]').val(),
            'content': $('[name="content"]').val()
        };

        <c:choose>
            <c:when test="${not empty post}">
                //--------------------------------
                $.ajax({
                    type: "put",
                    url: "/post/upateProcess/" + postId,
                    data: JSON.stringify(blog),
                    contentType: "application/json",
                    success: function (response) {
                        location.href='/post/list.do';
                    }
                });
            </c:when>
            <c:otherwise>

                //--------------------------------
                $.ajax({
                    type: "post",
                    url: "/post/writeProcess",
                    data: JSON.stringify(blog),
                    contentType: "application/json",
                    success: function (response) {
                        location.href='/post/list.do';
                    }
                });
            </c:otherwise>
        </c:choose>
    });
});
</script>
</body>
</html>