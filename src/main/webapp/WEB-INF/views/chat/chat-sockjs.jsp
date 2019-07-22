<%@ page contentType="text/html; charset=UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta  http-equiv="Content-Type" content="text/html" charset="utf-8">
<title>채팅</title>
<script type="text/javascript" src="/web/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="/web/js/sockjs-0.3.min.js"></script>
<link rel='stylesheet'
	href='/web/resources/fullcalendar-3.10.0/fullcalendar.css' />
<script src='/web/resources/fullcalendar-3.10.0/lib/jquery.min.js'></script>
<script src='/web/resources/fullcalendar-3.10.0/lib/moment.min.js'></script>
<script src='/web/resources/fullcalendar-3.10.0/fullcalendar.js'></script>


<script type="text/javascript">

function listCal(roomnumber) {

	$.ajax({
		type : 'post',
		url : '/web/ajax/listCal',
		dataType : 'json',
		data :{
			roomnumber : roomnumber
		},
		success : function (data) {
			console.log(data);
			console.log("성공");
			//if(result == 'SUCCESS'){ alert("등록 되었습니다");}
			var arr = [];
			var colors = ["blue","green","red","pink"];
			$(data).each(	function(index, e) { 

				
				var elm = { title : e.title, 
									start : e.startdate,
									end : e.enddate,
									 allDay: false,
								      color: colors[index%4],
								      myid : e.calno
								};
			arr.push(elm);
			
			var str ='<div class="card" style="display: none;" id="'+e.calno+'">'			
			+'<div class="card-body" style="  height: 200px;">'
             +' <h4 class="card-title">'+e.title+'</h4>'
              +'<h6 class="card-subtitle mb-2 text-muted">'+e.startdate+' '+e.starttime+' - '+e.enddate+' '+e.endtime+'</h6>'
              +'<p class="card-text">'+e.content+'</p>'
              +'<p class="card-text">'+e.loc+'</p>'
              +'<button onclick="location.href='+"'/web/ajax/delCal?calno="+e.calno+'&roomnumber=${param.roomnumber}'+"'"+'"'
            		  +'class="btn btn-primary" style="float: right;">삭제</button>'
              +'</div>'
              +'</div>';
              
              $('#cardList').prepend($(str));
							
		});

		
			var calendar = $('#calendar').fullCalendar({
				events: arr,
				editable : true,
				   dayClick: function (date, jsEvent, view) {
						alert(date.format('YYYY년 MM월 DD일'));
						var startdate =moment(new Date(date)).format('MM/DD/YYYY');// date.format('YYYY년 MM월 DD일');
						$('#startdate').val(startdate).html(startdate);
						$('#enddate').val(startdate).html(startdate);
						$('#calendar').fullCalendar('addEventSource',
							[
								{
									title:  '',
									start:  date.format('YYYY, MM, DD'),
									color : 'gray'
								}
							]
						);
					},
					
					  eventClick: function(event) {							    
						    alert(event.myid);
						    $('.card').css('display','none');
						   $('#'+event.myid).css('display','block');
						   
						  }
				});
			},
		error:function(){
			alert("에러~~~~~~~~~~");
		}
	});
};	




</script>
<script type="text/javascript">
var wsocket;

function connect() {

	wsocket = new SockJS("http://localhost/web/chat");
	wsocket.onopen = onOpen;
	wsocket.onmessage = onMessage;
}

function disconnect() {
	var nickname = $(".userid").val();
	wsocket.send("msg:${param.roomnumber}) >>" + nickname + "님이 퇴장했습니다.");
	wsocket.close();
}

function onOpen(evt) {
	var nickname = $(".userid").val();
	wsocket.send("msg:${param.roomnumber}) >>" + nickname + "님이 입장했습니다.");
}

function onMessage(evt) {
	var data = evt.data;
	if (data.substring(0, 4) == "msg:") {
		appendMessage(data.substring(11));
	}
	if (data.indexOf(">>") < 14) {
		var roomnumber = "${param.roomnumber}";
		$('.roommembers').empty();
		$
				.ajax({
					url : "/web/ajax/members",
					dataType : "json",
					type : "get",
					data : {
						roomnumber : roomnumber
					},
					cache : false,
					success : function(data) {
						$(data).each(
								function(index, e) {
									var user = e;
									var div1 = $("<div />").addClass("list-group-item d-flex justify-content-between align-items-center");
											div1.text(user);
											$('.roommembers').append(div1);
										})
					},
					error : function() {
						alert("에러~~~~")
					}
				});

	}
}

function send() {
	var nickname = $(".userid").val();
	var msg = $("#message").val();
	wsocket.send("msg:" + "${param.roomnumber}) " + nickname + " : " + msg);
	$("#message").val("");
}

function appendMessage(msg) {
	$("#chatMessageArea").append(msg + "<br>");
	var chatAreaHeight = $("#chatArea").height();
	var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
	$("#chatArea").scrollTop(maxScroll);
}

$(document).ready(function() {
	
	
	$('.callist').on("click", function(){
	
		$('.calendarmodal').css('display','block'); $('body').css('overflow','hidden');
		var roomnumber = '${param.roomnumber}';
		listCal(roomnumber);	
		
	})
	
	

connect();

$('#message')
		.keypress(
				function(event) {
					var keycode = (event.keyCode ? event.keyCode
							: event.which);
					if (keycode == '13') {
						send();
					}
					event.stopPropagation();
				});
$('#sendBtn').click(function() {
	send();
});
$('#exitBtn').click(function() {
	disconnect();
	location.href = "/web/c/main";
});

$('.exit-chatroom').click(
	function() {
		if (confirm("채팅방 나가기를 할 경우 대화내역이 모두 삭제 됩니다. 그래도 나가시겠습니까?")) {
			disconnect();
			location.href = "/web/c/main";
		}
	})


$('.votecomplete').on("click", function() {

	var votesub = $('.voteSub');
	var vote = new Array();
	var title = $('.voteTitle').val();
	var roomnumber = "${param.roomnumber}";
	vote[0] = roomnumber;
	vote[1] = title;
	var i = 2;
	var nickname = $(".userid").val();

	votesub.each(function() {
		vote[i++] = $(this).val();
	})

	$('.createVote').css("display", "none");
	$('.modal-body-footer').css("display", "none");
	$.ajaxSettings.traditional = true;
	$.ajax({
		url : "/web/ajax/createVote",
		dataType : "json",
		type : "get",
		data : {
			vote : vote
		},
		cache : false,
		success : function(data) {
			$('.voteComplete').empty();
			$('.voteComplete').css("display","block");
			var h3 = $("<h3 />");
			h3.text("투표 등록 완료");
			var button = $("<button class='btn btn-primary votelist' type='button' style='margin: 30px;' />");
			button.text("투표 목록 보기");
			
			$('.voteComplete').append(h3, button);
			
			wsocket.send("msg:" + "${param.roomnumber}) " + nickname + "님이 새 투표를 등록하였습니다. ["+title+"]");
		},
		error : function() {
			alert("에러~~~~")
		}
	})

})

$(document).on("click", '.votelist' ,function() {
	$('.votelistgroup').empty();
	$('.modal-body-footer').css("display", "block");
	$('.voteComplete').css("display","none");
	var roomnumber = "${param.roomnumber}";

	$.ajax({
				url : "/web/ajax/votelist",
				dataType : "json",
				type : "get",
				data : {
					roomnumber : roomnumber
				},
				cache : false,
				success : function(data) {
					$(data).each(
					function(index, e){
						
						var votetitle = e.voteTitle;
						var sub1 = e.sub1;
						var sub2 = e.sub2;
						var sub3 = e.sub3;
						var sub4 = e.sub4;
						var votenumber = e.votenumber;
						
						var li1 = $("<li class='list-group-item d-flex justify-content-between align-items-center vote2' />");
						var button = $("<button class='btn btn-primary vote2' type='button' onclick='$(this).parent().next().slideToggle(); $(\".vote2\").addClass(\"disabled\");'>투표 하기</button>")
						li1.text(votetitle);
						li1.append(button);
						
						var div = $("<div class='list-group-item justify-content-between align-items-center test' style='display: none;' />");
						var input = $("<input id='votesub' name='"+votenumber+"' type='radio'>");
						var br = $("<br>");
						
						div.append(input.clone().val(sub1), sub1, br.clone());
						div.append(input.clone().val(sub2), sub2, br.clone());
						div.append(input.clone().val(sub3), sub3, br.clone());
						div.append(input.clone().val(sub4), sub4, br.clone());
						
						var button2 = $("<button class='btn btn-primary votebtn' type='button' id='"+votenumber+"'>");
						button2.text("투표하기");

						div.append(button2);
						
						$('.votelistgroup').append(li1);
						$('.votelistgroup').append(div);
					})
				},
				error : function() {
					alert("에러~~~~")
				}
			});
		})
		
		
	$(document).on("click", ".votebtn" , function() {
		
		var val = $("#votesub:checked").val();
		var userid = $(".userid").val();
		var votenumber = $(this).attr("id");
		$('.modal-body-footer').css("display", "none");
		
		$.ajax({
			url : "/web/ajax/voteComplete",
			dataType : "json",
			type : "get",
			data : {
				val : val,
				userid : userid,
				votenumber : votenumber
			},
			cache : false,
			success : function(data) {
				$('.voteComplete').empty();
				$('.voteComplete').css("display","block");
				var h3 = $("<h3 />");
				h3.text("투표 완료");
				var button = $("<button class='btn btn-primary voteresult' type='button' style='margin: 30px;' id='"+votenumber+"' />");
				button.text("투표 결과 보기");
				
				$('.voteComplete').append(h3, button);
				
			},
			error : function() {
				alert("에러~~~~")
			}
		})
		
	})
	
	$(document).on("click", ".voteresult" , function() {
		
		var votenumber = $(this).attr("id");
		$('.modal-body-footer').css("display", "none");
		var votesub = $('input[name='+votenumber+']');
		var vote = new Array();
		var names = new Array();
		var i = 0;
		
		votesub.each(function() {
			vote[i++] = $(this).val();
		})
		
		
		$.ajaxSettings.traditional = true;
		$.ajax({
			url : "/web/ajax/voteResult",
			dataType : "json",
			type : "get",
			data : {
				votenumber : votenumber,
				vote : vote
			},
			cache : false,
			success : function(data) {
				$('.voteComplete').empty();
				$('.voteComplete').css("display","block");
				var h3 = $("<h3 />");
				h3.text("투표 결과");
				$('.voteComplete').append(h3);
				$(data).each(function(index, e) {
						var a = new Array();
						
						 a[0] = e.a;
						 a[1] = e.b;
						 a[2] = e.c;
						 a[3] = e.d;
						var tot = a[1]+a[2]+a[3]+a[0];
						
					for(var i = 0 ; i<4 ; i++){
						var div = $("<div />").clone();
						div.text(vote[i]+"<"+a[i]+"표>");
						var p = a[i]/tot*100;
						var div1 = $("<div class='progress'/>").clone();
						var div2 = $("<div class='progress-bar bg-success' role='progressbar' aria-valuenow='"+p+"' aria-valuemin='0' aria-valuemax='100' style='width: "+p+"%'/>").clone();
						
						div.append(div1);
						div1.append(div2);							
						$('.voteComplete').append(div);
					}
				})
				
				var button = $("<button class='btn btn-primary votelist' type='button' style='margin: 30px;' />");
				button.text("투표 목록 보기");
				
				$('.voteComplete').append(button);
				
			},
			error : function() {
				alert("에러~~~~")
			}
		})
		
	})
		
		

});
</script>
<script type="text/javascript">

/* Calendar 관련  */

$('#calendarComplete').on("click", function () {
	
	var roomnumber = '${param.roomnumber}';
	

	var params = $('#form1').serialize();
	console.log(params);
	
	var content = $('textarea[name="content"]').val();
	var title = $('textarea[name="title"]').val();
	var loc = $('textarea[name="loc"]').val();
	var sdate = $("select[name='sdate']").val();
	var shour = $("select[name='shour']").val();
	var sminute = $("select[name='sminute']").val();
	var edate = $("select[name='edate']").val();
	var ehour = $("select[name='ehour']").val();
	var eminute = $("select[name='eminute']").val();
	
	

	console.log(sdate+shour+sminute);
	
	alert(content);
	alert(title);
	alert(loc);
	alert(roomnumber);

	$.ajax({
		type : 'post',
		url : '/web/ajax/createCal',
		dataType : 'text',
		data : {
			content : content,
			title : title,
			loc : loc,
			startdate : sdate,
			starttime : shour+":"+sminute,
			enddate : edate,
			endtime : ehour+":"+eminute,
			roomnumber : roomnumber
		},
		success : function (data) {
			console.log(data);
			console.log("성공");
			if(result == 'SUCCESS'){ alert("등록 되었습니다");}
			appendMessage("일정이 등록되었습니다");
			
		},
		error:function(){
			alert("에러~~~~~~~~~~");
			
		}
	});
	
	



});






</script>
<style>
* {
	margin: 0;
	padding: 0;
}

.mainContainer {
	height: 900px;
	width: 1000px;
	background-color: white;
	margin: 10px auto;
	border-radius: 10px;
	border: solid 2px lightgray;
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

.roomInfo {
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

.btn-exit {
	background-color: #51abf3;
	color: #fff !important;
	margin: 10px;
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
	width: 20%;
	float: right;
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

#message {
	border: none !important;
	transition: all 0.3s ease;
	box-shadow: 0 1px 4px 0 rgba(52, 58, 64, 0.15), 0 0 1px 0
		rgba(52, 58, 64, 0.2);
	width: 80%;
	height: 100%;
	float: left;
	font-size: 20px;
	padding: 0 10px;
}

#sendBtn:hover {
	cursor: pointer;
	box-shadow: 0 1px 2px 0 #58aa93;
}
</style>
<style>
.fileDrop{
	width: 100%;
	height: 200px;
	border: 1px dotted blue;
}

small{
	margin-left: 3px;
	font-weight: bold;
	color: gray;
}
</style>


</head>
<body>
<s:authentication property="name" var="loginUser" />
	<input class="userid" type="hidden" value="${loginUser}">
	<div class="main" style="background-color: white">
		<div class="mainContainer">

			<div class="mainContent">
				<div class="chatTitle"
					style="border-bottom: solid 2px gray; height: 7%;">
					<h2 style="margin: 10px 20px; display: inline-block;"></h2>
					<button class="btn btn-primary btn-lg" id="exitBtn" type="button"
						style="float: right; margin: 8px;">HOME</button>
				</div>
				<div class="roomList"
					style="margin: 0 auto; width: 720px; height: 93%; background-color: skyblue;">
					<div class="chatArea"
						style="height: 92%; width: 100%; overflow: auto;">
						<div id="chatMessageArea"
							style="font-size: 18px; line-height: 1.5; width: 100%;"></div>
					</div>
					<div class="chatInsert"
						style="height: 7%; border-top: solid 2px #51abf3; position: relative;">
						<button type="button"
							style="width: 10%; height: 100%; float: left; background-color: #51abf3; border: 0;"
							onclick="$('.dropdown-menu').toggle();">
							<img class="DrawerButton__image" alt=""
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAAAXNSR0IArs4c6QAAApJJREFUaAXtVj9vGjEcPftADBESCwtDhjRKojJG2SqFD4DaCYYMkfgKfIHA12BPl9toP0BXhqwsTbmlZbmhoCtCQuEufr6zY66mQ5KeT4otGf+5n/F7z787P8exxSpgFbAKWAXesgJEQx5zomoeG5mK013Rij6fKmXgADhttVokDE/I0dFvHcHMknyGnhdEjvONVV4kCRUg6XQ6dDqdupPJ5Mp13eMoitTn+SDV7EIpjbfb7X2/378djUYggSpJiCUg4K7X6+u4oGWz2VwzsC6rUliaoucTQRAQxlQ+FMyK0irYJEbxDuA4CMv9qN1u347HX0m5XD5mJyUDzZJACkXfLy8/fGY4gFW8C09HAQIsc5xut0tnsxk/meVyKU7IGP5KpcJzvV6vR6zGnuftJQCQXHEQGQ6HBVE/0W4wGKAD8JwQBig6kLq5JNr87w5483AsAn0KQRc1jdS+Kc3+yn0BJAsO4/TL02HdgJyfn2RjxNr/3t7dNdKcH2AvQUK0fH8VHPq4C2gQ1Onh4R+yWCw4GXYDqnF8YV4/1WqVf/PxGVX8kLwHVBzcSvi+f8Y80H3R3AQwMadwygBrrQQnAivRaDQ+EkLeqcyK0AemWq32KYtl56bFTTefz8dM/R/ZQNNjYPL9X19SHOm74TjCC/H5ZrMZ93o9HNX71WpFHx4ujOX+k2A/nVKpEh8cBLASyH0JHjEqQN6HjYAfQjohIAxDNQZTuRX2Akuwig/a+xUCMAVsspbxMeaLEvtzwxAosP5xAjpld1bqAnKYS5TMYSO7xXMU2Jci6rzaf84er7EGaaRNpSw4jK0Xeg3JxX9YLySUMN1aL2TuBKwXsl7opdmnvcBe+qd2vVXAKmAVsApwBR4BFCTqVJ88d1YAAAAASUVORK5CYII=">
						</button>
						<div class="dropdown-menu"
							style="left: 0px; top: -240px; position: absolute; transform: translate3d(0px, 40px, 0px);"
							x-placement="bottom-start">
							<a class="dropdown-item" href="#">공지</a>
							<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#"
							onclick="$('.uploadmodal').css('display','block'); $('body').css('overflow','hidden');">파일</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item callist" href="#"
							onclick="" >일정</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item vote votelist" href="#"
								onclick="$('.votemodal').css('display','block'); $('body').css('overflow','hidden');">투표</a>
						</div>
						<input type="text" id="message">
						<button type="button"
							style="width: 10%; height: 100%; float: left; background-color: #51abf3; border: 0;"
							id="sendBtn">
							<span style="font-size: 18px; font-weight: 700; color: white;">전송</span>
						</button>
					</div>
				</div>
			</div>
			<div class="mainAside">
				<div class="roomInfo">
					<div class="roommembers"></div>
				</div>
				<div class="btn-wrapper">
					<button class="btn-new" id="btn_mypage" type="button">
						<span>마이 페이지</span>
					</button>
					<button class="btn-new exit-chatroom" type="button">
						<span>채팅방 나가기</span>
					</button>
				</div>
			</div>
		</div>
	</div>

<script>
$("#btn_mypage").on("click",function(){
	location.href="<%= request.getContextPath()%>/members/mypage.do";
});
</script>
<div class="modal uploadmodal">
		<div class="ReactModal__Overlay ReactModal__Overlay--after-open"
			aria-modal="true"
			style="position: fixed; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: rgba(73, 80, 86, 0.95); z-index: 150;">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">파일업로드</h5>
						<button class="close" aria-label="Close" type="button"
							data-dismiss="modal"
							onclick="$('.uploadmodal').css('display','none'); $('body').css('overflow','visible');  ">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>Modal body text goes here.</p>
						<div class="fileDrop"></div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" type="button" >파일 올리기</button>
					</div>
					<div class="uploadedList"></div>
					
				</div>
			</div>
		</div>
	</div>
<!-- 파일 업로드 -->	
	
<script>
$(".fileDrop").on("dragenter dragover", function (event) {
	event.preventDefault();
});
$('.fileDrop').on('drop', function (event) {
	event.preventDefault();
	
	var files = event.originalEvent.dataTransfer.files;
	
	var file = files[0];
	
	console.log(file);
	
	var formData = new FormData();
	
	formData.append("file",file);
	
	$.ajax({
		url: '/web/ajax/upload',
		data:formData,
		dataType: 'text',
		processData:false,
		contentType:false,
		type:'POST',
		success: function(data) {
			alert(data);
			
			var str = "";
			if (checkImageType(data)) { // 확장자가 존재하면
				str = "<div>"
				+"<a  href ='/web/ajax/displayFile?fileName="+getImageLink(data)+"'/>"
				+"<img  src ='/web/ajax/displayFile?fileName="+data+"'/>"
				+"</a><small data-src="+data+">X</small><div>";
			} else {
				str = "<div><a  href ='/web/ajax/displayFile?fileName="+data+"'>"+getOriginalName(data)+"</a>"
				+"<small data-src ="+data+">X</small></div></div>";
			}
			
			$('.uploadedList').append(str);
			
		}
	});
	
	
		$(".uploadedList").on("click","small",function(event){
			
			var that = $(this);
			
			$.ajax({
				url : "/web/ajax/deleteFile",
				type : "post",
				data : {fileName:$(this).attr("data-src")},
				dataType : "text",
				success:function(result){
					if (result == 'deleted') {
						alert("deleted!");
						that.parent("div").remove();
					}
					
				}

			}		
			
			);

		}
				);
	
	
	
	
	
	

	//파일의 확장자가 존재하는지 검사
	function checkImageType(fileName) {
		
		var pattern = /jpg|gif|png|jpeg/i;
		
		return fileName.match(pattern);
		
	}
	
	
	function getOriginalName(fileName) {
		if (checkImageType(fileName)) {
			return;
		}
		
		var idx = fileName.indexOf("_")+1;
		return fileName.substr(idx);

	}
	
	function getImageLink(fileName) {
		if (checkImageType(fileName)) {
			return;
		}
		var front = fileName.substr(0,12);
		var end = fileName.substr(14);
		
		return front+end;
		
	}
	
	
});

</script>
<!--Calendar -->
	<div class="modal calendarmodal">
		<div class="ReactModal__Overlay ReactModal__Overlay--after-open"
			aria-modal="true"
			style="position: fixed; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: rgba(73, 80, 86, 0.95); z-index: 150;">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">일정</h5>
						<button class="close" aria-label="Close" type="button"
							data-dismiss="modal"
							onclick="$('.calendarmodal').css('display','none'); $('body').css('overflow','visible'); $('.voteComplete').css('display','none'); ">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
					<!-- 	<p>Modal body text goes here.</p>
						<ul id="calList"></ul> -->
		<div  id="cardList" >
			<div class="card" style="display: none;">			
				<div class="card-body">
                  <h4 class="card-title">Card title</h4>
                  <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
                  <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                  <a href="#" class="card-link">Card link</a>
                  <a href="#" class="card-link">Another link</a>
                </div>
               </div>
            </div>  
               <div style="height: 20px"></div>
						<div id='calendar'></div>
					
					<div class="modal-footer">
						<button class="btn btn-primary" type="button" onclick="$('.registerCal').toggle();">일정 등록하기</button>
					</div>
					 
					 
<div class="registerCal" style="display: none; margin: 10px;">
					 		<form id="form1" >	
		<div class="form-group">

		<textarea class="form-control" name="content" rows="5" cols="100">일정내용 작성</textarea>
		<label>일정제목</label><br><textarea  class="form-control"  name="title" rows="1" cols="100"></textarea>
		<label>일시</label><br>
		 <select name="sdate" style="width: 150px">
				 <option id="startdate"></option>
				</select>
				
				<select name="szone" class="zone" style="width: 70px">
				<option>오전</option>
				<option>오후</option> 
				</select>
				<select name="shour" class="hour" style="width: 70px">
				<option selected="selected">05</option>
				</select>
				<select name="sminute" class="minute" style="width: 70px">
				<option selected="selected">00</option>
				</select>
				부터<br> 
				
				<select name="edate" style="width: 150px">
				<option id="enddate"></option>
				</select>
				<select name="ezone" class="zone" style="width: 70px">
				<option>오전</option>
				<option>오후</option> 
				</select>
				<select name="ehour"  class="hour"  style="width: 70px">
				<option selected="selected">05</option>
				 </select>
				<select name="eminute"   class="minute" style="width: 70px">
				<option selected="selected">30</option>
				</select>까지<br>
		
		
				<label>위치</label> <br>
				<textarea name="loc"  rows="1" style="width: 100%;"></textarea>
		
				<label>미리알림</label><br> 
				<input type="checkbox" name="alarm"><select
					style="width: 150px"><option>30분 전</option></select>
		

					</div>
					<div class="modal-footer">
						<button id="calendarComplete"  class="btn btn-primary">등록</button>
					</div>
</form>
</div>
 
					 </div>
					


				</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal votemodal">
		<div class="ReactModal__Overlay ReactModal__Overlay--after-open"
			aria-modal="true"
			style="position: fixed; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: rgba(73, 80, 86, 0.95); z-index: 150;">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">투표</h5>
						<button class="close" aria-label="Close" type="button"
							data-dismiss="modal"
							onclick="$('.votemodal').css('display','none'); $('body').css('overflow','visible'); $('.voteComplete').css('display','none'); ">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body-footer">
						<div class="modal-body">
							<ul class="list-group votelistgroup">
								<li class="list-group-item d-flex justify-content-between align-items-center vote2">
									Cras justo odio <button class="btn btn-primary votebtn vote2" type="button"onclick="$('.test').slideToggle(); $('.vote2').addClass('disabled');">투표 하기</button>
								</li>
								<div class="list-group-item justify-content-between align-items-center test" style="display: none;">
									sub1 <input name="sub" type="radio"><br>
									sub2 <input name="sub" type="radio"><br>
									sub3 <input name="sub" type="radio"><br>
									sub4 <input name="sub" type="radio"><br>
									<button class="btn btn-primary votebtn" type="button"onclick="$('.test').slideToggle(); $('.vote2').removeClass('disabled');">투표 하기</button>
								</div>
								<li class="list-group-item d-flex justify-content-between align-items-center vote2" style="display: none;">
									Dapibus ac facilisis in <button class="btn btn-primary vote2" type="button"onclick="">투표 하기</button>
								</li>
							</ul>
						</div>
						<div class="modal-footer">
							<button class="btn btn-primary" type="button"onclick="$('.createVote').toggle();">투표 올리기</button>
						</div>
					</div>
					<div class="createVote" style="display: none; margin: 10px;">
						<form action="">
							<fieldset>
								<div class="form-group">
									<label for="exampleInputPassword1">투표 제목</label> <input
										class="form-control voteTitle" id="exampleInputPassword1"
										type="text" placeholder="투표 제목을 입력하세요" name="voteTitle">
								</div>
								<div class="form-group">
									<label for="exampleInputPassword1">항목</label> <input
										class="form-control voteSub" id="" type="text"
										placeholder="항목을 입력하세요" name="sub1"> <input
										class="form-control voteSub" id="" type="text"
										placeholder="항목을 입력하세요" name="sub2"> <input
										class="form-control voteSub" id="" type="text"
										placeholder="항목을 입력하세요" name="sub3"> <input
										class="form-control voteSub" id="" type="text"
										placeholder="항목을 입력하세요" name="sub4">
								</div>
								<button class="btn btn-primary votecomplete" type="button">투표
									작성 완료</button>

							</fieldset>
						</form>
					</div>


					<div class="voteComplete" style="display: none; margin: 50px auto;">
						<h3>투표 등록 완료</h3>
						<button class="btn btn-primary votelist" type="button"
							style="margin: 30px;">투표 목록 보기</button>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>