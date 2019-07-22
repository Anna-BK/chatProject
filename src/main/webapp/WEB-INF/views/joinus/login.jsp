<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
<div class="member-panel">

<div class="panel-header">
logo

</div>

<c:if test="${param.login_error != null }">
<div style="color:red">아이디 또는 패스워드가 일치하지 않습니다.<br>
Message : <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message }"></c:out>
</div>
</c:if>
<!--  -->
<div class="panel-body">
<form action='<c:url value="/j_spring_security_check"/>' accept-charset="UTF-8" method="post"  class="fv-form fv-form-bootstrap">
<button type="submit" class="fv-hidden-submit" style="display: none; width: 0px; height: 0px;"></button>
<input name="utf8" type="hidden" value="✓">
<input type="hidden" name="authenticity_token" value="DaonfgagdC8F9cA6R4D4BH7qVwVR0smuvTZqa/GOi5wxzpQmDtIZ5S5XlqmDgIZGDt36OKeHNr/iic4buHCIKQ==">
<div class="form-wrapper">
<div class="content-wrapper">
<div class="form-group clearfix">
<div class="row">
<input autocomplete="" class="form-control" name="j_username"  title="이메일" type="text" placeholder="아이디" >
<small class="help-block" data-fv-validator="notEmpty" data-fv-for="user[email]" data-fv-result="NOT_VALIDATED" style="display: none;">꼭 필요해요.</small><small class="help-block" data-fv-validator="emailAddress" data-fv-for="user[email]" data-fv-result="NOT_VALIDATED" style="display: none;">이메일 주소가 맞나요?</small>

</div>
</div>
</div>
<div class="content-wrapper">
<div class="form-group">
<div class="row">
<input class="form-control" name="j_password"  title="비밀번호" type="password" placeholder="비밀번호" >
<small class="help-block"  style="display: none;">비밀번호를 입력해주세요.</small><small class="help-block" data-fv-validator="stringLength" data-fv-for="user[password]" data-fv-result="NOT_VALIDATED" style="display: none;">너무 짧은 비밀번호입니다.</small>
</div>
</div>
</div>

<div class="content-wrapper">
<div class="form-group">
<div class="row row-margin">
<div class="col-xs-6">
<div class="checkbox-custom checkbox-primary">
<input id="remember_me" name="_spring_security_remember_me" type="checkbox">
<label for="remember_me">로그인 상태 유지</label>
</div>
</div>
</div>
</div>
</div>

<div class="btn-wrap">
<button class="btn-new btn--type-primary btn--width-100" type="submit">
<span>로그인</span>
</button>
<div style="height: 20px;"></div>
<button id="joinbtn" class="btn-new btn--type-primary btn--width-100" type="button">
<span>회원가입</span>
</button>
</div>

</div>
</form>

</div>

</div>

<script>
	$("#joinbtn").on("click",function(){
		location.href="<%= request.getContextPath()%>/members/join.do";
	})
</script>

</body>
</html>