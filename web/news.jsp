<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pwk:getNewsById(param.id)}" var="news"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/jquery-1.4.4.js"></script>
<link rel="stylesheet" type="text/css" href="css/index.css"/>
<title>${news.title}</title>
</head>
<body>
<jsp:include page="include/bottom.jsp" flush="true"/>

<div class="cases_side_bg">
<div class="container">
	<div class="cases_big_con">
    	<div class="title">${news.title}</div>
		<div class="big_pic">
        	${news.content}
        </div>
    </div>
</div>
</div>



</body>
</html>



