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
<title>공지사항 목록</title>
<style>
a.toNoticeDetail {
	color: black;
	text-decoration: none;
}

a.toNoticeDetail:hover {
	color: gray;
}

#searchBtn {
	border: 1px solid black;
	background-color: white;
	color: black;
	border-radius: 5px;
	height: 38px;
}

#searchBtn:hover {
	color: white;
	background-color: black;
}

#deleteBtn {
	border: 1px solid #DC143C;
	background-color: white;
	color: #DC143C;
	border-radius: 5px;
	height: 38px;
}

#deleteBtn:hover {
	color: white;
	background-color: #DC143C;
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
	table-layout: fixed
}

* {
	box-sizing: border-box;
}

.table-title {
	padding-bottom: 15px;
	background: #f8f9fa;
	color: black;
	border-radius: 3px 3px 0 0;
	text-align: center;
}

.title-notice {
	padding: 50px;
	font-size: 40px;
	font-weight: bold;
}

.notice-List, .notice-search {
	padding: 20px;
}

.dynamic-tr>td {
	vertical-align: middle;
}
</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
	<div class="container">
		<div class="table-title">
			<div class="row">
				<div class="col title-notice">
					<div>공지사항 목록</div>
				</div>
			</div>

			<div class="row notice-search">
				<div class="col col-10 justify-content-start"
					style="text-align: left">
					<button type="button" class="btn btn-danger" id="deleteBtn">선택삭제</button>
				</div>
				<div class="col-2 justify-content-end">
					<div class="input-group">
						<input type="text" id="keyword" class="form-control"
							name="keyword" onkeyup="enterkey()">
						<button type="button" id="searchBtn" class="btn btn-primary">검색</button>
					</div>
				</div>
			</div>

		</div>
		<table class="table table-hover dynamic-table"
			style="text-align: center">
			<thead class="table-light">
				<tr class="text-center">
					<th class="col-1"><input type="checkbox" id="checkAll"></th>
					<th class="col-1">번호</th>
					<th class="col-5">제목</th>
					<th class="col-2">등록일</th>
					<th class="col-1">수정</th>
					<th class="col-1">삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list}">
					<tr>
						<td colspan="6">현재 등록된 공지사항이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${list}" var="dto">
					<tr class="text-center dynamic-tr">
						<td><input type="checkbox" value="${dto.notice_seq}"
							name="chk"></td>
						<td>${dto.notice_seq}</td>
						<td><a
							href="${pageContext.request.contextPath}/notice/toDetail?notice_seq=${dto.notice_seq}"
							class="toNoticeDetail">${dto.title}</a></td>
						<td>${dto.written_date}</td>
						<td><button type="button" class="btn toModifyNotice"
								value="${dto.notice_seq}">✏️</button>
						<td><button type="button" class="btn toDeleteNotice"
								value="${dto.notice_seq}">❌</button>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 페이징버튼 -->
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">

				<c:if test="${naviMap ne null and searchNaviMap eq null}">
					<!-- 이전버튼 -->
					<c:choose>
						<c:when test="${naviMap.needPrev eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/notice/toNoticeList?currentPage=${naviMap.startNavi - 1}">이전</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="num_box">이전</a></li>
						</c:otherwise>
					</c:choose>

					<!-- 번호버튼 -->
					<c:forEach var="i" begin="${naviMap.startNavi}"
						end="${naviMap.endNavi}">
						<c:choose>
							<c:when test="${naviMap.currentPage eq i}">
								<!-- 현재 페이지의 li 만 active 해줌 -->
								<li class="page-item active"><a class="num_box txt_point"
									href="${pageContext.request.contextPath}/notice/toNoticeList?currentPage=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="num_box"
									href="${pageContext.request.contextPath}/notice/toNoticeList?currentPage=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음버튼 -->
					<c:choose>
						<c:when test="${naviMap.needNext eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/notice/toNoticeList?currentPage=${naviMap.endNavi + 1}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="num_box">다음</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>

				<c:if test="${naviMap eq null and searchNaviMap ne null}">
					<!-- 검색시 페이징 버튼 -->
					<!-- 이전버튼 -->
					<c:choose>
						<c:when test="${searchNaviMap.needPrev eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/notice/toSearchList?keyword=${keyword}&currentPage=${searchNaviMap.startNavi - 1}">이전</a></li>
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
									href="${pageContext.request.contextPath}/notice/toSearchList?keyword=${keyword}&currentPage=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="num_box"
									href="${pageContext.request.contextPath}/notice/toSearchList?keyword=${keyword}&currentPage=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음버튼 -->
					<c:choose>
						<c:when test="${searchNaviMap.needNext eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/notice/toSearchList?keyword=${keyword}&currentPage=${searchNaviMap.endNavi + 1}">다음</a></li>
						</c:when>
						<c:otherwise>
							<li class="page-item disabled"><a class="num_box">다음</a></li>
						</c:otherwise>
					</c:choose>
				</c:if>
			</ul>
		</nav>
	</div>
	<%@include file="../footer.jsp"%>
	<script>
	$(".toModifyNotice").on("click", function(e){
	   	 console.log($(e.target).val());
	   	 let notice_seq = $(e.target).val();
	   	 location.href = "${pageContext.request.contextPath}/notice/toModifyNotice?notice_seq=" + notice_seq;
	    })
	    
	    $(".toDeleteNotice").on("click", function(e){
	   	 console.log($(e.target).val());
	   	 let notice_seq = $(e.target).val();
	   	 location.href = "${pageContext.request.contextPath}/notice/deleteNotice.do?notice_seq=" + notice_seq;
	    })
	    
	    // 체크박스 전체 선택
	   $("#checkAll").click(function(){
	    	if($("#checkAll").prop("checked")){
	    		$("input[name=chk]").prop("checked", true);
	    	}else{
	    		$("input[name=chk]").prop("checked", false);
	    	}
	   })
	   
	   // 체크된 목록 삭제
	   $("#deleteBtn").click(function(){
	   	if($("input:checkbox[name='chk']:checked").length == 0){
	   		alert("선택된 공지사항이 없습니다.");
	   		return;
	   	}
	   	
	   	let chk_Val = [];
	   	
	   	if(confirm("선택된 " + $("input:checkbox[name='chk']:checked").length
	   			+ "개의 공지사항을 정말로 삭제하시겠습니까?")){
	   		$("input:checkbox[name='chk']:checked").each(function(e, eVal){
	       		chk_Val.push(eVal.value);
	       	});
	       	location.href = "${pageContext.request.contextPath}/notice/deleteChecked.do?chk_Val=" + chk_Val;
	   	}
	   }) 
	   
	   // 검색
	   $("#searchBtn").on("click", function(){
    	let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;
		
		if(!searchRegx.test($("#keyword").val())){
			if($("#keyword").val != ""){
		   		let keyword = $("#keyword").val();
		   		console.log(keyword);
		   		
		   		let url = "${pageContext.request.contextPath}/notice/toSearchList?keyword=" + keyword + "&currentPage=1";
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

				if (!searchRegx.test($("#keyword").val())) {
					if ($("#keyword").val != "") {
						let keyword = $("#keyword").val();
						console.log(keyword);

						let url = "${pageContext.request.contextPath}/notice/toSearchList?keyword="
								+ keyword + "&currentPage=1";
						$(location).attr("href", url);
					}
				} else {
					alert("특수문자를 포함할 수 없습니다.");
					$("#keyword").val("");
				}
			}
		}
	</script>
</body>
</html>