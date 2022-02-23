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
<title>회원 목록</title>
<style>
#searchBtn {
	border: 1px solid black;
	background-color: white;
	color: black;
	border-radius: 5px;
	height: 38px;
	width: 50px;
}

#searchBtn:hover {
	color: white;
	background-color: black;
}

#activeBtn {
	border: 1px solid green;
	background-color: white;
	color: green;
	border-radius: 5px;
	height: 38px;
}

#activeBtn:hover {
	color: white;
	background-color: green;
}

#banBtn {
	border: 1px solid red;
	background-color: white;
	color: red;
	border-radius: 5px;
	height: 38px;
}

#banBtn:hover {
	color: white;
	background-color: red;
}

#changeBtn {
	border: 1px solid blue;
	background-color: white;
	color: blue;
	border-radius: 5px;
	height: 38px;
}

#changeBtn:hover {
	color: white;
	background-color: blue;
}

.num_box {
	margin: 0 7px 0 7px;
	border-width: 0px;
	font-weight: bold;
	color: black;
	font-size: 18px;
	text-decoration: none;
}

.num_box:hover {
	color: gray;
}

.txt_point {
	-ms-transform: scale(1.5); /* IE */
	-moz-transform: scale(1.5); /* FF */
	-webkit-transform: scale(1.5); /* Safari and Chrome */
	-o-transform: scale(1.5); /* Opera */
	background-color: smokewhite;
	-webkit-border-top-left-radius: 3px;
	-moz-border-radius-topleft: 3px;
	border-top-left-radius: 3px;
	-webkit-border-top-right-radius: 3px;
	-moz-border-radius-topright: 3px;
	border-top-right-radius: 3px;
	-webkit-border-bottom-right-radius: 3px;
	-moz-border-radius-bottomright: 3px;
	border-bottom-right-radius: 3px;
	-webkit-border-bottom-left-radius: 3px;
	-moz-border-radius-bottomleft: 3px;
	border-bottom-left-radius: 3px;
	text-indent: 0;
	border: 1px solid black;
	display: inline-block;
	color: blue;
	font-size: 12px;
	width: 16px;
	height: 16px;
	line-height: 16px;
	text-decoration: none;
	text-align: center;
	padding-bottom: 15px;
	text-shadow: 1px 1px 0px #ffffff;
}

.txt_point, .txt_point a:link, .txt_point a:visited, .txt_point a:active,
	a.txt_point:link, a.txt_point:visited, a.txt_point:hover, a.txt_point:active
	{
	color: blue;
}

table {
	background-color: rgb(245, 245, 245);
}

.table-title {
	padding-bottom: 15px;
	background: #f8f9fa;
	color: black;
	border-radius: 3px 3px 0 0;
	text-align: center;
}

.title-member {
	padding: 50px;
	font-size: 40px;
	font-weight: bold;
}

.member-status, .member-search {
	padding: 20px;
}

* {
	box-sizing: border-box;
}

.dynamic-tr>td {
	vertical-align: middle;
}

thead>th {
	text-align: center;
}

.tr_content:hover{
    background-color : rgb(230, 230, 230);
}
</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
	<form action="${pageContext.request.contextPath}/member/changeState.do"
		method="post">
		<div class="container">
			<div class="table-title">
				<div class="row">
					<div class="col title-member">
						<div>회원 목록</div>
					</div>
				</div>

				<div class="row justify-content-end member-search">
					<div class="col col-6"></div>
					<div class="col-1">
						<select id="searchOption" class="form-select"
							style="width: 100px; float: right;">
							<option value="all" selected>전체</option>
							<option value="id">아이디</option>
							<option value="name">이름</option>
						</select>
					</div>
					<div class="col-1">
						<select id="rank" class="form-select" style="width: 100px;">
							<option value="All" selected>전체</option>
							<option value="브론즈">브론즈</option>
							<option value="실버">실버</option>
							<option value="골드">골드</option>
							<option value="플래티넘">플래티넘</option>
							<option value="다이아몬드">다이아몬드</option>
						</select>
					</div>
					<div class="col-2">
						<div class="input-group">
							<input type="text" id="keyword" class="form-control"
								name="keyword" onkeyup="enterkey()">
							<button type="button" id="searchBtn">검색</button>
						</div>
					</div>
				</div>
				<div class="row member-status">
					<div class="col-12" style="text-align: right;">
						<button type="button" id="activeBtn">활동</button>
						<button type="button" id="banBtn">정지</button>
						<button type="button" id="changeBtn">회원 상태 저장</button>
					</div>
				</div>
			</div>
			<table class="table">
				<thead>
					<tr>
						<th class="col-2"><input type="checkbox" id="checkAll"></th>
						<th class="col-2">ID</th>
						<th class="col-2">이름</th>
						<th class="col-2">가입일</th>
						<th class="col-1">등급</th>
						<th class="col-1">신고 횟수</th>
						<th class="col-2">상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="dto">
						<tr class="tr_content">
							<td><input type="checkbox" value="${dto.id}" name="chk"></td>
							<td><input type="text" class="changeDTO id"
								value="${dto.id}" hidden>${dto.id}</td>
							<td>${dto.name}</td>
							<td>${dto.signup_date}</td>
							<td><c:choose>
									<c:when test="${dto.total_point >= 3000}">다이아</c:when>
									<c:when test="${dto.total_point >= 1000 and dto.total_point < 3000}">플래티넘</c:when>
									<c:when test="${dto.total_point >= 300 and dto.total_point < 1000}">골드</c:when>
									<c:when test="${dto.total_point >= 100 and dto.total_point < 300}">실버</c:when>
									<c:when test="${dto.total_point < 100}">브론즈</c:when>
								</c:choose></td>
							<td>${dto.reported_count}</td>
							<td><select class="form-select changeDTO state">
									<c:if test="${dto.state eq '활동'}">
										<option value="활동" selected>활동</option>
										<option value="정지">정지</option>
									</c:if>
									<c:if test="${dto.state eq '정지'}">
										<option value="활동">활동</option>
										<option value="정지" selected>정지</option>
									</c:if>
							</select></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<nav aria-label="Page navigation">
				<ul class="pagination justify-content-center">

					<c:if test="${naviMap ne null and searchNaviMap eq null}">
						<!-- 이전버튼 -->
						<c:choose>
							<c:when test="${naviMap.needPrev eq true}">
								<li class="page-item"><a class="num_box "
									href="${pageContext.request.contextPath}/member/toMemberList?currentPage=${naviMap.startNavi - 1}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="num_box ">이전</a></li>
							</c:otherwise>
						</c:choose>

						<!-- 번호버튼 -->
						<c:forEach var="i" begin="${naviMap.startNavi}"
							end="${naviMap.endNavi}">
							<c:choose>
								<c:when test="${naviMap.currentPage eq i}">
									<!-- 현재 페이지의 li 만 active 해줌 -->
									<li class="page-item active"><a class="num_box txt_point"
										href="${pageContext.request.contextPath}/member/toMemberList?currentPage=${i}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="num_box "
										href="${pageContext.request.contextPath}/member/toMemberList?currentPage=${i}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<!-- 다음버튼 -->
						<c:choose>
							<c:when test="${naviMap.needNext eq true}">
								<li class="page-item"><a class="num_box "
									href="${pageContext.request.contextPath}/member/toMemberList?currentPage=${naviMap.endNavi + 1}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="num_box ">다음</a></li>
							</c:otherwise>
						</c:choose>
					</c:if>

					<c:if test="${naviMap eq null and searchNaviMap ne null}">
						<!-- 검색시 페이징 버튼 -->
						<!-- 이전버튼 -->
						<c:choose>
							<c:when test="${searchNaviMap.needPrev eq true}">
								<li class="page-item"><a class="num_box"
									href="${pageContext.request.contextPath}/member/toSearchList?&searchOption=${searchOption}&rank=${rank}&keyword=${keyword}&currentPage=${searchNaviMap.startNavi - 1}">이전</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="num_box">이전</a></li>
							</c:otherwise>
						</c:choose>

						<!-- 번호버튼 -->
						<c:forEach var="i" begin="${searchNaviMap.startNavi}"
							end="${searchNaviMap.endNavi}">
							<c:choose>
								<c:when test="${searchNaviMap.currentPage eq i}">
									<!-- 현재 페이지의 li 만 active 해줌 -->
									<li class="page-item active"><a class="num_box txt_point"
										href="${pageContext.request.contextPath}/member/toSearchList?searchOption=${searchOption}&rank=${rank}&keyword=${keyword}&currentPage=${i}">${i}</a></li>
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="num_box"
										href="${pageContext.request.contextPath}/member/toSearchList?searchOption=${searchOption}&rank=${rank}&keyword=${keyword}&currentPage=${i}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>

						<!-- 다음버튼 -->
						<c:choose>
							<c:when test="${searchNaviMap.needNext eq true}">
								<li class="page-item"><a class="num_box"
									href="${pageContext.request.contextPath}/member/toSearchList?searchOption=${searchOption}&rank=${rank}&keyword=${keyword}&currentPage=${searchNaviMap.endNavi + 1}">다음</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled"><a class="num_box">다음</a></li>
							</c:otherwise>
						</c:choose>
					</c:if>
				</ul>
			</nav>
		</div>
	</form>
	<%@include file="../footer.jsp"%>
	<script>
	// 체크박스 전체 선택
	$("#checkAll").click(function() {
		if ($("#checkAll").prop("checked")) {
			$("input[name=chk]").prop("checked", true);
		} else {
			$("input[name=chk]").prop("checked", false);
		}
	})
	
	// 체크된 회원들 활동으로 변경
	$("#activeBtn").click(function(){
		if($("input:checkbox[name='chk']:checked").length == 0){
			alert("선택된 회원이 없습니다.");
			return
		}
		
		let id = [];
		
		$("input:checkbox[name='chk']:checked").each(function(e, eVal){
			id.push(eVal.value);
		})
		
		location.href="${pageContext.request.contextPath}/member/activeState.do?id=" + id;
	})
	
	// 체크된 회원들 정지로 변경
	$("#banBtn").click(function(){
		if($("input:checkbox[name='chk']:checked").length == 0){
			alert("선택된 회원이 없습니다.");
			return
		}
		
		let id = [];
		
		$("input:checkbox[name='chk']:checked").each(function(e, eVal){
			id.push(eVal.value);
		})
		
		location.href="${pageContext.request.contextPath}/member/banState.do?id=" + id;
	})
	
	// 회원 상태 저장
	$("#changeBtn").click(function(){
		let id = [];
		let state = [];
		
		$(".id").each(function(e, item){
			id.push(item.value);
		})
		$(".state").each(function(e, item){
			state.push(item.value);
		})
		
		location.href = "${pageContext.request.contextPath}/member/changeState.do?id=" + id + "&state=" + state;
	})
	
	// 검색
    $("#searchBtn").on("click", function(){
    	let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;
		
		if(!searchRegx.test($("#keyword").val())){
			if($("#keyword").val != ""){
	    		let searchOption = $("#searchOption").val();
	    		let rank = $("#rank").val();
	    		let keyword = $("#keyword").val();
	    		console.log(searchOption + " : " + rank + " : "+ keyword);
	    		
	    		let url = "${pageContext.request.contextPath}/member/toSearchList?searchOption=" + searchOption + "&rank=" + rank + "&keyword=" + keyword + "&currentPage=1";
	    		$(location).attr("href", url);
	    	}
		}
		else{
			alert("특수문자를 포함할 수 없습니다.");
			$("#keyword").val("");
		}
    })
    
    // 검색 (엔터키 입력시)
		function enterkey() {
			if (window.event.keyCode == 13) {
				let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;
				
				if(!searchRegx.test($("#keyword").val())){
					if($("#keyword").val != ""){
			    		let searchOption = $("#searchOption").val();
			    		let rank = $("#rank").val();
			    		let keyword = $("#keyword").val();
			    		console.log(searchOption + " : " + rank + " : "+ keyword);
			    		
			    		let url = "${pageContext.request.contextPath}/member/toSearchList?searchOption=" + searchOption + "&rank=" + rank + "&keyword=" + keyword + "&currentPage=1";
			    		$(location).attr("href", url);
			    	}
				}
				else{
					alert("특수문자를 포함할 수 없습니다.");
					$("#keyword").val("");
				}
			}
		}	
	</script>
</body>
</html>