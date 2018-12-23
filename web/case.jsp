<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pwk:getCaseById(param.id)}" var="case"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/index.css"/>
    <link rel="stylesheet" type="text/css" href="bxslider/jquery.bxslider.css">
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript" src="bxslider/jquery.bxslider.min.js"></script>
    <title>${case.title}</title>
</head>
<body>
<div class="menu_bg">
    <div class="container">
        <div id="menu">
            <ul>
                <li class="current" id="1001" onclick="return click_scroll('pos1');">案例</li>
                <li id="1002" onclick="return click_scroll('pos2');">新闻</li>
                <li id="1003" onclick="return click_scroll('pos3');">服务</li>
                <li id="1004" onclick="return click_scroll('pos4');">联系</li>
                <li id="1005" onclick="return click_scroll('pos5');">我们</li>
            </ul>
        </div>
    </div>
</div>

<div class="cases_side_bg">
<div class="container">
	<div class="cases_big_con">
    	<div class="title"><a href="javascript:void(0)" style="padding-bottom: 5px;border-bottom: 2px solid #000;">${case.title}</a></div>
        <div class="jianshu">
        	案例介绍:${case.description}
        </div>
		<div class="big_pic">
        	<div>
                <ul id="slider">
                    <c:forEach items="${case.images}" var="image">
                        <li>
                            <img src="${pageContext.request.contextPath}/${image.path}" alt="${image.id}" style="width:1100px;;" />
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
</div>



</body>
<script>
    $(document).ready(function(){
        $('#slider').bxSlider({
            adaptiveHeight: true
        });
    });
</script>
</html>



