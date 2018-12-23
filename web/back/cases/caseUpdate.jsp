<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pwk:getCaseById(param.id)}" var="case"/>
<html>
<head>
    <title>修改项目</title>
    <link href="${pageContext.request.contextPath}/js/uploadify/uploadify.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/uploadify/jquery.uploadify.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/ckfinder/ckfinder.js"></script>
    <script type="text/javascript">
        function deleteDom(obj){
            var dom = $(obj).parent();
            dom.remove();
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#uploadify1").uploadify({
                'id': 'uploadify1',
                'fileObjName': 'uploadImages',
                'fileExt':'*.jpg;*.gif;*.jpeg;*.png;*.bmp',
                'fileDesc': 'Image Files',
                'swf': '${pageContext.request.contextPath}/js/uploadify/uploadify.swf',
                'uploader': '${pageContext.request.contextPath}/image/uploadPic.do?type=case',
                'onUploadSuccess': function (file, data, response) {
                    var json = eval ("(" + data + ")");
                    var picDom = $("#upload");
                    picDom.append("<div class='controls'><input type='hidden' name='picId' value='"+json.picId+"'/><img src=" + "${pageContext.request.contextPath}/" + json.picPath + " style='width:150px;height:150px;'> <a href='javascript:void(0)' onclick='deleteDom(this)'>Delete</a></div>");
                }
            });
        });
    </script>
</head>

<body>
<div class="container">
<form action="${pageContext.request.contextPath}/case/update.do" method="post" class="form-horizontal" onsubmit="return validateForm()"
      id="theForm">
    <input type="hidden" name="id" value="${case.id}">
    <div class="control-group">
        <label class="control-label" for="title">项目名称</label>

        <div class="controls">
            <input type="text" name="title" id="title" class="input-xxlarge" placeholder="项目名称" value="${case.title}">
        </div>
    </div>

    <div class="input-group" id="upload">
        <label class="control-label" for="title">项目图片</label>
        <c:forEach items="${case.images}" var="pic">
            <div class="controls">
                <input type="hidden" name="picId" value="${pic.id}">
                <img src="${pageContext.request.contextPath}/${pic.path}" style="max-height: 200px;"/>
                <a href="javascript:void(0)" onclick="deleteDom(this)">Delete</a>
            </div>
        </c:forEach>
    </div>
    <div class="controls">
        <div id='fileQueue'></div>
        <input type='file' name='uploadify' id='uploadify1'/>
    </div>
    <br>

    <div class="control-group">
        <label class="control-label" for="description">项目介绍</label>
    </div>
    <textarea rows="30" cols="50" name="description" id="description">${case.description}</textarea>
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
