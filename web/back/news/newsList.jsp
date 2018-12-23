<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set value="${pwk:getNewsTotal()}" var="total"/>
<html>
<head>
    <title>新闻列表</title>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/back/news/newsAdd.jsp" class="btn btn-danger">添加新闻</a>
        <h4>新闻列表</h4>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
            <tr>
                <th>排序</th>
                <th>标题</th>
                <th>时间</th>
                <th>封面图</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${pwk:getNewsByList( param.p, param.s)}" var="news" varStatus="vs">
                <tr>
                    <td class="td2">${vs.count}</td>
                    <td class="td2"><a href="${pageContext.request.contextPath}/news_${news.id}.html" target="_blank">${news.title}</a> </td>
                    <td class="td2">${news.time} </td>
                    <td class="td2">
                        <c:forEach items="${news.images}" var="pic" begin="0" end="0">
                            <img src="${pageContext.request.contextPath}/${pic.miniPath}" style="max-height: 100px;"/>
                        </c:forEach>
                    </td>
                    <td class="td2">
                        <a href="${pageContext.request.contextPath}/back/news/newsUpdate.jsp?id=${news.id}" class="btn btn-danger">修改</a>
                        <a href="javascript:if(confirm('确定要删除吗？')){window.location.href='${pageContext.request.contextPath}/news/delete.do?id=${news.id}'}" class="btn btn-success">删除</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
<div id="page"></div>
<script type='text/javascript'>
    var options = {
        alignment: 'center',
        currentPage: ${empty param.p?1:param.p},
        totalPages: ${(total+10)/10},
        pageUrl: function (type, page, current) {
            return "${pageContext.request.contextPath}/back/cases/newsList.jsp?s=10&p=" + page+"&type=${param.type}";
        }
    };

    $('#page').bootstrapPaginator(options);
</script>
<jsp:include page="../exclude/message.jsp"/>

</body>
</html>