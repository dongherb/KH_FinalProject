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
	<title>리뷰쓰기</title>
	
	<style>
		.reviewContainer{
			margin-bottom: 100px;
		}
		.reviewInputContainer{
			padding: 20px;
			border: 1px solid rgb(200,200,200);
			border-radius: 5px;
		}
		
		.reviewInputContainer .reviewTitleDiv{
			padding-bottom: 20px;
		}
		.reviewInputContainer .reviewTitle{
			text-align: center;
		}
		
		.reviewInputContainer .reviewlineDiv{
			padding-left: 30px;
			padding-right: 30px;
			margin-bottom: 20px;
		}
		.reviewInputContainer .reviewlineDiv .reviewline{
			border-top: 1px solid rgb(200,200,200);
		}
		
		/* 별점 */
		.reviewInputContainer .starPointDiv{
			margin-top: 25px;
		}
		.reviewInputContainer #starPointImgContainer{
			text-align: center;
		}
		.reviewInputContainer #starPointImgContainer .starPointImg{
			height: 30px;
			width: 30px;
			cursor: pointer;
		}
		
		/* 사용자 정보 키,몸무게 */
		.reviewInputContainer .reviewUserInfo{
			margin-top: 30px;
		}
		
		/* 리뷰이미지 */
		.reviewInputContainer .reviewImgDiv{
			margin-top: 30px;
		}
		
		/* 리뷰내용 */
		.reviewInputContainer .reviewTextareaDiv{
			margin-top: 30px;
			margin-bottom: 50px;
		}
		.reviewInputContainer .reviewTextareaDiv textarea{
			height: 300px;
		}
		
		/* footer */
		.reviewContainer .reviewBtnsDiv{
			margin-top: 50px;
		}
		.reviewContainer .reviewBtnsDiv button{
			width: 100%;
		}
		
	</style>
	
</head>
<body>

	<c:choose>
		<c:when test="${done eq 'done'}">
			<script>
				alert("리뷰 작성완료.");
				$(location).attr("href","${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=구매확정&currentPage=1");
			</script>
		</c:when>
		<c:when test="${done eq 'fail'}">
			<script>
				alert("리뷰 작성실패.");
			</script>
		</c:when>
		<c:when test="${done eq 'exsit'}">
			<script>
				alert("이미 리뷰를 작성하셨습니다.");
				$(location).attr("href","${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=구매확정&currentPage=1");
			</script>
		</c:when>
		<c:when test="${done eq 'productDelete'}">
			<script>
				alert("해당 제품은 삭제되었습니다.");
				$(location).attr("href","${pageContext.request.contextPath}/mypageOrder/toMyOrderHistory?deal_status=구매확정&currentPage=1");
			</script>
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>

	<!-- 헤더 -->
	<%@include file="../header.jsp" %>
	<!-- 마이페이지 헤더 -->
	<%@include file="../mypage/mypageNavi.jsp" %>
	
	<form action="${pageContext.request.contextPath}/review/insertReviewProc" method="post" enctype="multipart/form-data" id="submitReview">
		
		<div class="container reviewContainer">
			<div class="row">
				<div class="d-sm-none d-lg-block col-lg-2"></div>
			
				<div class="col reviewInputContainer">
					
					<div class="row reviewTitleDiv">	<!-- 리뷰작성 타이틀 -->
						<div class="col reviewTitle"><h3>리뷰작성</h3></div>
						<input type="text" class="d-none" value="${order_seq}" name="order_seq">
						<input type="text" class="d-none" value="${product_code}" name="product_code">
					</div>
	
					<div class="row reviewlineDiv">	<!-- 라인 -->
						<div class="col reviewline"></div>
					</div>
	
					<!-- 리뷰작성의 내용들 -->
					<div class="row">
						<div class="d-sm-none d-lg-block col-lg-2"></div>
						
						<div class="col">
							<!-- 안내문 -->
							<div class="row">
								<div class="col" style="text-align: center;">
									<strong>상품을 잘 받으셨다면, 다른 사용자를 위해 별점과 리뷰를 남겨보세요.</strong>
									<br>(50포인트 획득)
								</div>
							</div>
							
							<!-- 별점 -->
							<div class="row starPointDiv">
								<div class="col" id="starPointImgContainer">
									<c:forEach var="i" begin="1" end="5">
										<img class="starPointImg" id="starPointImg_${i}" data-value="${i}" src="${pageContext.request.contextPath}/resources/images/HollowStar.png">
									</c:forEach>
									<input type="text" class="d-none" id="score" name="score" value="-1">
								</div>
							</div>
			
							<!-- 키, 몸무게 -->
							<div class="row reviewUserInfo">
								
								<div class="col">
									<label style="font-weight: bold">키</label>
									<select class="form-select" id="selectedHeight">
									
										<option value="-1">미입력</option>	<!-- 드롭다운으로 구성 -->
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
								
								<div class="col">
									<label style="font-weight: bold">몸무게</label>
									<select class="form-select" id="selectedWeight">
									
										<option value="-1">미입력</option>	<!-- 드롭다운으로 구성 -->
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
							
							<!-- 파일선택 -->
							<div class="row reviewImgDiv">
								<div class="col">
									<label style="font-weight: bold">사진선택_ ( 사진을 첨부할 시 추가 50포인트을 획득하실 수 있습니다. )</label>
									<input type="file" class="form-control" name="file" accept="image/*">
								</div>
							</div>
							
							
							<!-- 리뷰내용입력 -->
							<div class="row reviewTextareaDiv">
								<div class="col">
									<label style="font-weight: bold">내용</label>
									<textarea style="resize: none" class="form-control" id="content" name="content" placeholder="리뷰내용을 입력해주세요."></textarea>
								</div>
							</div>
							
						</div>
						
						<div class="d-sm-none d-lg-block col-lg-2"></div>
					</div>

				</div>
				
				<div class="d-sm-none d-lg-block col-lg-2"></div>
			</div>
			
			<div class="row reviewBtnsDiv">
				<div class="d-sm-none d-md-block col-md-2 col-lg-4"></div>
					
				<div class="col">
					<button type="button" class="btn btn-secondary" id="cancelReviewBtn">취소</button>
				</div>
				<div class="col">
					<button type="button" class="btn btn-dark" id="submitReviewBtn">리뷰작성</button>
				</div>
					
				<div class="d-sm-none d-md-block col-md-2 col-lg-4"></div>
			</div>
			
		</div>
		
	</form>
	
	<!-- 푸터 -->
	<%@include file="../footer.jsp" %>
	
	<script>
	
		// 별 클릭 시
		$(".starPointImg").on("click", function(e){
			let score = Number((e.target).getAttribute('data-value'));	// 문자열을 숫자로 형변환함
			
			for (let i = 1; i <= score; i++) {	// 클릭된 평점 값만큼 src를 변화시킴 // 노란별로 교체
				$("#starPointImg_"+i).attr("src", "${pageContext.request.contextPath}/resources/images/OneStarPoint.png");
			}
			for (let i = score + 1; i <= 5; i++) {	// 남은 칸은 검은별로 교체
				$("#starPointImg_"+i).attr("src", "${pageContext.request.contextPath}/resources/images/HollowStar.png");
			}
			
			$("#score").val(score);
		});
		
		// 리뷰작성 버튼 클릭 시
		$("#submitReviewBtn").on("click", function(){
			
			// 별점을 선택하지 않았을 시
			if($("#score").val() == "-1"){
				alert("별점을 선택해주세요.");
				return;
			}
			// 리뷰내용이 부실할 시
			if(($("#content").val()).length < 8){
				alert("8글자 이상의 리뷰를 작성해주세요.");
				return;
			}
			// 리뷰내용이 많을 시
			if(($("#content").val()).length > 100){
				alert("100글자 이내의 리뷰를 작성해주세요.");
				return;
			}
			
			// 키, 몸무게 등 담기
			let height = $("#selectedHeight option:selected").val();
			let weight = $("#selectedWeight option:selected").val();
			$("#height").val(height);
			$("#weight").val(weight);
			
			$("#submitReview").submit();	// 제출
		});
		
		// 취소버튼 클릭 시
		$("#cancelReviewBtn").on("click", function(){
			window.history.back();
		})
		
	
	</script>

</body>
</html>