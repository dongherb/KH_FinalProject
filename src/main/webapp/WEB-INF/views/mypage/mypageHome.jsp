<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<title>회원정보</title>
<style>
#myInfoContentTitle {
	margin-bottom: 20px;
	margin-top: 20px;
}

.myInfoContentTitle-options {
	margin: auto;
	border-bottom: 1px solid #e9e9e9;
}

.myInfoTitle {
	padding: 20px;
	font-size: 14px;
	font-weight: bold;
	border-right: 1px solid #e9e9e9;
	background-color: rgb(250, 250, 250);
	text-align: center;
	color: #555555;
}

.addBorderLeft {
	border-left: 1px solid #e9e9e9;
}

.point-row{
	border-bottom: 1px solid #e9e9e9;
}

.myInfoContent {
	padding: 20px;
	font-size: 14px;
}

.myInfoContent img {
	width: 15px;
	height: 15px;
}

.myInfoContainer .row:not(#myInfoContentTitle) {
	border-top: 1px solid #e9e9e9;
}

.btn-gap {
	padding-top: 50px;
	text-align: center;
}

.myInfoBtnsDiv .btn {
	width: 100%;
	text-align: center;
}

.myInfoBtnsDiv-Modify .btn {
	width: 100%;
}

.myInfoContainer .form-control {
	width: 50%;
}

.PwContent {
	margin-top: -80px;
	margin-bottom: 150px;
}


.myPwContainer .row:not(#myInfoContentTitle) {
	border-top: 1px solid #e9e9e9;
}

.myPwBtnsDiv .col {
	padding-top: 50px;
	text-align: center;
}

.myPwBtnsDiv .btn {
	width: 100%;
}

.myPwContainer .form-control {
	width: 50%;
}

.mainContent {
	margin-bottom: 150px;
}
</style>
</head>
<body>

	<c:choose>
		<c:when test="${checkPw eq 'toModifyPw'}">	<!-- 비밀번호변경 -->
			<script>
				alert("비밀번호가 일치합니다.");
				
				// 팝업창 띄우기
				let url = "${pageContext.request.contextPath}/mypageHome/toModifyPassword";
				let name = "비밀번호 수정";
				let option = "width=450, height=410, top=200, left=620";
				window.open(url, name, option);
				
				// 페이지도 리로드
				$(location).attr("href", "${pageContext.request.contextPath}/mypageHome/toMypageHome");
			</script>
		</c:when>
		
		<c:when test="${checkPw eq 'toWithdraw'}">	<!-- 회원탈퇴 -->
			<script>
				if(confirm("비밀번호가 일치합니다.\n정말 회원탈퇴를 진행하시겠습니까?")){
					$(location).attr("href", "${pageContext.request.contextPath}/mypageHome/withdrawProc");
				}
			</script>
		</c:when>
		
		<c:when test="${checkPw eq 'wrong'}">	<!-- 비밀번호 불일치 -->
			<script>
				alert("비밀번호가 틀립니다.");
			</script>
		</c:when>
		
		<c:otherwise/>
	</c:choose>

	<!-- 헤더 -->
	<%@include file="../header.jsp" %>

	<!-- 마이페이지 헤더 -->
	<%@include file="mypageNavi.jsp" %>
	
	<div class="container mainContent">
		<div class="row">
			<div class="d-sm-none d-md-block col-md-1"></div>
			
			<div class="col myInfoContainer">
				<div class="row" id="myInfoContentTitle">
					<h3>회원정보</h3>
				</div>
				
				<!-- 회원등급 -->
				<div class="row rowBorder">
					<div class="col-2 myInfoTitle">회원등급</div>	
					<!-- 등급으로 띄우기 -->
					<div class="col myInfoContent">
						<c:choose>
							<c:when test="${loginSession.total_point >= 3000}">
								<img src="${pageContext.request.contextPath}/resources/images/rank__0001_diamond.jpg">
								&nbsp;&nbsp;다이아
							</c:when>
							<c:when test="${loginSession.total_point >= 1000}">
								<img src="${pageContext.request.contextPath}/resources/images/rank__0000_platinum.jpg">
								&nbsp;&nbsp;플래티넘
							</c:when>
							<c:when test="${loginSession.total_point >= 300}">
								<img src="${pageContext.request.contextPath}/resources/images/rank__0002_gold.jpg">
								&nbsp;&nbsp;골드
							</c:when>
							<c:when test="${loginSession.total_point >= 100}">
								<img src="${pageContext.request.contextPath}/resources/images/rank__0003_silver.jpg">
								&nbsp;&nbsp;실버
							</c:when>
							<c:when test="${loginSession.total_point < 100}">
								<img src="${pageContext.request.contextPath}/resources/images/rank__0004_bronze.jpg">
								&nbsp;&nbsp;브론즈
							</c:when>
						</c:choose>
					</div>	
				</div>
				
				<!-- 아이디 -->
				<div class="row">
					<div class="col-2 myInfoTitle">아이디</div>
					<c:choose>
						<c:when test="${(loginSession.id).substring(0, 2) eq 'k@'}">
							<div class="col myInfoContent">kakao로그인 <span style="color: rgb(150, 150, 150);">(구분ID: ${loginSession.id})</span></div>
						</c:when>
						<c:otherwise>
							<div class="col myInfoContent">${loginSession.id}</div>
						</c:otherwise>
					</c:choose>
				</div>
				
				<!-- 아이디 -->
				<div class="row">
					<div class="col-2 myInfoTitle">이름</div>
					<div class="col myInfoContent">${loginSession.name}</div>
				</div>
				
				<!-- 주소 -->
				<div class="row">
					<div class="col-2 myInfoTitle">주소</div>
					<div class="col myInfoContent">${loginSession.address}</div>
				</div>
				
				<!-- 이메일 null 값 허용 -->
				<div class="row">
					<div class="col-2 myInfoTitle">이메일</div>
					<div class="col myInfoContent">${loginSession.email}</div>
				</div>

				<!-- 포인트 -->
				<div class="row point-row">
					<div class="col-2 myInfoTitle">포인트</div>
					<div class="col myInfoContent">${loginSession.extra_point}</div>
				</div>
			
			
				<!-- 키, 몸무게 : -1은 선택없음 -->
				<div class="row" id="myInfoContentTitle">
						<h4>추가 정보</h4>
					</div>
					<div class="row myInfoContentTitle-options">
						<div class="col-2 myInfoTitle">키(cm)</div>
						<div class="col myInfoContent">
							<c:choose>
								<c:when test="${loginSession.height eq '-1'}">
								비어있음
							</c:when>
								<c:otherwise>
								${loginSession.height}
							</c:otherwise>
							</c:choose>
						</div>
						<div class="col-2 myInfoTitle addBorderLeft">몸무게(kg)</div>
						<div class="col myInfoContent">
							<c:choose>
								<c:when test="${loginSession.weight eq '-1'}">
								비어있음
							</c:when>
								<c:otherwise>
								${loginSession.weight}
							</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div><!--col myInfoContainer 끝  -->
				<div class="d-sm-none d-md-block col-md-1"></div>
			</div><!-- row끝 -->
				
				<!-- 버튼들 -->
				<div class="row myInfoBtnsDiv justify-content-center">
					<div class="d-sm-none d-md-block col-md-1"></div>
					<div class="col-2 btn-gap ">
						<button type="button" class="btn btn-sm" id="toModifyBtn" style="background-color : #e5eaee">수정</button>
					</div>
					
					<c:if test="${(loginSession.id).substring(0, 2) ne 'k@'}">	<!-- 카카오로그인시 PW 변경 불가 -->
						<div class="col-2 btn-gap" id="modifyPwBtnDiv">
							<button type="button" class="btn btn-sm" id="modifyPwBtn" style="background-color : #e5eaee">비밀번호변경</button>
						</div>
					</c:if>
					
					<div class="col-2 btn-gap" id="withdrawBtnDiv">
						<button type="button" class="btn btn-sm" id="withdrawBtn" style="background-color : #e5eaee">회원탈퇴</button>
					</div>
					<div class="col-2 btn-gap" id="cancelPwBtnDiv" style="display: none">
						<button type="button" class="btn btn-sm"  id="cancelPwBtn" style="background-color : #e5eaee">취소</button>
					</div>
						
					<div class="d-sm-none d-md-block col-md-1"></div>
				</div>				

			<div class="d-sm-none d-md-block col-md-1"></div>
		</div>
	
	<form action="${pageContext.request.contextPath}/mypageHome/passwordCheckProc" method="post" id="submitPw">
		<div class="container PwContent" id="passwordContainer" style="display: none">
			<div class="row">
				<div class="d-sm-none d-md-block col-md-1"></div>
				
				<div class="col myPwContainer">
				`
					<!-- 비밀번호 변경 -->
					<div class="row myInfoBtnsDiv-Modify">
						<div class="col-2 myInfoTitle">현재비밀번호</div>
						<div class="col myInfoContent">
							<input type="password" class="form-control form-control-sm" name="pw" id="pw">
						</div>
					</div>
					
					<!-- 버튼들 -->
					<div class="row myPwBtnsDiv">
						<div class="d-sm-none d-md-block col-md-4"></div>
						<div class="col-2 btn-gap">
							<button type="button" class="btn btn-dark btn-sm" id="pwModifyCheckBtn" style="display: none">확인</button>
							<button type="button" class="btn btn-dark btn-sm" id="withdrawCheckBtn" style="display: none">확인</button>
							<input type="text" class="d-none" id="btnType" name="type">	<!-- post로 담을 type -->
						</div>
						<div class="d-sm-none d-md-block col-md-4"></div>
					</div>
					
				</div>
	
						<div class="d-sm-none d-md-block col-md-1"></div>
			</div>
		</div>
	</form>
	
	<!-- 푸터 -->
	<%@include file="../footer.jsp" %>
	
	<script>
		// 수정페이지로
		$("#toModifyBtn").on("click", function(){
			$(location).attr("href", "${pageContext.request.contextPath}/mypageHome/toMypageModify");
		});
		
		// 비밀번호변경 버튼 클릭 시
		$("#modifyPwBtn").on("click", function(){
			
			if(confirm("변경을 위해 비밀번호 인증이 필요합니다.")){
				
				$("#modifyPwBtnDiv").css("display", "none");
				$("#withdrawBtnDiv").css("display", "none");
				
				$("#cancelPwBtnDiv").css("display", "block");
				
				$("#passwordContainer").css("display", "block");
				
				$("#pwModifyCheckBtn").css("display", "block");
				$("#withdrawCheckBtn").css("display", "none");
			}
		});
		
		// 회원탈퇴버튼 클릭 시
		$("#withdrawBtn").on("click", function(){
			
			let id = "${loginSession.id}";
			
			if(id.substring(0, 2) == 'k@'){
				if(confirm("정말 회원탈퇴를 진행하시겠습니까?")){
					$(location).attr("href", "${pageContext.request.contextPath}/mypageHome/withdrawProc");
				}
				return;
			}
			
			if(confirm("회원탈퇴을 위해 비밀번호 인증이 필요합니다.")){
				
				$("#modifyPwBtnDiv").css("display", "none");
				$("#withdrawBtnDiv").css("display", "none");
				
				$("#cancelPwBtnDiv").css("display", "block");
				
				$("#passwordContainer").css("display", "block");
				
				$("#pwModifyCheckBtn").css("display", "none");
				$("#withdrawCheckBtn").css("display", "block");
			}
		});
		
		// 취소 버튼 클릭 시
		$("#cancelPwBtn").on("click", function(){
			$("#pw").val("");
			
			$("#modifyPwBtnDiv").css("display", "block");
			$("#withdrawBtnDiv").css("display", "block");
			
			$("#cancelPwBtnDiv").css("display", "none");
			
			$("#passwordContainer").css("display", "none");
			
			$("#pwModifyCheckBtn").css("display", "none");
			$("#withdrawCheckBtn").css("display", "none");
		});
		
		// 비밀번호 확인 클릭시 // 비밀번호 변경
		$("#pwModifyCheckBtn").on("click", function(){
			if($("#pw").val() == ""){
				alert("현재 비밀번호를 입력해주세요.");
				return;
			}
			$("#btnType").val("modifyPw");
			
			submitPw.submit();
		});
		
		// 비밀번호 확인 클릭시 // 회원탈퇴
		$("#withdrawCheckBtn").on("click", function(){
			if($("#pw").val() == ""){
				alert("현재 비밀번호를 입력해주세요.");
				return;
			}
			$("#btnType").val("withdraw");
			
			submitPw.submit();
		});
		
	</script>

</body>
</html>