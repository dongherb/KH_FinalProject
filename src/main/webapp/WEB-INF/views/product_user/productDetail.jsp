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
	<title>상품페이지</title>
	
	<style>
		/* 제품메인 */
		.productDetailContainer{
			margin-top: 50px;
		}
		.productDetailContainer .productMainImgDiv{
			height: 500px;
		}
		.productMainImgDiv img{
			height: 500px;
			width: 100%;
			border-radius: 20px; 
		}
		.productMainSettingDiv{
			padding-left: 50px;
			padding-bottom: 70px;
		}
		.productDetailContainer .productTitleName{
			margin-top: 15px;
		}
		.productDetailContainer .productSettingInput{
			width: 70%;
		}
		.productDetailContainer .productContentDiv{
			margin-top: 20px;
		}
		
		
		/* 상세설명 */
		.productDetailContent{
			margin-top: 80px;
			margin-bottom: 100px;
			padding-top: 60px;
			border-top: 2px solid rgb(200, 200, 200);
		}
		.productDetailContent .detailHeader{
			border-radius: 7px;
			padding: 10px;
			background-color: rgb(230, 230, 230);
		}
		.productDetailContent .mainDetailContainer{
			margin-top: 30px;
		}
		
		.productDetailContent #boughtAges{
			margin-top: 70px;
			margin-bottom: 20px;
		}
		.productDetailContent #boughtAgesContainer{
			border-radius: 10px;
			background-color: white;
			padding: 20px;
			box-shadow: 1px 1px 1px 1px rgb(150, 150, 150);
		}
		.productDetailContent .boughtImgDiv{
			padding: 20px;
		}
		.productDetailContent .boughtImgDiv img{
			height: 100%;
			width: 100%;
		}
		.productDetailContent .boughtAgesContentsTitle{
			margin-bottom: 10px;
		}
		.productDetailContent .boughtAgesContents{
			padding: 1px;
		}
		.productDetailContent .boughtAgesTitle{
			text-align: center;
		}
		.productDetailContent .boughtBars{
			background-color: rgb(50, 150, 250);
			border-radius: 20px;
		}
		
		.productDetailContent #recommendedProductTitle{
			margin-top: 70px;
			margin-bottom: 20px;
		}
		
		.productDetailContent .recommendedProductDiv{
			cursor: pointer;
			opacity: 0.85;
			transition: 0.3s;
		}
		.recommendedProductDiv:hover{
			opacity: 1;
			transform: scale(1.02);
		}
	
	
		/* 리뷰쪽 */
		.productReviewContainer{
			margin-top: 80px;
			padding-bottom: 1px;
		}
		.productReviewContainer .reviewHeader{
			border-radius: 7px;
			padding: 10px;
			background-color: rgb(230, 230, 230);
		}
		.productReviewContainer .reviewInfo{
			margin-bottom: 50px;
		}
		.productReviewContainer .reviewImgDiv img{
			width: 100%;
			height: 100%;
			border-radius: 30px;
			padding-top: 15px;
			padding-left: 15px; 
			padding-right: 15px;
		}
		.productReviewContainer .reviewContentDiv{
			font-size: 1rem;
			padding-top: 10px;
		}
		.productReviewContainer .reviewContainer{
			border-bottom: 1px solid rgb(200, 200, 200);
			padding-bottom: 15px;
		}
		
		
		.starPointImgDiv img{
			width: 15px;
			height: 15px;
		}
		.productReviewContainer #reviewPageNavi{
			margin-top: 50px;
			margin-bottom: 30px;
		}
		
		#backShopBtnDiv{
			margin-bottom: 100px;
			text-align: right;
		}
	
	</style>
</head>
<body>

	<c:choose>
		<c:when test="${done eq 'done'}">
			<script>
				alert("요청완료");
			</script>
		</c:when>
		<c:when test="${done eq 'fail'}">
			<script>
				alert("요청실패");
			</script>		
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>

	<!-- 헤더 -->
	<%@include file="../header.jsp" %>
	<!-- 사이드바 -->
	<%@include file="../sideBar.jsp" %>
	
	<div class="container productDetailContainer">
		
		<!-- 제품 메인정보와 기본주문설정 -->
		<div class="row">
			<!-- 주요내용 -->
			<div class="d-sm-none d-lg-block col-lg-1"></div>
			
			<!-- 이미지 -->
			<div class="col productMainImgDiv">	
				<img src="${pageContext.request.contextPath}/product_img/${product.product_img}">
			</div>
			
			<div class="col productMainSettingDiv">	
			
				<div class="row productContentDiv">	<!-- 제품이름 -->
					<div class="col productTitleName"><span style="font-size: 2.5rem;">${product.product_name}</span> / ${product.product_category} / ${product.detail_category}</div>	
				</div>
				<div class="row" style="font-size: 1.25rem;">
					<c:choose>
						<c:when test="${product.avg_score eq 0}">
							<div class="col" style="color: gray;">별점없음</div>
						</c:when>
						<c:otherwise>
							<div class="col">⭐ ${String.format("%.2f", product.avg_score)}</div>
						</c:otherwise>
					</c:choose>
				</div>
				
				<div class="row productContentDiv">	<!-- 제품가격 -->
					<div class="col">
						<c:choose>
						
							<c:when test="${product.discount ne 0}">
								<div class="row">
									<div class="col-4">
										<span style="font-weight: bold; font-size: 1.8rem"> ${Math.round( product.price - (product.price * (product.discount / 100)) )}원 </span>
										
									</div>
									<div class="col" style="color: rgb(255,100,100)">
										<span style="font-size: 2rem;"> ${product.discount}%&nbsp;</span>SALE
									</div>
								</div>
								<div class="row">
									<div class="col">
										&nbsp;<span style="text-decoration: line-through; font-size: 1.3rem; color: gray;">${product.price}원</span>
									</div>
								</div>
							</c:when>
							
							<c:otherwise>
								<span style="font-weight: bold; font-size: 1.8rem">${product.price}원</span>
							</c:otherwise>
							
						</c:choose>
					</div>
				</div>
				
				
				<!-- 색상 -->	<!-- 신발일 경우 색상선택 없음 -->
				<c:choose>	
					<c:when test="${product.product_category eq '신발'}">
						<div class="row productContentDiv">	<!-- color -->
							<br><br>
						</div>
					</c:when>	
					<c:otherwise>
						<div class="row productContentDiv">	<!-- color -->
							<div class="col-6">
								<label>색상</label>
								<select class="form-select productSettingInput" id="color">
									<option value="-1" selected>--</option>	<!-- 드롭다운으로 구성 -->	<!-- 제품입력에서 radio 박스로 설정하면 좋을듯 -->
									<option value="화이트">화이트</option>	
									<option value="블랙">블랙</option>
									<option value="다크그린">다크그린</option>
									<option value="레드">레드</option>
									<option value="그레이">그레이</option>
									<option value="아이보리">아이보리</option>
									<option value="카키">카키</option>
									<option value="챠콜">챠콜</option>
									<option value="스카이블루">스카이블루</option>
									<option value="베이직">베이직</option>
								</select>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
					
				<!-- 사이즈 --><!-- 신발일 경우 달라짐 -->
				<c:choose>	
				
					<c:when test="${product.product_category eq '신발'}">		
						<div class="row">	<!-- 제품 사이즈 --><!-- cloth_size -->
							<div class="col-6">
								<label>사이즈</label>
								<select class="form-select productSettingInput" id="cloth_size">
								
									<option value="-1" selected>--</option>	<!-- 드롭다운으로 구성 --> 
									<c:forEach var="i" begin="230" end="300">
										<c:if test="${(i % 5) eq 0}">	<!-- 10의 배수만 -->
											<option value="${i}">${i}</option>
										</c:if>
									</c:forEach>
									
								</select>
							</div>
						</div>
					</c:when>
					
					<c:otherwise>
						<div class="row">	<!-- 제품 사이즈 --><!-- cloth_size -->
							<div class="col-6">
								<label>사이즈</label>
								<select class="form-select productSettingInput" id="cloth_size">
									<option value="-1" selected>--</option>	<!-- 드롭다운으로 구성 --> 
									<option value="S">S</option>
									<option value="M">M</option>
									<option value="L">L</option>
									<option value="XL">XL</option>
								</select>
							</div>
						</div>
					</c:otherwise>
					
				</c:choose>
				
				
				<div class="row">	<!-- 제품수량 --><!-- quantity -->
					<div class="col-6">
						<label>수량</label>
						<input type="number" id="quantity" class="form-control productSettingInput" step="1" value="1" min="1" max="99">
					</div>
				</div>
				
				<div class="row productContentDiv">	<!-- 상호작용 버튼들 -->
					<div class="col">
						<button type="button" class="btn btn-warning" id="orderProductBtn">구매하기</button>
						<button type="button" class="btn btn-secondary" id="toBasketBtn">장바구니 담기</button>
					</div>
				</div>
				
			</div>
			
			<div class="d-sm-none d-lg-block col-lg-1"></div>
		</div>

		
		<!-- 상품상세페이지 -->
		<div class="row productDetailContent">
			<div class="d-sm-none d-lg-block col-lg-1"></div>
			
			<div class="col">
				<div class="row detailHeader"><h2>상세설명</h2></div>
				
				<div class="row">
					<div class="d-sm-none d-lg-block col-lg-1"></div>
					
					<!-- 제품에 대한 상세 설명을 담는 곳 -->
					<div class="col mainDetailContainer">
						<div class="row">
							<img src="${pageContext.request.contextPath}/product_img/${product.detail_img}">
						</div>
						<div class="row">
							<div class="col">${product.product_content}</div>
						</div>

					</div>
					
					<div class="d-sm-none d-lg-block col-lg-1"></div>
				</div>
				
				<!-- 구매자가 있을경우 -->
				<c:if test="${!buyerAgeList.isEmpty()}">	
					<!-- 구매자 나이 통계 -->
					<div class="row" id="boughtAges">
						<div class="col"><h3>구매자 나이 통계</h3></div>
					</div>
					
					<!-- 통계내용 -->
					<div class="row" style="background-color: rgb(245, 245, 245); padding:5px; padding-top: 20px; padding-bottom: 20px; border-radius: 10px;">
						<div class="d-sm-none d-lg-block col-lg-1"></div>
						
						<div class="d-none d-sm-none d-lg-block col-lg-3 boughtImgDiv">
							<img src="${pageContext.request.contextPath}/resources/images/smile.png">
						</div>
						
						<div class="d-sm-none d-lg-block col-lg-1"></div>
						
						<div class="col" id="boughtAgesContainer">
							
							<div class="row boughtAgesContents boughtAgesContentsTitle">
								<div class="col-2" style="font-weight: bold; margin-bottom: 10px; font-size: 1.2rem"> 연령 </div>
								<div class="col" id="totalBuyerCount" style="font-size: 0.8rem; text-align: right"> 총 ${totalCount} 명</div>
							</div>
							
							<div class="row boughtAgesContents"> <!-- ~18 -->
								<div class="col-4 boughtAgesTitle"> ~ 18세</div>
								<div class="col-7">
									<div class="row progress">
									  	<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${agePercents[0]}%" aria-valuenow="${agePercents[0]}" aria-valuemin="0" aria-valuemax="100">
											<c:choose>
												<c:when test="${agePercents[0] ne 0}">
													<span style="font-weight: bold;">${agePercents[0]}%</span>
												</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row boughtAgesContents"> <!-- 19~23 -->
								<div class="col-4 boughtAgesTitle">19~23세</div>
								<div class="col-7">
									<div class="row progress">
									  	<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${agePercents[1]}%" aria-valuenow="${agePercents[1]}" aria-valuemin="0" aria-valuemax="100">
											<c:choose>
												<c:when test="${agePercents[1] ne 0}">
													<span style="font-weight: bold;">${agePercents[1]}%</span>
												</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row boughtAgesContents"> <!-- 24~28 -->
								<div class="col-4 boughtAgesTitle">24~28세</div>
								<div class="col-7">
									<div class="row progress">
									  	<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${agePercents[2]}%" aria-valuenow="${agePercents[2]}" aria-valuemin="0" aria-valuemax="100">
											<c:choose>
												<c:when test="${agePercents[2] ne 0}">
													<span style="font-weight: bold;">${agePercents[2]}%</span>
												</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row boughtAgesContents"> <!-- 29~33 -->
								<div class="col-4 boughtAgesTitle">29~33세</div>
								<div class="col-7">
									<div class="row progress">
									  	<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${agePercents[3]}%" aria-valuenow="${agePercents[3]}" aria-valuemin="0" aria-valuemax="100">
											<c:choose>
												<c:when test="${agePercents[3] ne 0}">
													<span style="font-weight: bold;">${agePercents[3]}%</span>
												</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row boughtAgesContents"> <!-- 34~39 -->
								<div class="col-4 boughtAgesTitle">34~39세</div>
								<div class="col-7">
									<div class="row progress">
									  	<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${agePercents[4]}%" aria-valuenow="${agePercents[4]}" aria-valuemin="0" aria-valuemax="100">
											<c:choose>
												<c:when test="${agePercents[4] ne 0}">
													<span style="font-weight: bold;">${agePercents[4]}%</span>
												</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							
							<div class="row boughtAgesContents"> <!-- 40~ -->
								<div class="col-4 boughtAgesTitle"> 40세 ~ </div>
								<div class="col-7">
									<div class="row progress">
									  	<div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar" style="width: ${agePercents[5]}%" aria-valuenow="${agePercents[5]}" aria-valuemin="0" aria-valuemax="100">
											<c:choose>
												<c:when test="${agePercents[5] ne 0}">
													<span style="font-weight: bold;">${agePercents[5]}%</span>
												</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
							
						</div>
						<div class="d-sm-none d-lg-block col-lg-2"></div>
					</div>
				</c:if>
				
				<!-- 제품 추천 -->
				<c:if test="${!recommendedList.isEmpty()}">
					<div class="row" id="recommendedProductTitle">
						<div class="col"><h2>이런 상품은 어떠신가요?</h2></div>
					</div>
				</c:if>
				
				<!-- 리스트로 4개 출력 -->
				<c:if test="${!recommendedList.isEmpty()}">
					<div class="row" style="background-color: rgb(245, 245, 245); padding: 10px; border-radius: 5px;">
					
						<c:forEach items="${recommendedList}" var="product">
							<div class="col-md-6 col-lg-3 recommendedProductDiv" onclick="clickRecommend('${product.product_code}')">
	
								<div class="card" style="width: 100%;">
									<img src="${pageContext.request.contextPath}/product_img/${product.product_img}" class="card-img-top" style="height: 250px;">
									
									<div class="card-body">
									
										<!-- 제품이름 -->
										<h5 class="card-title">${product.product_name}</h5>
										
										<!-- 제품설명 -->
										<p class="card-text">${product.product_content}</p>
										
										<!-- 가격 -->
										<c:choose>
											<c:when test="${product.discount ne 0}">
												<p class="card-text">
													${Math.round( product.price - (product.price * (product.discount / 100)) )}원
													<span style="text-decoration: line-through; color: rgb(180, 180, 180);">${product.price}원</span>
													<br><span style="color: rgb(255,100,100);">${product.discount}%&nbsp;SALE</span>
												</p>
											</c:when>
											<c:otherwise>
												<p class="card-text">${product.price}원
													<br>&nbsp;
												</p>
											</c:otherwise>
										</c:choose>
										
										<!-- 평균평점 / 리뷰수 -->
										<c:choose>
											<c:when test="${product.avg_score eq 0}">
												<p class="card-text" style="color: gray;">별점없음</p>
											</c:when>
											<c:otherwise>
												<p class="card-text">⭐ ${String.format("%.2f", product.avg_score)} (${product.review_count})</p>
											</c:otherwise>
										</c:choose>
										
									</div>
								</div>
								
							</div>
						</c:forEach>
						
					</div>
				</c:if>
				
			</div>
			
			<div class="d-sm-none d-lg-block col-lg-1"></div>
		</div>
		
		<!-- 리뷰 -->
		<div class="row productReviewContainer">
			<div class="d-sm-none d-lg-block col-lg-1"></div>
			
			<div class="col">
				<div class="row reviewHeader"><h2>Review</h2></div>
				<div class="row reviewInfo">
					<br>
					*상품을 실제 구매하신분들이 작성한 리뷰입니다. 리뷰작성시 아래 금액만큼 포인트가 적립됩니다.<br>
					텍스트 리뷰: 50포인트 / 포토리뷰: 100포인트
				</div>
				
				<!-- 리뷰가 들어갈 div -->
				<div class="row">
					<div class="col" id="reviewAjaxContainer"></div>
				</div>

			</div>

			<div class="d-sm-none d-lg-block col-lg-1"></div>
		</div>
		
		<!-- 목록으로 -->
		<div class="row" id="backShopBtnDiv">
			<div class="d-sm-none d-lg-block col-lg-1"></div>
			<div class="col">
				<button class="btn btn-secondary" id="backShopBtn">돌아가기</button>
			</div>
			<div class="d-sm-none d-lg-block col-lg-1"></div>
		</div>
		
	</div>
	<!-- 푸터 -->
	<%@include file="../footer.jsp" %>

	<script>

		// 수량에 소수점 입력 시 알림
		$("#quantity").keypress(function(e){
			let keyVal = e.keyCode;
			
			if(((keyVal >= 48) && (keyVal <= 57))){
	            return true;
	        }
			else{
	            alert("숫자만 입력가능합니다.");
	            $("#quantity").val("1");
	            return false;
	        }
		});
	
	
		// 주문수량 범위초과시 재설정
		$("#quantity").change(function(e){
			// 10초과일 시 10
			if($(e.target).val() > 99){
				alert("한번에 주문가능한 구매수량이 초과되었습니다.");
				$(e.target).val(99);
			}
			// 1미만일 시 1
			else if($(e.target).val() < 1){
				alert("1미만의 숫자를 입력할 수 없습니다.");
				$(e.target).val(1);
			}
		});
		
		// 구매하기 클릭 시
		$("#orderProductBtn").on("click",function(){

			if($("#color").val() == -1){
				alert("색상을 선택해주세요.");
				return;
			}
			if($("#cloth_size").val() == -1){
				alert("사이즈를 선택해주세요.");
				return;
			}
			
			// form 생성 및 제출
			let $basketForm = $('<form action="${pageContext.request.contextPath}/order/createOrderToPayment" method="post" id="basketForm"></form>');
			$basketForm.appendTo('body');
			
			let product_code = $('<input name="product_code" type="hidden" value="${product.product_code}">');
			let cloth_size = $('<input name="cloth_size" type="hidden" value="'+ $("#cloth_size").val() +'">');
			let color = $('<input name="color" type="hidden" value="'+ $("#color").val() +'">');
			let quantity = $('<input name="quantity" type="hidden" value="'+ $("#quantity").val() +'">');

			$basketForm.append(product_code).append(cloth_size).append(color).append(quantity);
			$basketForm.submit();
		});
		
		// 장바구니 담기 클릭 시
		$("#toBasketBtn").on("click",function(){
			if($("#color").val() == -1){
				alert("색상을 선택해주세요.");
				return;
			}
			if($("#cloth_size").val() == -1){
				alert("사이즈를 선택해주세요.");
				return;
			}
			// form 생성 및 제출
			let $basketForm = $('<form action="${pageContext.request.contextPath}/order/createOrderToBasket" method="post" id="basketForm"></form>');
			$basketForm.appendTo('body');
			
			let product_code = $('<input name="product_code" type="hidden" value="${product.product_code}">');
			let cloth_size = $('<input name="cloth_size" type="hidden" value="'+ $("#cloth_size").val() +'">');
			let color = $('<input name="color" type="hidden" value="'+ $("#color").val() +'">');
			let quantity = $('<input name="quantity" type="hidden" value="'+ $("#quantity").val() +'">');

			$basketForm.append(product_code).append(cloth_size).append(color).append(quantity);
			$basketForm.submit();
		});
		
		// 제춤추천 div 클릭 시
		function clickRecommend (product_code){
			$(location).attr("href", "${pageContext.request.contextPath}/product/toProductDetail?product_code="+product_code);
		};
		
		// 돌아가기 클릭 시
		$("#backShopBtn").on("click", function() {
			window.history.back();
		});
		
		//-----------------------------------
		
		// 리뷰불러오기 ajax // 기본으로 리뷰 1페이지 시작
		getReview(1);
		let naviMap; // 함수 밖에서도 사용되는 변수
		
		// 리뷰 ajax 함수
		function getReview(currentPage){
			$.ajax({
				url : "${pageContext.request.contextPath}/review/getProductReview?product_code=${product.product_code}&currentPage="+currentPage,
				type : "get"
				
			}).done(function(data){
				
				$("#reviewAjaxContainer").html("");
				naviMap = data.naviMap;

				for (let review of data.reviewList) {
					// 키 표시법
					let height = review.height;
					if(review.height == 0 || review.height == -1){	// 키가 비어있을 시
						height = '<span style="color: rgb(150, 150, 150)">미입력</span>';
					}
					// 무게 표시법
					let weight = review.weight;
					if(review.weight == 0 || review.weight == -1){	// 무게가 비어있을 시
						weight = '<span style="color: rgb(150, 150, 150)">미입력</span>';
					}
					// 별점 표시법
					let score = "";
					for (let i = 1; i <= review.score; i++) {
						score += '<span class="starPointImgDiv"><img src="${pageContext.request.contextPath}/resources/images/OneStarPoint.png"></span>';
					}
					for (let i = review.score; i < 5; i++) {
						score += '<span class="starPointImgDiv"><img src="${pageContext.request.contextPath}/resources/images/blackStar.png"></span>';
					}
					
					// 날짜 표시법
					let written_date = toDateFromLong(review.written_date);
					
					function toDateFromLong( longDate ){  // long 타입의 시간값
						let date = new Date(longDate);  //입력 파라메터로 Date 객체를 생성합니다
						let yyyy = date.getFullYear().toString(); 		// 년
						let mm = (date.getMonth() + 1).toString(); 		// 월
						let dd = date.getDate().toString(); 			// 일
						
						// 한자리 수일 경우 0을 채우기	
						let temp = yyyy + '-' + (mm[1] ? mm : '0' + mm[0]) + '-' +(dd[1] ? dd : '0' + dd[0]);
						return temp;
					}
	
					let reviewHtml =
						'<div class="row reviewContainer">'
							+'<div class="col-1"></div>'
							
							+'<div class="col-7">'
							
								+'<div class="row reviewContentDiv">'	/* 별점 */
									+'<div class="col">'
										+ score
									+'</div>'
								+'</div>'
								
								+'<div class="row reviewContentDiv">'	/* 등급, 아이디, 신고버튼 */
									+'<div class="col">'
										+'<span style="font-size: 1.1rem; font-weight: bold;">'+ review.id +'</span> /'
										+'<span style="color: rgb(100, 100, 100); font-size: 0.9rem;"> '+ written_date +' </span> '
										+'<span class="reportReviewSpan" data-value="'+review.review_seq+'"id-value="'+review.id+'"style="font-size: 0.9rem; cursor:pointer;"> / 신고</span>'
									+'</div>'
								+'</div>'
								
								+'<div class="row reviewContentDiv">'	/* 키, 무게 */
									+'<div class="col" style="font-size: 0.9rem;">&nbsp;키 : '+ height +' | 무게 : '+ weight +'</div>'
								+'</div>'
								
								+'<div class="row reviewContentDiv">'	/* 내용 */
									+'<div class="col">'+ review.content +'</div>'
								+'</div>'
								
							+'</div>'
							
							/* 이미지 */
							+'<div class="col-3 reviewImgDiv">';
	
					if(review.review_img != null){	// 사진파일이 있다면
						reviewHtml += '<img src="${pageContext.request.contextPath}/review_img/'+review.review_img+'">';
					}
					reviewHtml +=
							'</div>'
							+'<div class="col-1"></div>'
						+'</div>';
					
					$("#reviewAjaxContainer").append(reviewHtml);
				}
				
				// 페이징 버튼
				let naviHtml =
					'<nav aria-label="Page navigation" id ="reviewPageNavi">'
						+'<ul class="pagination justify-content-center">'
					  		+'<li class="page-item" id="prevReviewBtn"><a class="page-link disabled">이전</a></li>'; 	// 이전버튼

					  		for (let i = naviMap.startNavi; i <= naviMap.endNavi; i++) {		// 번호버튼
					  			
					  			if(naviMap.currentPage == i){	// 만약 현재 띄운 페이지라면 선택된 속성으로 생성
					  				naviHtml += '<li class="page-item active selectReviewBtn"><a class="page-link">'+i+'</a></li>';
					  			}
					  			else{
					  				naviHtml += '<li class="page-item selectReviewBtn"><a class="page-link">'+i+'</a></li>';
					  			}
							}
					  		
				naviHtml += '<li class="page-item" id="nextReviewBtn"><a class="page-link disabled" >다음</a></li>'		// 다음버튼
						+'</ul>'
					+'</nav>';

				$("#reviewAjaxContainer").append(naviHtml);
				
				// css 및 속성 변화 (이전버튼, 다음버튼)
				if(naviMap.needPrev == false){	// 이전 버튼이 필요없다면 비활성화
					$("#prevReviewBtn").attr("class", "page-item disabled");
				}
				if(naviMap.needNext == false){	// 다음 버튼이 필요없다면 비활성화
					$("#nextReviewBtn").attr("class", "page-item disabled");
				}
				
			}).fail(function(e){
				console.log(e);
			});
		}
		
		// 리뷰 이전버튼 클릭 시	// disabled 클래스가 있다면 제외
		$("#reviewAjaxContainer").on("click", "#prevReviewBtn:not('.disabled')", function(){
			let currentPage = naviMap.startNavi - 1;
			getReview(currentPage);
		});
		
		// 리뷰 숫자버튼 클릭 시	// active 클래스가 있다면 제외
		$("#reviewAjaxContainer").on("click", ".selectReviewBtn:not('.active')", function(e){
			let currentPage = $(e.target).html();
			getReview(currentPage);
		});
		
		// 리뷰 다음버튼 클릭 시	// disabled 클래스가 있다면 제외
		$("#reviewAjaxContainer").on("click", "#nextReviewBtn:not('.disabled')", function(){
			let currentPage = naviMap.endNavi + 1;
			getReview(currentPage);
		});
		
		
		// 신고버튼 클릭 시
		$("#reviewAjaxContainer").on("click", ".reportReviewSpan", function(e){
			let review_seq = (e.target).getAttribute('data-value');
			let id = (e.target).getAttribute('id-value');
			
			let url = "${pageContext.request.contextPath}/report/toReportPopup?review_seq=" + review_seq + "&id=" + id;
			let name = "리뷰 신고하기";
			let option = "width=600, height=500, top=200, left=620";
			
			window.open(url, name, option);
		});
		
	</script>
	
	
</body>
</html>