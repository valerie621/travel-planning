<%@ page import="java.util.concurrent.PriorityBlockingQueue" %><%--
  Created by IntelliJ IDEA.
  User: hanchen
  Date: 2016/10/27
  Time: AM8:49
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Detail Map Information.">
    <meta name="author" content="">
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>Map Detail</title>
    <link href="${contextPath}/resources/css/map_detail_test.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAMjtjAnJSZsDgN1N7NvX7Y2ofexcLTSSc&v=3.exp&sensor=false"></script>
<script>
    google.maps.event.addDomListener(window, 'load', initialize);


    function initialize() {


        var data = JSON.parse('${locationInfo}');
        var first = data["1"];

        var locations = [];

        var map = new google.maps.Map(document.getElementById('map-canvas'), {
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });


        for (var location in first) {
            var array = [];
            var temp = first[location];
            array.push(temp.name);
            array.push(temp.longitude);
            array.push(temp.latitude);
            array.push(temp.zoom);
            locations.push(array);
        }


        console.log(locations);

        var bounds = new google.maps.LatLngBounds();

        var marker, i;
        var infowindow = new google.maps.InfoWindow();

        function renderDirections(result) {
            var directionsRenderer = new google.maps.DirectionsRenderer({
                suppressMarkers: true,
                suppressInfoWindows: false,
            });
            directionsRenderer.setMap(map);
            directionsRenderer.setDirections(result);
        }

        var directionsService = new google.maps.DirectionsService;
        function requestDirections(start, end) {
            directionsService.route({
                origin: start,
                destination: end,
                travelMode: google.maps.DirectionsTravelMode.DRIVING
            }, function(result) {
                renderDirections(result);
            });
        }

        for (i = 0; i < locations.length; i++) {
            marker = new google.maps.Marker({
                position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                map: map
            });
            if (i < locations.length - 1) {
                var start = new google.maps.LatLng(locations[i][1], locations[i][2]);
                var end = new google.maps.LatLng(locations[i + 1][1], locations[i + 1][2]);
                requestDirections(start, end);
             }

            bounds.extend(marker.position);

            google.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                    infowindow.setContent(locations[i][0]);
                    infowindow.open(map, marker);
                }
            })(marker, i));
        }

        map.fitBounds(bounds);

        var listener = google.maps.event.addListener(map, "idle", function () {
            map.setZoom(10);
            google.maps.event.removeListener(listener);
        });

    }

    function newLocation(count)
    {
        var data = JSON.parse('${locationInfo}');
        var first = data[count];

        var locations = [];

        var map = new google.maps.Map(document.getElementById('map-canvas'), {
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });


        for (var location in first) {
            var array = [];
            var temp = first[location];
            array.push(temp.name);
            array.push(temp.longitude);
            array.push(temp.latitude);
            array.push(temp.zoom);
            locations.push(array);
        }

        var bounds = new google.maps.LatLngBounds();

        var marker, i;
        var infowindow = new google.maps.InfoWindow();

        function renderDirections(result) {
            var directionsRenderer = new google.maps.DirectionsRenderer({
                suppressMarkers: true,
                suppressInfoWindows: false,
            });
            directionsRenderer.setMap(map);
            directionsRenderer.setDirections(result);
        }

        var directionsService = new google.maps.DirectionsService;
        function requestDirections(start, end) {
            directionsService.route({
                origin: start,
                destination: end,
                travelMode: google.maps.DirectionsTravelMode.DRIVING
            }, function(result) {
                renderDirections(result);
            });
        }

        for (i = 0; i < locations.length; i++) {
            marker = new google.maps.Marker({
                position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                map: map
            });
            if (i < locations.length - 1) {
                var start = new google.maps.LatLng(locations[i][1], locations[i][2]);
                var end = new google.maps.LatLng(locations[i + 1][1], locations[i + 1][2]);
                requestDirections(start, end);
            }

            bounds.extend(marker.position);

            google.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                    infowindow.setContent(locations[i][0]);
                    infowindow.open(map, marker);
                }
            })(marker, i));
        }

        map.fitBounds(bounds);

        var listener = google.maps.event.addListener(map, "idle", function () {
            map.setZoom(10);
            google.maps.event.removeListener(listener);
        });

    }

    function travelDetail(count, start, end) {
        var data = JSON.parse('${locationInfo}');
        var first = data[count];

        var locations = [];

        var map = new google.maps.Map(document.getElementById('map-canvas'), {
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });
            array = [];
            temp = first[start];
            array.push(temp.name);
            array.push(temp.longitude);
            array.push(temp.latitude);
            array.push(temp.zoom);
            locations.push(array);
            temp = first[end];
            array = [];
            array.push(temp.name);
            array.push(temp.longitude);
            array.push(temp.latitude);
            array.push(temp.zoom);
            locations.push(array);

        var bounds = new google.maps.LatLngBounds();

        var marker, i;
        var infowindow = new google.maps.InfoWindow();

        function renderDirections(result) {
            var directionsRenderer = new google.maps.DirectionsRenderer({
                suppressMarkers: true,
                suppressInfoWindows: false,
            });
            directionsRenderer.setMap(map);
            directionsRenderer.setDirections(result);
        }

        var directionsService = new google.maps.DirectionsService;
        function requestDirections(start, end) {
            directionsService.route({
                origin: start,
                destination: end,
                travelMode: google.maps.DirectionsTravelMode.DRIVING
            }, function(result) {
                renderDirections(result);
            });
        }

        for (i = 0; i < locations.length; i++) {
            marker = new google.maps.Marker({
                position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                map: map
            });
            if (i < locations.length - 1) {
                var start = new google.maps.LatLng(locations[i][1], locations[i][2]);
                var end = new google.maps.LatLng(locations[i + 1][1], locations[i + 1][2]);
                requestDirections(start, end);
            }

            bounds.extend(marker.position);

            google.maps.event.addListener(marker, 'click', (function(marker, i) {
                return function() {
                    infowindow.setContent(locations[i][0]);
                    infowindow.open(map, marker);
                }
            })(marker, i));
        }

        map.fitBounds(bounds);

        var listener = google.maps.event.addListener(map, "idle", function () {
            map.setZoom(10);
            google.maps.event.removeListener(listener);
        });

    }

</script>
</head>
<body>
<!-- begin template -->
<!--nav bar-->
<div class="navbar navbar-inverse navbar-fixed-top opaque-navbar">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navMain">
                <span class="glyphicon glyphicon-chevron-right" style="color:white;border:none;"></span>

            </button>
            <a class="navbar-brand" href="/home" style="font-family: Papyrus, fantasy;">Trip4U</a>
        </div>
        <c:if test="${pageContext.request.userPrincipal.name != null}">
            <div class="collapse navbar-collapse" id="navMain">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="/profile"><span class="glyphicon glyphicon-user">${pageContext.request.userPrincipal.name}</span></a></li>
                    <li><a href="/logout"><span class="glyphicon glyphicon-log-in">Logout</span></a></li>
                </ul>
            </div>
        </c:if>
        <c:if test="${pageContext.request.userPrincipal.name == null}">
        <div class="collapse navbar-collapse" id="navMain">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/login"><span class="glyphicon glyphicon-log-in">Login</span></a></li>
                <li><a href="/registration"><span class="glyphicon glyphicon-user">SignUp</span></a></li>
            </ul>
        </div>
        </c:if>
    </div>
</div>
<div id="map-canvas"></div>
<div class="container-fluid" id="main">
    <div class="row">
        <div class="col-xs-4"><!--map-canvas will be postioned here--></div>
        <div class="col-xs-8" id="right">

            <h2>Travel Plan Detail</h2>

            <!-- item list -->
            <c:forEach items="${path}" var="pathDetail" varStatus="loop">
            <div class="panel panel-default">
                <div class="panel-heading"><a href="#" onclick="newLocation(${loop.index + 1})">Day <c:out value="${loop.index + 1}" /></a></div>
            </div>


            <p>Here is the Details of One Day Travel Plan</p>
                <c:forEach items="${pathDetail}" var="onePath">
                 <div>
                    <div><a href="#" onclick="travelDetail(${loop.index + 1}, ${onePath.start}, ${onePath.end})">Path: <c:out value="${onePath.name}" /></a></div>
                 </div>
                </c:forEach>
            <hr>
               </c:forEach>
            <!-- /item list -->
            </div>

        </div>

    </div>
<!-- end template -->
</body>
</html>


