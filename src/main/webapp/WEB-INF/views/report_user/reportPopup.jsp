<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<style>
     .row{
         padding:5px;
     }
     .box-row{
         text-align:center;
     }
</style>
</head>
<body>
<c:choose>
    <c:when test="${done eq 'done'}">
        <script>
            alert("신고가 접수되었습니다.");
            window.close();
        </script>
    </c:when>
    <c:when test="${done eq 'fail'}">
        <script>
            alert("신고에 실패했습니다. 다시 시도해주세요");
            window.close();
        </script>
    </c:when>
    <c:when test="${done eq 'alreadyReport'}">
        <script>
            alert("이미 신고한 리뷰입니다.");
            window.close();
        </script>   
    </c:when>
    <c:otherwise></c:otherwise>
</c:choose>
     <form id="reportForm" action="${pageContext.request.contextPath}/report/insertReport.do?review_seq=${review_seq}" method="post">
          <div class="container">
              <div class="row">
                  <label class="label-form form-select-sm">신고 사유</label>
                  <div class="col">
                      <select class="form-select" name="category">
                          <option value="욕설">욕설</option>
                          <option value="제품과는 관계없는 내용(광고 등)">제품과는 관계없는 내용(광고 등)</option>
                          <option value="도배">도배</option>
                          <option value="기타">기타</option>
                      </select>
                  </div>
              </div>
              <div class="row">
                  <label class="label-form form-select-sm">상세 설명</label>
                  <div class="col">
                      <textarea name="reason" id="reason" style="width:100%; height: 300px; resize:none"></textarea>
                  </div>
              </div>
              <div class="row box-row">
                  <div class="col">
                      <button type="button" class="btn btn-secondary" id="cancelBtn">취소</button>
                      <button type="button" class="btn btn-warning" id="submitBtn">제출</button>
                  </div>
              </div>
          </div>
          <div>
              <!-- 신고자 아이디 -->
              <input type="text" name="id" id="loginSession" value="${loginSession.id}" hidden>
              <!-- 신고 당한 아이디 -->
              <input type="text" id="reportedId" name="reportedId" value="${id}" hidden>
          </div>
     </form>
     <script>
          // 취소 버튼
          document.getElementById("cancelBtn").onclick = function(){
        	  self.close();
          }
          
          // 신고 제출 버튼
          document.getElementById("submitBtn").onclick = function(){
        	  let loginSession = $("#loginSession").val();
        	  let reason = $("#reason").val();
        	  let reportedId = $("#reportedId").val();
        	  
        	  if(loginSession == ""){
        		  alert("로그인 후 진행해주세요.");
        		  window.close();
        	  }else if(reason == ""){
        		  alert("상세 설명을 입력해주세요.");
        		  return;
        	  }else if(loginSession == reportedId){
        		  alert("자신이 작성한 리뷰를 신고할 수 없습니다.");
        		  window.close();
        	  }else{
            	  document.getElementById("reportForm").submit();  
        	  }
          }
     </script>
</body>
</html>