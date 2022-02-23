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
<title>신고 목록</title>
<style>
.container_All {
	width: 1600px;
	text-align: center;
	margin: auto;
}

.row {
	padding: 5px;
}

a.toReview {
	color: black;
	text-decoration: none;
}

a.toReview:hover {
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

#deleteReport {
	border: 1px solid red;
	background-color: white;
	color: red;
	border-radius: 5px;
	height: 38px;
}

#deleteReport:hover {
	color: white;
	background-color: red;
}

#deleteReview {
	border: 1px solid #ff7f00;
	background-color: white;
	color: #ff7f00;
	border-radius: 5px;
	height: 38px;
}

#deleteReview:hover {
	color: white;
	background-color: #ff7f00;
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
	table-layout: fixed;
}

.dynamic-tr>td {
	vertical-align: middle;
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

.title-report {
	padding: 50px;
	font-size: 40px;
	font-weight: bold;
}
</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
	<div class="container">
		<div class="table-title">
			<div class="row">
				<div class="col title-report">
					<div>신고 목록</div>
				</div>
			</div>

			<div class="row report-search">
				<div class="col-8 justify-content-start" style="text-align: left">
					<button type="button" id="deleteReview" class="btn btn-warning">선택리뷰
						삭제</button>
					<button type="button" id="deleteReport" class="btn btn-danger">선택신고
						삭제</button>
				</div>

				<div class="col-1">
					<select id="searchOption" class="form-select"
						style="width: 100px; height: 100%; float: right;">
						<option value="all" selected>전체</option>
						<option value="id">신고자아이디</option>
						<option value="review">리뷰 내용</option>
						<option value="reason">신고 사유</option>
					</select>
				</div>

				<div class="col-1">
					<select id="reportCategory" class="form-select"
						style="width: 100px;">
						<option value="All" selected>전체</option>
						<option value="욕설">욕설</option>
						<option value="제품과는 관계없는 내용(광고 등)">제품과는 관계없는 내용(광고 등)</option>
						<option value="도배">도배</option>
						<option value="기타">기타</option>
					</select>
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


		<table class="table table-hover dynamic-table">
			<thead class="table-light">
				<tr class="text-center">
					<th class="col-1"><input type="checkbox" id="checkAll"></th>
					<th class="col-1">번호</th>
					<th class="col-1">아이디</th>
					<th class="col-1">카테고리</th>
					<th class="col-3">리뷰 내용 (리뷰 페이지 이동)</th>
					<th class="col-3">신고 사유</th>
					<th class="col-1">리뷰 삭제</th>
					<th class="col-1">신고 삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${empty list_report}">
					<tr>
						<td colspan="12" style="text-align: center">현재 등록된 신고가 없거나
							검색된 내용이 존재하지 않습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${list_report}" var="dto">
					<tr class="text-center dynamic-tr">
						<td><input type="checkbox" value="${dto.report_seq}"
							name="chk"></td>
						<td>${dto.report_seq}</td>
						<td><c:forEach items="${list_review}" var="review">
								<c:if test="${review.review_seq eq dto.review_seq}">
									            ${review.id}
									        </c:if>
							</c:forEach></td>
						<td>${dto.category}</td>
						<td class="reviewContent${dto.review_seq}"><input
							type="button" id="review_seq" value="${dto.review_seq}" hidden>
							<span style="font-style: italic;">삭제된 리뷰</span> <c:forEach
								items="${list_review}" var="review">
								<c:if test="${review.review_seq eq dto.review_seq}">
									<script>
										$(".reviewContent${dto.review_seq}")
												.html(
														'<a href="${pageContext.request.contextPath}/product/toProductDetail?product_code=${review.product_code}" class="toReview">${review.content}</a>');
									</script>
								</c:if>
							</c:forEach></td>
						<td>${dto.reason}</td>
						<td><c:forEach items="${list_review}" var="review">
								<c:if test="${review.review_seq eq dto.review_seq}">
									<button type="button" value="${dto.review_seq}"
										category="${dto.category}" reason="${dto.reason}"
										reportedId="${review.id}" class="btn deleteReview">❌</button>
								</c:if>
							</c:forEach></td>
						<td>
							<button type="button" value="${dto.report_seq}"
								category="${dto.category}" reason="${dto.reason}"
								class="btn deleteReport">❌</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- 페이징버튼 -->
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<c:if test="${naviMap ne null and SearchNaviMap eq null}">
					<!-- 이전버튼 -->
					<c:choose>
						<c:when test="${naviMap.needPrev eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/report/toReportList?currentPage=${naviMap.startNavi - 1}">이전</a></li>
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
									href="${pageContext.request.contextPath}/report/toReportList?currentPage=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="num_box"
									href="${pageContext.request.contextPath}/report/toReportList?currentPage=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음버튼 -->
					<c:choose>
						<c:when test="${naviMap.needNext eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/report/toReportList?currentPage=${naviMap.endNavi + 1}">다음</a></li>
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
								href="${pageContext.request.contextPath}/report/toSearchList?category=${category}&searchOption=${searchOption}&keyword=${keyword}&currentPage=${searchNaviMap.startNavi - 1}">이전</a></li>
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
									href="${pageContext.request.contextPath}/report/toSearchList?category=${category}&searchOption=${searchOption}&keyword=${keyword}&currentPage=${i}">${i}</a></li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="num_box"
									href="${pageContext.request.contextPath}/report/toSearchList?category=${category}&searchOption=${searchOption}&keyword=${keyword}&currentPage=${i}">${i}</a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- 다음버튼 -->
					<c:choose>
						<c:when test="${searchNaviMap.needNext eq true}">
							<li class="page-item"><a class="num_box"
								href="${pageContext.request.contextPath}/report/toSearchList?category=${category}&searchOption=${searchOption}&keyword=${keyword}&currentPage=${searchNaviMap.endNavi + 1}">다음</a></li>
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
	// 신고 당한 리뷰 삭제
	$(".deleteReview").on("click", function(e){
    	let review_seq = $(e.target).val();
    	let reportedId = (e.target).getAttribute('reportedId');
    	let category = (e.target).getAttribute('category'); 
    	let reason = (e.target).getAttribute('reason');
    	
    	if(confirm("정말로 해당 리뷰를 삭제하시겠습니까?\n\n"
    			    + "작성자 ID : " + reportedId + "\n"
        			+ "카테고리 : " + category + "\n"
        			+ "신고 사유 : " + reason + "\n"
        			+ "")){
        	location.href = "${pageContext.request.contextPath}/review/deleteReviewProc?review_seq=" + review_seq + "&id=" + reportedId;
        }	
    })
    
    // 신고 삭제
	$(".deleteReport").on("click", function(e){
    	let report_seq = $(e.target).val();
    	let category = (e.target).getAttribute('category'); 
    	let reason = (e.target).getAttribute('reason');
    	
    	if(confirm("정말로 해당 신고를 삭제하시겠습니까?\n\n"
    			+ "카테고리 : " + category + "\n"
    			+ "신고 사유 : " + reason + "\n")){
    		location.href = "${pageContext.request.contextPath}/report/deleteReport.do?report_seq=" + report_seq;
    	}	
    })
    
	// 체크박스 전체 선택
    $("#checkAll").click(function(){
     	if($("#checkAll").prop("checked")){
     		$("input[name=chk]").prop("checked", true);
     	}else{
     		$("input[name=chk]").prop("checked", false);
     	}
    })
    
        // 체크된 신고 목록 삭제
        $("#deleteReport").click(function(){
        	if($("input:checkbox[name='chk']:checked").length == 0){
        		alert("선택된 신고가 없습니다.");
        		return;
        	}
        	
        	let chk_Val = [];
        	
        	if(confirm("선택된 " + $("input:checkbox[name='chk']:checked").length
        			+ "개의 신고를 정말로 삭제하시겠습니까?")){
        		$("input:checkbox[name='chk']:checked").each(function(e, eVal){
            		chk_Val.push(eVal.value);
            	});
            	location.href = "${pageContext.request.contextPath}/report/deleteChecked.do?chk_Val=" + chk_Val;
        	}
        })
        
        // 체크된 리뷰 목록 삭제
        $("#deleteReview").click(function(){
        	if($("input:checkbox[name='chk']:checked").length == 0){
        		alert("선택된 신고가 없습니다.");
        		return;
        	}
        	
        	let chk_Val = [];
        	
        	if(confirm("선택된 " + $("input:checkbox[name='chk']:checked").length
        			+ "개의 리뷰를 정말로 삭제하시겠습니까?")){
        		$("input:checkbox[name='chk']:checked").each(function(e, eVal){
            		chk_Val.push(eVal.value);
            	});
            	location.href = "${pageContext.request.contextPath}/review/deleteChecked.do?chk_Val=" + chk_Val;
        	}
        })
        
        // 검색
		$("#searchBtn").on("click", function() {
			let searchRegx = /[~`!@#$%^&*()_+.\\|]/gm;

			if (!searchRegx.test($("#keyword").val())) {
				if ($("#keyword").val != "") {
					let searchOption = $("#searchOption").val();
					let category = $("#reportCategory").val();
					let keyword = $("#keyword").val();
					console.log(category + " : " + searchOption
							+ " : " + keyword);

					let url = "${pageContext.request.contextPath}/report/toSearchList?category="
							+ category
							+ "&searchOption="
							+ searchOption
							+ "&keyword="
							+ keyword
							+ "&currentPage=1";
					$(location).attr("href", url);
				}
			} else {
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
						let searchOption = $("#searchOption").val();
						let category = $("#reportCategory").val();
						let keyword = $("#keyword").val();
						console.log(category + " : " + searchOption
								+ " : " + keyword);

						let url = "${pageContext.request.contextPath}/report/toSearchList?category="
								+ category
								+ "&searchOption="
								+ searchOption
								+ "&keyword="
								+ keyword
								+ "&currentPage=1";
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