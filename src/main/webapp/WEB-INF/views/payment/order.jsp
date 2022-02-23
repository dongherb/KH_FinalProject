<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>주문하기</title>
<!-- 부트페이 CDN -->     
<script src="https://cdn.bootpay.co.kr/js/bootpay-3.3.2.min.js" type="application/javascript"></script>
</head>
<style>
#usePoint {
	width: 100%;
}

.orderDetailContainer {
	margin-top: 80px;
}

.detail-title{
	margin-bottom:20px;
}

h3 {
	padding-bottom: 10px;
	border-bottom: 1px solid rgba(128, 128, 128, 0.487);
	font-weight: bold;
}

.orderContainer > .row{
padding-top: 10px;
}

.order-title{
	font-size:15px;
	font-weight: 600;
	text-align: left;
	border-right : 1px solid #dbdbdb;
	padding-left : 10px;
}

.order-content{
	font-size:13px;
}

.addressModifyDiv {
	padding-top: 10px;
}

.addressModifyDiv .col {
	padding-top: 10px;
}

.phoneModifyDiv {
	padding-top: 10px;
}

.phoneModifyDiv .col {
	padding-top: 10px;
}

.inputPhoneDiv {
	padding-top: 10px;
}

.memberContainer .row {
	padding-top: 10px;
}

.orderHeader {
	border-bottom: 1px solid #dbdbdb;
	text-align:left;
	font-size: 16px;
	font-weight: bolder;
	padding-top: 5px;
	padding-bottom: 5px;
}

.orderBody {
	border-bottom: 1px solid #dbdbdb;
}

.quantity, .price, .point, .totalPrice {
	padding-top: 45px;
}

#ableUsePoint {
	color: grey;
	font-size: 90%;
}

#infoPoint {
	color: grey;
	font-size: 13px;
}

img {
	height: 100px;
	width: 100px;
	margin:10px;
}

#orderPrice {
	padding: 10px;
	height: 130px;
	overflow: hidden;
}

#finalPriceText {
	border: 2px solid grey;
	text-align: center;
	font-size: 20px;
	font-weight: bolder;
	color: red;
	margin: auto;
}

.payInfo {
	text-align: center;
	font-size: 15px;
	margin-bottom: 150px;
}

#payBtn {
	border: none;
	background-color: #c9425f;
	color: white;
	width: 150px;
	height: 50px;
	font-size: 20px;
}
</style>
<body>
	<%@include file="../header.jsp" %>
	
	<!-- 주문 상세 내역 -->
	<div class="container orderDetailContainer">
		<div class="row detail-title">
			<div class="col">
				<h3>주문 상세 내역</h3>
			</div>
		</div>
		<div class="row orderHeader">
			<div class="col-6">상품/옵션 정보</div>
			<div class="col-1">수량</div>
			<div class="col-2">상품 금액</div>
			<div class="col-2">예상 적립 포인트</div>
			<div class="col-1">합계 금액</div>
		</div>
		
	 <c:forEach items="${list}" var="order">
		<div class="row orderBody">
			<div class="col-6">
				<c:forEach items="${product_list}" var="product">
                	<c:if test="${order.product_code eq product.product_code}">
					<img src = "${pageContext.request.contextPath}/product_img/${product.product_img}" height = "100%">
						<c:choose>
                			<c:when test = "${order.color eq 'undefined'}">
									<span>${product.product_name} / ${order.cloth_size}mm </span>
                			</c:when>
                			<c:otherwise>
								<span>${product.product_name} / ${order.color} / ${order.cloth_size} </span>
                			</c:otherwise>
                		</c:choose>
                	</c:if>
                </c:forEach>
			</div>
			<div class="col-1 quantity">
				<span>${order.quantity}개</span>
			</div>
			<div class="col-2 price">
				<c:forEach items="${product_list}" var="product">
               		 <c:if test="${order.product_code eq product.product_code}">
                	<span>
                		${Math.round(product.price - ((product.discount/100) * product.price))}원
                	</span>
                </c:if>
              </c:forEach>
			</div>
			
			<div class="col-2 point">
				<c:forEach items="${product_list}" var="product">
               		 <c:if test="${order.product_code eq product.product_code}">
                	<span>
                		${Math.round(order.quantity * Math.round(product.price - ((product.discount/100) * product.price)) / 2)}포인트
                	</span>
                </c:if>
              </c:forEach>
			</div>
			<div class="col-1 totalPrice">
				<c:forEach items="${product_list}" var="product">
               		 <c:if test="${order.product_code eq product.product_code}">
                	<span>
                		${order.quantity * Math.round(product.price - ((product.discount/100) * product.price))}원
                	</span>
                </c:if>
              </c:forEach>
			</div>
		</div>
	</c:forEach>
	<br>
	<div class="row orderFooter">
		<div class="col" style="text-align: right;">
			<a style="text-decoration: none;" href="${pageContext.request.contextPath}/order/toBasket">
			<button type="button" class="btn btn-dark">장바구니 확인</button></a>
		</div>
	</div>
	
	<!--
	<div class="row orderPrice">
		<div class="col">
			<textarea class="form-control" style=resize:none; id="orderPrice" readonly></textarea>
		</div>
	</div>
	</div>
 -->	
 
 </div>		
	<br>
	<br>

	<!-- 주문자 정보 -->
	 <div class="container memberContainer">
        <h3>주문자 정보</h3>
        <div class="row">
            <div class="col-2 order-title">주문하시는 분</div>
            <div class="col-10 order-content">${loginSession.name}</div>
        </div>

        <div class="row">
            <div class="col-2 order-title">주소</div>
            <div class="col-10 order-content">${loginSession.address}</div>
        </div>
        
        <div class="row">
        	<div class="col-2 order-title">연락처</div>
        	<div class="col-10 order-content">${loginSession.phone}</div>
        </div>
        
        <div class="row">
        	<div class="col-2 order-title">이메일</div>
        	<div class="col-10 order-content">${loginSession.email}</div>
        </div>
       </div>
       <br>
       <br>
        
    <!-- 배송지 정보 -->
	<div class="container deliveryContainer">
		<h3>배송지 정보</h3>
		<br>
		<div class="row">
			<div class="col-2 order-title">받으실 분</div>
			<div class="col-2  order-content">
				<input type="text" class="form-control form-control-sm" id="receiverName" value ="${loginSession.name}">
			</div>
		</div>
		<br>

		<div class="row rowBorder">
						<div class="col-2 order-title">주소</div>
						<div class="col myInfoContent">
							
							<div class="row">
								<div class="col deliveryAddr"><input name="address" id="address" class="form-control form-control-sm" value="${loginSession.address}" disabled></div>
								<div class="col">
									<button type="button" class="btn btn-outline-primary btn-sm" id="addressModifyBtn">배송지 수정</button>
									<button type="button" class="btn btn-outline-secondary btn-sm" id="addressCancelBtn" style="display: none">취소</button>
								</div>
							</div>
							<div class="row addressModifyDiv" style="display: none">
								<div class="col col-6">
									<input type="text" class="form-control form-control-sm" id="postCode" placeholder="우편번호" disabled>
								</div>
								<div class="col col-6">
									<input type="button" class="btn btn-outline-primary btn-sm" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
								</div>
								
								<div class="col col-12">
									<input type="text" class="form-control form-control-sm" id="roadAddr" placeholder="도로명주소" disabled>
								</div>
								
								<div class="col col-12">
									<span id="guide" style="color:#999;display:none"></span>
									<input type="text" class="form-control form-control-sm" id="detailAddr" placeholder="상세주소">
								</div>
								
								<div class="col col-6">
									<button type="button" class="btn btn-primary btn-sm" id="inputAddressBtn">입력하기</button>
								</div>
							</div>
						</div>
					</div>
				<br>	
		<div class="row">
			<div class="col-2">연락처</div>
			<div class="col-3"><input type="text" id="phone" class="form-control form-control-sm" value="${loginSession.phone}" disabled></div>
			<div class="col-2">
				<button type="button" class="btn btn-outline-primary btn-sm" id="phoneModifyBtn">연락처 수정</button>
				<button type="button" class="btn btn-outline-secondary btn-sm" id="phoneCancelBtn" style="display: none">취소</button>
			</div>
			
			<div class="row phoneModifyDiv" style="display:none">
			<div class="col-2"></div>&nbsp;
			<div class="col-3">
				<select class="form-select form-select-sm" id="phone1">
					<option value="010">010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="018">018</option>
					<option value="019">019</option>
				</select>		
			</div>
			<div class="col-3">
				<input type="text" onKeyPress="return checkNum(event)" class="form-control form-control-sm" maxlength ="4" id="phone2">
			</div>
			
			<div class="col-3">
				<input type= "text" onKeyPress="return checkNum(event)" class="form-control form-control-sm" maxlength="4" id="phone3">
			</div>
			
			<div class="row inputPhoneDiv">
				<div class="col-2"> </div> &nbsp;
				<div class="col-3">
					<button type="button" class="btn btn-primary btn-sm" id="inputPhoneBtn">입력하기</button>
				</div>
			</div>
			
			<div class="col-1 d-none">
				<input type="text" class="form-control form-control-sm" id="phoneNew">
			</div>
		</div>
		</div>
	</div>
	
     <br>
     <br>
     
	<!-- 결제 정보 -->
	 <div class="container orderContainer">
        <h3>결제정보</h3>
        <div class="row">
             <div class="col-2 order-title">상품 합계 금액</div>
            <div class="col-10 order-content">
                	<span id="totalPrice"></span>
            </div>
        </div>

        <div class="row">
             <div class="col-2 order-title">배송비</div>
            <div class="col-10 order-content" id="deliveryPrice"></div>
        </div>

        <div class="row">
              <div class="col-2 order-title">포인트 사용
            <br>
             <span id="ableUsePoint">가용 포인트: ${loginSession.extra_point}</span>
            </div>
            	
            <div class="col-2">
                <input type="text" onKeyPress="return checkNum(event)" class="form-control  form-control-sm" id="usePoint">
            	<span id="infoPoint">※ 포인트 사용 시 포인트는 &nbsp; 적립되지 않습니다.</span>
            </div>
        </div>

        <div class="row">
  			 <div class="col-2 order-title">최종 결제 금액</div>
            <div class="col-10 order-content" id="finalPrice"></div>
        </div>
        <br>
        
        <div class="row" style="margin-top:30px; margin-bottom:30px;">
        	<div class="col form-control form-control-lg" id="finalPriceText"></div>
        </div>
    </div>
    <br>
    
    <div class="row payInfo">
    	<div class="col-12">
    		<input type="checkbox" id="payInfo">(필수) 구매하실 상품의 결제정보를 확인하였으며, 구매진행에 동의합니다.
    	</div>
    	<br>
    	<div class="col-12" style="margin-top: 50px;">
    		<button type="button" id="payBtn">결제하기</button>
    	</div>
    </div>
    
    <%@include file="../footer.jsp" %>
    
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
			// 카카오 주소
				function sample4_execDaumPostcode() {
					new daum.Postcode({
					oncomplete: function (data) {
					let roadAddr = data.roadAddress; // 도로명 주소 변수
					let extraRoadAddr = ''; // 참고 항목 변수

					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraRoadAddr !== '') {
						extraRoadAddr = ' (' + extraRoadAddr + ')';
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById("postCode").value = data.zonecode;
					document.getElementById("roadAddr").value = roadAddr;
				}
			}).open();
		}
	</script>
   
   <script>
   
   // 소수점 및 문자 입력 막기
   function checkNum(e) {
       var keyVal = event.keyCode;
       if(((keyVal >= 48) && (keyVal <= 57))){
           return true;
       }
       else{
           alert("숫자만 입력가능합니다");
           return false;
       }
   }
   
   // 주소 수정하기 버튼 클릭
   $("#addressModifyBtn").on("click", function(){
			$("#addressModifyBtn").css("display", "none");
			$("#addressCancelBtn").css("display", "block");
			$(".addressModifyDiv").css("display", "inline-flex");
		});
   
	// 주소 취소 버튼 클릭 시
	$("#addressCancelBtn").on("click", function(){
		$("#addressModifyBtn").css("display", "block");
		$("#addressCancelBtn").css("display", "none");
		$(".addressModifyDiv").css("display", "none");
	});
	
	// 주소 입력하기 클릭 시
	$("#inputAddressBtn").on("click", function(){
		if($("#postCode").val() == ""){
			alert("우편번호를 선택해주세요.");
			return;
		}
		else if($("#detailAddr").val() == ""){
			alert("상세주소를 입력해주세요.");
			return;
		}
		
		// 주소를 input address에 담기
		$("#address").val( $("#postCode").val() +" "+ $("#roadAddr").val() +" "+ $("#detailAddr").val());
		
		// 주소div 닫기
		$("#addressModifyBtn").css("display", "block");
		$("#addressCancelBtn").css("display", "none");
		$(".addressModifyDiv").css("display", "none");
		
		// 초기화
		$("#postCode").val("");
		$("#roadAddr").val("");
		$("#detailAddr").val("");
		alert("배송지가 수정되었습니다.");
	})
	
	// 연락처 수정 버튼 클릭 시
	$("#phoneModifyBtn").on("click",function(){
		$("#phoneModifyBtn").css("display","none");
		$("#phoneCancelBtn").css("display","block");
		$(".phoneModifyDiv").css("display","inline-flex");
	})
	
	// 연락처 수정 취소 버튼 클릭 시
	$("#phoneCancelBtn").on("click", function(){
		$("#phoneModifyBtn").css("display", "block");
		$("#phoneCancelBtn").css("display", "none");
		$(".phoneModifyDiv").css("display", "none");
	});
	
	// 연락처 입력하기 클릭 시
	$("#inputPhoneBtn").on("click",function(){
		if($("#phone2").val()==""){
			alert("연락처를 올바르게 입력해주세요.");
			return;
		}else if($("#phone3").val()==""){
			alert("연락처를 올바르게 입력해주세요.");
			return;
		}else if(isNaN($("#phone2").val())){
			alert("연락처를 올바르게 입력해주세요.");
			$("#phone2").val("");
			$("#phone3").val("");
			return;
		}else if(isNaN($("#phone3").val())){
			alert("연락처를 올바르게 입력해주세요.");
			$("#phone2").val("");
			$("#phone3").val("");
			return;
		}
		
		// 연락처를 phone에 담기
		$("#phone").val($("#phone1").val() + " " + $("#phone2").val() + " " + $("#phone3").val());
		
		// 연락처 div 닫기
		$("#phoneModifyBtn").css("display", "block");
		$("#phoneCancelBtn").css("display", "none");
		$(".phoneModifyDiv").css("display", "none");
		alert("연락처가 수정되었습니다.");
	});
	
   // 가격 정보
   let totalPrice = ${totalPrice};
   $("#totalPrice").html(totalPrice);
   
   let deliveryPrice = 2500;
   $("#deliveryPrice").html(deliveryPrice);
   
   let finalPrice = totalPrice + deliveryPrice;
   $("#finalPrice").html(finalPrice);
   
   $("#orderPrice").html(" 상품 합계 금액 : " + totalPrice + "원\n 배송비 : " + deliveryPrice + "원\n 적립 예정 포인트 : " + totalPrice/2 + "포인트\n 총 결제 금액 : " + finalPrice + "원");
   $("#finalPriceText").html("최종 결제 금액 : " + finalPrice + "원");

   // 포인트 사용 입력창 변화 생겼을 때 처리
   $("#usePoint").change(function(){
	   if(isNaN($("#usePoint").val())){
		    alert("숫자만 입력가능합니다");
			$("#usePoint").val("");
		   return;
	   }
	   
	   if($("#usePoint").val() > ${loginSession.extra_point}){
			alert("잔여 포인트를 초과한 포인트를 사용할 수 없습니다.");
			$("#usePoint").val("");
			return;
			}else if($("#usePoint").val() > (totalPrice/2)){
			alert("상품 가격의 50%를 초과하는 포인트는 사용할 수 없습니다.");
			$("#usePoint").val("");
			return;
			}else if ($("#usePoint").val() < 10){
                alert("최소 10포인트 이상을 입력해주세요.");
                $("#usePoint").val("");
                return;
            }
	   
	   finalPrice = totalPrice + deliveryPrice - $("#usePoint").val();
	   $("#finalPrice").html(finalPrice);
	   $("#orderPrice").html(" 상품 합계 금액 : " + totalPrice + "\n 배송비 : " + deliveryPrice + "\n 적립 예정 포인트 : " + totalPrice/2 + "\n 총 결제 금액 : " + finalPrice);
	   $("#finalPriceText").html("최종 결제 금액 : " + finalPrice + "원");
   });
   
 	// 결제 부분 스크립트 코드
	// 실제 복사하여 사용시에는 모든 주석을 지운 후 사용하세요
	// 결제하기 버튼 누를 때 실행 결제API 실행
	$("#payBtn").on("click",function(){
		let address = document.getElementById("address");
		let phone1 = document.getElementById("phone1");
		let phone2 = document.getElementById("phone2");
		let phone3 = document.getElementById("phone3");
		let phone = document.getElementById("phone");
		let use_point = $("#usePoint").val();

		 // 이름 및 연락처 값이 비어있을 때 안 넘어가게끔
		   if($("#receiverName").val() == ""){
			   alert("받으실 분의 성함을 작성해주세요.");
			   return;
		   }
		 
		// 포인트 입력칸이 공백일 때 0으로 초기화
		if(use_point == ""){
			use_point = 0;
		}
		
		// 동의 체크 여부
		if(!$("#payInfo").is(":checked")){
			alert("동의 여부를 체크해주세요");
			return;
		}    
		
		// 포인트 사용시 조건
		if(use_point > ${loginSession.extra_point}){
			alert("잔여 포인트를 초과한 포인트를 사용할 수 없습니다.");
			return;
		}else if(use_point > (totalPrice/2)){
			alert("상품 가격의 50%를 초과하는 포인트는 사용할 수 없습니다.");
			return;
		}else if(use_point == 0 ){
			alert("포인트 미사용시 상품 금액의 50%가 적립됩니다.");
		}else if(use_point < 0 ){
			alert("올바른 포인트를 입력해주세요.");
			return;
		}else if(use_point < 10){
			alert("최소 10포인트 이상의 포인트를 입력해주세요.");
			return;
		}

		BootPay.request({
			price: finalPrice,//실제 결제되는 가격 (상품가격으로 표시)
			application_id: "61dd7a62e38c3000287b78e1",
			name: 'Mood&Style 의류', //결제창에서 보여질 이름
			pg: 'inicis',
			method: 'card', //결제수단, 입력하지 않으면 결제수단 선택부터 화면이 시작합니다.
			show_agree_window: 0, // 부트페이 정보 동의 창 보이기 여부
			items: [
				{
					item_name: '사과', //상품명
					qty: 1, //수량
					unique: '123', //해당 상품을 구분짓는 primary key
					price: 1000 //상품 단가
				}
			],
			
			order_id: 'order_1234' //고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
		}).error(function (data) {
			//결제 진행시 에러가 발생하면 수행됩니다.
			console.log(data);
		}).cancel(function (data) {
			//결제가 취소되면 수행됩니다.
			console.log(data);
		}).close(function (data) {
		    // 결제창이 닫힐때 수행됩니다. (성공,실패,취소에 상관없이 모두 수행됨)
		    console.log(data);
		}).done(function (data) {
			//결제가 정상적으로 완료되면 수행됩니다
			//비즈니스 로직을 수행하기 전에 결제 유효성 검증을 하시길 추천합니다.
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/pay/paySuccess",
				data:{
					"order_id" : data.order_id,
					"use_point" : use_point,
					"pay_type" : data.method,
					"pg_type" : data.pg,
					"origin_price" : Number(finalPrice) + Number(use_point), // 상품 가격 + 배송비
					"real_price" : finalPrice, // 사용한 포인트만큼 제외한 실제 결제 금액
					"card_name" : data.card_name,
					"card_code" : data.card_code,
					"deliveryAddr" : address.value,
					"phone" : phone.value
				}
			}).done(function(result){
				if(result =="success"){
					location.href="${pageContext.request.contextPath}/pay/Success";
				}else if(result=="fail"){
					location.href="${pageContext.request.contextPath}/payment/payFail";
				}
			}).fail(function(error){
				
			})
			console.log(data);
		});	
	})
    </script>
</body>
</html>