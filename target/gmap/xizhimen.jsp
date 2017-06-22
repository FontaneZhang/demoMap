<%--
  Created by IntelliJ IDEA.
  User: Pactera
  Date: 2017/6/19
  Time: 15:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Simple Polygon</title>
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

    // This example creates a simple polygon representing the Bermuda Triangle.

    function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 16,
            center: {lat: 39.937909, lng: 116.356719},
            mapTypeId: 'terrain'
        });

        // Define the LatLng coordinates for the polygon's path.
        var triangleCoords = [
            {lat: 39.950761, lng: 116.351532},
            {lat: 39.951618, lng: 116.355801},
            {lat: 39.949941, lng: 116.356949},
            {lat: 39.948362, lng: 116.356638},
            {lat: 39.944145, lng: 116.356986},
            {lat: 39.937909, lng: 116.356719},
            {lat: 39.937628, lng: 116.352462},
            {lat: 39.943208, lng: 116.35101},
            {lat: 39.943991, lng: 116.352},
            {lat: 39.947047, lng: 116.350908},
            {lat: 39.950761, lng: 116.351532}
        ];

        // Construct the polygon.
        var bermudaTriangle = new google.maps.Polygon({
            paths: triangleCoords,
            strokeColor: '#FF0000',
            strokeOpacity: 0.8,
            strokeWeight: 2,
            fillColor: '#FF0000',
            fillOpacity: 0.35
        });
        bermudaTriangle.setMap(map);
    }
</script>
<script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB1G7DaBfHMB9460oE4LgbQgRiDOMrOAOA&callback=initMap">
</script>
</body>
</html>
