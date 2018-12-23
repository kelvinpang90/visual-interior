<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="infoModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="close">×</button>
        <h3 id="myModalLabel">Message</h3>
    </div>
    <div class="modal-body">
        <p id="msg"></p>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true" id="bt">关闭</button>
    </div>
</div>
<script src="${pageContext.request.contextPath}/bootstrap/js/jquery.form.js"></script>
<script>
    $(function () {
        $("#theForm").ajaxForm({
            success:function (json, statusText, xhr, $form) {
                if (json.state == 'ok') {
                    if(json.msg!=''){
                        $("#msg").html(json.msg);
                        $("#bt").attr("onclick","javascript:window.location.href='"+json.url+"'");
                        $("#close").attr("onclick","javascript:window.location.href='"+json.url+"'");
                        $('#infoModal').modal();
                    }else{
                        if(json.url!=''){
                            window.location.href=json.url;
                        }
                    }
                }
                else {
                    $("#msg").html(json.msg);
                    $('#infoModal').modal();
                }
            },
            dataType:'json'

        });
    })
</script>