<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
		<link href="/web/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<style>
#wrapper{
	margin: 0 auto;
    padding: 50px 0 50px;
    position: relative;
    width: 400px;
    border: solid 1px lightgray;
}

.title{
	text-align: center;
	margin-top: 50px;
	margin-bottom: 50px;
}
.mb-3{
	width:300px;
    margin: 0 auto;
}
.profile{
	width:85px;
	margin: 0 auto;
}
#updatebox{
	margin-top:75px;
	margin-left: 50px;
	width:100%;

}
.card-title{
	text-align: center;
}
#btnbox{
	width: 130px; 
	margin: 75px 0 0 75px;
}


</style>

<body>
<h3 class="title">프로필</h3>

<div id="wrapper">
	<div class="card mb-3">
		<div class="card-body">
			<h5 class="card-title">${vo.name }</h5>
		</div>
		<div class="profile">
			<img alt="프로필 사진" class="img-circle"
				src="//d2yoing0loi5gh.cloudfront.net/assets/default/user_profile_image-414acc60b27f0a258bec14c82b70dc361fc6768da9289f924f887bec1fc33849.png"
				width="80">
		</div>
		<div class="card-body">
			<a href="#" class="card-link">Card link</a>
		</div>
	</div>
	
<div id="updatebox">
	<form>
    <div class="form-group row">
      <label for="staticID" class="col-sm-3 col-form-label">ID</label>
      <div class="col-sm-8">
        <input type="text" readonly="" class="form-control-plaintext" id="staticEmail" value="${vo.id }">
      </div>
    </div>
    
    <div class="form-group row">
      <label for="staticID" class="col-sm-3 col-form-label">이름</label>
      <div class="col-sm-8">
        <input type="text" readonly="" class="form-control-plaintext" id="staticEmail" value="${vo.name }">
      </div>
    </div>
    
    <div class="form-group row">
      <label for="staticID" class="col-sm-3 col-form-label">생년월일</label>
      <div class="col-sm-8">
        <input type="text" readonly="" class="form-control-plaintext" id="staticBirth">
      </div>
    </div>
<!-- 
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호</label>
      <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
    </div>

    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호 확인</label>
      <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
    </div>
     -->
	
	<div class="form-group row">
      <label for="staticID" class="col-sm-3 col-form-label">Email</label>
      <div class="col-sm-8">
      <c:if test="${vo.email eq null }">
      <!-- <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email"> -->
	  	<input type="text" readonly="" class="form-control-plaintext" id="staticEmail" value="등록된 이메일 없음">
	  </c:if>        
	  <c:if test="${vo.email ne null }">
        <input type="text" readonly="" class="form-control-plaintext" id="staticEmail" value="${vo.email }">
	  </c:if>       
      </div>
    </div>

    <div id="btnbox">
    <button type="submit" class="btn btn-primary">수정</button>
    <button type="button" class="btn btn-primary">취소</button>
  	</div>
	</form>
	</div>
</div>

<script language="JavaScript">
	var birth= ${vo.birthday}+"";

	var yy = birth.substring(0,4) + "년 ";
	var mm = birth.substring(4,6)+"월 ";
	var dd = birth.substring(6,8)+"일 ";
	
	birth= yy+mm+dd;
	$("#staticBirth").val(birth);
	
</script>

</body>
</html>