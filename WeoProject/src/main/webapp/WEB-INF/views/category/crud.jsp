<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Category !
</h1>

<table class="table">
	<colgroup>
		<col width="500"/>
		<col width="500"/>
	</colgroup>
    <tr>
        <td>
            <!-- list -->
            <ul id="result">
            </ul>
        </td>
        <td>

            <!-- form -->
            <table>
                <tr>
                    <td>카테고리</td>
                    <td>
                        <input type="text" name="name" value=""/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="button" name="btnCategory" value="등록"/>
                    </td>
                </tr>
            </table>
            <!-- -->
        </td>
    </tr>
</table>




<link href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/blog/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script>
$(document).ready(function () {

    $('[name="btnCategory"]').on('click', function (e) {

        var category = {
            'id': '',
            'name': $('[name="name"]').val(),
            'userId': ''
        };

        $.ajax({
            type: "post",
            url: "/category/insertProcess",
            data: JSON.stringify(category),
            contentType: "application/json",
            success: function (response) {
                loadData();
            }
        });
    });

    function loadData() {
		$.ajax({
			url: "/category/list",
			success: function (response) {
                var str = '';
                $.each(response.data, function (indexInArray, valueOfElement) { 
                     str += '<li data-id='+ valueOfElement.id +'>' + valueOfElement.name + '</li>';
                });
                $('#result').empty();
                $('#result').append(str);
                $('[name="name"]').val('');
			}
		});
    }

    loadData();
});
</script>
</body>
</html>