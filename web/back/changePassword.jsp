<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改管理员密码</title>
</head>
<body>
<div class="container">
    <form action="${pageContext.request.contextPath}/admin/changePassword.do" method="post" class="form-signin"
          id="theForm">
        <div class="control-group">
            <label class="control-label" for="oldPassword">当前密码</label>
            <div class="controls">
                <input type="password" name="oldPassword" id="oldPassword" class="input-medium" placeholder="当前密码">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="newPassword">新密码</label>
            <div class="controls">
                <input type="password" name="newPassword" id="newPassword" class="input-medium" placeholder="新密码">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="newPassword1">确认新密码</label>
            <div class="controls">
                <input type="password" name="newPassword1" id="newPassword1" class="input-medium" placeholder="确认新密码">
            </div>
        </div>

        <div class="form-horizontal">
            <input type="submit" value="确定" class="btn btn-danger"/>
        </div>
    </form>
</div>
<jsp:include page="../back/exclude/message.jsp"/>
</body>
<script src="${pageContext.request.contextPath}/bootstrap/js/jquery.js"></script>
<script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet">
</html>