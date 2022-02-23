<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<meta charset="UTF-8">
	<title>회원정보</title>
	
	<style>

		#myInfoContentTitle{
			margin-bottom: 30px;
		}
		.mainContent{
			margin-bottom: 150px;
		}
		
		.myInfoTitle{
			padding: 20px;
			font-size: 1.1rem;
			font-weight: bold;
			border-right: 1px solid gray;
			background-color: rgb(200,200,200);
			text-align: center;
		}
		.addBorderLeft{
			border-left: 1px solid gray;
		}
		
		.myInfoContent{
			padding: 20px;
			font-size: 1.1rem;
		}
		.myInfoContainer .rowBorder {
			border-top: 1px solid gray;
		}
		.myInfoBtnsDiv .col{
			padding-top: 50px;
			text-align: center;
		}
		.myInfoBtnsDiv .btn{
			width: 100%;
		}
		.myInfoContainer .form-control-50{
			width: 50%;
		}
		.myInfoContainer .dropdownContainer{
			width: 50%;
		}
		
		.addressModifyDiv{
			padding-top: 40px;
		}
		.addressModifyDiv .col{
			padding-top: 10px;
		}

	</style>
</head>
<body>

	<!-- 헤더 -->
	<%@include file="../header.jsp" %>

	<!-- 마이페이지 헤더 -->
	<%@include file="mypageNavi.jsp" %>
	
	<form action="${pageContext.request.contextPath}/mypageHome/modifyProc" method="post" id="modifySubmit">
	
		<div class="container mainContent">
			<div class="row">
				<div class="d-sm-none d-md-block col-md-1"></div>
				
				<div class="col myInfoContainer">
					<div class="row" id="myInfoContentTitle">
						<h2>회원정보</h2>
					</div>
					
					<!-- 회원등급 -->
					<div class="row rowBorder">
						<div class="col-2 myInfoTitle">회원등급</div>
						<div class="col myInfoContent">
							<c:choose>
								<c:when test="${loginSession.total_point >= 3000}">
									다이아
								</c:when>
								<c:when test="${loginSession.total_point >= 1000}">
									플래티넘
								</c:when>
								<c:when test="${loginSession.total_point >= 300}">
									골드
								</c:when>
								<c:when test="${loginSession.total_point >= 100}">
									실버
								</c:when>
								<c:when test="${loginSession.total_point < 100}">
									브론즈
								</c:when>
							</c:choose>
						</div>
					</div>
					
					<!-- 아이디 -->
					<div class="row rowBorder">
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
					<div class="row rowBorder">
						<div class="col-2 myInfoTitle">이름</div>
						<div class="col myInfoContent">${loginSession.name}</div>
					</div>
					
					<!-- 주소 -->
					<div class="row rowBorder">
						<div class="col-2 myInfoTitle">주소</div>
						<div class="col myInfoContent">
							
							<div class="row">
								<div class="col"><input name="address" id="address" class="form-control" value="${loginSession.address}" disabled></div>
								<div class="col">
									<button type="button" class="btn btn-outline-primary" id="addressModifyBtn">수정하기</button>
									<button type="button" class="btn btn-outline-secondary" id="addressCancelBtn" style="display: none">취소</button>
								</div>
							</div>
							
							<div class="row addressModifyDiv" style="display: none">
								<div class="col col-6">
									<input type="text" class="form-control" id="postcode" placeholder="우편번호" disabled>
								</div>
								<div class="col col-6">
									<input type="button" class="btn btn-outline-primary" onclick="execDaumPostcode()" value="우편번호 찾기">
								</div>
								
								<div class="col col-12">
									<input type="text" class="form-control" id="roadAddress" placeholder="도로명주소" disabled>
								</div>
								<div class="col col-12">
									<input type="text" class="form-control" id="jibunAddress" placeholder="지번주소" disabled>
								</div>
								<div class="col col-12">
									<span id="guide" style="color:#999;display:none"></span>
									<input type="text" class="form-control" id="detailAddress" placeholder="상세주소">
								</div>
								<div class="col col-6">
									<input type="text" class="form-control" id="extraAddress" placeholder="참고항목" disabled>
								</div>
								<div class="col col-6">
									<button type="button" class="btn btn-primary" id="inputAddressBtn">주소 입력하기</button>
								</div>
							</div>
							
						</div>
					</div>
					
					<!-- 이메일 -->
					<div class="row rowBorder">
						<div class="col-2 myInfoTitle">이메일</div>
						<div class="col myInfoContent">
							${loginSession.email}
							<input name="email" id="email" class="form-control form-control-50 d-none" value="${loginSession.email}">
						</div>
					</div>
	
					<!-- 포인트 -->
					<div class="row rowBorder">
						<div class="col-2 myInfoTitle">포인트</div>
						<div class="col myInfoContent">${loginSession.extra_point}</div>
					</div>
					
					<!-- 키, 몸무게 -->
					<div class="row rowBorder">
						<div class="col-2 myInfoTitle">키</div>
						<div class="col myInfoContent">
							<select class="form-select dropdownContainer" id="selectedHeight">
								<option value="-1">키 선택</option>	<!-- 드롭다운으로 구성 -->	<!-- foreach문안에 c:choose로 select된 option 추가 // 174를 저장했으면 시작이 174 -->
								<c:forEach var="i" begin="120" end="200">
									<c:choose>
										<c:when test="${loginSession.height eq i}">
											<option value="${i}" selected>${i}cm</option>	<!-- 회원이 입력한 키가 미리 선택되어 있음 -->
										</c:when>
										<c:otherwise>
											<option value="${i}">${i}cm</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</select>
							<input name="height" id="height" class="d-none" value="">
						</div>
						
						<div class="col-2 myInfoTitle addBorderLeft">몸무게</div>
						<div class="col myInfoContent">
							<select class="form-select dropdownContainer" id="selectedWeight">
								<option value="-1">몸무게 선택</option>	<!-- 드롭다운으로 구성 -->	<!-- foreach문안에 c:choose로 select된 option 추가 -->
								<c:forEach var="i" begin="30" end="120">
									<c:choose>
										<c:when test="${loginSession.weight eq i}">
											<option value="${i}" selected>${i}kg</option>	
										</c:when>
										<c:otherwise>
											<option value="${i}">${i}kg</option>	
										</c:otherwise>
									</c:choose>	
								</c:forEach>
							</select>
							<input name="weight" id="weight" class="d-none" value="">
						</div>
					</div>
					
					<!-- 버튼들 -->
					<div class="row myInfoBtnsDiv rowBorder">
						<div class="d-sm-none d-md-block col-md-3"></div>
						
						<div class="col">
							<button type="button" class="btn btn-secondary" id="toMypageHomeBtn">취소</button>
						</div>
						<div class="col">
							<button type="button" class="btn btn-dark" id="submitBtn">저장하기</button>
						</div>
						
						<div class="d-sm-none d-md-block col-md-3"></div>
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
		
		// 취소버튼 클릭 시 마이페이지홈으로
		$("#toMypageHomeBtn").on("click", function(){
			$(location).attr("href", "${pageContext.request.contextPath}/mypageHome/toMypageHome");
		});
		
		// 저장버튼 클릭 시
		$("#submitBtn").on("click", function(){
			
			if(!confirm("회원정보를 수정하시겠습니까?")){
				return;
			}
			
			if($("#address").val() == ""){
				alert("주소를 입력해주세요.");
				return;
			}
			
			// 키 값이 담김 -1은 선택없음
			$("#height").val($("#selectedHeight option:selected").val());
			// 몸무게 값이 담김 -1은 선택없음
			$("#weight").val($("#selectedWeight option:selected").val());
			
			// disabled 면 값이 안 들어가는듯 따라서 해제
			$("#address").attr("disabled", false);
			$("#email").attr("disabled", false);
			
			$("#modifySubmit").submit();
		});
		
		// 주소수정 버튼 클릭 시
		$("#addressModifyBtn").on("click", function(){
			$("#addressModifyBtn").css("display", "none");
			$("#addressCancelBtn").css("display", "block");
			$(".addressModifyDiv").css("display", "inline-flex");
		});
		
		// 주소취소 버튼 클릭 시
		$("#addressCancelBtn").on("click", function(){
			$("#addressModifyBtn").css("display", "block");
			$("#addressCancelBtn").css("display", "none");
			$(".addressModifyDiv").css("display", "none");
		});
		
		// 주소 입력하기 클릭 시
		$("#inputAddressBtn").on("click", function(){
			if($("#postcode").val() == ""){
				alert("우편번호를 선택해주세요.");
				return;
			}
			if($("#detailAddress").val() == ""){
				alert("상세주소를 입력해주세요.");
				return;
			}
			if( ($("#detailAddress").val()).length >= 30 ){
				alert("30자 이하로 입력해주세요.");
			}
			
			// 주소를 input address에 담기
			$("#address").val( $("#postcode").val() +" "+ $("#roadAddress").val() +" "+ $("#jibunAddress").val() +" "+ $("#detailAddress").val() +" "+ $("#extraAddress").val());
			
			// 주소div 닫기
			$("#addressModifyBtn").css("display", "block");
			$("#addressCancelBtn").css("display", "none");
			$(".addressModifyDiv").css("display", "none");
			
			// 초기화
			$("#postcode").val("");
			$("#roadAddress").val("");
			$("#jibunAddress").val("");
			$("#detailAddress").val("");
			$("#extraAddress").val("");
			
			alert("입력 완료");
		})
		
		// 주소 API : daum
		    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("roadAddress").value = roadAddr;
	                document.getElementById("jibunAddress").value = data.jibunAddress;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if(roadAddr !== ''){
	                    document.getElementById("extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }
	
	                var guideTextBox = document.getElementById("guide");
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';
	
	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
	                }
	            }
	        }).open();
	    }
		
		
		
	</script>

</body>
</html>