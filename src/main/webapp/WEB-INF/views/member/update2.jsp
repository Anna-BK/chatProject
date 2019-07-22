<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

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
        
    <div class="form-group">
      <label for="exampleInputName">이름</label>
      <input type="text" class="form-control" id="exampleInputName" placeholder="${vo.name }">
    </div>
    
    <div class="form-group row">
      <label for="staticID" class="col-sm-3 col-form-label">생년월일</label>
      <div class="col-sm-8">
        <input type="text" readonly="" class="form-control-plaintext" id="staticBirth">
      </div>
    </div>
 
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호</label>
      <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
    </div>

    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호 확인</label>
      <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
    </div>
  
	<div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
      <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>

    <div id="btnbox">
    <button type="submit" class="btn btn-primary">수정</button>
    <button type="button" class="btn btn-primary" id="cancel_btn">취소</button>
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
<script>
$("#cancel_btn").on("click",function(){
	location.href="<%= request.getContextPath()%>/members/mypage.do"
})

</script>




</body>
</html>