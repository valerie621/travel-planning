<%--
  Created by IntelliJ IDEA.
  User: hanchen
  Date: 2016/11/2
  Time: PM1:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="Profile" content="Profile">
    <meta name="author" content="">
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>User Profile</title>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<body>
<div class="navbar navbar-inverse navbar-fixed-top opaque-navbar">
<div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navMain">
            <span class="glyphicon glyphicon-chevron-right" style="color:white;border:none;"></span>

        </button>
        <a class="navbar-brand" href="/home" style="font-family: Papyrus, fantasy;">Trip4U</a>
    </div>
    <div class="collapse navbar-collapse" id="navMain">
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/logout"><span class="glyphicon glyphicon-log-in">Logout</span></a></li>
        </ul>
    </div>
</div>
</div>
<br><br>
<div class="container-fluid well span6">
    <div class="row-fluid">
        <div class="span2" >
            <img src="${contextPath}/resources/static/img/unknown.png" class="img-circle">
        </div>

        <div class="span8">
            <h3>User Name: ${pageContext.request.userPrincipal.name}</h3>
            <h6>Email: ${pageContext.request.userPrincipal.name}@gmail.com</h6>
            <h6></h6>
        </div>

        <div class="span2">
            <div class="btn-group">
                <a class="btn dropdown-toggle btn-info" data-toggle="dropdown" href="#">
                    Action
                    <span class="icon-cog icon-white"></span><span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="/modify"><span class="icon-wrench"></span> Modify</a></li>
                    <li><a href="/delete"><span class="icon-trash"></span> Delete</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
