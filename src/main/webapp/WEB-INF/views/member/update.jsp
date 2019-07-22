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
    <form class="form1" action="updateProfile.do" method="post">
    <div class="form-group row">
      <label for="staticID" class="col-sm-3 col-form-label">ID</label>
      <div class="col-sm-8">
        <input type="text" readonly="" class="form-control-plaintext" name="id" id="staticEmail" value="${vo.id }">
      </div>
    </div>
      
    <div class="form-group">
      <label for="exampleInputName">이름</label>
      <input type="text" class="form-control" id="exampleInputName" name="name" value="${vo.name }">
    </div>
    
    <div class="form-group row">
      <label for="staticID" class="col-sm-3 col-form-label">생년월일</label>
      <div class="col-sm-8">
        <input type="text" readonly="" class="form-control-plaintext" name="birthday" id="staticBirth" value="${vo.birthday }">
      </div>
    </div>
 
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호</label>
      <input type="password" class="form-control" id="exampleInputPassword1" name="pswd" placeholder="Password">
    </div>

    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호 확인</label>
      <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
    </div>
  
	<div class="form-group">
      <label for="exampleInputEmail1">Email address</label>
      <input type="email" class="form-control" id="exampleInputEmail1" name="email" aria-describedby="emailHelp" value="${vo.email }">
      <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>

    <div id="btnbox">
    <button type="button" class="btn btn-primary" id="update_btn">수정</button>
    <button type="button" class="btn btn-primary" id="cancel_btn">취소</button>
  	</div>
  	</form>
	</div>
</div>


<script>
$("#cancel_btn").on("click",function(){
	location.href="<%= request.getContextPath()%>/members/mypage.do"
})
$("#update_btn").on("click",function(){
	$('.form1').submit();
})



</script>




</body>
</html>