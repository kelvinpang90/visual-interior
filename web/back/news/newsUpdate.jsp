<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pwk:getNewsById(param.id)}" var="news"/>
<html>
<head>
    <title>新闻编辑</title>
    <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript">
        function deleteDom(obj){
            var dom = $(obj).parent();
            dom.empty();
            dom.append("<div id='fileQueue'></div><input type='file' name='uploadify' id='uploadify'/>");
            $("#uploadify").uploadify({
                'id': 'uploadify',
                'fileObjName': 'uploadImages',
                'fileDesc': 'Image Files',
                'fileExt':'*.jpg;*.gif;*.jpeg;*.png;*.bmp',
                'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
                'uploader': '${pageContext.request.contextPath}/image/uploadPic.do?type=news',
                'uploadLimit' : 1,
                'onUploadSuccess': function (file, data, response) {
                    dom.empty();
                    var json = eval ("(" + data + ")");
                    dom.append("<input type='hidden' name='picId' value='"+json.picId+"'/>");
                    dom.append("<img src=" + "${pageContext.request.contextPath}/" + json.picPath + " style='width:150px;height:150px;'>");
                    dom.append("<a href='javascript:void(0)' onclick='deleteDom(this)'>Delete</a>");
                }
            });
        }
    </script>
</head>

<body>
<div class="container">
<form action="${pageContext.request.contextPath}/news/update.do" method="post" class="form-horizontal" onsubmit="return validateForm()"
      id="theForm">
    <input type="hidden" name="id" value="${news.id}">
    <div class="control-group">
        <label class="control-label" for="title">项目名称</label>

        <div class="controls">
            <input type="text" name="title" id="title" class="input-xxlarge" placeholder="新闻标题" value="${news.title}">
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="time">时间</label>

        <div class="controls">
            <div id="datetimepicker" class="input-append date">
                <input type="text" name="time" id="time" value="${news.time}"/>
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

    <div class="input-group" id="upload">
        <label class="control-label" for="title">封面图片</label>
        <c:forEach items="${news.images}" var="pic" begin="0" end="0">
            <div class="controls">
                <input type="hidden" name="picId" value="${pic.id}">
                <img src="${pageContext.request.contextPath}/${pic.path}" style="max-height: 200px;"/>
                <a href="javascript:void(0)" onclick="deleteDom(this)">Delete</a>
            </div>
        </c:forEach>
    </div>
    <br>

    <div class="control-group">
        <label class="control-label" for="content">新闻内容</label>
    </div>
    <textarea rows="30" cols="50" name="content" id="content">${news.content}</textarea>
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
