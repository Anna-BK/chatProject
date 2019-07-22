<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<body>

	<div class="main" style="background-color: white;">
		<div class="mainContainer">
			<div class="mainAside">
				<div class="list-group">
					<a href="#" class="list-group-item list-group-item-action active"
						style="border-radius: 7px;">채팅 테마 </a> <a href="#"
						class="list-group-item list-group-item-action theme">게임</a> <a href="#"
						class="list-group-item list-group-item-action theme">여행</a> <a href="#"
						class="list-group-item list-group-item-action theme">운동</a> <a href="#"
						class="list-group-item list-group-item-action theme">영화</a> <a href="#"
						class="list-group-item list-group-item-action theme">음악</a> <a href="#"
						class="list-group-item list-group-item-action theme">기타</a>
				</div>
				
				<s:authorize ifAnyGranted="ROLE_USER">
				<div class="btn-wrapper">
               <button id="btn_mypage"class="btn-new" type="button">
                  <span>마이 페이지</span>
               </button>
               <button class="btn-new" type="button"
                  onclick="$('.modal').css('display','block'); $('body').css('overflow','hidden'); ">
                  <span>채팅방 만들기</span>
               </button>
            	</div>
				</s:authorize>
			</div>

			<div class="mainContent">
				<h2 style="margin: 20px 20px;">신규 채팅방</h2>
				<div class="roomList" style="margin: 0 auto; width: 670px;">
				<c:forEach items="${list }" var="dto" >
					<div class="card">
						<div class="card-body">
							<h4 class="card-title">${dto.roomname }</h4>
							<h6 class="card-subtitle mb-2 text-muted">${dto.roomtheme }</h6>
							<p class="card-text">${dto.roominfo}</p>
							<button type="button" class="btn btn-outline-primary enterbtn"
							onclick="location.href='chat?roomnumber=${dto.roomnumber}'">입장하기</button>
						</div>
					</div>
					</c:forEach>
					
					
					<div style="margin: 20px 220px;">
						<ul class="pagination">
							<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a>
							</li>
							<li class="page-item active"><a class="page-link" href="#">1</a>
							</li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
							<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item"><a class="page-link" href="#">4</a></li>
							<li class="page-item"><a class="page-link" href="#">5</a></li>
							<li class="page-item"><a class="page-link" href="#">&raquo;</a>
							</li>
						</ul>
					</div>

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
                              <c:forEach begin="2" end="20" varStatus="i">
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
	
<script>
$("#btn_mypage").on("click",function(){
	location.href="<%= request.getContextPath()%>/members/mypage.do";
});
</script>	
	
<script>
$(document).ready(function() {
	
	$('.theme').on("click",function(){
		
		var roomtheme = $(this).text();
		$('.roomList').empty();
		$.ajax({
			url : "/web/ajax/roomlist",
			dataType : "json",
			type : "get",
			data:{
				roomtheme:roomtheme
			},
			cache : false,
			success : function(data) {
				$(data).each(function(index, e) {
					
					var roomname = e.roomname;
					var roomtheme = e.roomtheme;
					var roominfo = e.roominfo;
					var roomnumber = e.roomnumber;
					
					var div1 = $("<div />").addClass("card");
					var div2 = $("<div />").addClass("card-body");
					var h4 = $("<h4 />").addClass("card-title");
					var h6 = $("<h6 />").addClass("card-subtitle mb-2 text-muted");
					var p = $("<p />").addClass("card-text");
					var button = $("<button type='button' class='btn btn-outline-primary enterbtn'	onclick='location.href=\"chat?roomname="+roomnumber+"\"'>");

					h4.text(roomname);
					h6.text(roomtheme);
					p.text(roominfo);
					button.text("입장하기");
					div2.append(h4, h6, p, button);
					div1.append(div2);

					$('.roomList').append(div1);
				})
			},
			error : function() {
				alert("에러~~~~")
			}
		});
		
	});
	
})


</script>
</body>
</html>