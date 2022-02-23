<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 수정</title>
<style>
.container_All {
	width: 1600px;
	text-align: center;
	margin: auto;
}

.row {
	padding: 5px;
}

textarea {
	height: 200px;
	width: 600px;
}

input {
	width: 100px;
}

.title {
	font-size: 15px;
	font-weight: bold;
	padding: 10px 20px;
	background: #f8f8f8;
	border-bottom: 1px solid #dddddd;
}

#checkCodeBtn {
	border: 1px solid green;
	background-color: white;
	color: green;
	border-radius: 5px;
	height: 38px;
}

#checkCodeBtn:hover {
	color: white;
	background-color: green;
}

#submitBtn {
	border: 1px solid blue;
	background-color: white;
	color: blue;
	border-radius: 5px;
	height: 38px;
}

#submitBtn:hover {
	color: white;
	background-color: blue;
}

#cancelBtn {
	border: 1px solid black;
	background-color: white;
	color: black;
	border-radius: 5px;
	height: 38px;
}

#cancelBtn:hover {
	color: white;
	background-color: black;
}

.big-title {
	padding: 50px;
	font-size: 40px;
	font-weight: bold;
	background: #f8f9fa;
}

* {
	box-sizing: border-box;
}

.container {
	text-align: center;
}
</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
	<form id="modifyForm"
		action="${pageContext.request.contextPath}/product/modifyProduct.do"
		method="post" enctype="multipart/form-data">
		<div class="container">
			<div class="row">
				<div class="col big-title">
					<div>제품 수정</div>
				</div>
			</div>
			<div class="row">
				<div class="col-3 title">제품명</div>
				<div class="col-9">
					<input type="text" class="form-control" id="product_name" name="product_name"
						value="${dto.product_name}" style="width: 300px;">
				</div>
			</div>
			<div class="row">
				<div class="col-3 title">제품 코드</div>
				<div class="col-3">
					<input type="text" class="form-control" name="product_code"
						value="${dto.product_code}" style="width: 300px;" readonly>
				</div>
			</div>
			<div class="row">
				<div class="col-3 title">제품 이미지</div>
				<div class="col-6">
					<input type="file" class="form-control" id="file1" name="file1">
				</div>
			</div>
			<div class="row">
				<div class="col-3 title">제품 설명</div>
				<div class="col-6">
					<textarea class="form-control" id="product_content" name="product_content"
						style="resize: none">${dto.product_content}</textarea>
				</div>
			</div>
			<div class="row">
				<div class="col-3 title">제품 상세 이미지</div>
				<div class="col-6">
					<input type="file" class="form-control" id="file2" name="file2"
						multiple>
				</div>
			</div>
			<div class="row">
				<div class="col-3 title">카테고리</div>
				<div class="col-2" style="padding-top: 5px;">
					<select class="form-select form-select-sm" name="product_category"
						id="product_category" style="width: 150px; margin: auto;">
						<c:choose>
							<c:when test="${dto.product_category eq '상의'}">
								<option value="상의" selected>상의</option>
								<option value="하의">하의</option>
								<option value="신발">신발</option>
								<option value="아우터">아우터</option>
							</c:when>
							<c:when test="${dto.product_category eq '하의'}">
								<option value="상의">상의</option>
								<option value="하의" selected>하의</option>
								<option value="신발">신발</option>
								<option value="아우터">아우터</option>
							</c:when>
							<c:when test="${dto.product_category eq '신발'}">
								<option value="상의">상의</option>
								<option value="하의">하의</option>
								<option value="신발" selected>신발</option>
								<option value="아우터">아우터</option>
							</c:when>
							<c:when test="${dto.product_category eq '아우터'}">
								<option value="상의">상의</option>
								<option value="하의">하의</option>
								<option value="신발">신발</option>
								<option value="아우터" selected>아우터</option>
							</c:when>
						</c:choose>
					</select>
				</div>
				<div class="col-3 title">세부 카테고리</div>
				<div class="col-2" style="padding-top: 5px;">
					<select class="form-select form-select-sm" id="detail_category"
						name="detail_category" style="width: 150px; margin: auto;">
						<c:choose>
							<c:when test="${dto.detail_category eq '맨투맨'}">
								<option value="맨투맨" selected>맨투맨</option>
								<option value="니트/스웨터">니트/스웨터</option>
								<option value="티셔츠">티셔츠</option>
								<option value="셔츠">셔츠</option>
								<option value="후드티">후드티</option>
							</c:when>
							<c:when test="${dto.detail_category eq '니트/스웨터'}">
								<option value="맨투맨">맨투맨</option>
								<option value="니트/스웨터" selected>니트/스웨터</option>
								<option value="티셔츠">티셔츠</option>
								<option value="셔츠">셔츠</option>
								<option value="후드티">후드티</option>
							</c:when>
							<c:when test="${dto.detail_category eq '티셔츠'}">
								<option value="맨투맨">맨투맨</option>
								<option value="니트/스웨터">니트/스웨터</option>
								<option value="티셔츠" selected>티셔츠</option>
								<option value="셔츠">셔츠</option>
								<option value="후드티">후드티</option>
							</c:when>
							<c:when test="${dto.detail_category eq '셔츠'}">
								<option value="맨투맨">맨투맨</option>
								<option value="니트/스웨터">니트/스웨터</option>
								<option value="티셔츠">티셔츠</option>
								<option value="셔츠" selected>셔츠</option>
								<option value="후드티">후드티</option>
							</c:when>
							<c:when test="${dto.detail_category eq '후드티'}">
								<option value="맨투맨">맨투맨</option>
								<option value="니트/스웨터">니트/스웨터</option>
								<option value="티셔츠">티셔츠</option>
								<option value="셔츠">셔츠</option>
								<option value="후드티" selected>후드티</option>
							</c:when>
							<c:when test="${dto.detail_category eq '청바지'}">
								<option value="청바지" selected>청바지</option>
								<option value="면바지">면바지</option>
								<option value="반바지">반바지</option>
							</c:when>
							<c:when test="${dto.detail_category eq '면바지'}">
								<option value="청바지">청바지</option>
								<option value="면바지" selected>면바지</option>
								<option value="반바지">반바지</option>
							</c:when>
							<c:when test="${dto.detail_category eq '반바지'}">
								<option value="청바지">청바지</option>
								<option value="면바지">면바지</option>
								<option value="반바지" selected>반바지</option>
							</c:when>
							<c:when test="${dto.detail_category eq '가디건'}">
							    <option value="가디건" selected>가디건</option>
								<option value="자켓">자켓</option>
								<option value="코트">코트</option>
								<option value="패딩">패딩</option>
								<option value="후드집업">후드집업</option>
							</c:when>
							<c:when test="${dto.detail_category eq '자켓'}">
							    <option value="가디건">가디건</option>
								<option value="자켓" selected>자켓</option>
								<option value="코트">코트</option>
								<option value="패딩">패딩</option>
								<option value="후드집업">후드집업</option>
							</c:when>
							<c:when test="${dto.detail_category eq '코트'}">
							    <option value="가디건">가디건</option>
								<option value="자켓">자켓</option>
								<option value="코트" selected>코트</option>
								<option value="패딩">패딩</option>
								<option value="후드집업">후드집업</option>
							</c:when>
							<c:when test="${dto.detail_category eq '패딩'}">
							    <option value="가디건">가디건</option>
								<option value="자켓">자켓</option>
								<option value="코트">코트</option>
								<option value="패딩" selected>패딩</option>
								<option value="후드집업">후드집업</option>
							</c:when>
							<c:when test="${dto.detail_category eq '후드집업'}">
							    <option value="가디건">가디건</option>
								<option value="자켓">자켓</option>
								<option value="코트">코트</option>
								<option value="패딩">패딩</option>
								<option value="후드집업" selected>후드집업</option>
							</c:when>
							<c:when test="${dto.detail_category eq '운동화'}">
								<option value="운동화" selected>운동화</option>
								<option value="캔버스">캔버스</option>
								<option value="단화">단화</option>
							</c:when>
							<c:when test="${dto.detail_category eq '캔버스'}">
								<option value="운동화">운동화</option>
								<option value="캔버스" selected>캔버스</option>
								<option value="단화">단화</option>
							</c:when>
							<c:when test="${dto.detail_category eq '단화'}">
								<option value="운동화">운동화</option>
								<option value="캔버스">캔버스</option>
								<option value="단화" selected>단화</option>
							</c:when>
						</c:choose>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-3 title">가격</div>
				<div class="col-9">
					<input type="text" class="form-control" id="price" name="price"
						value="${dto.price}" style="width: 200px;">
				</div>
			</div>
			<div class="row">
				<div class="col-3 title">할인율</div>
				<div class="col-9">
					<input type="text" class="form-control" id="discount" name="discount"
						value="${dto.discount}" style="width: 200px;">
				</div>
			</div>
			<div class="row">
				<div class="col">
					<button type="button" id="cancelBtn">취소</button>
					<button type="button" id="submitBtn">수정 완료</button>
				</div>
			</div>
		</div>
	</form>
	<%@include file="../footer.jsp"%>
	<script>
	// product_category에 따른 detail_category 표시
    $("#product_category").change(function(e){
    	if($(e.target).val() == "상의"){
    		$("#detail_category").find("option").remove();
    		$("#detail_category").append("<option value='니트/스웨터'>니트/스웨터</option>");
    		$("#detail_category").append("<option value='맨투맨'>맨투맨</option>");
    		$("#detail_category").append("<option value='티셔츠'>티셔츠</option>");
    		$("#detail_category").append("<option value='셔츠'>셔츠</option>");
    		$("#detail_category").append("<option value='후드티'>후드티</option>");
    	} else if($(e.target).val() == "하의"){
    		$("#detail_category").find("option").remove();
    		$("#detail_category").append("<option value='청바지'>청바지</option>");
    		$("#detail_category").append("<option value='면바지'>면바지</option>");
    		$("#detail_category").append("<option value='반바지'>반바지</option>");
    	} else if($(e.target).val() == "아우터"){
    		$("#detail_category").find("option").remove();
    		$("#detail_category").append("<option value='가디건'>가디건</option>");
    		$("#detail_category").append("<option value='자켓'>자켓</option>");
    		$("#detail_category").append("<option value='코트'>코트</option>");
    		$("#detail_category").append("<option value='패딩'>패딩</option>");
    		$("#detail_category").append("<option value='후드집업'>후드집업</option>");
    	} else if($(e.target).val() == "신발"){
    		$("#detail_category").find("option").remove();
    		$("#detail_category").append("<option value='운동화'>운동화</option>");
    		$("#detail_category").append("<option value='캔버스'>캔버스</option>");
    		$("#detail_category").append("<option value='단화'>단화</option>");
    	}
    })
    
    $("#cancelBtn").click(function(){
        	history.back();
    })
    
    let product_name = document.getElementById("product_name");
    let product_content = document.getElementById("product_content");
	let price = document.getElementById("price");
	let discount = document.getElementById("discount");
    
    $("#submitBtn").click(function(){
    	let regexProduct_name = /[a-zA-Zㄱ-힣]{1,50}/;
    	let regexProduct_content = /[a-zA-Zㄱ-힣]{1,1000}/;
    	let regexPrice = /[0-9]{1,8}/;
    	let regexDiscount = /[0-9]{1,3}/;
    	let file1 = $("#file1").val();
    	let file2 = $("#file2").val();
    	
    	if(!regexProduct_name.test(product_name.value)){
    		alert("제품명이 비어있거나 최대 글자수를 초과했습니다.");
        }else if(!regexProduct_content.test(product_content.value)){
    		alert("제품 설명은 빈칸일수 없고 1000글자 이내만 가능합니다.");
    		return;
    	}else if(!regexPrice.test(price.value)){
    		alert("가격은 비어있거나 천만 단위를 초과할 수 없고 숫자만 가능합니다.");
    		return;
    	}else if(!regexDiscount.test(discount.value)){
    		alert("할인율은 0~100까지의 숫자만 가능합니다.");
    		return;
    	}else if(file1 == ""){
    		alert("제품 이미지를 등록해주세요.");
    		return;
    	}else if(file2 == ""){
    		alert("제품 상세 이미지를 등록해주세요.");
    		return;
    	}else{
    		document.getElementById("insertForm").submit();
    	}
    })	
	</script>
</body>
</html>