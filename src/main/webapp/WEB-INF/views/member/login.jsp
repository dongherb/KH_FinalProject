<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<meta charset="UTF-8">
<title>로그인</title>
<style>
.mainBox {
	height: 600px;
	display: flex;
	justify-content: center;
	align-items: center;
	border: none;
}

.loginBox {
	width: 50%;
	float: right;
}

.adBox {
	width: 50%;
	float: left;
}
.adBox a{
	text-decoration: none;
	color: black;
}
.adBox img{
	width: 100%;
	height: 100%;
	border-radius: 5px;
	opacity: 0.8;
	transition: 0.3s;
}
.adBox img:hover{
	opacity: 1;
}

.loginBox div {
	margin: 5px;
	padding: 0px;
}

.signupBox {
	font-size: 11px;
}

.loginBox button {
	height: 50px;
	cursor: pointer;
	padding-bottom: 10px;
}

.socialBox a {
	height: 50px;
	width: 290px;
	padding: 0px;
	cursor: pointer;
	margin-left:12px;
}

.socialBox img {
	height: 50px;
	width: 100%;
	padding: 0px;
}

.signupBox span {
	height: 100%;
	width: 100%;
	cursor: pointer;
	margin-left:5px;
}

.buttonBox button {
	width: 290px;
	margin-left:12px;
}

.inputBox div{
	padding:0px;
	margin-left:5px;
	
}
#ad {
	height: 300px;
	width: 300px;
}
</style>
</head>
<body>
	<%@include file="../header.jsp"%>
	<div class="container">
		<div class="row mainBox">
			<div class="col">
				<!-- 로그인 -->
				<div class="row loginBox" id="loginView">
					<div class="row">
						<h3 id="title">로그인</h3>
					</div>
					<div class="row inputBox">
						<form id="loginForm">
							<div class="row">
								<input type="text" class="form-control" id="id" name="id"
									placeholder="아이디" maxlength="20">
							</div>
							<div class="row">
								<input type="password" class="form-control" id="pw" name="pw"
									placeholder="비밀번호" maxlength="20">
							</div>
							<div class="row">
								<input type="text" class="form-control" id="email" name="email"
									placeholder="이메일" maxlength="30" style="display: none">
							</div>
							<div class="row">
								<input type="text" class="form-control" id="phone" name="phone"
									placeholder="전화번호" maxlength="11" style="display: none">
							</div>
						</form>
					</div>
					<div class="row signupBox">
							<div class="col">
							<span id=rememberIdSpan> 
							<input type="checkbox" class="form-check-input" id="rememberId"> 
							<label class="form-check-label" for="rememberId">아이디 저장</label></span>
							<span><a id="toSearchId">아이디 찾기</a></span> |
							<span><a id="toSearchPw">비밀번호 찾기</a></span> | <span><a id="toSignup">회원가입</a></span>
						</div>
					</div>


					<div class="row buttonBox">
						<!-- 				<button type="button" id="loginBtn" class="btn btn-warning">로그인</button> -->
						<button type="button" id="loginBtn2" class="btn btn-dark">로그인</button>
						<button type="button" id="searchIdBtn" class="btn btn-dark"
							style="display: none">아이디 찾기</button>
						<button type="button" id="searchPwBtn" class="btn btn-dark"
							style="display: none">비밀번호 찾기</button>
						<!-- <button type="button" id="signupBtn" class="btn btn-warning">회원가입</button> -->
					</div>
					<div class="row socialBox">
						<!-- REST_API키 , REDIRECT_URI 입력-->
						<a
                     href="https://kauth.kakao.com/oauth/authorize?client_id=e43b1a5d4ceca562dba92ae1b279974d&redirect_uri=http://3.35.231.101/member/kakaoLogin.do&response_type=code">
                    	<img src="${pageContext.request.contextPath}/resources/image/kakao_login3.png">
                  </a>
					</div>

				</div>




			</div>
			
			
				<div class="col-6 adBox">
					<div class="row" id="ad">
						<c:choose>
							<c:when test="${product.product_name ne null}">
								<div class="col">
									<a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${product.product_code}">
										<img src="${pageContext.request.contextPath}/product_img/${product.product_img}">
									</a>
								</div>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</div>
<!-- 					<div class="row"> -->
<!-- 						<div class="col" style="padding-left: 20px;"> -->
<%-- 							<a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${product.product_code}"> --%>
<%-- 								<span  style="font-size: 1.2rem;">${product.product_name}</span> --%>
<!-- 							</a> -->
<!-- 						</div> -->
<!-- 					</div> -->
				</div>

		</div>


	</div>
	<%@include file="../footer.jsp"%>
</body>

<script>

	//쿠키 값 가져와 id 인풋창에 세팅 
	$(document).ready(function(){
		
		let regex = /rememberId=(.*)/;
		
		if (regex.test(document.cookie)) {
			let id = RegExp.$1;
			$("#id").val(id);
			$("#rememberId").attr("checked",true);
		}
	});
	
	// 엔터키 입력시 로그인
	window.onkeydown = function(key) {
		if (key.keyCode == 13) {
			login();
		}
	};

	// 로그인버튼 클릭시 로그인
	$("#loginBtn2").on("click", function() {
		login();
	});

	// 아이디 찾기 클릭시
	$("#toSearchId").on("click", function() {

		$("#id").css("display", "none");
		$("#pw").css("display", "none");
		$("#email").css("display", "block");
		$("#phone").css("display", "block");
		$("#rememberIdSpan").css("visibility", "hidden");
		$("#title").text("아이디 찾기");
		$("#loginBtn2").css("display", "none");
		$("#searchIdBtn").css("display", "block");
		$("#searchPwBtn").css("display", "none");
		$("#id").val("");
		$("#pw").val("");
		$("#email").val("");
		$("#phone").val("");

	});

	// 비밀번호 찾기 클릭시
	$("#toSearchPw").on("click", function() {
		$("#id").css("display", "block");
		$("#pw").css("display", "none");
		$("#email").css("display", "block");
		$("#phone").css("display", "none");
		$("#rememberIdSpan").css("visibility", "hidden");
		$("#title").text("비밀번호 찾기");
		$("#loginBtn2").css("display", "none");
		$("#searchIdBtn").css("display", "none");
		$("#searchPwBtn").css("display", "block");
		$("#id").val("");
		$("#pw").val("");
		$("#email").val("");
		$("#phone").val("");
	});

	// 아이디 찾기 버튼 클릭시
	$("#searchIdBtn").on("click",function() {
						let email = $("#email").val();
						let phone = $("#phone").val();
						let regexPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
						let regexEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

						if ($("#email").val() == "") {
							alert("이메일을 입력하세요");
							$("#email").focus();
							return false;
						} else if ($("#phone").val() == "") {
							alert("전화번호를 입력하세요");
							$("#phone").focus();
							return false;
						} else if (!regexEmail.test(email)) {
							alert("이메일을 올바르게 입력하세요.");
							$("#email").focus();
							return false;
						} else if (!regexPhone.test(phone)) {
							alert("전화번호를 올바르게 입력하세요.");
							$("#phone").focus();
							return false;
						}

						let data = $("#loginForm").serialize();
						$.ajax({
							url : "${pageContext.request.contextPath}/member/searchId.do",
							type : "post",
							data : data
							}).done(function(rs) {
								if (rs.msg == "success") {
									alert("아이디는 " + rs.id + " 입니다.");
								} else if (rs.msg == "fail") {
									alert("이메일 혹은 전화번호가 일치하지 않습니다.");
								}
							}).fail(function(e) {
								console.log(e);
							})
						});

	// 비밀번호 찾기 버튼 클릭시
	$("#searchPwBtn").on("click", function() {
		let email = $("#email").val();
		let regexEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if ($("#id").val() == "") {
			alert("아이디를 입력하세요");
			$("#id").focus();
			return false;
		} else if ($("#email").val() == "") {
			alert("이메일을 입력하세요");
			$("#email").focus();
			return false;
		} else if (!regexEmail.test(email)) {
			alert("이메일을 올바르게 입력하세요.");
			$("#email").focus();
			return false;
		}

		let data = $("#loginForm").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/member/searchPw.do",
			type : "post",
			data : data
		}).done(function(rs) {
			if (rs.msg == "success") {
				alert("임시 비밀번호를 " + rs.email + " 으로 전송하였습니다.");
			} else if (rs.msg == "fail") {
				alert("아이디 혹은 이메일이 일치하지 않습니다.");
			}
		}).fail(function(e) {
			console.log(e);
		})
	});

	// 로그인 요청
	function login() {

		if ($("#id").val() == "") {
			alert("아이디를 입력하세요");
			return false;
		} else if ($("#pw").val() == "") {
			alert("비밀번호를 입력하세요");
			return false;
		}

		// 아이디 기억하기 여부 검사
		if ($("#rememberId:checked").length == 1) {
			rememberId();
		} else {
			deleteRememberId();
		}

		let data = $("#loginForm").serialize();
		$.ajax({
			url : "${pageContext.request.contextPath}/member/login.do",
			type : "post",
			data : data
		}).done(function(rs) {

			if (rs == "성공") {
				location.href = "${pageContext.request.contextPath}/";
			} else if (rs == "실패") {
				alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
			} else if (rs == "정지"){
				alert("관리자에 의해 정지된 아이디입니다. 메일 또는 전화로 관리자에게 문의하세요.");
			}

		}).fail(function(e) {
			console.log(e);
		})
	};

	// 회원가입 페이지 요청 
	document.getElementById("toSignup").onclick = function() {
		location.href = "${pageContext.request.contextPath}/member/toSignup.do";
	}
	
	// 로그인 쿠키 삭제 함수
	function deleteRememberId() {
		document.cookie = "rememberId=;Expires=Sat, 01 Jan 2022 00:00:10 GMT";
	}

	// 로그인 쿠키 생성 함수
	function rememberId() {
		let expiryDate = new Date();
		expiryDate.setDate(expiryDate.getDate() + 30);

		// 쿠키 생성 -> 키,값 지정
		let key = "rememberId";
		let value = $("#id").val();

		// 쿠키 설정
		document.cookie = key + "=" + value + ";Expires=" + expiryDate;
	}
</script>

</html>