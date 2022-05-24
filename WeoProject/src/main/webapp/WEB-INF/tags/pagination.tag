<%-- --%>
<%-- // 출처: https://hsol.tistory.com/894 [한솔닷컴] --%>
<%-- // java 백엔드 단에서 ${maxpage}와 ${currentpage}  --%>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="cpage"        required="true" type="java.lang.Integer" rtexprvalue="true" %>
<%@ attribute name="pageSize"        required="true" type="java.lang.Integer" rtexprvalue="true" %>
<%@ attribute name="groupSize"        required="true" type="java.lang.Integer" rtexprvalue="true" %>
<%@ attribute name="totalCount"     required="true" type="java.lang.Integer" rtexprvalue="true" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<c:set var="cpage" value="<%= cpage %>" />
<c:set var="totalCount" value="<%= totalCount %>" />
<c:set var='pageSize' value="<%= pageSize %>" />
<c:set var='groupSize' value="<%= groupSize %>" />

<fmt:formatNumber var="totalPage" value="${((totalCount - 1) / pageSize)}" maxFractionDigits="0" pattern="######" />
<c:set var="totalPage" value="${totalPage -(totalPage % 1) }" />
<c:set var="totalPage" value="${totalPage == 0 ? 1 : totalPage }" />


<c:set var="firstPage" value="${((cpage - 1) / groupSize)}" />
<c:set var="firstPage" value="${firstPage - (firstPage % 1) }" /> <!--  floor -->
<c:set var="firstPage" value="${firstPage * groupSize + 1 }" />

<c:if test="${firstPage le 0}">
    <c:set var="firstPage" value="1" />
</c:if>
<c:set var="lastPage" value="${firstPage - 1 + groupSize }" />
<c:if test="${lastPage gt totalPage}">
    <c:set var="lastPage" value="${totalPage + 1}" />
</c:if>
<style>
.page_number ul {
    list-style: none;
    overflow: hidden;
    margin: 0;
    padding: 0;
    display: inline-block;
}
.page_number li {
float: left;
padding-left:10px;
}

</style>
<p>&nbsp;</p>
<div class="page_number">
    <div style="text-align:center;">
        <c:choose>
            <c:when test="${firstPage gt groupSize}">
                <button class="left_button" onclick="goPage(${firstPage}-1); return false;"> 이전 </button>
            </c:when>
            <c:otherwise>
                <button class="left_button" onclick="return false;"> 처음 </button>
            </c:otherwise>
        </c:choose>
        <ul>
            <c:forEach begin="${firstPage}" end="${lastPage}" step="1" varStatus="status">
                <c:set var="first" value="" />
                <c:set var="last" value="" />
                <c:if test="${firstPage eq status.index}">
                    <c:set var="first" value="first" />
                </c:if>
                <c:if test="${lastPage eq status.index}">
                    <c:set var="last" value="last" />
                </c:if>
                <c:choose>
                    <c:when test="${cpage eq status.index}">
                        <li class="on ${first} ${last}"><fmt:formatNumber value="${status.index }" maxFractionDigits="0" /></li>
                    </c:when>
                    <c:otherwise>
                        <li class="${first} ${last}"><a href="javascript:goPage(${status.index});">[<fmt:formatNumber value="${status.index }" maxFractionDigits="0" />]</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </ul>
        <c:choose>
            <c:when test="${lastPage lt totalPage}">
                <button class="right_button" onclick="goPage(${lastPage+1}); return false;"> 다음 </button>
            </c:when>
            <c:otherwise>
                <button class="right_button" onclick="return false;"> 마지막 </button>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<div style="height:10px;"></div>