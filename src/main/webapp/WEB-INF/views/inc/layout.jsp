<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles"  uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<title><tiles:getAsString name="title" /></title>
		<link href="/web/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
		<link href="/web/css/layout.css" type="text/css" rel="stylesheet"/>
		<link href="/web/css/<tiles:getAsString name="css"/>" type="text/css" rel="stylesheet"/>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	</head>
	<body>
	    <!--  header  -->
	    <tiles:insertAttribute name="header" />
		<div id="main">
			<!-- content -->
			<tiles:insertAttribute name="content" />
		</div>
		<!-- footer    -->
		<tiles:insertAttribute name="footer" />
	</body>
</html>
