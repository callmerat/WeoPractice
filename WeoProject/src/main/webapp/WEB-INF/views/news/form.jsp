<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>${vo.title_name}</title>
</head>
<body>
    <div class="container">
        <div class="row">

            <h1>Daum 기사 작성</h1>
            <form name="form" method="post">
            <table class="table">
                <tr>
                    <th>아이디</th>
                    <td>
                        <input type="text" name="id" value="${vo.id}"/>
                    </td>
                    <th>오픈여부(${vo.open_yn})</th>
                    <td>
                        <input type="radio" name="open_yn" value="Y"/> 공개
                        <input type="radio" name="open_yn" value="N"/> 비공개
                    </td>
                </tr>
                <tr>
                    <th>등록일</th>
                    <td>
                        ${vo.reg_date}
                    </td>
                    <th>기사 카테고리</th>
                    <td>
                        <select name="category_id">
                            <c:forEach var="vo" items="${category}">
                                <option value="${vo.id}">${vo.name}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td colspan="3">
                        <input type="text" name="title_name" value='${vo.title_name}' size="90"/>
                    </td>
                </tr>
                <tr>
                    <th>기사요약</th>
                    <td colspan="3">
                        <textarea name="summary" style="width:900px;height:100px;">${vo.summary}</textarea>
                    </td>
                </tr>
                <tr>
                    <th>기사내용</th>
                    <td colspan="3">
                        <textarea id="ir1" name="title_contents" style="width:890px;height:400px;">${vo.title_contents}</textarea>
                    </td>
                </tr>

                <tr>
                    <th>썸네일</th>
                    <td colspan="3">
                        <input type="text" name="thumbnail" value="${vo.thumbnail}" size="100"/>
                    </td>
                </tr>

                <tr>
                    <th>썸네일2</th>
                    <td colspan="3">
                        <input type="file" name="file_thumbnail" value="" style="display:none;"/>
                        <input type="button" name="btn_thumbnail" value="파일첨부"/>
                        <input type="hidden" name="pathNm" value=""/>
                        <input type="text" name="title_thumbnail" value="${vo.title_thumbnail}" size="100"/>
                        <img src="${vo.title_thumbnail}" alt="" id="title_thumbnail"/>
                    </td>
                </tr>
                <tr>
                    <th>기자</th>
                    <td colspan="3">
                        <input type="text" name="reporter" value="${vo.reporter}" size="100"/>
                    </td>
                </tr>

                <tr>
                    <th>회사</th>
                    <td colspan="3">
                        <input type="text" name="newspaper" value="${vo.newspaper}" size="100"/>
                    </td>
                </tr>
                <tr>
                    <th>원문링크</th>
                    <td colspan="3">
                        <input type="text" name="link" value="${vo.link}" size="100"/>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">&nbsp;</td>
                </tr>
                <tr align="center">
                    <td colspan="4">
                        <input type="button" name="btn_save" value="저장">
                        &nbsp;
                        <input type="button" name="btn_list" value="목록">
                    </td>
                </tr>
            </table>
            </form>

        </div>
    </div>
<h1>
	${vo.title_name}
</h1>


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
	sSkinURI: "/blog/smarteditor2/SmartEditor2Skin.html",
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
$(document).ready(function(){

    $('[name="id"]').on('change', function() {
        $('[name="link"]').val('https://news.v.daum.net/v/' + this.value);
        $('[name="open_yn"]').val('Y');
        $('[name="category_id"]').val('1');
    });

    $('[name="btn_thumbnail"]').on('click', function(){
        $('[name="file_thumbnail"]').click();
    });

    $('[name="file_thumbnail"]').on('change', function() {

         var data = new FormData();
         data.append('fileObject', $(this)[0].files[0]);
         data.append('pathNm', 'bbs');

         $.ajax({
             type: "POST",
             url: "/web/uploadimage",
             data: data,
             processData: false,
             contentType: false,
             dataType: 'json',
             success: function (data) {
                $('[name="title_thumbnail"]').val(data.pathNm);
                $('#title_thumbnail').attr('src', data.pathNm);
             },
             complete: function() {
            	 var _clone = document.querySelector('[name="file_thumbnail"]').cloneNode();
 				document.querySelector('[name="file_thumbnail"]').replaceWith(_clone);
 				document.querySelector('[name="file_thumbnail"]').value = '';
             }
         });
    });  // file upload

    $('[name="btn_list"]').on('click', function() {
        location.href = '/news/news';
    });

//    $('[name="title_name"]').val();
    $('[name="category_id"]').val('${vo.category_id}');

    var st = '${vo.open_yn}';
    $('input:radio[name="open_yn"]:input[value="' + st + '"]').attr("checked", true);

    // submit
    $('[name="btn_save"]').on('click', function() {

        // 에디터의 내용이 textarea에 적용됩니다.
        oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);

        var obj = {
            "id": $('[name="id"]').val(),
            "reg_date": new Date(),
            "category_id": $('[name="category_id"]').val(),
            "thumbnail": $('[name="thumbnail"]').val(),
            "summary": $('[name="summary"]').val(),
            "title_name": $('[name="title_name"]').val(),
            "title_contents": $('[name="title_contents"]').val(),
            "reporter": $('[name="reporter"]').val(),
            "newspaper": $('[name="newspaper"]').val(),
            "open_yn": $('[name="open_yn"]').val(),
            "view_count": $('[name="view_count"]').val(),
            "link": $('[name="link"]').val()
        }

<c:choose>
    <c:when test="${not empty vo.id}">

        obj.id = '${vo.id}';
        $.ajax({
            type: "put",
            url: "/news/update",
            data: JSON.stringify(obj),
            contentType: "application/json",
            success: function (response) {
                alert(response.msg);
            },
            error: function(error) {
                debugger
            }
        });
    </c:when>
    <c:otherwise>

        // 등록
        $.ajax({
            type: "post",
            url: "/news/create",
            data: JSON.stringify(obj),
            contentType: "application/json",
            success: function (response) {
                alert(response.msg);
            },
            error: function(error) {
                debugger
            }
        });
    </c:otherwise>
</c:choose>

    });
});
</script>
</body>
</html>
