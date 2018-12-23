<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/jquery-1.4.4.js"></script>
<link rel="stylesheet" type="text/css" href="css/index.css"/>
<title>新闻列表</title>
</head>
<body>
<jsp:include page="include/bottom.jsp" flush="true"/>

<div class="cases_side_bg">
<div class="container" style="padding-bottom:80px; padding-top:30px;">
	<div class="index_top">新闻</div>
    <div class="index_cases_con">
    	<c:forEach items="${pwk:getNewsByList(1, 5)}" var="news">
            <div class="case_pic">
                <div class="l_pic">
                    <c:forEach items="${case.images}" begin="0" end="0" var="image">
                        <img src="${pageContext.request.contextPath}/${image.path}" width="701" height="438" />
                    </c:forEach>
                </div>
                <div class="r_con">
                    <div class="title">${news.title}</div>
                    <div class="jianshu">${case.description}</div>
                    <a href="${pageContext.request.contextPath}/caseList_${case.id}.html" class="detail">新闻详情</a>
                </div>
                <div class="clear"></div>
            </div>
        </c:forEach>
        </div>
    </div>
    
    <div class="cases_more"><a href="#">更多>>></a></div>
</div>
</div>



</body>
</html>



