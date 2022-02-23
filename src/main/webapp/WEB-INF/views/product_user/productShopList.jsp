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
	<title>상품목록</title>
	
	<style>
		.shopMainContainer{
			margin-top: 80px;
		}
		
		.shopMainContainer .categoryBtnDiv{
			margin-bottom: 10px;
		}
		.shopMainContainer .detailCategoryBtnDiv{
			margin-bottom: 20px;
		}
		.shopMainContainer .categoryBtnDiv .btn{
			border-radius: 50px;
		}
		.shopMainContainer .detailCategoryBtnDiv .btn{
			border-radius: 50px;
		}
		
		.product_categoryTitle{
			border-top: 2px solid rgb(200,200,200);
			padding-top: 20px;
			margin-top: 30px;
			margin-bottom: 40px;
		}

		.productListContent .productBasicCss{
			text-align: left;
			margin-bottom: 35px;
			padding-bottom: 10px;
		}
		.productListContent .productImgDiv{
			height: 280px;
			margin-bottom: 15px;
		}
		.productListContent .productImgDiv img{
			transition: 0.3s;
			width: 100%;
			height: 280px;
		}
		.productListContent .productImgDiv img:hover{
			opacity: 0.8;
			transform: scale(1.02);
		}
		
		.productBasicCss .productTitle{
			font-size: 1.5rem;
		}
		.productListContent .productLinkDiv{
			cursor: pointer;
		}
		
		/* 페이징 네비 */
		#pagingNavi{
			margin-bottom: 100px;
		}
	</style>
</head>
<body>

	<!-- 헤더 -->
	<%@include file="../header.jsp" %>
	<!-- 사이드바 -->
	<%@include file="../sideBar.jsp" %>
	
	<div class="container shopMainContainer">
		
		<!-- 카테고리 버튼 -->
		<div class="row">
			<div class="col-sm-12 col-md-8 categoryBtnDiv">	
				<button type="button" class="btn btn-outline-secondary categoryBtn" value="전체">전체</button>
				<button type="button" class="btn btn-outline-secondary categoryBtn" value="아우터">아우터</button>
				<button type="button" class="btn btn-outline-secondary categoryBtn" value="상의">상의</button>
				<button type="button" class="btn btn-outline-secondary categoryBtn" value="하의">하의</button>
				<button type="button" class="btn btn-outline-secondary categoryBtn" value="신발">신발</button>
			</div>
			
			<div class="col input-group mb-3">
			  	<input type="text" id="searchKeywordInput" class="form-control form-control-sm" placeholder="상품명 / 카테고리 입력" aria-describedby="searchKeywordBtn" value="${keyword}">
			  	<button class="btn btn-outline-secondary btn-sm" type="button" id="searchKeywordBtn">검색</button>
			</div>
		</div>
		
		<!-- 세부카테고리 -->
		<div class="row">
			<div class="col detailCategoryBtnDiv">
				&nbsp;
				<c:choose>
					<c:when test="${product_category eq '아우터'}">
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="전체">전체</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="가디건">가디건</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="자켓">자켓</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="코트">코트</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="패딩">패딩</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="후드집업">후드집업</button>
					</c:when>
					<c:when test="${product_category eq '상의'}">
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="전체">전체</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="니트/스웨터">니트/스웨터</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="맨투맨">맨투맨</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="셔츠">셔츠</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="티셔츠">티셔츠</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="후드티">후드티</button>
					</c:when>
					<c:when test="${product_category eq '하의'}">
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="전체">전체</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="청바지">청바지</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="면바지">면바지</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="반바지">반바지</button>
					</c:when>
					<c:when test="${product_category eq '신발'}">
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="전체">전체</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="운동화">운동화</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="캔버스">캔버스</button>
						<button type="button" class="btn btn-outline-secondary btn-sm detailCategoryBtn" value="단화">단화</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="btn btn-secondary btn-sm detailCategoryBtn" value="전체">전체</button>
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="col-3 col-lg-2 categoryBtnDiv">
				<select class="form-select form-select-sm" id="arrangeOption">
					<option value="insert_date">최신순</option>	<!-- 드롭다운으로 구성 -->
					<option value="discount">할인률</option>	
					<option value="avg_score">평점순</option>
					<option value="review_count">리뷰수</option>
				</select>
			</div>
		</div>
		
		<script>
			// 선택된 카테고리의 스타일 변화
			for (let category of $(".categoryBtn")) {
				if($(category).val() == "${product_category}"){	// 현재 카테고리에 맞는 버튼의 스타일 변화
					$(category).removeClass('btn-outline-secondary').addClass('btn-secondary');
				}
			}
			// 선택된 세부 카테고리 스타일 변화
			for (let category of $(".detailCategoryBtn")) {
				if($(category).val() == "${detail_category}"){	// 현재 세부 카테고리에 맞는 버튼의 스타일 변화
					$(category).removeClass('btn-outline-secondary').addClass('btn-secondary');
				}
			}
			
			// 정렬옵션 값이 선택됨
			for (let option of $("#arrangeOption option")) {
				if($(option).val() == "${option}"){	// 정렬옵션에 맞는 option이 select 됨
					$(option).attr("selected", true);
				}
			}
		</script>
		
		<!-- 카테고리 이름 -->
		<div class="row product_categoryTitle">
			<h2>${product_category}</h2>
		</div>
	
		<!-- 제품 리스트 부분 -->
		<div class="row productListContent g-0">
		
			<div class="col-1"></div>
			
			<div class="col-10">
				<div class="row">
					<!-- 리스트로 출력 -->

					<c:if test="${productList.isEmpty()}">
						<div class="col" style="font-size: 1.2rem; text-align: center; padding-top: 70px; padding-bottom: 150px;">
							조건에 맞는 상품이 존재하지 않습니다.
						</div>
					</c:if>

					<c:forEach items="${productList}" var="product">
						
						<div class="col productBasicCss col-6 col-lg-3">
							<div class="p-2 border bg-light productLinkDiv" onclick="linkProductPage('${product.product_code}')">
								<div class="row productImgDiv">
									<div class="col">
										<img src="${pageContext.request.contextPath}/product_img/${product.product_img}">
									</div>
								</div>

								<div class="row">	<!-- 제품이름 -->
									<div class="col productTitle">
										&nbsp;${product.product_name}
									</div>
								</div>
								
								<div class="row">	<!-- 제품가격 -->
									<div class="col">
										<c:choose>
											<c:when test="${product.discount ne 0}">
												<span style="text-decoration: line-through; color: rgb(180, 180, 180); font-style: italic;">${product.price}원</span>
												<span style="font-weight: bold"> ${Math.round( product.price - (product.price * (product.discount / 100)) )}원 </span>
											</c:when>
											
											<c:otherwise><span style="font-weight: bold">${product.price}원</span></c:otherwise>
										</c:choose>
									</div>
								</div>
								
								<div class="row">	<!-- 할인 -->
									<c:choose>
										<c:when test="${product.discount ne 0}">
											<span style="color: rgb(255,100,100);">${product.discount}%&nbsp;SALE</span>
										</c:when>
										<c:otherwise>
											&nbsp;
										</c:otherwise>
									</c:choose>
								</div>
								
								<div class="row"></div>	<!-- 상세설명 -->
								
								<div class="row">	<!-- 평점 및 리뷰수 -->
									<div class="col">
										⭐
										<c:choose>
											<c:when test="${product.avg_score eq 0}">
												<span style="color : gray">없음</span>
											</c:when>
											<c:otherwise>
												${String.format("%.2f", product.avg_score)}
											</c:otherwise>
										</c:choose>
									</div>
								
									<div class="col">
										리뷰:
										<c:choose>
											<c:when test="${product.review_count eq 0}">
												<span style="color : gray">없음</span>
											</c:when>
											<c:otherwise>
												${product.review_count}
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>
						
					</c:forEach>

				</div>
			</div>

			<div class="col-1"></div>
		</div>
		
		<!-- 페이징버튼 -->
		<nav aria-label="Page navigation" id="pagingNavi">
		  	<ul class="pagination justify-content-center">
		  		
		  		<!-- 이전버튼 -->
			  	<c:choose>
			  		<c:when test="${naviMap.needPrev eq true}">
			  			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/product/toProductShopList?product_category=${product_category}&detail_category=${detail_category}&option=${option}&currentPage=${naviMap.startNavi - 1}">이전</a></li>
			  		</c:when>
			  		<c:otherwise>
			  			<li class="page-item disabled"><a class="page-link">이전</a></li>
			  		</c:otherwise>
			  	</c:choose>
			  	
			  	<!-- 번호버튼 -->
			    <c:forEach var = "i" begin="${naviMap.startNavi}" end="${naviMap.endNavi}">
			    	<c:choose>
			    		<c:when test="${naviMap.currentPage eq i}">	<!-- 현재 페이지의 li 만 active 해줌 -->
			    			<li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/product/toProductShopList?product_category=${product_category}&detail_category=${detail_category}&option=${option}&currentPage=${i}">${i}</a></li>
			    		</c:when>
			    		<c:otherwise>
			    			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/product/toProductShopList?product_category=${product_category}&detail_category=${detail_category}&option=${option}&currentPage=${i}">${i}</a></li>
			    		</c:otherwise>
			    	</c:choose>
			    </c:forEach>
			    
			    <!-- 다음버튼 -->
			    <c:choose>
			  		<c:when test="${naviMap.needNext eq true}">
			  			<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/product/toProductShopList?product_category=${product_category}&detail_category=${detail_category}&option=${option}&currentPage=${naviMap.endNavi + 1}">다음</a></li>
			  		</c:when>
			  		<c:otherwise>
			  			<li class="page-item disabled"><a class="page-link">다음</a></li>
			  		</c:otherwise>
			  	</c:choose>
		    
		  	</ul>
		</nav>
	</div>
	
	<!-- 헤더 -->
	<%@include file="../footer.jsp" %>
	
	<script>
	
		// 카테고리 버튼 클릭시 해당 val값으로 카테고리 변환
		$(".categoryBtn").on("click", function(e){
			let product_category = $(e.target).val();
			let detail_category = "";
			let option = "${option}";	// 현재 선택된 정렬방법
			let keyword = "";
			
			$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category="+product_category+"&detail_category="+detail_category+"&keyword="+keyword+"&option="+option+"&currentPage=1");
		});
		
		// 세부 카테고리 버튼 클릭 시 해당 val값으로 세부 카테고리 변환
		$(".detailCategoryBtn").on("click", function(e){
			let product_category = "${product_category}";
			let detail_category = $(e.target).val();
			let option = "${option}";
			let keyword = "";
			
			$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category="+product_category+"&detail_category="+detail_category+"&keyword="+keyword+"&option="+option+"&currentPage=1");
		});
		
		// 검색클릭 시
		$("#searchKeywordBtn").on("click", function(){
			
			if(($("#searchKeywordInput").val()).length < 2){
				alert("최소 2자 이상의 키워드를 입력해주세요.");
				return;
			}
			else if(($("#searchKeywordInput").val()).length > 10){
				alert("10자 이내의 키워드를 입력해주세요.");
				return;
			}
			
			let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;
			
			if(!searchRegx.test($("#searchKeywordInput").val())){
				
				let product_category = "${product_category}";
				let detail_category = "${detail_category}";
				let option = "${option}";
				let keyword = $("#searchKeywordInput").val();
				
				$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category="+product_category+"&detail_category="+detail_category+"&keyword="+keyword+"&option="+option+"&currentPage=1");
			}
			else{
				alert("특수문자를 포함할 수 없습니다.");
				$("#searchKeywordInput").val("");
			}
			
		});
		
		// 검색창에서 엔터 입력시
		$("#searchKeywordInput").keyup(function(e){

			if(e.keyCode == 13){
				
				if(($("#searchKeywordInput").val()).length < 2){
					alert("최소 2자 이상의 키워드를 입력해주세요.");
					return;
				}
				else if(($("#searchKeywordInput").val()).length > 10){
					alert("10자 이내의 키워드를 입력해주세요.");
					return;
				}
				
				let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;
				if(!searchRegx.test($("#searchKeywordInput").val())){
					let product_category = "${product_category}";
					let detail_category = "${detail_category}";
					let option = "${option}";
					let keyword = $(e.target).val();
					
					$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category="+product_category+"&detail_category="+detail_category+"&keyword="+keyword+"&option="+option+"&currentPage=1");

				}
				else{
					alert("특수문자를 포함할 수 없습니다.");
					$("#searchKeywordInput").val("");
				}
			}
		});
		
		
		// 정렬옵션 선택 시
		$("#arrangeOption").change(function(){
			let product_category = "${product_category}";
			let detail_category = "${detail_category}";
			let option = $("#arrangeOption option:selected").val();	// 현재 선택된 정렬방법
			let keyword = "${keyword}";
			
			$(location).attr("href", "${pageContext.request.contextPath}/product/toProductShopList?product_category="+product_category+"&detail_category="+detail_category+"&keyword="+keyword+"&option="+option+"&currentPage=1");
		});
		
		
		// 제품div 클릭 시
		function linkProductPage(product_code){
			$(location).attr("href", "${pageContext.request.contextPath}/product/toProductDetail?product_code="+product_code);
		}
	</script>
	
</body>
</html>