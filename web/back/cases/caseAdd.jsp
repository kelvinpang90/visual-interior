<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加项目</title>
    <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#caseUpload").uploadify({
                'fileObjName': 'uploadImages',
                'fileTypeDesc': '*.jpg;*.gif;*.jpeg;*.png;*.bmp;',
                'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
                'uploader': '${pageContext.request.contextPath}/image/uploadPic.do?type=case',
                'onUploadSuccess': function (file, data, response) {
                    var picPath = $("#case");
                    var json = eval ("(" + data + ")");
                    picPath.append("<input type='hidden' name='picId' value='"+json.picId+"'/>");
                    picPath.append("<img src=" + "${pageContext.request.contextPath}/" + json.picPath + " style='max-height:150px;'>");
                }
            });
        });
    </script>
</head>
<body>
<div class="container">
<form action="${pageContext.request.contextPath}/case/add.do" method="post" class="form-horizontal" onsubmit="return validateForm()"
      id="theForm">
    <div class="control-group">
        <label class="control-label" for="title">项目名称</label>

        <div class="controls">
            <input type="text" name="title" id="title" class="input-xxlarge" placeholder="项目名称">
        </div>
    </div>

    <div class="control-group" id="casePic">
        <label class="control-label" for="caseUpload">项目图片</label>
        <input type="hidden" id="pic" name="pic">

        <div class="controls">
            <div id="fileQueue"></div>
            <input type="file" name="caseUpload" id="caseUpload"/>
        </div>
        <div class="controls" id="case"></div>
    </div>

    <div class="control-group">
        <label class="control-label" for="description">项目介绍</label>
    </div>
    <textarea rows="30" cols="50" name="description" id="description"></textarea>

    <script type="text/javascript">
        var editor;
        $(document).ready(function () {
            editor = CKEDITOR.replace('description');
        })
    </script>

    <div class="control-group">
        <input type="submit" value="保存" class="btn btn-danger"/>
    </div>
</form>
</div>
<jsp:include page="../exclude/message.jsp"/>
<script>
    function validateForm(){
        $("#description").attr("value",editor.document.getBody().getHtml()) ;
        return true;
    }
</script>
</body>

</html>