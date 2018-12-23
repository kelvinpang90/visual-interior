<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pwk:getServiceById(param.id)}" var="service"/>
<html>
<head>
    <title>修改方案</title>
    <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
    <script>
        function deletePic(){
            $("#servicePic").empty();
            $("#pic").attr("value", "");
            $("#picDiv").append("<div class='controls' id='upload'> <div id='fileQueue'></div><input type='file' name='serviceUpload' id='serviceUpload'/></div>");
            $("#serviceUpload").uploadify({
                'fileObjName': 'serviceUpload',
                'uploadLimit': 1,
                'fileTypeDesc': '*.jpg;*.gif;*.jpeg;*.png;*.bmp;',
                'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
                'uploader': '${pageContext.request.contextPath}/imageUpload?type=service',
                'onUploadSuccess': function (file, data, response) {
                    var picPath = $("#pic").val();
                    picPath += data;
                    $("#pic").attr("value", picPath);
                    $("#servicePic").append("<img src=" + "${pageContext.request.contextPath}/" + data + " style='max-width: 300px;'><br>");
                }
            });
        }
    </script>
</head>

<body>
<div class="container">
    <form action="${pageContext.request.contextPath}/service/update.do" method="post" class="form-horizontal" onsubmit="return validateForm()"
          id="theForm">
        <input type="hidden" name="id" value="${service.id}">
        <div class="control-group">
            <label class="control-label" for="title">方案名称</label>

            <div class="controls">
                <input type="text" name="title" id="title" class="input-large" placeholder="方案名称" value="${service.title}">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="type">类型</label>

            <div class="controls">
                <select name="type" id="type">
                    <option value="1" ${service.type eq 1?'selected':''}>三维立体投影</option>
                    <option value="2" ${service.type eq 2?'selected':''}>数字婚礼策划</option>
                    <option value="3" ${service.type eq 3?'selected':''}>视觉创意设计</option>
                    <option value="4" ${service.type eq 4?'selected':''}>数字舞美设计</option>
                    <option value="5" ${service.type eq 5?'selected':''}>媒体广告设计</option>
                    <option value="5" ${service.type eq 6?'selected':''}>商业活动策划</option>
                </select>
            </div>
        </div>

        <div class="control-group"  id="picDiv">
            <label class="control-label">方案图片</label>
            <input type="hidden" id="pic" name="pic" value="${service.pic}">

            <div class="controls" id="servicePic">
                <c:forEach items="${pwk:getPics(service.pic)}" var="pic">
                    <img src="${pageContext.request.contextPath}/${pic}" style="max-width: 300px;"/>
                </c:forEach>
                <a href="javascript:deletePic()">删除图片</a>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="video">视频</label>
            <div class="controls">
                 <input type="text" name="video" id="video" value="${service.video}" class="input-xxlarge"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="description">介绍</label>
            <div class="controls">
                <textarea rows="20" cols="70" name="description" id="description">${service.description}</textarea>
            </div>
        </div>

        <div class="control-group">
            <input type="submit" value="保存" class="btn btn-danger"/>
        </div>
    </form>
</div>
<jsp:include page="../exclude/message.jsp"/>
<script>
    function validateForm(){
        return true;
    }
</script>
</body>
</html>
