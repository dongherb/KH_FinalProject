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
<title>제품 등록</title>
<style>
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

.container{
    text-align : center;
}
</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
	<form id="insertForm"
		action="${pageContext.request.contextPath}/product/insertProduct.do"
		method="post" enctype="multipart/form-data">
		<div class="container">
				<div class="row">
					<div class="col big-title">
						<div>제품 등록</div>
					</div>
				</div>
				<div class="row">
				    <div class="col-1"></div>
					<div class="col-3 title">제품명</div>
					<div class="col-7 content">
						<input type="text" class="form-control" id="product_name"
							name="product_name" value="${product_name}" style="width: 300px;">
					</div>
				</div>
				<div class="row">
				    <div class="col-1"></div>
					<div class="col-3 title">제품 코드</div>
					<div class="col-3 content">
						<input type="text" class="form-control" id="product_code"
							name="product_code" style="width: 300px;" readonly>
					</div>
					<div class="col-3" style="text-align: left;">
						<button type="button" id="checkCodeBtn">중복 확인</button>
					</div>
				</div>
				<div class="row">
				    <div class="col-1"></div>
					<div class="col-3 title">제품 이미지</div>
					<div class="col-6 content">
						<input type="file" class="form-control" id="file1" name="file1" required>
					</div>
				</div>
				<div class="row">
				    <div class="col-1"></div>
					<div class="col-3 title">제품 설명</div>
					<div class="col-6 content">
						<textarea class="form-control" id="product_content"
							name="product_content" style="resize: none"></textarea>
					</div>
				</div>
				<div class="row">
				    <div class="col-1"></div>
					<div class="col-3 title">제품 상세 이미지</div>
					<div class="col-6 content">
						<input type="file" class="form-control" id="file2" name="file2" required>
					</div>
				</div>
				<div class="row">
				    <div class="col-1"></div>
					<div class="col-3 title">카테고리</div>
					<div class="col-2 content" style="padding-top: 5px;">
						<select id="product_category" class="form-select form-select-sm"
							name="product_category" style="width: 150px; margin: auto;">
							<option>--- 선택 ---</option>
							<option value="상의">상의</option>
							<option value="하의">하의</option>
							<option value="신발">신발</option>
							<option value="아우터">아우터</option>
						</select>
					</div>
					<div class="col-3 title">세부 카테고리</div>
					<div class="col-2 content" style="padding-top: 5px;">
						<select class="form-select form-select-sm" id="detail_category"
							name="detail_category" style="width: 150px; margin: auto;">
						</select>
					</div>
				</div>
				<div class="row">
				    <div class="col-1"></div>
					<div class="col-3 title">가격</div>
					<div class="col-8 content">
						<input type="text" class="form-control" id="price" name="price"
							value="${price}" style="width: 200px;">
					</div>
				</div>
				<div class="row">
				    <div class="col-1"></div>
					<div class="col-3 title">할인율</div>
					<div class="col-8 content">
						<input type="text" class="form-control" id="discount"
							name="discount" value="${discount}" style="width: 200px;">
					</div>
				</div>
				<div class="row">
					<div class="col">
						<button type="button" id="cancelBtn">취소</button>
						<button type="button" id="submitBtn">제품 등록</button>
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
    
    $("#checkCodeBtn").click(function(){
    	let url = "${pageContext.request.contextPath}/product/toCheckCodePopup"
    	let name = "제품 코드 중복검사";
    	let option = "width=500, height=225";
    	
    	window.open(url, name, option);
    })
    
    let product_name = document.getElementById("product_name");
	let product_code = document.getElementById("product_code");
    let product_content = document.getElementById("product_content");
	let price = document.getElementById("price");
	let discount = document.getElementById("discount");
    
    $("#submitBtn").click(function(){
    	let regexProduct_name = /^[a-zA-Zㄱ-힣0-9 ]{1,50}$/;
    	let regexProduct_content = /^[a-zA-Zㄱ-힣0-9.,~!@#$%^&*=()_+ -]{1,300}$/;
    	let regexPrice = /^[0-9]{1,8}$/;
    	let regexDiscount = /^[0-9]{1,3}$/;
    	let file1 = $("#file1").val();
    	let file2 = $("#file2").val();
    	
    	if(!regexProduct_name.test(product_name.value)){
    		alert("제품명이 비어있거나 최대 글자수를 초과했습니다.");
        }else if(product_code.value == ""){
        	alert("제품코드가 비어있습니다. 중복확인 후 입력해주세요.");
        }else if(product_content.value.length > 300 || product_content.value.length == 0){
    		alert("제품 설명은 빈칸일 수 없고 300글자 이내만 가능합니다.");
    		return;
    	}else if(!regexPrice.test(price.value) || price.value > 99999999){
    		alert("가격은 비어있거나 천만 단위를 초과할 수 없고 숫자만 가능합니다.");
    		return;
    	}else if(!regexDiscount.test(discount.value) || discount.value > 100){
    		alert("할인율이 비어있거나 0~100까지의 숫자만 가능합니다.");
    		return;
    	}else if(file1 == ""){
    		alert("제품 이미지를 등록해주세요.");
    		return;
    	}else if(file2 == ""){
    		alert("제품 상세 이미지를 등록해주세요.");
    		return;
    	}else if($("#product_category").val() == "--- 선택 ---" || $("#detail_category").val() == null){
    		alert("카테고리가 선택되지 않았습니다.");
    	}else{
    		document.getElementById("insertForm").submit();
    	}
    })	
	</script>
</body>
</html>