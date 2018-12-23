<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set value="${pwk:getServiceTotal()}" var="total"/>
<html>
<head>
    <title>服务列表</title>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/back/service/serviceAdd.jsp" class="btn btn-danger">添加服务</a>
    <h4>服务列表</h4>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="table table-condensed table-striped table-hover">
        <tr>
            <th>排序</th>
            <th>类型</th>
            <th>标题</th>
            <th>图片</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${pwk:getServiceByList(param.p, param.s)}" var="service" varStatus="vs">
            <tr>
                <td class="td2">${vs.count}</td>
                <td class="td2">${service.type eq '1'?'三维立体投影':service.type eq '2'?'数字婚礼策划':service.type eq '3'?'视觉创意设计':service.type eq '4'?'数字舞美设计':service.type eq '5'?'媒体广告设计':service.type eq '6'?'商业活动策划':''}</td>
                <td class="td2">${service.title} </td>
                <td class="td2"><img src="${pageContext.request.contextPath}/${pwk:getPics(service.pic)[0]}" width="52" height="29" /></td>
                <td class="td2">
                    <a href="${pageContext.request.contextPath}/back/service/serviceUpdate.jsp?id=${service.id}" class="btn btn-danger">修改</a>
                    <a href="javascript:if(confirm('确定要删除吗？')){window.location.href='${pageContext.request.contextPath}/service/delete.do?id=${service.id}'}" class="btn btn-success">删除</a>
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
            return "${pageContext.request.contextPath}/back/service/serviceList.jsp?s=10&p=" + page;
        }
    };

    $('#page').bootstrapPaginator(options);
</script>
<jsp:include page="../exclude/message.jsp"/>

</body>
</html>