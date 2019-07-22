<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/c/bootstrap.min.css"></script>
<style>
* {
	margin: 0;
	padding: 0;
}

.mainTop {
	width: 100%;
	height: 100px;
	background-color: white;
}

.mainContainer {
	height: 800px;
	width: 1200px;
	background-color: white;
	margin: 0 auto;
	border-radius: 20px;
}

.mainContent {
	float: right;
	width: 74%;
	height: 100%;
	display: inline-block;
	margin-right: 5px;
}

.mainAside {
	width: 25%;
	height: 100%;
	display: inline-block;
	border-right: solid 2px gray;
}

.mainBottom {
	width: 100%;
	height: 100px;
	background-color: #51abf9;
}

.myInfo {
	height: 63%;
	width: 100%;
	border-bottom: solid 2px gray;
}

.btn-wrapper {
	height: 36%;
	width: 100%;
	margin: 10px auto;
}

.btn-new {
	background-color: #51abf3;
	color: #fff !important;
	margin: 30px auto;
	-webkit-transition: all 0.1s ease-out;
	transition: all 0.1s ease-out;
	border-radius: 2px;
	border: 0;
	cursor: pointer;
	display: block;
	font-size: 16px;
	font-weight: 700;
	height: 48px;
	line-height: 46px;
	padding: 0;
	text-align: center;
	width: 80%;
}

.chatRoom {
	height: 170px;
	width: 285px;
	margin: 23px;
	background-color: lightgray;
	border-radius: 20px;
	display: inline-block;
}

.hc-search-input input[type="text"] {
	padding: 0 55px !important;
	height: 48px;
	width: 300px;
	border: none !important;
	border-radius: 4px;
	transition: all 0.3s ease;
	box-shadow: 0 1px 4px 0 rgba(52, 58, 64, 0.15), 0 0 1px 0
		rgba(52, 58, 64, 0.2);
}

.Dialog__size--s {
	margin: 100px auto 0 auto;
	height: 600px;
	width: 500px;
	background-color: white;
	border-radius: 20px;
}

.input_row {
	position: relative;
	height: 29px;
	margin: 0 10px 14px;
	padding: 10px 35px 10px 15px;
	border: solid 1px #dadada;
	background: #fff;
}

.int {
	font-size: 15px;
	line-height: 16px;
	position: relative;
	z-index: 9;
	width: 100%;
	height: 16px;
	padding: 7px 0 6px;
	color: #000;
	border: none;
	background: #fff;
	-webkit-appearance: none;
}

.app-close-button {
	margin: 15px;
	border: 0;
	background-color: lightgray;
	height: 30px;
	width: 30px;
}

.app-close-button:hover {
	box-shadow: 0px 1px 1px 0px gray;
}

.btn {
	background-color: #51abf3;
	color: #fff !important;
	margin: 20px auto;
	-webkit-transition: all 0.1s ease-out;
	transition: all 0.1s ease-out;
	border-radius: 10px;
	border: 0;
	cursor: pointer;
	display: block;
	font-size: 16px;
	font-weight: 700;
	height: 48px;
	line-height: 46px;
	padding: 0;
	text-align: center;
	width: 80px;
	display: inline-block;
	/*   float: right; */
}
</style>
<link href="bootstrap.min.css" type="text/css" rel="stylesheet">
</head>
<body>
	<div class="mainTop" style="align-items: center;">
		<div class="logo"
			style="width: 200px; height: 80px; background-color: black; display: inline-block; margin: 10px;"></div>
		<div class="btnwrapper"
			style="width: 400px; height: 100%; display: inline-block; float: right;">
			<button class="btn" type="button">
				<span>HOME</span>
			</button>
			<button class="btn" type="button">
				<span>로그인</span>
			</button>
			<button class="btn" type="button">
				<span>로그아웃</span>
			</button>
		</div>

	</div>
	<hr style="border: solid 2px lightgray;">
	<div class="main" style="background-color: #2b96ed;">
		<div class="mainContainer">

			<div class="mainAside">

				<div class="myInfo">
					<div class="myImg"
						style="margin: 20px auto; width: 250px; height: 250px; border-radius: 125px; background-color: lightgray;">
						<img src="#">
					</div>
					<div class="myIntroduce"
						style="margin: 10px; border-radius: 20px; height: 200px; background-color: lightgray;">

					</div>
				</div>
				<div class="btn-wrapper">
					<button class="btn-new" type="button">
						<span>마이 페이지</span>
					</button>
					<button class="btn-new" type="button">
						<span>내 채팅목록</span>
					</button>
					<button class="btn-new" type="button"
						onclick="$('.modal').css('display','block'); $('body').css('overflow','hidden'); ">
						<span>채팅방 만들기</span>
					</button>
				</div>
			</div>

			<div class="mainContent">
				<h2 style="margin: 20px 20px;">신규 채팅방</h2>
				<div class="roomList" style="margin: 0 auto; width: 670px;">
					<div class="chatRoom"></div>
					<div class="chatRoom"></div>
					<div class="chatRoom"></div>
					<div class="chatRoom"></div>
					<div class="chatRoom"></div>
					<div class="chatRoom"></div>

					<div class="paging"
						style="width: 250px; margin: 0 auto; height: 40px; background-color: lightgray;"></div>
				</div>
			</div>
		</div>
	</div>


	<!-- 채팅방 생성 모달창 -->
	<div class="modal" style="display: none;">
		<div class="ReactModal__Overlay ReactModal__Overlay--after-open"
			aria-modal="true"
			style="position: fixed; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: rgba(73, 80, 86, 0.95); z-index: 150;">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">채팅방 만들기</h5>
						<button class="close" aria-label="Close" type="button"
							data-dismiss="modal"
							onclick="$('.modal').css('display','none'); $('body').css('overflow','visible'); ">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form action="create" method="post">
							<fieldset>
								<div class="form-group">
									<label for="exampleInputPassword1">방 제목</label> <input
										class="form-control" id="exampleInputPassword1" type="text"
										placeholder="방 제목을 입력하세요." name="roomname">
								</div>
								<div class="form-group">
									<label for="exampleSelect1">방 최대인원</label> <select
										class="form-control" id="exampleSelect1" name="members">
										<c:forEach begin="1" end="20" varStatus="i">
											<option>${i.index }</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group">
									<label for="exampleSelect1">방 테마 선택</label> <select
										class="form-control" id="exampleSelect1" name="roomtheme">
										<option>게임</option>
										<option>여행</option>
										<option>운동</option>
										<option>음악</option>
										<option>영화</option>
										<option>기타</option>
									</select>
								</div>
								<div class="form-group">
									<label for="exampleTextarea">방 소개글</label>
									<textarea class="form-control" id="exampleTextarea" rows="3" name="roominfo"></textarea>
								</div>

								<button class="btn btn-primary" type="submit">Submit</button>
							</fieldset>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--  모달창 여기까지 ~~~~ -->


	<div class="mainBottom"></div>


</body>
</html>