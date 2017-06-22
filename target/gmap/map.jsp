<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Region Hotspot</title>
    <style>
        /* Always set the map height explicitly to define the size of the div
         * element that contains the map. */
        /* Optional: Makes the sample page fill the window. */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
    </style>
    <script language="JavaScript" type="text/javascript" src="js/jquery-1.11.1.js" charset="utf-8"></script>
    <!--(指定编码方式，防止出现乱码)引入EasyUI中使用的Jquery版本-->
    <script language="JavaScript" type="text/javascript" src="jquery-easyui-1.5.2/jquery.easyui.min.js" charset="utf-8"></script>
    <!--(指定编码方式，防止出现乱码)引入EasyUi文件-->

    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.2/themes/default/easyui.css">   <!--引入CSS样式-->
    <link rel="stylesheet" type="text/css" href="jquery-easyui-1.5.2/themes/icon.css">   <!--Icon引入-->

    <script language="JavaScript" type="text/javascript" src="jquery-easyui-1.5.2/locale/easyui-lang-zh_CN.js"></script>  <!--汉化-->
    <script>
        setTimeout(function(){
            $('#Departing').datebox({
                onSelect: function(date){
                    $("#effect_date").val(date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());
                    var effectDate = new Date($("#effect_date").val());
                    var strDate = effectDate.getFullYear()+"-";
                    strDate += effectDate.getMonth()+1+"-";
                    strDate += effectDate.getDate()+1;//+"-"
                    $("#Returning").datebox("setValue", strDate);
                }
            });
            $('#Returning').datebox({
                onSelect: function(date){
//                    $("#effect_date").val(date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate());
                }
            });
            var curr_time = new Date();
            var strDate1 = curr_time.getFullYear()+"-";
            strDate1 += curr_time.getMonth()+1+"-";
            strDate1 += curr_time.getDate();//+"-"
            $("#Departing").datebox("setValue", strDate1);
            var strDate2 = curr_time.getFullYear()+"-";
            strDate2 += curr_time.getMonth()+1+"-";
            strDate2 += curr_time.getDate()+1;//+"-"
            $("#Returning").datebox("setValue", strDate2);

            // 这是只允许选择今后的日期
            $('#Departing').datebox('calendar').calendar({
                validator: function(date){
                    var now = new Date();
                    var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                    return d1<=date;
                }
            });
            $('#Returning').datebox('calendar').calendar({
                validator: function(date){
                    var now = new Date($("#Departing").datebox("getValue"));
                    var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate()+1);
                    return d1<=date;
                }
            });
        },500);

        function ajaxLoading(){
            $("<div class=\"datagrid-mask\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("body");
            $("<div class=\"datagrid-mask-msg\"></div>").html("正在处理，请稍候。。。").appendTo("body").css({display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});
        }
        function ajaxLoadEnd(){
            $(".datagrid-mask").remove();
            $(".datagrid-mask-msg").remove();
        }

        function doSearch(){
            ajaxLoading();
            var regionIds = "6160338,6160339,6160345,6160393,6160395,6051831," +
                    "6048791,6048792,6048793";//,6048795,6048796,6048797," +
//                    "6048798,6048802,6233607,6233654,6233986,6189429," +
//                    "6242359,6181880,6269359,6160146,6160194,6160223," +
//                    "6140252,6140253,6140255,6130853,6342008,6199891," +
//                    "6199894,178553,178555,178559,178564,178565," +
//                    "178573,178574,178576,178578,178581,178584," +
//                    "6050437,597,6188374,6188375,6188376,6188377," +
//                    "6188378,6188380,6188381,6188383,6188384,6188385," +
//                    "6188387,6160331,6048794,6234100,6233761,6181914," +
//                    "6269457,6269412,6269422,178557,178563,178580," +
//                    "6188379,6188382";
            var array_region = regionIds.split(",");
            var timeCount = 0;
            for(var i=0;i<array_region.length;i++){
                timeCount = i;
                handleSearch(array_region[i]);
            }
            var interval = setInterval(function(){
                var result = $("#regionId_hots").val();
                result = result.substring(0,result.length-1);
//                console.log("result="+result);
//                console.log(result.split(",").length);
                if(result.split(",").length==9){
                    clearInterval(interval);
                    ajaxLoadEnd();
                    document.getElementById("sub").click();

                }
            },1000);

//            handleSearch("6160393");
        }
        function handleSearch(regionId){
            $.ajax({
                url:'http://localhost:8081/myServlet',
                dataType: "json",
                data:{
                    regionId:regionId,
                    checkInDate:$("#Departing").datebox("getValue"),
                    checkOutDate:$("#Returning").datebox("getValue")
                },
                type :'GET',
                success:function(data) {
//                    console.log(data);
                    if(data!=null&&data[0]!=null){
                        var hotspots = data[0].regionInsights[0];
                        if(hotspots!=null&&hotspots!=undefined) {
                            successHandler(regionId + "-" + hotspots);
//                            console.log(regionId+"-"+hotspots);
//                            regionId_hots+= regionId+"-"+hotspots+",";
//                            console.log(regionId_hots);
                        }else{
                            successHandler(regionId + "-" + 0);
                        }
                    }else{
                        successHandler(regionId + "-" + 0);
                    }
//                    console.log(data[0].employees[0].firstName);//bill
//                    console.log(12);

                }
            });
        }
        function successHandler(str){
            var tmp = $("#regionId_hots").val();
            tmp += str+",";
            $("#regionId_hots").val(tmp);
        }

    </script>
</head>

<body>
<div style="text-align:center" id="firstDiv">
    <input type="hidden" id="effect_date">
    <div style="width: 80%;margin:auto">
        <div id="tb" style="padding:3px">
            <span>CheckIn:</span>
            <input id="Departing">
            <span style="margin-left: 10px">CheckOut:</span>
            <input id="Returning">
            <a href="#" class="easyui-linkbutton" plain="true" iconCls="icon-search" onclick="doSearch()">Search</a>
        </div>
        <table id="tt" class="easyui-datagrid" toolbar="#tb" title="Hot Of Region"></table>
        <img src="/images/capture.png" style="width:1482px">
    </div>
</div>
<div style="display: none">
    <form action="showResult.jsp" name="formTomap2" id="formTomap2" method="post">
        <input type="hidden" id="regionId_hots" name="regionId_hots">
        <input type="submit" value="Enter" name="submit" id="sub">
    </form>
</div>
</body>
</html>
