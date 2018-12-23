<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理后台</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="google-site-verification" content="R7G5THr8xgaHFkTNkr_RUB0HvX2Nf8e4qnWi0X1kmz8" />
    <meta http-equiv="X-Frame-Options" content="deny" />

    <link data-turbolinks-track="true" href="${pageContext.request.contextPath}/css/login.css" media="all" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/js/jquery-1.7.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/jquery.form.js"></script>
    <script src="${pageContext.request.contextPath}/js/common.js" type="text/javascript"></script>
    <meta content="authenticity_token" name="csrf-param" />
    <meta content="+9cjxX4p0X2B5t4d6DasL1HO9hF5C02t2MxV9zgiLXU=" name="csrf-token" />
</head>
<body class="app signed-out static home">
<div class="page-container">
    <div class="navbar navbar-static-top">
        <div class="navbar-inner">
            <div class="container">
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
            </div>
        </div>
    </div>
    <div class="container" id="page">
        <div class="flash">
        </div>
        <noscript>
            <div class="alert alert-error">
                <h4 class="alert-heading">Javascript is disabled in your browser</h4>
                Please enable javascript or upgrade your browser for the best experience on Coinbase.
            </div>
        </noscript>

        <div class="hero-unit index-hero">
            <div class="container">
                <h1>御舍，后台管理</h1>
                <p><a href="${pageContext.request.contextPath}/" class="open-trailer"><span>VIsual Interior<span class='icon-play'></span></span></a></p>
                <form action="<%=request.getContextPath()%>/admin/login.do" class="form-inline" id="theForm" method="post" style=""><div style="margin:0;padding:0;display:inline"></div>


                    <input class="focus" id="loginName" name="loginName" placeholder="loginName" size="30" type="text" />
                    <input class="" id="password" name="password" placeholder="password" size="30" type="password" />
                    <input class="btn btn-primary" data-disable-with="Sign In" name="commit" type="submit" value="Sign In" />
                </form>

            </div>
            <div class="globe" id="globe"></div>
        </div>

        <div class="trailer-embed" style="display:none">
            <a href class="close">&times;</a>
        </div>
    </div>
</div>



</body>
</html>
