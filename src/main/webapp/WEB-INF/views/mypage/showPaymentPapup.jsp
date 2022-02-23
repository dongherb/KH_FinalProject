<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<!-- 폰트 시작 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&display=swap" rel="stylesheet">
<!-- 폰트 끝 -->
	<meta charset="UTF-8">
	<title>결제정보</title>
	
	<style>

		.headerContainer{
			height: 20px;
			background-color: rgb(230, 230, 230);
		}
		.footerContainer{
			height: 80px;
			background-color: rgb(230, 230, 230);
		}
		
		.orderInfoContainer .logoImgDiv{
			text-align: center;
			margin-bottom: 25px;
		}
		.orderInfoContainer h3{
			border-bottom: 1px solid gray;
			padding-bottom: 10px;
			margin-bottom: 20px;
		}
		
		.orderInfoContainer .productInfoContainer{
			padding: 10px;
			margin: 5px;
			border: 1px solid rgb(230, 230, 230);
		}
		.orderInfoContainer .productInfoContainer img{
			width: 100%;
			height: 100px;
		}
		.orderInfoContainer .orderQuantityDiv{
			font-size: bold;
			text-align: right;
		}
		
		.orderInfoContainer .payInfoContainer{
			border: 1px solid rgb(230, 230, 230);
			padding: 5px;
			margin-bottom: 10px;
		}
		.orderInfoContainer .payInfoContainer .payInfoThead{
			font-weight: bold;
			border-bottom: 1px solid rgb(220, 220, 220);
		}
		.orderInfoContainer .finalPaymentDiv {
			margin-top: 30px;
			margin-bottom: 10px;
			text-align: right;
		}
		
		.orderInfoContainer .closeBtnDiv{
			margin-bottom: 30px;
			text-align: right;
		}
	.logoImgDiv >.top-header-font {
	font-family: 'Abril Fatface', cursive;
	font-size: 40px;
	text-align: center;
	margin:10px;
}	
		
	</style>
	
</head>
<body>

	<c:if test="${done eq 'fail'}">
		<script>
			alert("결제정보가 없습니다.");
			window.close();
		</script>
	</c:if>
	
	<div class="container-fluid headerContainer"></div>
	
	<div class="container orderInfoContainer">
	
		<div class="row logoImgDiv">
			<div class="col top-header-font">
				Mood & Style
			</div>
		</div>
		
		<div class="row">
			<div class="col">
				<h3>${loginSession.id}님의 주문정보_ ${orderInfoList.get(0).pay_date}</h3>
			</div>
		</div>
		
		<!-- 함께 결제한 제품들 -->
		<c:forEach items="${orderInfoList}" var="orderInfo">
			<div class="row productInfoContainer">
		
				<div class="d-none d-sm-block col-sm-3">
					<c:choose>
                        <c:when test="${orderInfo.product_name ne null}">
                            <img src="${pageContext.request.contextPath}/product_img/${orderInfo.product_img}">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/resources/images/noImg.png">
                        </c:otherwise>
                    </c:choose>
				</div>
				
				<div class="col-10 col-sm-7">
					<div class="row">
						<div class="col">
							<c:choose>
								<c:when test="${orderInfo.product_name ne null}">
									<span style="font-size: 1.1rem; font-weight: bold;">${orderInfo.product_name}</span>
									<span style="font-size: 0.8rem;"> / ${orderInfo.product_category} / ${orderInfo.detail_category}</span>
								</c:when>
								<c:otherwise>
									<span style="font-size: 1.1rem; font-weight: bold;">삭제된 제품</span>
									<span style="font-size: 0.8rem;"> / 카테고리 정보없음</span>
								</c:otherwise>
							</c:choose>
							
						</div>
					</div>
					
					<div class="row" style="font-size: 0.7rem;">
						<div class="col">
							<c:choose>
								<c:when test="${orderInfo.color eq 'undefined'}">
									${orderInfo.cloth_size}mm
								</c:when>
								<c:otherwise>
									${orderInfo.cloth_size} / ${orderInfo.color}
								</c:otherwise>
							</c:choose>
						</div>
					</div>
					
					<div class="row"><br></div>
					
					<div class="row">
						<div class="col" style="font-size: 0.8rem;">
							<c:choose>
								<c:when test="${orderInfo.product_name ne null}">
									⭐ ${String.format("%.2f", orderInfo.avg_score)} (${orderInfo.review_count})
								</c:when>
								<c:otherwise>
									별점정보 없음
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				
				<div class="col orderQuantityDiv">
					${orderInfo.quantity}개
				</div>
				
			</div>
		</c:forEach>
		
		
		<div class="row" style="margin-top: 80px;">
			<div class="col">
				<h3>결제정보</h3>
			</div>
		</div>

		<div class="row payInfoContainer">
			<div class="col">

				<div class="row payInfoThead">
					<div class="col">상품(들)가격</div>
					<div class="col">배송금</div>
					<div class="col">포인트할인</div>
					<div class="col">결제한 금액</div>
				</div>
				<div class="row  payInfoTbody">
					<div class="col">${orderInfoList.get(0).origin_price - 2500}원</div>
					<div class="col">2500원</div>
					<div class="col">
						<c:choose>
							<c:when test="${orderInfoList.get(0).use_point eq 0}">
								<span style="color: gray;">없음</span>
							</c:when>
							<c:otherwise>
								- ${orderInfoList.get(0).use_point}원
							</c:otherwise>
						</c:choose>
					</div>
					<div class="col">${orderInfoList.get(0).real_price}원</div>
				</div>
			
			</div>
		</div>
		
		<div class="row">
			<div class="col">
				<span style="font-size: 0.7rem;"><strong>배송주소: </strong> ${orderInfoList.get(0).deliveryAddr}</span>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<span style="font-size: 0.7rem;"><strong>연락처: </strong> ${orderInfoList.get(0).phone}</span>
			</div>
		</div>
		
		<div class="row">
			<div class="col finalPaymentDiv">
				<h2>총 결제금: ${orderInfoList.get(0).real_price} 원</h2>
			</div>
		</div>
		
		<div class="row closeBtnDiv">
			<div class="col">
				<button type="button" class="btn btn-secondary btn-sm" id="closeBtn">닫기</button>
			</div>
		</div>

	</div>

	<div class="container-fluid footerContainer"></div>

	<script>
	
		// 닫기버튼 클릭 시
		$("#closeBtn").on("click", function(){
			window.close();	
		})
		
	
	</script>

</body>
</html>