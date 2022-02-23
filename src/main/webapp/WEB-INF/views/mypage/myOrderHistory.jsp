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
	<title>주문내역조회</title>
	
	<style>
		.orderHistoryContainer{
			margin-top: 40px;
		}
		.orderHistoryContainer a{
			text-decoration: none;
			color: black;
		}
		
		.dealStatus_navi{
			padding-top: 10px;
			padding-bottom: 10px;
			
			text-align: center;
			box-shadow: 1px 1px 1px 1px rgb(150, 150, 150);
			
			margin-bottom: 80px;
		}
		.dealStatus_navi .statusTitle{
			text-align: left;
			font-size: 1.3rem;
			font-weight: bold;
			padding-top: 5px;
			padding-bottom: 5px;
			border-bottom: 1px solid rgb(200, 200, 200);
		}
		.dealStatus_navi .statusContentes{
			padding: 10px;
		}
		
		.dealStatus_navi .statusCountSpan{
			font-size: 1.5rem;
			font-weight: bold;
		}
	
		/* 주문내역 리스트 */
		.orderListContainer{
			margin-bottom: 15px;
			box-shadow: 1px 1px 1px 1px rgb(150, 150, 150);
		}
		.orderListContainer .orderContent{
			padding: 10px;
		}
		.orderListContainer .product_imgDiv img{
			height: 160px;
			width: 100%;
		}
	
		/* 페이징 관련 */
		.orderHistoryContainer #pagingNavi{
			margin-top: 80px;
			margin-bottom: 130px;
		}
		
		.orderInfoDiv{
			margin-top: -10px;
			padding-bottom: 10px;
			margin-bottom: 5px;
			text-align: right;
		}
		.orderInfoSpan{
			cursor: pointer;
			border-radius:10px;
			background-color:#dbdbdb;
			padding:8px;
			font-weight:bold;
		}
		h2{
		text-align: center;
		}
	
	</style>
	
</head>
<body>

	<c:choose>
		<c:when test="${done eq 'done'}">
			<script>
				alert("거래확정 완료.");
			</script>
		</c:when>
		<c:when test="${done eq 'fail'}">
			<script>
				alert("요청실패.");
			</script>
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>

	<!-- 헤더 -->
	<%@include file="../header.jsp" %>
	<!-- 마이페이지 헤더 -->
	<%@include file="mypageNavi.jsp" %>
	<%@include file="../sideBar.jsp" %>
	
	<div class="container orderHistoryContainer">
	
		<div class="row">
			<div class="d-sm-none d-md-block col-md-1"></div>

			<div class="col">
				<div class="row">
					<div class="col">
						<h2>주문 내역</h2>
					</div>
				</div>
				  <br>
   				  <br>
				<div class="row dealStatus_navi">
					<div class="col">
						<div class="row">
							<div class="col statusTitle">${deal_status}</div>
						</div>

						<div class="row">
							<div class="col statusContentes">
								<a
									href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=전체&currentPage=1">
									전체<br> <span class="statusCountSpan">${statusCounts[0]}</span>
								</a>
							</div>
							<div class="col statusContentes">
								<a
									href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=결제완료&currentPage=1">
									결제완료<br> <span class="statusCountSpan">${statusCounts[1]}</span>
								</a>
							</div>
							<div class="col statusContentes">
								<a
									href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=배송중&currentPage=1">
									배송중<br> <span class="statusCountSpan">${statusCounts[2]}</span>
								</a>
							</div>
							<div class="col statusContentes">
								<a
									href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=배송완료&currentPage=1">
									배송완료<br> <span class="statusCountSpan">${statusCounts[3]}</span>
								</a>
							</div>
							<div class="col statusContentes">
								<a
									href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=구매확정&currentPage=1">
									구매확정<br> <span class="statusCountSpan">${statusCounts[4]}</span>
								</a>
							</div>
						</div>

					</div>
				</div>

				<c:forEach items="${orderList}" var="order">
					<div class="row orderListContainer">
						<div class="col">

							<div class="row" style="background-color: rgb(248, 248, 248);">
								<!-- 결제날짜 -->
								<div class="col orderContent"
									style="font-size: 1.2rem; font-weight: bold; color: rgb(130, 130, 130);">${order.deal_date}</div>
								<div class="col orderContent"
									style="font-size: 1.2rem; text-align: right; color: rgb(130, 130, 130);">
									<c:choose>
										<c:when test="${order.deal_status eq '배송완료'}">
											${order.deal_status}
										</c:when>
										<c:when test="${order.deal_status eq '구매확정'}">
											${order.deal_status}
										</c:when>
										<c:when test="${order.deal_status eq '리뷰완료'}">
											${order.deal_status}
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
								</div>
							</div>

							<div class="row">

								<div
									class="d-none d-sm-none d-md-block col-md-4 col-lg-2 orderContent product_imgDiv">
									<!-- 사진 -->
									<a
										href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${order.product_code}">
										<c:choose>
											<c:when test="${order.product_name ne null}">
												<img
													src="${pageContext.request.contextPath}/product_img/${order.product_img}">
											</c:when>
											<c:otherwise>
												<img
													src="${pageContext.request.contextPath}/resources/images/noImg.png">
											</c:otherwise>
										</c:choose>
									</a>
								</div>

								<div class="col-sm-9 col-md-6 col-lg-8 orderContent">
									<!-- 제품이름 / 제품카테고리 / 색상 / 사이즈 -->
									<div class="row">
										<div class="col" style="font-size: 1.3rem">
											<c:choose>
												<c:when test="${order.product_name ne null}">${order.product_name}</c:when>
												<c:otherwise>삭제된 제품 (주문기록은 정상적으로 처리됐습니다.)</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<div class="col">
											<c:choose>
												<c:when test="${order.product_name ne null}">${order.product_category} / ${order.detail_category}</c:when>
												<c:otherwise>카테고리 불러올 수 없음</c:otherwise>
											</c:choose>
										</div>
									</div>
									<div class="row">
										<c:choose>
											<c:when test="${order.color eq 'undefined'}">
												<div class="col" style="font-size: 1.1rem; color: gray;">주문사이즈
													: ${order.cloth_size} | ${order.quantity}개</div>
											</c:when>
											<c:otherwise>
												<div class="col" style="font-size: 1.1rem; color: gray;">주문사이즈
													: ${order.cloth_size} 색상 : ${order.color} |
													${order.quantity}개</div>
											</c:otherwise>
										</c:choose>
									</div>
									<div class="row">
										<div class="col" style="margin-top: 10px; font-size: 1.3rem;">
											<c:choose>
												<c:when test="${order.product_name ne null}">${ Math.round( order.price - (order.price * (order.discount / 100)) ) }원</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>

								<div class="col-sm-3 col-md-2 col-lg-2 orderContent"
									style="text-align: right">
									<!-- 주문상태표시 -->
									<c:choose>
										<c:when test="${order.deal_status eq '결제완료'}">
											<button type="button" class="btn btn-outline-secondary"
												value="${order.order_seq}" disabled>${order.deal_status}</button>
										</c:when>
										<c:when test="${order.deal_status eq '배송중'}">
											<button type="button" class="btn btn-outline-danger"
												value="${order.order_seq}" disabled>${order.deal_status}</button>
										</c:when>
										<c:when test="${order.deal_status eq '배송완료'}">
											<button type="button"
												class="btn btn-outline-success decideOrderBtn"
												value="${order.order_seq}">구매확정</button>
										</c:when>
										<c:when test="${order.deal_status eq '구매확정'}">
											<c:choose>
												<c:when test="${order.product_name ne null}">
													<button type="button"
														class="btn btn-outline-primary reviewOrderBtn"
														value="${order.order_seq}"
														product_code="${order.product_code}">리뷰작성</button>
												</c:when>
												<c:otherwise>
													<button type="button"
														class="btn btn-outline-primary reviewOrderBtn" disabled>리뷰불가</button>
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${order.deal_status eq '리뷰완료'}">
											<button type="button"
												class="btn btn-outline-warning showReviewBtn"
												value="${order.order_seq}">리뷰보기</button>
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>

								</div>

							</div>

							<div class="row">
								<div class="col orderInfoDiv">
									<span class="orderInfoSpan" span_value="${order.pay_seq}">주문내역확인</span>
								</div>
							</div>

						</div>
					</div>
				</c:forEach>

			</div>

			<div class="d-sm-none d-md-block col-md-1"></div>
		</div>
		
		<!-- 페이징버튼 -->
		<nav aria-label="Page navigation" id="pagingNavi">
		  	<ul class="pagination justify-content-center">
		  		
		  		<!-- 이전버튼 -->
			  	<c:choose>
			  		<c:when test="${naviMap.needPrev eq true}">
			  			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=${deal_status}&currentPage=${naviMap.startNavi - 1}">이전</a></li>
			  		</c:when>
			  		<c:otherwise>
			  			<li class="page-item disabled"><a class="page-link">이전</a></li>
			  		</c:otherwise>
			  	</c:choose>
			  	
			  	<!-- 번호버튼 -->
			    <c:forEach var = "i" begin="${naviMap.startNavi}" end="${naviMap.endNavi}">
			    	<c:choose>
			    		<c:when test="${naviMap.currentPage eq i}">	<!-- 현재 페이지의 li 만 active 해줌 -->
			    			<li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=${deal_status}&currentPage=${i}">${i}</a></li>
			    		</c:when>
			    		<c:otherwise>
			    			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=${deal_status}&currentPage=${i}">${i}</a></li>
			    		</c:otherwise>
			    	</c:choose>
			    </c:forEach>
			    
			    <!-- 다음버튼 -->
			    <c:choose>
			  		<c:when test="${naviMap.needNext eq true}">
			  			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=${deal_status}&currentPage=${naviMap.endNavi + 1}">다음</a></li>
			  		</c:when>
			  		<c:otherwise>
			  			<li class="page-item disabled"><a class="page-link">다음</a></li>
			  		</c:otherwise>
			  	</c:choose>
		    
		  	</ul>
		</nav>

	</div>


	<!-- 푸터 -->
	<%@include file="../footer.jsp" %>

	<script>
	
		// 구매확정 클릭 시
		$(".decideOrderBtn").on("click", function(e){
			
			if(confirm("구매를 확정하시면 환불 / 교환이 불가능합니다.\n구매를 확정하시겠습니까?")){
				$(location).attr("href", "${pageContext.request.contextPath}/mypageOrder/changeToDecideProc?order_seq="+$(e.target).val());
			}
		});
		
		// 리뷰쓰기 클릭 시
		$(".reviewOrderBtn").on("click", function(e){
			
			let product_code = (e.target).getAttribute('product_code');
			
			if(confirm("리뷰를 작성할 시 포인트를 획득할 수 있습니다.\n리뷰를 작성하시겠습니까?")){
				$(location).attr("href", "${pageContext.request.contextPath}/review/toWriteReview?product_code="+product_code+"&order_seq="+$(e.target).val());
			}
		});
		
		// 리뷰보기 클릭 시
		$(".showReviewBtn").on("click", function(e){
			
			// 팝업창 띄우기
			let url = "${pageContext.request.contextPath}/review/toShowReviewPapup?order_seq="+$(e.target).val();
			let name = "리뷰보기";
			let option = "width=600, height=750, top=100, left=620";
			
			window.open(url, name, option);
		});
	
		// 결제정보보기 클릭 시
		$(".orderInfoSpan").on("click", function(e){
			
			let pay_seq = (e.target).getAttribute('span_value');

			// 팝업창 띄우기
			let url = "${pageContext.request.contextPath}/mypageOrder/toShowPaymentPapup?pay_seq="+pay_seq;
			let name = "결제정보";
			let option = "width=600, height=750, top=100, left=620";
			
			window.open(url, name, option);
			
		});
		
	</script>


</body>
</html>