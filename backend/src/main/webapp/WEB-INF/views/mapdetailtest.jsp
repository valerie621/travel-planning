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

    var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    google.maps.event.addDomListener(window, 'load', initialize);
    var marks;
    var flag;


    function initialize() {

        flag = true;


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

        var labelIndex = 0;

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

        marks = [];

        for (i = 0; i < locations.length; i++) {
            marker = new google.maps.Marker({
                position: new google.maps.LatLng(locations[i][1], locations[i][2]),
                label: labels[labelIndex++ % labels.length],
                draggable: true,
                animation: google.maps.Animation.DROP,
                map: map
            });
            marks.push(marker);
            marker.addListener('click', toggleBounce);

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
        flag = true;
        var data = JSON.parse('${locationInfo}');
        var first = data[count];

        var locations = [];
        var labelIndex = 0;

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

        marks = [];

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
                draggable: true,
                animation: google.maps.Animation.DROP,
                label: labels[labelIndex++ % labels.length],
                map: map
            });
            marks.push(marker);
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

    function toggleBounce(count, point) {
        if (!flag) {
            newLocation(count)
        }
        var marker = marks[point];
            marker.setAnimation(google.maps.Animation.BOUNCE);
        setTimeout(function() {
            marker.setAnimation(null)
        }, 5000);
    }

    function travelDetail(count, start, end) {
        flag = false;
        var data = JSON.parse('${locationInfo}');
        var first = data[count];

        var map = new google.maps.Map(document.getElementById('map-canvas'), {
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        var locations = [];

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
                label: labels[start++ % labels.length],
                map: map
            });
            if (i < locations.length - 1) {
                var startPoint = new google.maps.LatLng(locations[i][1], locations[i][2]);
                var endPoint = new google.maps.LatLng(locations[i + 1][1], locations[i + 1][2]);
                requestDirections(startPoint, endPoint);
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
    <form class="row">
        <div class="col-xs-4"><!--map-canvas will be postioned here--></div>
        <div class="col-xs-8" id="right">

            <div class="col-lg-12">
                <form action="/mapdetail" method="get">
                <div class="input-group">
                    <input type="text" class="form-control" style="width: 50%" placeholder="${destination}" name="destination" id="destination" required>
                    <input type="text" class="form-control" style="width: 50%" placeholder="${day}" name="day" id="day">
                    <span class="input-group-btn">
                        <button class="btn btn-primary" type="submit">Go!</button>
                     </span>
                </div><!-- /input-group -->
                </form>
            </div><!-- /.col-lg-6 -->

            <h2>Travel Plan Detail</h2>

            <!-- item list -->
            <c:forEach items="${path}" var="pathDetail" varStatus="loop">
            <div class="panel panel-default">
                <div class="panel-heading"><a href="#" onclick="newLocation(${loop.index + 1})">Day <c:out value="${loop.index + 1}" /></a></div>
            </div>


            <p>Here is the Details of One Day Travel Plan</p>
                <div class="timeline">
                <c:forEach items="${pathDetail}" var="onePath" varStatus="innerloop">
                    <c:if test="${innerloop.index == 0}" >
                        <div class="timeline-item">
                            <div class="timeline-point timeline-point-default">
                                <i class="fa fa-circle"></i>
                            </div>
                            <div class="timeline-event timeline-event-default">
                                <div class="timeline-heading">
                                    <a href="#" onclick="toggleBounce(${loop.index + 1}, ${onePath.start})"><h4><c:out value="${onePath.initial}" /></h4></a>
                                </div>
                                <div class="timeline-body">
                                    <p><c:out value="${onePath.startPointDescription}"/></p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <span class="timeline-label">
                        <span class="label label-primary"><a href="#" onclick="travelDetail(${loop.index + 1}, ${onePath.start}, ${onePath.end})">TimeCost: <c:out value="${onePath.timeCost}" /></a></span>
                    </span>
                    <div class="timeline-item">
                        <div class="timeline-point timeline-point-default">
                            <i class="fa fa-circle"></i>
                        </div>
                        <div class="timeline-event timeline-event-default">
                            <div class="timeline-heading">
                                <a href="#" onclick="toggleBounce(${loop.index + 1}, ${onePath.end})"><h4><c:out value="${onePath.initial}" /></h4></a>
                            </div>
                            <div class="timeline-body">
                                <p><c:out value="${onePath.endPointDescription}"/></p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            <hr>
                </div>
               </c:forEach>
            <!-- /item list -->
            </div>
        </form>
        </div>
<!-- end template -->
</body>
</html>


