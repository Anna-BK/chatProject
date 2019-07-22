<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>

	<div class="mainTop" style="align-items: center;">
		<nav class="navbar navbar-expand-lg navbar-dark bg-primary"> <a
			class="navbar-brand" href="#">tiqui-taca</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarColor01" aria-controls="navbarColor01"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarColor01">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="${ pageContext.request.contextPath }/c/main">Home
						<span class="sr-only">(current)</span>
				</a></li>			
			</ul>
			<ul class="navbar-nav" id="loginmenu">
				<s:authorize ifNotGranted="ROLE_USER">
					<li class="nav-item"><a class="nav-link" href="${ pageContext.request.contextPath }/members/login.do">Login</a></li>
				</s:authorize>
				<s:authorize ifAnyGranted="ROLE_USER">
					<s:authentication property="name" var="loginUser" />
					<li class="nav-item nav-link">${loginUser}님</li>
					<li class="nav-item"><a class="nav-link" href="${ pageContext.request.contextPath }/members/logout.do">Logout</a></li>
				</s:authorize>
			</ul>		
		</div>
		</nav>
	</div>