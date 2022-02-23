<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<meta charset="UTF-8">
	<title>비밀번호 수정</title>
	
	<style>
		body{
			overflow: hidden;
		}
		.modifyContainer{
			margin: auto;
		}
		.modifyContainer .headDecoratedDiv{
			height: 15px;
			background-color: #bbb;
		}
		.modifyContainer .footDecoratedDiv{
			height: 100px;
			background-color: #bbb;
		}

		.modifyContainer .imgDiv{
			text-align: center;
		}
		.modifyContainer img{
			height: 130px;
		}
		
		.buttonDiv {
			margin-top: 10px;
			margin-bottom: 25px;
		}
		.buttonDiv1{
			text-align: center;
		}
		.buttonDiv2{
			text-align: right;
		}
		
		.buttonDiv1 button{
			width: 100%;
			box-shadow: 1px 1px 1px 1px #3366cc;
		}
		.buttonDiv2 button{
			box-shadow: 1px 1px 1px 1px rgb(150, 150, 150);
		}
		
		
	</style>
</head>
<body>
	
	<c:choose>
		<c:when test="${done eq 'done'}">
			<script>
				alert("비밀번호 변경완료.");
				opener.parent.location="${pageContext.request.contextPath}/mypageHome/toMypageHome";
				window.close();
			</script>
		</c:when>
		<c:when test="${done eq 'duplication'}">
			<script>
				alert("기존의 비밀번호와 같습니다.");
			</script>
		</c:when>
		<c:when test="${done eq 'fail'}">
			<script>
				alert("비밀번호 변경실패.");
			</script>
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>

	<form action="${pageContext.request.contextPath}/mypageHome/modifyPasswordProc" method="post" id="pwSubmit">
		<div class="container modifyContainer">
			<div class="row headDecoratedDiv"></div>
		
			<div class="row">
				<div class="col imgDiv">
					<img src="${pageContext.request.contextPath}/resources/image/logo1.png">
				</div>
			</div>
		
			<div class="row">
				<div class="col-1"></div>
				<div class="col">
					<label style="font-size : 0.8rem">_ 변경할 새로운 비밀번호</label>
					<input type="password" class="form-control" name="pw" id="pw">
				</div>
				<div class="col-1"></div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col">
					<label style="font-size : 0.8rem">_ 새로운 비밀번호 확인</label>
					<input type="password" class="form-control" id="pwChk">
					<span style="font-size : 0.7rem" id="pwChkNotice"></span>
				</div>
				<div class="col-1"></div>
			</div>	
			
			<div class="row buttonDiv">
				<div class="col-1"></div>
				<div class="col"></div>
				<div class="col buttonDiv1">
					<button type="button" class="btn btn-outline-primary btn-sm" id="submitBtn">변경</button>
				</div>
				<div class="col buttonDiv2">
					<button type="button" class="btn btn-outline-secondary btn-sm" id="cancelBtn">취소</button>
				</div>
				<div class="col-1"></div>
			</div>	
			
			<div class="row buttonDiv footDecoratedDiv"></div>
			
		</div>
	</form>
	
	<script>
		// 취소 클릭 시 팝업창 종료
		$("#cancelBtn").on("click", function(){
			window.close();
		});
		
		// 변경 클릭 시
		$("#submitBtn").on("click", function(){
			
			if($("#pw").val() == ""){
				alert("새로운 비밀번호를 입력해주세요.");
				return;
			}
			else if($("#pwChk").val() == ""){
				alert("비밀번호 확인이 필요합니다.");
				return;
			}
			else if($("#pw").val() != $("#pwChk").val()){
				alert("비밀번호가 틀립니다.");
				return;
			}
			// 다른 정규식 추가해야함
			

			// 확인
			if(confirm("비밀번호를 변경하시겠습니까?")){
				pwSubmit.submit();
			}
		});
		
		//비밀번호 체크
		$(function() {

			$('#pw, #pwChk').keyup(function() {
				if ($('#pw').val() !== "" && $('#pwChk').val() !== "") {
					if ($('#pw').val() != $('#pwChk').val()) {
						$('#pwChkNotice').html('비밀번호 일치하지 않음');
						$('#pwChkNotice').css('color', 'rgb(250,30,30)');
					} else {
						$('#pwChkNotice').html('비밀번호 일치함');
						$('#pwChkNotice').css('color', 'rgb(50,150,50)');
					}
				} else {
					$('#pwChkNotice').html('');
				}
			});
			
		});
	
	</script>

</body>
</html>