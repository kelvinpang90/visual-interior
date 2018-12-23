<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加新闻</title>
    <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#picUpload").uploadify({
                'fileObjName': 'uploadImages',
                'fileTypeDesc': '*.jpg;*.gif;*.jpeg;*.png;*.bmp;',
                'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
                'uploader': '${pageContext.request.contextPath}/image/uploadPic.do?type=news',
                'uploadLimit': 1,
                'onUploadSuccess': function (file, data, response) {
                    var picPath = $("#news");
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
<form action="${pageContext.request.contextPath}/news/add.do" method="post" class="form-horizontal" onsubmit="return validateForm()"
      id="theForm">

    <div class="control-group">
        <label class="control-label" for="title">新闻标题</label>

        <div class="controls">
            <input type="text" name="title" id="title" class="input-xxlarge" placeholder="新闻标题">
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="time">时间</label>

        <div class="controls">
            <div id="datetimepicker" class="input-append date">
                <input type="text" name="time" id="time"/>
          <span class="add-on">
            <i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
          </span>
            </div>
            <script type="text/javascript">
                $(function () {
                    $('#datetimepicker').datetimepicker({
                        format: 'yyyy-MM-dd',
                        language: 'zh-cn',
                        pickDate: true,
                        pickTime: false
                    });
                });
            </script>
        </div>
    </div>

    <div class="control-group" id="newPic">
        <label class="control-label" for="picUpload">新闻封面图</label>
        <div class="controls">
            <div id="fileQueue"></div>
            <input type="file" name="picUpload" id="picUpload"/>
        </div>
        <div class="controls" id="news"></div>
    </div>

    <div class="control-group">
        <label class="control-label" for="content">新闻内容</label>
    </div>
    <textarea rows="30" cols="50" name="content" id="content"></textarea>

    <script type="text/javascript">
        var editor;
        $(document).ready(function () {
            editor = CKEDITOR.replace('content');
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
        $("#content").attr("value",editor.document.getBody().getHtml()) ;
        return true;
    }
</script>
</body>

</html>