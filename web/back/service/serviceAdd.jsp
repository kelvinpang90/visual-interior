<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加服务</title>
    <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#serviceUpload").uploadify({
                'fileObjName': 'solutionUpload',
                'uploadLimit': 1,
                'fileTypeDesc': '*.jpg;*.gif;*.jpeg;*.png;*.bmp;',
                'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
                'uploader': '${pageContext.request.contextPath}/imageUpload?type=service',
                'onUploadSuccess': function (file, data, response) {
                    var picPath = $("#pic").val();
                    picPath += data;
                    $("#pic").attr("value", picPath);
                    $("#service").append("<img src=" + "${pageContext.request.contextPath}/" + data + " style='max-width: 300px;'><br>");
                }
            });
        });
    </script>
</head>
<body>
<div class="container">
    <form action="${pageContext.request.contextPath}/service/add.do" method="post" class="form-horizontal" onsubmit="return validateForm()"
          id="theForm">
        <div class="control-group">
            <label class="control-label" for="title">添加名称</label>

            <div class="controls">
                <input type="text" name="title" id="title" class="input-large" placeholder="添加名称">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="type">类型</label>

            <div class="controls">
                <select name="type" id="type">
                    <option value="1">三维立体投影</option>
                    <option value="2">数字婚礼策划</option>
                    <option value="3">视觉创意设计</option>
                    <option value="4">数字舞美设计</option>
                    <option value="5">媒体广告设计</option>
                    <option value="6">商业活动策划</option>
                </select>
            </div>
        </div>

        <div class="control-group" id="casePic">
            <label class="control-label" for="serviceUpload">添加图片</label>
            <input type="hidden" id="pic" name="pic">

            <div class="controls">
                <div id="fileQueue"></div>
                <input type="file" name="serviceUpload" id="serviceUpload"/>
            </div>
            <div class="controls" id="service"></div>
        </div>

        <div class="control-group">
            <label class="control-label" for="video">视频</label>
            <div class="controls">
                <input type="text" name="video" id="video" class="input-xxlarge"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="description">介绍</label>
            <div class="controls">
                 <textarea rows="20" cols="70" name="description" id="description"></textarea>
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