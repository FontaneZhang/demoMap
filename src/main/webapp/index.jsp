<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Circles</title>
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
</head>
<body>
<div id="map"></div>
<script>
    // This example creates circles on the map, representing populations in North
    // America.

    // First, create an object containing LatLng and population for each city.
    var citymap = {
        chicago: {
            center: {lat: 41.878, lng: -87.629},
            population: 2714856
        },
        newyork: {
            center: {lat: 40.714, lng: -74.005},
            population: 8405837
        },
        losangeles: {
            center: {lat: 34.052, lng: -118.243},
            population: 3857799
        },
        vancouver: {
            center: {lat: 49.25, lng: -123.1},
            population: 603502
        }
    };

    function initMap() {
        // Create the map.
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 4,
            center: {lat: 37.090, lng: -95.712},
            mapTypeId: 'terrain'
        });

        // Construct the circle for each value in citymap.
        // Note: We scale the area of the circle based on the population.
        var fillOpacityValue = 0.15;
        var offsetValue = 0.2;
        for (var city in citymap) {
            // Add the circle for this city to the map.
            fillOpacityValue += offsetValue;
            var cityCircle = new google.maps.Circle({
                strokeColor: '#000000',
                strokeOpacity: 0.8,
                strokeWeight: 2,
                fillColor: '#FF0000',
                fillOpacity: fillOpacityValue,
                map: map,
                center: citymap[city].center,
                radius: Math.sqrt(citymap[city].population) * 100
            });
        }
    }
</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB1G7DaBfHMB9460oE4LgbQgRiDOMrOAOA&callback=initMap">
</script>

<!--<script type="text/javascript">
 function gradientColor(startColor,endColor,step){
     startRGB = this.colorRgb(startColor);
     startR = startRGB[0];
     startG = startRGB[1];
     startB = startRGB[2];

     endRGB = this.colorRgb(endColor);
     endR = endRGB[0];
     endG = endRGB[1];
     endB = endRGB[2];

     sR = (endR-startR)/step;
     sG = (endG-startG)/step;
     sB = (endB-startB)/step;

     var colorArr = [];
     for(var i=0;i<step;i++){
         var hex = this.colorHex('rgb('+parseInt((sR*i+startR))+','+parseInt((sG*i+startG))+','+parseInt((sB*i+startB))+')');
         colorArr.push(hex);
     }
     return colorArr;
 }

 gradientColor.prototype.colorRgb = function(sColor){
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

 gradientColor.prototype.colorHex = function(rgb){
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

 var gradient = new gradientColor('#013548','#554851',10);
 console.log(gradient);
 alert(gradient);
</script>!-->
</body>
</html>
<%--<html>--%>
<%--<body>--%>
<%--<h2>Hello World!</h2>--%>
<%--</body>--%>
<%--</html>--%>
