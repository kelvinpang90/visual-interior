<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.pwk.com" prefix="pwk" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="js/jquery-1.4.4.js"></script>
    <link rel="stylesheet" type="text/css" href="css/index.css"/>
    <!--引用百度地图API-->
    <style type="text/css">
        .iw_poi_title {color:#CC5522;font-size:14px;font-weight:bold;overflow:hidden;padding-right:13px;white-space:nowrap}
        .iw_poi_content {font:12px arial,sans-serif;overflow:visible;padding-top:4px;white-space:-moz-pre-wrap;word-wrap:break-word}
    </style>
    <script type="text/javascript" src="http://api.map.baidu.com/api?key=&v=1.1&services=true"></script>

    <title>广州御舍</title>
</head>


<script type="text/javascript" src="js/jquery.innerfade.js"></script>
<script type="text/javascript"> 
$(document).ready( function() {

	$('ul#portfolio').innerfade({
			 animationtype:    'fade',//slide
				speed: 1000,
				timeout: 3000,
				type: 'sequence',//type: 'random'
				containerheight: '674px'
	});
	
});
		
</script>
<script type="text/javascript">
$(function(){
	
//    $( window ).scrollTo(0);
	switch_aimermain(); //初始化 滚动
	$(window).bind('scroll', switch_aimermain );
  });
  
  //滚动效果
  function switch_aimermain(e)
  {
	var array = new Array();
	$(".home_gun_div").each( function(){
	  var num=(this.offsetTop - 200)  - $(window).scrollTop();
	  if(num<=0) array.push(this);
	});
	if( array.length > 0 ){
	  var classes = $(array[(array.length-1)]).attr("class");
	  var li_id = classes.split( " " )[1];
	 // alert(li_id);
	  var item = $("#"+li_id);
	  item.addClass("current").siblings().removeClass("current");
	}
  }
  //点击效果
  /*function onClickmenuaimer(e)
  {
	var self = $(this);
	$(window).unbind('scroll', switch_aimermain );
	self.parent().addClass("current").siblings().removeClass("current");
	var id_str = e.target.parentNode.id;
	var sel = $("."+id_str);
	//alert(sel[0].offsetTop);
	if (sel[0].offsetTop==499){
		var scorll_h=0;
	}else{
		var scorll_h=sel[0].offsetTop-90;
	}
	$(window).scrollTo(scorll_h+'px',500,{axis:"y",onAfter:function(){$(window).bind('scroll', switch_aimermain );}});
  }


	$("#menu ul").children("li").each(function(){
		 $(this).on( "click",onClickmenuaimer );
	});*/
	
	function click_scroll(Gunid) {
	var scroll_offset = $("#"+Gunid+"").offset();  
	//得到pos这个div层的offset，包含两个值，top和left  
	$("body,html").animate({   scrollTop:scroll_offset.top  
	//让body的scrollTop等于pos的top，就实现了滚动
	   },1000); 
	} 

</script>

<body>
<div class="logo"><img src="images/logo.jpg" /></div>
<div class="index_banner">
<div class="container">
    <ul id="portfolio" style=" height:674px; z-index:10; overflow:hidden;position:relative;">
		<li><img src="images/index/1.jpg" width="1080" height="674" /></li>
		<li><img src="images/index/2.jpg" width="1080" height="674" /></li>
		<li><img src="images/index/3.jpg" width="1080" height="674" /></li>
		<li><img src="images/index/4.jpg" width="1080" height="674" /></li>
		<li><img src="images/index/5.jpg" width="1080" height="674" /></li>
	</ul>
</div>
</div>

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

<div id="pos1"></div>
<div class="index_cases_bg">
<div class="home_gun_div 1001">
<div class="container">
	<div class="index_top">案例</div>
    <div class="index_cases_con">
    	<c:forEach items="${pwk:getCaseByList(1,5 )}" var="case">
            <div class="case_pic">
                <div class="l_pic">
                    <c:forEach items="${case.images}" var="image" begin="0" end="0">
                        <a href="${pageContext.request.contextPath}/case_${case.id}.html" target="_blank">
                            <img src="${pageContext.request.contextPath}/${image.path}" width="701" height="438" />
                        </a>
                    </c:forEach>
                </div>
                <div class="r_con">
                    <div class="title"><a href="${pageContext.request.contextPath}/case_${case.id}.html" target="_blank" style="padding-bottom: 5px;border-bottom: 2px solid #000;">${case.title}</a></div>
                    <div class="jianshu" style="display: table-cell;vertical-align:middle;text-align: center;"><span style="display:inline-block;vertical-align:middle;">${fn:substring(case.description, 0, 150)}</span></div>
                    <a href="${pageContext.request.contextPath}/case_${case.id}.html" target="_blank" class="detail">案例详情</a>
                    <%--<a href="#" class="detail">显示更多图像内容</a>--%>
                </div>
                <div class="clear"></div>
            </div>
        </c:forEach>
    </div>
    <div class="cases_more"><a href="javascript:void(0)" onclick="loadMore()">更多>>></a></div>
</div>
</div>
</div>

<div id="pos2"></div>
<div class="index_news_bg">
<div class="home_gun_div 1002">
<div class="container">
	<div class="index_top">新闻</div>
    <div class="index_news_con">
    	<c:forEach items="${pwk:getNewsByList(1,4 )}" var="news">
            <div class="news_list">
                <div class="title"><a href="#">${news.title}</a><br />${news.time}</div>
                <div class="news_p">
                    <a href="${pageContext.request.contextPath}/news_${news.id}.html">
                        <c:forEach items="${news.images}" var="image" begin="0" end="0">
                            <img src="${pageContext.request.contextPath}/${image.path}" width="515" height="322" />
                        </c:forEach>
                    </a>
                </div>
                <div>${news.content}</div>
            </div>
        </c:forEach>
    </div>
    </div>
    
    <div class="clear"></div>
</div>
</div>
</div>

<div id="pos3"></div>
<div class="index_service_bg">
<div class="home_gun_div 1003">
<div class="container">
	<div class="index_top">服务</div>
    <div class="index_service_con"><img src="images/liucheng_p.jpg" /></div>
</div>
</div>
</div>

<div id="pos4"></div>
<div class="index_contact_bg">
<div class="home_gun_div 1004">
<div class="container">
	<div class="index_top">联系我们</div>
   	<div class="index_contact_con">
        <div style="width:900px;height:450px;border:#ccc solid 1px;margin-left: 100px;" id="dituContent"></div>
        <div style="margin-top:25px;font-size: 18px;line-height: 28px;"><br/>
        	<span style="font-family:'title';font-size: 24px;; ">联系方式</span><br />
            服务热线：020-84340865<br />
            电子邮箱：dv3d@qq.com<br />
            地      址：广东省广州市海珠区昌岗中路166号富盈国际中心2807室<br />
        </div>
    </div>
</div>
</div>
</div>

<div id="pos5"></div>
<div class="index_intro_bg">
<div class="home_gun_div 1005">
<div class="container">
	<div class="index_top">关于御舍</div>
    <div class="index_intro_con">
    	<div><img src="images/intro_logo.jpg" /></div>
        <br/>
        <div>
        　　广州御舍装饰工程有限公司（GUANGZHOU VISUAL INTERIOR DESIGN CO.,LTD）,位于广州市海珠区昌岗中路166号富盈国际大厦2807室。由粤港两地数名行业资深人士携手创立，成员来自国内顶级策划公司、美术院校、平面设计公司、土木工程等多个领域，是一家生机勃勃的具备整体品牌形象设计、室内外设计、工程施工等一站式综合能力的装饰工程公司，除多元化的家居装饰装修外，拥有包括“表叔”、“星洲大椰”、“烤肉先生”等多家连锁餐饮品牌的客户群。迄今为止, 一大批专业员工负责完成广州及珠三角范围的工程项目。多年以专业造就完美（professional & perfect）为口号，开拓创新，融合中西方装饰元素，不断设计出别具一格的艺术作品。
            <br/>
            <br />
        我们生活在一个视觉时代<br />
        WE LIVED IN A VISUAL AGE<br /><br /><br />
        E.H.GOMBRICH<br />
            <br /><br /><br /><br /><br /><br />
        </div>
    </div>
</div>
</div>
</div>

</body>
<script type="text/javascript">
    //创建和初始化地图函数：
    function initMap(){
        createMap();//创建地图
        setMapEvent();//设置地图事件
        addMapControl();//向地图添加控件
        addMarker();//向地图中添加marker
    }

    //创建地图函数：
    function createMap(){
        var map = new BMap.Map("dituContent");//在百度地图容器中创建一个地图
        var point = new BMap.Point(113.280241,23.092941);//定义一个中心点坐标
        map.centerAndZoom(point,18);//设定地图的中心点和坐标并将地图显示在地图容器中
        window.map = map;//将map变量存储在全局
    }

    //地图事件设置函数：
    function setMapEvent(){
        map.enableDragging();//启用地图拖拽事件，默认启用(可不写)
        map.enableScrollWheelZoom();//启用地图滚轮放大缩小
        map.enableDoubleClickZoom();//启用鼠标双击放大，默认启用(可不写)
        map.enableKeyboard();//启用键盘上下左右键移动地图
    }

    //地图控件添加函数：
    function addMapControl(){
        //向地图中添加缩放控件
        var ctrl_nav = new BMap.NavigationControl({anchor:BMAP_ANCHOR_TOP_LEFT,type:BMAP_NAVIGATION_CONTROL_LARGE});
        map.addControl(ctrl_nav);
        //向地图中添加缩略图控件
        var ctrl_ove = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_RIGHT,isOpen:0});
        map.addControl(ctrl_ove);
        //向地图中添加比例尺控件
        var ctrl_sca = new BMap.ScaleControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT});
        map.addControl(ctrl_sca);
    }

    //标注点数组
    var markerArr = [{title:"广州御舍装饰工程有限公司",content:"广东省广州市海珠区昌岗中路166号富盈国际中心2807室",point:"113.279473|23.093439",isOpen:0,icon:{w:21,h:21,l:0,t:0,x:6,lb:5}}
    ];
    //创建marker
    function addMarker(){
        for(var i=0;i<markerArr.length;i++){
            var json = markerArr[i];
            var p0 = json.point.split("|")[0];
            var p1 = json.point.split("|")[1];
            var point = new BMap.Point(p0,p1);
            var iconImg = createIcon(json.icon);
            var marker = new BMap.Marker(point,{icon:iconImg});
            var iw = createInfoWindow(i);
            var label = new BMap.Label(json.title,{"offset":new BMap.Size(json.icon.lb-json.icon.x+10,-20)});
            marker.setLabel(label);
            map.addOverlay(marker);
            label.setStyle({
                borderColor:"#808080",
                color:"#333",
                cursor:"pointer"
            });

            (function(){
                var index = i;
                var _iw = createInfoWindow(i);
                var _marker = marker;
                _marker.addEventListener("click",function(){
                    this.openInfoWindow(_iw);
                });
                _iw.addEventListener("open",function(){
                    _marker.getLabel().hide();
                })
                _iw.addEventListener("close",function(){
                    _marker.getLabel().show();
                })
                label.addEventListener("click",function(){
                    _marker.openInfoWindow(_iw);
                })
                if(!!json.isOpen){
                    label.hide();
                    _marker.openInfoWindow(_iw);
                }
            })()
        }
    }
    //创建InfoWindow
    function createInfoWindow(i){
        var json = markerArr[i];
        var iw = new BMap.InfoWindow("<b class='iw_poi_title' title='" + json.title + "'>" + json.title + "</b><div class='iw_poi_content'>"+json.content+"</div>");
        return iw;
    }
    //创建一个Icon
    function createIcon(json){
        var icon = new BMap.Icon("http://app.baidu.com/map/images/us_mk_icon.png", new BMap.Size(json.w,json.h),{imageOffset: new BMap.Size(-json.l,-json.t),infoWindowOffset:new BMap.Size(json.lb+5,1),offset:new BMap.Size(json.x,json.h)})
        return icon;
    }

    initMap();//创建和初始化地图
</script>
<script>
    if(${not empty param.type}){
        click_scroll('${param.type}');
    }
</script>
<script type="text/javascript">
    var count = 2;
    function loadMore(){
        $.post("/case/loadMore.do",{'count':count},function(data){
            count++;
            $(".index_cases_con").append(data);
        },"html");
    }
</script>

</html>



