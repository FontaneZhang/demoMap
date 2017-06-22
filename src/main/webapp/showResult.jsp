<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Region Hotspot</title>
    <style>
        /* Always set the map height explicitly to define the size of the div
         * element that contains the map. */
        #map {
            height: 100%;
        }
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
        function doSearch(){
            window.location.href="/showResult.jsp"
        }
    </script>
</head>

<body>
<div style="text-align:center">
    <%
        String textContent = request.getParameter("regionId_hots");
    %>

    <input type="hidden" id="regionIdhots" value="<%=textContent%>">
    <div id="map"></div>

</div>


<script>

    // This example creates a simple polygon representing the Bermuda Triangle.
    function gradientColor(startColor,endColor,step){
        startRGB = colorRgb(startColor);
        startR = startRGB[0];
        startG = startRGB[1];
        startB = startRGB[2];

        endRGB = colorRgb(endColor);
        endR = endRGB[0];
        endG = endRGB[1];
        endB = endRGB[2];

        sR = (endR-startR)/step;
        sG = (endG-startG)/step;
        sB = (endB-startB)/step;

        var colorArr = [];
        for(var i=0;i<step;i++){
            var hex = colorHex('rgb('+parseInt((sR*i+startR))+','+parseInt((sG*i+startG))+','+parseInt((sB*i+startB))+')');
            colorArr.push(hex);
        }
        return colorArr;
    }

    function colorRgb(sColor){
        var reg = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/;
        var sColor = sColor.toLowerCase();
        if(sColor && reg.test(sColor)){
            if(sColor.length === 4){
                var sColorNew = "#";
                for(var i=1; i<4; i+=1){
                    sColorNew += sColor.slice(i,i+1).concat(sColor.slice(i,i+1));
                }
                sColor = sColorNew;
            }
            var sColorChange = [];
            for(var i=1; i<7; i+=2){
                sColorChange.push(parseInt("0x"+sColor.slice(i,i+2)));
            }
            return sColorChange;
        }else{
            return sColor;
        }
    };

    function colorHex(rgb){
        var _this = rgb;
        var reg = /^#([0-9a-fA-f]{3}|[0-9a-fA-f]{6})$/;
        if(/^(rgb|RGB)/.test(_this)){
            var aColor = _this.replace(/(?:(|)|rgb|RGB)*/g,"").split(",");
            var strHex = "#";
            for(var i=0; i<aColor.length; i++){
                var hex = Number(aColor[i]).toString(16);
                hex = hex<10 ? 0+''+hex :hex;
                if(hex === "0"){
                    hex += hex;
                }
                strHex += hex;
            }
            if(strHex.length !== 7){
                strHex = _this;
            }
            return strHex;
        }else if(reg.test(_this)){
            var aNum = _this.replace(/#/,"").split("");
            if(aNum.length === 6){
                return _this;
            }else if(aNum.length === 3){
                var numHex = "#";
                for(var i=0; i<aNum.length; i+=1){
                    numHex += (aNum[i]+aNum[i]);
                }
                return numHex;
            }
        }else{
            return _this;
        }
    }

    function initMap() {

        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 10,
            center: {lat: 39.937909, lng: 116.356719},
            mapTypeId: 'terrain'
        });

        var regionId_hots = $("#regionIdhots").val();
        regionId_hots = regionId_hots.substring(0,regionId_hots.length-1);
        var array_rh = regionId_hots.split(",");
        var regionMap = {};
        for(var i=0;i<array_rh.length;i++){
            var arrtmp = array_rh[i].split("-");
            regionMap[arrtmp[0]]=arrtmp[1];
        }

        // Define the LatLng coordinates for the polygon's path.
        var region1 = {regionId:6160338,zb:[
            {lat: 39.99839968, lng: 116.40102137},
            {lat: 39.99789697, lng: 116.38002526},
            {lat: 40.0014708, lng: 116.38031516},
            {lat: 40.00138591, lng: 116.37591679},
            {lat: 40.00997256, lng: 116.37496332}
        ]};
        var region2 = {regionId:6160339,zb:[
            {lat: 39.99474224, lng: 116.40077764},
            {lat: 39.99536428, lng: 116.41716476},
            {lat: 39.98874992, lng: 116.41340704},
            {lat: 39.98839676, lng: 116.40101298}
        ]};
        var region3 = {regionId:6160345,zb:[
            {lat: 39.941253, lng: 116.456368},
            {lat: 39.933641, lng: 116.456422},
            {lat: 39.933633, lng: 116.45487},
            {lat: 39.941188, lng: 116.454737}
        ]};
        var region4 = {regionId:6160393,zb:[
            {lat: 39.973568, lng: 116.179419},
            {lat: 39.973766, lng: 116.182767},
            {lat: 39.971727, lng: 116.180964},
            {lat: 39.969227, lng: 116.182166},
            {lat: 39.969556, lng: 116.189633},
            {lat: 39.962254, lng: 116.195727},
            {lat: 39.957649, lng: 116.193753},
            {lat: 39.957386, lng: 116.186801},
            {lat: 39.949622, lng: 116.185428},
            {lat: 39.955017, lng: 116.17633},
            {lat: 39.958504, lng: 116.174184},
            {lat: 39.96107, lng: 116.175815},
            {lat: 39.966267, lng: 116.171437}
        ]};
        var region5 = {regionId:6160395,zb:[
            {lat: 39.947622, lng: 116.375277},
            {lat: 39.939758, lng: 116.389694},
            {lat: 39.932115, lng: 116.390066},
            {lat: 39.932264, lng: 116.383428},
            {lat: 39.936939, lng: 116.383581},
            {lat: 39.942269, lng: 116.366335},
            {lat: 39.947231, lng: 116.365728}
        ]};
        var region6 = {regionId:6051831,zb:[
            {lat: 39.949874, lng: 116.440289},
            {lat: 39.950042, lng: 116.430879},
            {lat: 40.012901, lng: 116.508051},
            {lat: 40.0, lng: 116.533},
            {lat: 39.907873, lng: 116.532694},
            {lat: 39.901283, lng: 116.435916},
            {lat: 39.928588, lng: 116.435904},
            {lat: 39.928164, lng: 116.443121}
        ]};
        var region7 = {regionId:6048791,zb:[
            {lat: 40.122716, lng: 116.574672},
            {lat: 40.136628, lng: 116.616901},
            {lat: 40.132429, lng: 116.621021},
            {lat: 40.036552, lng: 116.65913},
            {lat: 40.025511, lng: 116.624111},
            {lat: 40.025248, lng: 116.597675},
            {lat: 40.032609, lng: 116.569523},
            {lat: 40.039181, lng: 116.565059},
            {lat: 40.046015, lng: 116.54858},
            {lat: 40.05968, lng: 116.543773},
            {lat: 40.070715, lng: 116.530727},
            {lat: 40.106174, lng: 116.526264},
            {lat: 40.123241, lng: 116.550297}
        ]};
        var region8 = {regionId:6048792,zb:[
            {lat: 39.973616, lng: 116.406443},
            {lat: 39.973342, lng: 116.412225},
            {lat: 39.963402, lng: 116.412226},
            {lat: 39.963152, lng: 116.431334},
            {lat: 39.949978, lng: 116.430444},
            {lat: 39.949843, lng: 116.440256},
            {lat: 39.928221, lng: 116.443058},
            {lat: 39.928627, lng: 116.435864},
            {lat: 39.894146, lng: 116.435771},
            {lat: 39.893908, lng: 116.393085},
            {lat: 39.963685, lng: 116.3911},
            {lat: 39.963481, lng: 116.4062}
        ]};
        var region9 = {regionId:6048793,zb:[
            {lat: 39.90153169, lng: 116.41213228},
            {lat: 39.90130767, lng: 116.41964393},
            {lat: 39.90062274, lng: 116.42758473},
            {lat: 39.89351504, lng: 116.42740042},
            {lat: 39.89291478, lng: 116.41188246}
        ]};


        var regionlist = [];
        regionlist.push(region1);
        regionlist.push(region2);
        regionlist.push(region3);
        regionlist.push(region4);
        regionlist.push(region5);
        regionlist.push(region6);
        regionlist.push(region7);
        regionlist.push(region8);
        regionlist.push(region9);


        // var regionMap = new Object();
        // regionMap[6160338] = 0;
        // regionMap[6160339] = 1;
        // regionMap[6160345] = 2;
        // regionMap[6160393] = 3;
        // regionMap[6160395] = 4;
        // regionMap[6051831] = 5;
        // regionMap[6048791] = 6;
        // regionMap[6048792] = 7;
        // regionMap[6048793] = 8;
        // regionMap[6048795] = 9;
        // regionMap[6048796] = 10;
        // regionMap[6048797] = 11;
        // regionMap[6048798] = 12;
        // regionMap[6048802] = 13;
        // regionMap[6233607] = 14;
        // regionMap[6233654] = 15;
        // regionMap[6233986] = 16;
        // regionMap[6189429] = 17;
        // regionMap[6242359] = 18;
        // regionMap[6181880] = 19;
        // regionMap[6269359] = 20;
        // regionMap[6160146] = 21;
        // regionMap[6160194] = 22;
        // regionMap[6160223] = 23;
        // regionMap[6140252] = 24;
        // regionMap[6140253] = 25;
        // regionMap[6140255] = 26;
        // regionMap[6130853] = 27;
        // regionMap[6342008] = 28;
        // regionMap[6140255] = 29;
        // regionMap[6199891] = 30;
        // regionMap[6199894] = 31;
        // regionMap[178553] = 32;
        // regionMap[178555] = 33;
        // regionMap[178559] = 34;
        // regionMap[178564] = 35;
        // regionMap[178565] = 36;
        // regionMap[178573] = 37;
        // regionMap[178574] = 38;
        // regionMap[178576] = 39;
        // regionMap[178578] = 40;
        // regionMap[178581] = 41;
        // regionMap[178584] = 42;
        // regionMap[6050437] = 43;
        // regionMap[597] = 44;
        // regionMap[6188374] = 45;
        // regionMap[6188375] = 46;
        // regionMap[6188376] = 47;
        // regionMap[6188377] = 48;
        // regionMap[6188378] = 49;
        // regionMap[6188380] = 50;
        // regionMap[6188381] = 51;
        // regionMap[6188383] = 52;
        // regionMap[6188384] = 53;
        // regionMap[6188385] = 54;
        // regionMap[6188387] = 55;
        // regionMap[6160331] = 56;
        // regionMap[6048794] = 57;
        // regionMap[6234100] = 58;
        // regionMap[6233761] = 59;
        // regionMap[6181914] = 60;
        // regionMap[6269457] = 61;
        // regionMap[6269412] = 62;
        // regionMap[6269422] = 63;
        // regionMap[178557] = 64;
        // regionMap[178563] = 65;
        // regionMap[178580] = 66;
        // regionMap[6188379] = 67;
        // regionMap[6188382] = 68;

        var fillColorArray = gradientColor('#FFFFFF', '#000000', 10);//regionlist.length
        var currentOpacityValue = 0;
        var stepOpacity = 1.0 / regionlist.length;

        // Construct the polygon.
        for (var index in regionlist) {
            var regionId = regionlist[index].regionId;
            var hots = regionMap[regionId]==undefined?0:regionMap[regionId];
            hots = Math.round(hots * 10) / 10;
//            console.log("map2:regionId-hots="+regionId+"-"+hots);//hots可能为undefined
            currentOpacityValue += stepOpacity;
            var beijingRegion = new google.maps.Polygon({
                paths: regionlist[index].zb,
                strokeColor: '#FF0000', //线条颜色
                strokeOpacity: 0.8, //透明度80%
                strokeWeight: 2,    //宽度 2像素
                fillColor: fillColorArray[hots*10],   //填充色//index
                fillOpacity: currentOpacityValue    //填充色透明度
            });
            beijingRegion.setMap(map);
        }

        var hiltonLatLng = {lat: 39.958889, lng: 116.469078};
        var yitelLatLng = {lat: 40.050855, lng: 116.302349};
        var shangrilaLatLng = {lat: 39.950226, lng: 116.314172};

        var marker1 = new google.maps.Marker({
            position: hiltonLatLng,
            map: map
        });
        var marker2 = new google.maps.Marker({
            position: yitelLatLng,
            map: map
        });
        var marker3 = new google.maps.Marker({
            position: shangrilaLatLng,
            map: map
        });

        var infowindow1 = new google.maps.InfoWindow({
            content: "Hotel: Hilton Beijing<br>Pirce: 233USD<br>Checkin: 2017-06-20<br>Checkout: 2017-06-21<br>Occupancy rate:0.736"
        });
        var infowindow2 = new google.maps.InfoWindow({
            content: "Hotel: Yitel Ruanjian Yuan<br>Pirce: 83USD<br>Checkin: 2017-06-20<br>Checkout: 2017-06-21<br>Occupancy rate:0.423"
        });
        var infowindow3 = new google.maps.InfoWindow({
            content: "Hotel: Shangrila Zizhu Yuan<br>Pirce: 111USD<br>Checkin: 2017-06-20<br>Checkout: 2017-06-21<br>Occupancy rate:0.352"
        });
        marker1.addListener("click", function(){
            infowindow1.open(map,marker1);
        });
        marker2.addListener("click", function(){
            infowindow2.open(map,marker2);
        });
        marker3.addListener("click", function(){
            infowindow3.open(map,marker3);
        });
    }


</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB1G7DaBfHMB9460oE4LgbQgRiDOMrOAOA&callback=initMap">
</script>
</body>
</html>
