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
	<title>출석체크</title>
	
	<style>
		.calenderContainer{
			background-color: #e5eaee;
			border-radius: 20px;
			padding: 20px;
			box-shadow: 2px 2px 2px 2px gray;
			margin-bottom: 150px;
		}
		.calenderContainer .calenderBtnDiv{
			margin-bottom: 30px;
			text-align: center;
		}
		.calenderContainer .calenderBtnDiv button{
			height: 100%;
		}
		.calenderContainer .calenderTitleDiv{
			text-align: center;
			font-size: 1.2rem;
			font-weight: bold;
		}
		.calenderContainer a{
			text-decoration: none;
			color: black;
		}
		.calenderContainer .moveImgDiv img{
			height: 40px;
			width: 20px;
		}
		.calenderContainer .resetImgDiv img{
			height: 40px;
			width: 40px;
		}
		.calenderContainer #btnEnterCheck{
			width: 100%;
			border-radius: 50px;
			background-color : white;
			box-shadow: 1px 1px 1px 1px gray;
		}
		.calenderContainer #btnEnterCheck:hover{
			background-color : rgb(240, 240, 240);
		}
		
		.calenderDayShell{
			margin: 10px;
			height: 85px;
			border-radius: 10px;
			box-shadow: 1px 1px 1px 1px gray;
		}
		.calenderDayShell .shellValue{
			padding-left: 10px;
			height: 20%;
		}
		.calenderDayShell .shellContent{
			text-align: center;
			height: 80%;
		}
		.calenderDayShell .shellContent .checkImg{
			width : 70%;
			height: 80%;
		}
		
		.fillWhiteColor{
			background-color: white;
		}
		.fillGrayColor{
			background-color: rgb(200, 200, 200);
		}
	
	
	
	</style>
</head>
<body>
	
	<c:choose>
		<c:when test="${done eq 'done'}">
			<script>alert("출석완료.");</script>
		</c:when>
		<c:when test="${done eq 'fail'}">
			<script>alert("출석실패.");</script>
		</c:when>
		<c:when test="${done eq 'exsit'}">
			<script>alert("이미 출석함.");</script>
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>

	<!-- 헤더 -->
	<%@include file="../header.jsp" %>

	<!-- 마이페이지 헤더 -->
	<%@include file="mypageNavi.jsp" %>
	
	<div class="container mainContent">
		<div class="row">
			<div class="d-sm-none d-md-block col-md-2"></div>
			
			<div class="col calenderContainer">
				<div class="row calenderBtnDiv">
					<div class="col-1 resetImgDiv">
						<a href="${pageContext.request.contextPath}/mypageAttend/toCheckPage?selectMonth=0">
							<img src="${pageContext.request.contextPath}/resources/images/resetImg.png">
						</a>
					</div>
					<div class="col-2"><h5 style="font-weight: bold; padding-top:20px;">${calendarInfo.year}년</h5></div>
					<div class="col-1 moveImgDiv">
						<h1>
							<a href="${pageContext.request.contextPath}/mypageAttend/toCheckPage?selectMonth=${selectMonth-1}">
								<img src="${pageContext.request.contextPath}/resources/images/Back_icons8.png">
							</a>
						</h1>
					</div>
					<div class="col">
						<h1>${calendarInfo.month}월 출석</h1>
					</div>
					<div class="col-1 moveImgDiv">
						<h1>
							<a href="${pageContext.request.contextPath}/mypageAttend/toCheckPage?selectMonth=${selectMonth+1}">
								<img src="${pageContext.request.contextPath}/resources/images/Forward_icons8.png">
							</a>
						</h1>
					</div>
					<div class="col-1"></div>
					<div class="col-2">
						<button type="button" id="btnEnterCheck"><b>출석</b></button>
					</div>
				</div>
			
				<div class="row calenderTitleDiv">
					<div class="col">일</div>
					<div class="col">월</div>
					<div class="col">화</div>
					<div class="col">수</div>
					<div class="col">목</div>
					<div class="col">금</div>
					<div class="col">토</div>
				</div>
				
				<!-- 1줄 -->
				<div class="row calenderDayDiv">
					<c:forEach var="i" begin="1" end="7">
						<c:choose>
						
							<c:when test="${i < calendarInfo.firstDay}">
								<div class="col calenderDayShell fillGrayColor"></div>
							</c:when>
							
							<c:otherwise>
								<div class="col calenderDayShell fillWhiteColor">	<!-- 칸 수에서 시작되는 날만큼 뺌// 실제 일 -->
									<div class="row shellValue">${(i+1)-calendarInfo.firstDay}</div>
									<div class="row shellContent">
										<c:forEach items="${enteredDays}" var="enteredDays">	<!-- 리스트를 돌려가며 해당일에 출석을 했는지 검사함 -->
											<c:if test="${enteredDays eq (i+1)-calendarInfo.firstDay}">	<!-- 만약 출석했을경우 내용을 입력함 -->
												<div class="col"><img class="checkImg" src="${pageContext.request.contextPath}/resources/images/check_Img.png"></div>
											</c:if>	
										</c:forEach>
									</div>
								</div>	
							</c:otherwise>
							
						</c:choose>
					</c:forEach>
				</div>
				
				<!-- 2줄~6줄 -->
				<c:forEach var="j" begin="1" end="5">
				
					<div class="row calenderDayDiv">
						<c:forEach var="i" begin="${(j*7)+1}" end="${(j*7)+7}">
							<c:choose>
							
								<c:when test="${(i+1)-calendarInfo.firstDay <= calendarInfo.numberOfDays}">	<!-- 실제 일이 마지막 일보다 작거나 클 경우 출력 -->
									<div class="col calenderDayShell fillWhiteColor">
										<div class="row shellValue">${(i+1)-calendarInfo.firstDay}</div>
										<div class="row shellContent">
											<c:forEach items="${enteredDays}" var="enteredDays">	<!-- 리스트를 돌려가며 해당일에 출석을 했는지 검사함 -->
												<c:if test="${enteredDays eq (i+1)-calendarInfo.firstDay}">	<!-- 만약 출석했을경우 내용을 입력함 -->
													<div class="col"><img class="checkImg" src="${pageContext.request.contextPath}/resources/images/check_Img.png"></div>
												</c:if>	
											</c:forEach>
										</div>
									</div>
								</c:when>
								
								<c:otherwise>
									<div class="col calenderDayShell fillGrayColor"></div>
								</c:otherwise>
								
							</c:choose>
						</c:forEach>
					</div>
					
				</c:forEach>

				
			</div>

			<div class="d-sm-none d-md-block col-md-2"></div>
		</div>
	</div>

	<!-- 푸터 -->
	<%@include file="../footer.jsp" %>

	<script>
		// 출석버튼 클릭 시
		$("#btnEnterCheck").on("click", function(){
			$(location).attr("href", "${pageContext.request.contextPath}/mypageAttend/enterCheckProc");
		});

	</script>

</body>
</html>