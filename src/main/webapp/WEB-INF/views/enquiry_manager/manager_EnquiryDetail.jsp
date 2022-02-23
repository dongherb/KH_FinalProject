<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<title>관리자 페이지:: 문의글 상세보기</title>
<style>
.container {
	margin-bottom: 150px;
}

.title {
	margin-bottom: 10px;;
}

.answer>img {
	width: 25px;
	height: 25px;
}
.rowBorder {
	padding: 10px;
}

.rowBorder-btn {
	padding: 10px;
	margin-bottom: 20px;
}

.form-label {
	padding: 10px;
}

.contentForm {
	padding-left: 5px;
}

.content{
margin-top: 5px;
}

.admin {
margin-left: 10px;
}

.date{
padding-top: 5px;
}


</style>
</head>
<body>
	<%@include file="../managerHeader.jsp"%>
		<div class="container w-50">
		<input class="d-none" name="enquiry_seq" value="0">
		<div class="row">
			<div class="col d-flex justify-content-center title">
				<h3>관리자 문의사항 답변</h3>
			</div>
		</div>

		<div class="row rowBorder">
			<div class="col-3">
				<div class="form-control" readonly>제목: ${dto.title}</div>
			</div>

			<div class="col-3">
				<div class="form-control" readonly>문의유형: ${dto.category}</div>
			</div>

			<div class="col-3">
				<div class="form-control" readonly>문의일: ${dto.enquiry_date}</div>
			</div>

			<div class="row rowBorder">
				<div class="col content">
					<label for="content" class="form-label"><b>문의 내용</b></label>
					<textarea class="form-control contentForm" id="content" name="content" rows="10" style="resize: none;"  readonly>${dto.content}</textarea>
				</div>
			</div>
		</div>
				<div class="container w-90">
					<form id="cmtForm" name="commentForm" method="post">
						<div class="row rowBorder">
							<div class="col commentTitle">
								<h5>Comments</h5>
							</div>
							<div class="row">
								<div class="col ">
									<textarea class="form-control answer" id="answer" name="answer" rows="3" style="resize: none;"  placeholder=" 답글을입력하세요"></textarea>
								</div>
							</div>

							<div class="row rowBorder-btn">
								<div class="col d-grid d-md-flex justify-content-md-end">
									<button type="button" class="btn btn-dark btn-sm" id=btnSubmitCmt>답글 등록</button>
								
								</div>
							</div>

							<div class="container w-90 cmt-container ">
								<div class="cmt-showBox" style="padding: 10px;"></div>
							</div>
						</div>
						<input type="text" id="enquiry_seq" name="enquiry_seq" value="${dto.enquiry_seq}" hidden>
					</form>
				</div>
			</div>
	<%@include file="../footer.jsp"%>
	<script>
	//댓글 등록
	$(document).ready(function(){
		getCommentList();
	//#btnSubmitCmt : 댓글 등록 버튼
	//#cmtForm : 댓글 폼
	//#answer : 댓글 내용
	$("#btnSubmitCmt").on("click",function(){
		let answer = $(".answer");
		let data = $("#cmtForm").serialize();
		$("#answer").val("");
		$.ajax({
			url : "${pageContext.request.contextPath}/enquiry/insertComment.co"
			, type : "post"
			, data : data
		}).done(function(rs){
			console.log(rs)
			if(rs == "success"){
				getCommentList();
			}else if(rs == "fail"){
				alert("댓글 등록 실패");
			}			
		}).fail(function(e){
			console.log(e);
		});
	});

	//댓글 목록
	function getCommentList() {
		$.ajax(
			{type : "get"
			 ,url : "${pageContext.request.contextPath}/enquiry/getComment.co?enquiry_seq=${dto.getEnquiry_seq()}"
			 ,dataType : "json"
			}).done(function(data) {
			 $(".cmt-showBox").empty(); 
				let comment = "<div class='col commentContent'>"
				+ "<div class='col admin'> <img src='${pageContext.request.contextPath}/resources/image/admin.png'>관리자  &nbsp; "
				+ data.answer_date
				+ "</div>"
				+ "<div class='col d-flex justify-content-start contentDiv-cmt'>"
				+ "<textarea style='resize: none;' class='form-control' id='answer' name='answer' rows='3'readonly>"
				+ data.answer
				+ "</textarea>"
				+ "</div>"
				+ "</div>";
				$(".cmt-showBox").append(comment);
				let btns = "<div class='row rowBorder-btn'>"			
					+"<div class='col d-flex justify-content-end rowBorder-btn'>"				
	          		+ "<button type='button' id='deleteCmtBtn' class='btn deleteCmtBtn btn-danger btn-sm' value='" + data.enquiry_seq + "'>삭제</button>"          
	          		+ "</div>";
	          		+ "</div>";
				$(".contentDiv-cmt:last").after(btns);
				
		}).fail(function(e) {
			console.log(e);
		});
	};
						
    // 댓글 삭제
    $(document).on("click","#deleteCmtBtn",function(){
	    let rs = confirm("댓글을 삭제하시겠습니까?");
		    if(rs) {
			    let seq = $("#enquiry_seq").val();
			    console.log(seq);
            location.href = "${pageContext.request.contextPath}/enquiry/deleteEnquiryCmt.co?enquiry_seq=" + seq
	    }
    });
    });	
	</script>
</body>
</html>