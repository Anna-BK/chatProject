<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">

<body>
<form id="join_form" method="post" action="">
    <input type="hidden" id="birthday" name="birthday" value="">

    <!-- container -->
    <div id="container" role="main">
        <div id="content">
                 
            <div class="join_content">
                <!-- 아이디, 비밀번호 입력 -->
                <div class="row_group">
                    <div class="join_row">
                        <h3 class="join_title"><label for="id">아이디</label></h3>
                        <span class="ps_box int_id">
							<input type="text" id="id" name="id" class="int" title="ID" maxlength="20">
						</span>
						<button type="button" id="btn_idck"class="btn btn-primary">중복확인</button>
                        <span class="error_next_box" id="idMsg" style="display:none" role="alert"></span>
                    </div>

                    <div class="join_row">
                        <h3 class="join_title"><label for="pswd">비밀번호</label></h3>
                        <span class="ps_box int_pass" id="pswd1Img">
							<input type="password" id="pswd" name="pswd" class="int" title="비밀번호 입력" aria-describedby="pswd1Msg" maxlength="20">
                            <span class="lbl"><span id="pswd1Span" class="step_txt"></span></span>
						</span>
                        <span class="error_next_box" id="pswd1Msg" style="display:none" role="alert"></span>

                        <h3 class="join_title"><label for="pswd2">비밀번호 재확인</label></h3>
                        <span class="ps_box int_pass_check" id="pswd2Img">
							<input type="password" id="pswd2" name="pswd2" class="int" title="비밀번호 재확인 입력" aria-describedby="pswd2Blind" maxlength="20">
							<span id="pswd2Blind" class="wa_blind"></span>
						</span>
                        <span class="error_next_box" id="pswd2Msg" style="display:none" role="alert"></span>
                    </div>
                </div>
                <!-- // 아이디, 비밀번호 입력 -->

                <!-- 이름, 생년월일 입력 -->
                <div class="row_group">

                    <!-- lang = ko_KR -->
                    <div class="join_row">
                        <h3 class="join_title"><label for="name">이름</label></h3>
                        <span class="ps_box box_right_space">
							<input type="text" id="name" name="name" title="이름" class="int" maxlength="40">
						</span>
                        <span class="error_next_box" id="nameMsg" style="display:none" role="alert"></span>
                    </div>
                    <!-- lang = ko_KR -->

                    <div class="join_row join_birthday">
                        <h3 class="join_title"><label for="yy">생년월일</label></h3>
                        <div class="bir_wrap">
                            <div class="bir_yy">
								<span class="ps_box">
									<input type="text" id="yy" placeholder="년(4자)" aria-label="년(4자)" class="int" maxlength="4">
								</span>
                            </div>
                            <div class="bir_mm">
								<span class="ps_box">
									<select id="mm" class="sel" aria-label="월">
										<option>월</option>
										  	 			<option value="01">
                                                            1
                                                        </option>
										  	 			<option value="02">
                                                            2
                                                        </option>
										  	 			<option value="03">
                                                            3
                                                        </option>
										  	 			<option value="04">
                                                            4
                                                        </option>
										  	 			<option value="05">
                                                            5
                                                        </option>
										  	 			<option value="06">
                                                            6
                                                        </option>
										  	 			<option value="07">
                                                            7
                                                        </option>
										  	 			<option value="08">
                                                            8
                                                        </option>
										  	 			<option value="09">
                                                            9
                                                        </option>
										  	 			<option value="10">
                                                            10
                                                        </option>
										  	 			<option value="11">
                                                            11
                                                        </option>
										  	 			<option value="12">
                                                            12
                                                        </option>
									</select>
								</span>
                            </div>
                            <div class=" bir_dd">
								<span class="ps_box">
									<input type="text" id="dd" placeholder="일" aria-label="일" class="int" maxlength="2">
									<label for="dd" class="lbl"></label>
								</span>
                            </div>
                        </div>
                        <span class="error_next_box" id="birthdayMsg" style="display:none" role="alert"></span>
                    </div>

                    <div class="join_row join_sex">
                        <h3 class="join_title"><label for="gender">성별</label></h3>
                        <div class="ps_box gender_code">
                            <select id="gender" name="gender" class="sel" aria-label="성별">
                                <option value="" selected="">성별</option>
                                        <option value="M">남자</option>
                                        <option value="F">여자</option>
                            </select>
                        </div>
                    </div>
                    <span class="error_next_box" id="genderMsg" style="display:none" role="alert"></span>

                    <div class="join_row join_email">
                        <h3 class="join_title"><label for="email">본인 확인 이메일<span class="terms_choice">(선택)</span></label></h3>
                        <span class="ps_box int_email box_right_space">
							<input type="text" id="email" name="email" maxlength="100" placeholder="선택입력" aria-label="선택입력" class="int">
						</span>
                    </div>
                    <span class="error_next_box" id="emailMsg" style="display:none" role="alert"></span>
                </div>
                <!-- // 이름, 생년월일 입력 -->

                <div class="btn_area">
                    <button type="submit" id="btnJoin" class="btn_type btn_primary"><span>가입하기</span></button>
                </div>
            </div>
        </div>
    </div>
    <!-- // container -->
</form>



<script type="text/JavaScript">
   $("#btnJoin").on("click",function(){

		var birthday;
		var yy = $("#yy").val();
		var mm = $("#mm").val();
		var dd = $("#dd").val();
		
		if (mm.length == 1) {
            mm = "0" + mm;
        }
        if (dd.length == 1) {
            dd = "0" + dd;
        }
		
		birthday=yy+mm+dd;
		alert(typeof birthday);
		$("#birthday").val(birthday);	
   });
</script>

<script type="text/javascript">

	var idCheck=0;
	var oMsg = $("#idMsg");
    var isID = /^[a-z0-9][a-z0-9_\-]{4,19}$/;

	function showErrorMsg(obj, msg) {
        obj.attr("class", "error_next_box");
        obj.html(msg);
        obj.show();
    }
	
    function showSuccessMsg(obj, msg) {
        obj.attr("class", "error_next_box green");
        obj.html(msg);
        obj.show();
    }
	
	$(function(){
		$("#btn_idck").click(function(){
			var inputid = $("#id").val();
			
			$.ajax({
				data: {id: inputid},
				url: "checkId.do",			
				success : function(data){
					//alert(typeof data);
					if ( inputid == "") {
     				   showErrorMsg(oMsg,"필수 정보입니다.");
    				}else if (!isID.test(inputid)) {
    			        showErrorMsg(oMsg,"5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
    			    }else if(data==1){
						showErrorMsg(oMsg,"이미 사용중이거나 탈퇴한 아이디입니다.");
						$("#btnJoin").prop("disabled",true);	
						$("#spanId").addClass("has-error")
						$("id").focus();
						idCheck=0;
					}else{
						showSuccessMsg(oMsg, "멋진 아이디네요!");
						$("#btnJoin").prop("disabled",false);	
						$("#spanId").removeClass("has-error")
						$("#pswd").focus();
						idCheck=1;
					}
				},
				error: function(error){
					alert("error~! "+error);
				}				
			});
		});
	});

//비밀번호
    function isValidPasswd(str) {
        var cnt = 0;
        if (str == "") {
            return false;
        }
        if (str.length < 8) {
            return false;
        }
        for (var i = 0; i < str.length; ++i) {
            if (str.charAt(0) == str.substring(i, i + 1))
                ++cnt;
        }
        if (cnt == str.length) {
            return false;
        }
        
        var isPW =/^[A-Za-z0-9`\-=\\\[\];',\./~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{8,16}$/;
        if (!isPW.test(str)) {
            return false;
        }
        return true;
    }
    
$("#pswd").blur( function checkPswd1() {
    
	var pw = $("#pswd").val()+"";
    var oSpan = $("#pswd1Span");
    var oMsg = $("#pswd1Msg");
	
    if (pw == "") {
        showErrorMsg(oMsg,"필수 정보입니다.");
    }
    if (isValidPasswd(pw) != true) {
        showErrorMsg(oMsg,"8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.");
    }else{
    	showSuccessMsg(oMsg,"안전한 비밀번호입니다.")
    }
    
    		
});    

$("#pswd2").blur(function checkPswd2() {
        var pswd1 = $("#pswd");
        var pswd2 = $("#pswd2");
        var oMsg = $("#pswd2Msg");
        var oBlind = $("#pswd2Blind");

        if (pswd1.val() != pswd2.val()) {
            showErrorMsg(oMsg,"비밀번호가 일치하지 않습니다.");
            pswd2.val("");
        } else {
        	showSuccessMsg(oMsg,"일치합니다.")
        }
});


	
</script>

</body>
</html>