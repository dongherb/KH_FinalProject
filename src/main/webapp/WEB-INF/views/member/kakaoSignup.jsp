<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<title>카카오 회원가입</title>
<style>
.container {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-bottom:50px;
}

.inputForm div {
	margin: 0px;
	padding: 5px;
}

.title span{
	color: red;
	font-size: 11px;
}

.signupTitle {
	display: grid;
	place-items: center;
	text-align: left;
	font-weight: bold;
	border-right: 1px solid #e0e0e0;
	font-size:13px;
	color: #555555;
}

.signupRow {
	border-top: 1px solid #e0e0e0;
}

.signupSide {
	display: flex;
	align-items: center;
	font-size: 8px;
}

.signupSide span {
	color: #555555;
	text-align: center;
	font-size:12px;
}

.buttonBox {
	padding: 50px;
}

.termsBox {
	display: flex;
	justify-content: center;
	align-items: center;
	border: 1px solid #e0e0e0;
	padding: 15px;
}

.termsBox span {
	color: blue;
	font-size:15px;
	font-weight: bold;
}

.termsBox legend{
	font-size:15px;
	font-weight: bold;
}

.agree-group > label {
	font-size:13px;
}

.agreeText {
	width: 100%;
	height: 400px;
	resize: none;
	font-size:12px;	
}

#lastRow {
	border-bottom: 1px solid #e9e9e9;
}

#emailChk{
	margin-top : 10px;
}

</style>
</head>
<body>
 	<c:choose>
		<c:when test="${msg eq 'done'}">
			<script>alert("첫 카카오 로그인입니다. 추가정보를 입력해주세요");</script>			
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose> 
	<%@include file="../header.jsp"%>
	
		
				<div>&nbsp;</div>
				<div>&nbsp;</div>
				<div>&nbsp;</div>
		
		
	<form id="signupForm"
		action="${pageContext.request.contextPath}/member/signup.do"
		method="post">
		<div class="container">
			<div class="col-2"></div>

			<div class="col-8">
				<div class="row">
					<div class="col d-flex justify-content-center">
						<h2><b>카카오 회원가입</b></h2>
					</div>
				</div>

				<div>&nbsp;</div>
				<div>&nbsp;</div>
				<div>&nbsp;</div>

				<div class="row inputForm">
					<div class="row title">
						<h4>기본정보</h4>
							<span>(*표기는 필수입력)</span>
					</div>

					<div class="row d-none signupRow">
						<div class="col-2 signupTitle">*아이디</div>
						<div class="col-5 signupInput">
							<input type="text" class="form-control form-control-sm" id="id" name="id" check_result="fail" maxlength="20" value="${userInfo.id}">

						</div>
						<div class="col-4 signupSide">
							<button type="button" id="checkBtn" class="btn btn-danger">중복확인</button>
							<span>(영문 소문자/숫자 , 6~20자)</span>
						</div>
					</div>
					
					<div class="row d-none signupRow">
						<div class="col-2 signupTitle">*비밀번호</div>
						<div class="col-5 signupInput">
							<input type="password" class="form-control" id="pw" name="pw"
								maxlength="20">
						</div>
						<div class="col-4 signupSide">
							<span>(영문 대소문자/숫자/특수문자 사용가능,6~20자)</span>
						</div>
					</div>
					
					<div class="row signupRow">
						<div class="col-2 signupTitle">*이름</div>
						<div class="col-5 signupInput">
							<input type="text" class="form-control form-select-sm" id="name" name="name" value="${userInfo.name}" maxlength="50" readonly>
						</div>
						<div class="col-5 signupSide"></div>
					</div>
							

					<div class="row signupRow" id="emailRow">
						<div class="col-2 signupTitle">*이메일</div>
						<div class="col-5 signupInput">
							<input type="text" class="form-control form-select-sm" id="email" name="email" check_result="fail" value="${userInfo.email}"
								maxlength="30" readonly>							
						</div>
						<div class="col-5 signupSide">
						</div>
					</div>

					<div class="row signupRow">
						<div class="col-2 signupTitle">키</div>
						<div class="col-3 signupInput">
							<select class="form-select form-select-sm dropdownContainer" id="selectedHeight">
								<option value="-1">선택사항</option>
								<!-- 드롭다운으로 구성 -->
								<c:forEach var="i" begin="120" end="200">
									<option value="${i}">${i}cm</option>
								</c:forEach>
							</select> <input type="text" class="d-none" id="height" name="height">
						</div>
						<div class="col-2 signupTitle">몸무게</div>
						<div class="col-3 signupInput">
							<select class="form-select form-select-sm dropdownContainer" id="selectedWeight">
								<option value="-1">선택사항</option>
								<!-- 드롭다운으로 구성 -->
								<c:forEach var="i" begin="30" end="120">
									<option value="${i}">${i}kg</option>
								</c:forEach>
							</select> <input type="text" class="d-none" id="weight" name="weight">
						</div>
					</div>

					<div class="row signupRow">
						<div class="col-2 signupTitle">*생년월일</div>
						<div class="col-2 signupInput">
							<select class="form-select form-select-sm dropdownContainer"
								id="selectedBirth_date1">
								<option value="-1">년</option>
								<!-- 드롭다운으로 구성 -->
								<c:forEach var="i" begin="1900" end="2022">
									<option value="${i}">${i}년</option>
								</c:forEach>
							</select><input type="text" class="d-none" id="birth_date1">
						</div>
						<div class="col-2 signupInput">
							<select class="form-select form-select-sm dropdownContainer"
								id="selectedBirth_date2">
								<option value="-1">월</option>
								<!-- 드롭다운으로 구성 -->
								<c:forEach var="i" begin="1" end="12">
									<option value="${i}">${i}월</option>
								</c:forEach>
							</select><input type="text" class="d-none" id="birth_date2">
						</div>
						<div class="col-2 signupInput">
							<select class="form-select form-select-sm dropdownContainer"
								id="selectedBirth_date3">
								<option value="-1">일</option>
								<!-- 드롭다운으로 구성 -->
								<c:forEach var="i" begin="1" end="31">
									<option value="${i}">${i}일</option>
								</c:forEach>
							</select><input type="text" class="d-none" id="birth_date3">
						</div>
						<div class="col d-none signupInput">
							<input type="text" class="form-control form-control-sm" id="birth_date"
								name="birth_date">
						</div>
					</div>

					<div class="row signupRow">
						<div class="col-2 signupTitle">*전화번호</div>
						<div class="col-2 signupInput">
							<select class="form-select form-select-sm" id="phone1">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
						</div>
						<div class="col-2 signupInput">
							<input type="text" class="form-control form-control-sm" id="phone2" maxlength="4">
						</div>
						<div class="col-2 signupInput">
							<input type="text" class="form-control form-control-sm" id="phone3" maxlength="4">
						</div>
						<div class="col d-none signupInput">
							<input type="text" class="form-control form-control-sm" id="phone" name="phone">
						</div>
					</div>


					<div class="row signupRow" id="lastRow">
						<div class="col-2 signupTitle">*주소</div>
						<div class="col-6">
							<div class="row">
								<div class="col-4 signupInput">
									<input type="text" class="form-control form-control-sm" name="postCode"
										id="postCode" placeholder="우편번호" readonly>
								</div>
								<div class="col-4 signupInput">
									<button type="button" id="btnOpenPostCode" class="btn btn-outline-primary btn-sm">주소검색</button>
								</div>
							</div>
							<div class="row signupInput">
								<input type="text" class="form-control form-control-sm" name="roadAddr"
									id="roadAddr" placeholder="도로명주소" readonly>
							</div>
							<div class="row signupInput">
								<input type="text" class="form-control form-control-sm" name="extraAddr"
									id="extraAddr" placeholder="읍/면/동" readonly>
							</div>
							<div class="row signupInput">
								<input type="text" class="form-control form-control-sm" name="detailAddr"
									id="detailAddr" placeholder="상세주소" maxlength=100>
							</div>
							<div class="row d-none signupInput">
								<input type="text" class="form-control form-control-sm" name="address"
									id="address">
							</div>
							<div class="col-2"></div>
						</div>
						<div class="col-4"></div>
					</div>

				</div>

				<div>&nbsp;</div>
				<div>&nbsp;</div>
				<div>&nbsp;</div>

				<div class="row">
					<h3>이용 약관</h3>
				</div>
				<div class="row termsBox">

					<fieldset class="col fieldarea f2">
						<legend>
							<span>[필수]</span>이용약관 동의
						</legend>
						<div class="row">
							<div class="col agree-group">
								<label for="agreement1">아래 사항에 동의 합니다.</label> <input
									id="agreement1" type="checkbox" name="agreement1" />
							</div>
						</div>

						<textarea class="agreeText" readonly>제 1 장 총칙
제 1 조 (목적)
1. 본 약관은 MOOD & STYLE 사이트가 제공하는 모든 서비스(이하 "서비스")의 이용조건 및 절차, 이용자와 MOOD & STYLE 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.
제 2 조 (약관의 효력과 변경)
1. MOOD & STYLE 사이트는 귀하가 본 약관 내용에 동의하는 경우 MOOD & STYLE 사이트의 서비스 제공 행위 및 귀하의 서비스 사용 행위에 본 약관이 우선적으로 적용됩니다.
2. MOOD & STYLE 사이트는 본 약관을 사전 고지 없이 변경할 수 있고 변경된 약관은 MOOD & STYLE 사이트 내에 공지하거나 e-mail을 통해 회원에게 공지하며, 공지와 동시에 그 효력이 발생됩니다.
이용자가 변경된 약관에 동의하지 않는 경우, 이용자는 본인의 회원등록을 취소 (회원탈락)할 수 있으며 계속 사용의 경우는 약관 변경에 대한 동의로 간주 됩니다.
제 3 조 (약관 외 준칙)
1. 본 약관에 명시되지 않은 사항은 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보통신 윤리강령, 프로그램보호법 및 기타 관련 법령의 규정에 의합니다.
제 4 조 (용어의 정의)
본 약관에서 사용하는 용어의 정의는 다음과 같습니다.

1. 이용자 : 본 약관에 따라 MOOD & STYLE 사이트가 제공하는 서비스를 받는 자.
2. 가입 : MOOD & STYLE 사이트가 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위.
3. 회원 : MOOD & STYLE 사이트에 개인 정보를 제공하여 회원 등록을 한 자로서 MOOD & STYLE 사이트가 제공하는 서비스를 이용할 수 있는 자.
4. 비밀번호 : 이용자와 회원ID가 일치하는지를 확인하고 통신상의 자신의 비밀보호를 위하여 이용자 자신이 선정한 문자와 숫자의 조합.
5. 탈퇴 : 회원이 이용계약을 종료시키는 행위.
제 2 장 서비스 제공 및 이용
제 5 조 (이용계약의 성립)
1. 이용계약은 신청자가 온라인으로 MOOD & STYLE 사이트에서 제공하는 소정의 가입신청 양식에서 요구하는 사항을 기록하여 가입을 완료하는 것으로 성립됩니다.
2. MOOD & STYLE 사이트는 다음 각 호에 해당하는 이용계약에 대하여는 가입을 취소할 수 있습니다.
① 다른 사람의 명의를 사용하여 신청하였을 때
② 이용계약 신청서의 내용을 허위로 기재하였거나 신청하였을 때
③ 다른 사람의 MOOD & STYLE 사이트 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 때
④ MOOD & STYLE 사이트를 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우
⑤ 기타 MOOD & STYLE 사이트가 정한 이용신청요건이 미비 되었을 때
제 6 조 (회원정보 사용에 대한 동의)
1. 회원의 개인정보는 공공기관의 개인정보보호에 관한 법률에 의해 보호됩니다.
2. MOOD & STYLE 사이트의 회원 정보는 다음과 같이 사용, 관리, 보호됩니다.
① 개인정보의 사용 : MOOD & STYLE 사이트는 서비스 제공과 관련해서 수집된 회원의 신상정보를 본인의 승낙 없이 제3자에게 누설, 배포하지 않습니다.
단, 전기통신기본법 등 법률의 규정에 의해 국가기관의 요구가 있는 경우, 범죄에 대한 수사상의 목적이 있거나 정보통신윤리 위원회의 요청이 있는 경우 또는 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우, 귀하가 MOOD & STYLE 사이트에 제공한 개인정보를 스스로 공개한 경우에는 그러하지 않습니다.
② 개인정보의 관리 : 귀하는 개인정보의 보호 및 관리를 위하여 서비스의 개인정보관리에서 수시로 귀하의 개인정보를 수정/삭제할 수 있습니다.
③ 개인정보의 보호 : 귀하의 개인정보는 오직 귀하만이 열람/수정/삭제 할 수 있으며, 이는 전적으로 귀하의 ID와 비밀번호에 의해 관리되고 있습니다.
따라서 타인에게 본인의 ID와 비밀번호를 알려주어서는 안되며, 작업 종료 시에는 반드시 로그아웃 해 주시기 바랍니다.
3. 회원이 본 약관에 따라 이용신청을 하는 것은, MOOD & STYLE 사이트가 신청서에 기재된 회원정보를 수집, 이용하는 것에 동의하는 것으로 간주됩니다.
제 7 조 (사용자의 정보 보안)
1. 가입 신청자가 MOOD & STYLE 사이트 서비스 가입 절차를 완료하는 순간부터 귀하는 입력한 정보의 비밀을 유지할 책임이 있으며, 회원의 ID와 비밀번호를 사용하여 발생하는 모든 결과에 대한 책임은 회원 본인에게 있습니다.
2. ID와 비밀번호에 관한 모든 관리의 책임은 회원에게 있으며, 회원의 ID나 비밀번호가 부정하게 사용 되었다는 사실을 발견한 경우에는 즉시 MOOD & STYLE 사이트에 신고하여야 합니다. 신고를 하지 않음으로 인한 모든 책임은 회원 본인에게 있습니다. 종료하지 아니함으로써 제3자가 귀하에 관한 정보를 이용하게 되는 등의 결과로 인해 발생하는 손해 및 손실에 대하여 MOOD & STYLE 사이트는 책임을 부담하지 아니합니다.
제 8 조 (서비스의 중지)
1. MOOD & STYLE 사이트는 이용자가 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지할 수 있습니다.
제 9 조 (서비스의 변경 및 해지)
1. MOOD & STYLE 사이트는 귀하가 서비스를 이용하여 기대하는 손익이나 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않으며, 회원이 본 서비스에 게재한 정보, 자료, 사실의 신뢰도, 정확성 등 내용에 관하여는 책임을 지지 않습니다. 의한 손해에 대하여 책임을 부담하지 아니합니다.
제 10 조 (게시물의 저작권)
1. 귀하가 게시한 게시물의 내용에 대한 권리는 귀하에게 있습니다.
2. MOOD & STYLE 사이트는 게시된 내용을 사전 통지 없이 편집, 이동할 수 있는 권리를 보유하며, 게시판운영 원칙에 따라 사전 통지 없이 삭제할 수 있습니다.
3. 귀하의 게시물이 타인의 저작권을 침해함으로써 발생하는 민, 형사상의 책임은 전적으로 귀하가 부담하여야 합니다.
제 3 장 의무 및 책임
제 11 조 (MOOD & STYLE 사이트의 의무)
1. MOOD & STYLE 사이트는 회원의 개인 신상 정보를 본인의 승낙없이 타인에게 누설, 배포하지 않습니다. 다만, 전기통신관련법령 등 관계법령에 의하여 관계 국가기관 등의 요구가 있는 경우에는 그러하지 아니합니다.
제 12 조 (회원의 의무)
1. 회원 가입 시에 요구되는 정보는 정확하게 기입하여야 합니다. 또한 이미 제공된 귀하에 대한 정보가 정확한 정보가 되도록 유지, 갱신하여야 하며, 회원은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.
2. 회원은 MOOD & STYLE 사이트의 사전 승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없습니다.
제 4 장 기타
제 13 조 (양도금지)
1. 회원이 서비스의 이용권한, 기타 이용계약 상 지위를 타인에게 양도, 증여할 수 없습니다.
제 14 조 (손해배상)
1. MOOD & STYLE 사이트는 무료로 제공되는 서비스와 관련하여 회원에게 어떠한 손해가 발생하더라도 MOOD & STYLE 사이트가 고의로 행한 범죄행위를 제외하고 이에 대하여 책임을 부담하지 아니합니다.
제 15 조 (면책조항)
1. MOOD & STYLE 사이트는 회원이나 제3자에 의해 표출된 의견을 승인하거나 반대하거나 수정하지 않습니다. MOOD & STYLE 사이트는 어떠한 경우라도 회원이 서비스에 담긴 정보에 의존해 얻은 이득이나 입은 손해에 대해 책임이 없습니다. 금전적 거래등과 관련하여 어떠한 책임도 부담하지 아니하고, 회원이 서비스의 이용과 관련하여 기대하는 이익에 관하여 책임을 부담하지 않습니다.
제 16 조 (재판관할)
1. MOOD & STYLE 사이트와 이용자 간에 발생한 서비스 이용에 관한 분쟁에 대하여는 대한민국 법을 적용하며, 본 분쟁으로 인한 소는 대한민국의 법원에 제기합니다. </textarea>


					</fieldset>
					<fieldset class="col fieldarea f3">
						<legend>
							<span>[필수]</span>개인정보 수집 및 이용 동의
						</legend>

						<div class="row">
							<div class="col agree-group">
								<label for="agreement2">아래 사항에 동의 합니다.</label> <input
									id="agreement2" type="checkbox" name="agreement2" />
							</div>
						</div>

						<textarea class="agreeText" readonly> MOOD & STYLE은 「개인정보보호법」 제15조제1항제1호, 제17조제1항제1호, 제23조제1호, 제24조제1항 제1호에 따라
아래와 같이 개인정보의 수집. 이용에 관하여 귀하의 동의를 얻고자 합니다.

MOOD & STYLE은 이용자의 사전 동의 없이는 이용자의 개인정보를 함부로 공개하지 않으며, 수집된 정보는 아래와 같이 이용하고 있습니다.
이용자가 제공한 모든 정보는 아래의 목적에 필요한 용도 이외로는 사용되지 않으며 이용 목적이 변경될 시에는 이를 알리고 동의를 구할 것입니다.

개인정보의 수집 및 이용 동의
1. 개인정보의 수집 및 이용 목적
가. 서비스 제공에 관한 업무 이행 - 컨텐츠 제공, 특정 맞춤 서비스 제공(마이페이지, 뉴스레터 등), 기업 애로상담
나. 회원관리
- 회원제 서비스 이용 및 제한적 본인 확인제에 따른 본인확인, 개인식별, 가입의사 확인, 가입 및 가입횟수 제한, 추후 법정 대리인 본인확인, 분쟁 조정을 위한 기록보존, 불만처리 등 민원처리, 공지사항 전달

2. 수집하는 개인정보의 항목
<개인회원 가입>
필수항목 : 아이디, 비밀번호, 이름, 핸드폰번호, 이메일, 암호화된 이용자 확인값(CI)
선택항목 : 이메일 수신여부, 문자수신여부, 웹진구독여부
<기업회원 가입>
필수항목 : 아이디, 비밀번호, 담당자 이름, 담당자 전화번호, 핸드폰번호, 이메일, (법인기업의 경우 법인등록번호), 기업정보(회사명, 대표자명, 사업자등록번호, 회사전화번호, 주소, 지역, 대표업종), 암호화된 이용자 확인값(CI)
선택항목 : 팩스번호, 홈페이지주소, 회사이메일주소, 창업일자, 부업종, 매출액, 수출액, 상시근로자 수, 주요생산품명, 이메일 수신여부, 문자수신여부, 이메일 수신여부, 문자수신여부, 웹진구독여부
<자동수집>
IP주소, 쿠키, 서비스 이용기록, 방문기록 등

3. 개인정보의 보유 및 이용기간
MOOD & STYLE은 원칙적으로 보유기간의 경과, 개인정보의 수집 및 이용목적의 달성 등 그 개인정보가 불필요하게 되었을 때에는 지체 없이 파기합니다. 다만, 다른 법령에 따라 보존하여야 하는 경우에는 그러하지 않을 수 있습니다. 불필요하게 되었을 때에는 지체 없이 해당 개인정보를 파기합니다.

회원정보
-탈퇴 후 지체없이 파기

4. 동의거부권 및 불이익
정보주체는 개인정보 수집에 동의를 거부할 권리가 있습니다. 다만, 필수 항목에 대한 동의를 거부할 시 저희가 제공하는 서비스를 이용할 수 없습니다. </textarea>


					</fieldset>
				</div>


				<div class="row buttonBox">
					<div class="col d-flex justify-content-end">
						<button type="button" id="cancelBtn" class="btn btn-secondary">취소</button>
					</div>
					<div class="col">
						<button type="button" id="submitBtn" class="btn btn-dark">가입</button>
					</div>
				</div>

			</div>
			<div class="col-2"></div>
		</div>
	</form>
	<%@include file="../footer.jsp"%>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js">
		//우편 api 태그
	</script>

	<script>
		
		// 이메일제공 거부시 이메일입력창 안보이게
		$(function(){ 
			if('${userInfo.email}'==null || '${userInfo.email}'==""){
				$("#emailRow").css("display", "none");
			}
		});

	
		// 취소 버튼
		document.getElementById("cancelBtn").onclick = function() {
			location.href = "${pageContext.request.contextPath}/member/toLoginPage"
		}

		// 가입 버튼을 눌렀을 때 정규식,빈값 확인
		document.getElementById("submitBtn").addEventListener(
				"click",
				function() {

					//기본 요소 선택
					let id = document.getElementById("id");
					let pw = document.getElementById("pw");
					let name = document.getElementById("name");
					let email = document.getElementById("email");
					let height = document.getElementById("height");
					let weight = document.getElementById("weight");
					

					//생년월일 값 선택
					let birth_date1Value = $(
							"#selectedBirth_date1 option:selected").val();
					let birth_date2Value = $(
							"#selectedBirth_date2 option:selected").val();
					let birth_date3Value = $(
							"#selectedBirth_date3 option:selected").val();

					//폰 관련 요소 선택
					let phone1 = document.getElementById("phone1");
					let phone2 = document.getElementById("phone2");
					let phone3 = document.getElementById("phone3");
					let phone = document.getElementById("phone");

					//주소 관련 요소 선택
					let postCode = document.getElementById("postCode");
					let roadAddr = document.getElementById("roadAddr");
					let detailAddr = document.getElementById("detailAddr");
					let extraAddr = document.getElementById("extraAddr");
					let address = document.getElementById("address");

					let regexEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
					let regexPhone2 = /^[0-9]{3,4}$/;
					let regexPhone3 = /^[0-9]{4}$/;
					let regexBirth_date = /^[0-9]{2,4}$/;

					// 한자리수일 경우 앞에 '0'을 추가함
					if (birth_date2Value < 10) {
						birth_date2Value = "0" + birth_date2Value;
					}
					if (birth_date3Value < 10) {
						birth_date3Value = "0" + birth_date3Value;
					}
	
					if (phone2.value == "" || phone3.value == ""
							|| !regexPhone2.test(phone2.value)
							|| !regexPhone3.test(phone3.value)) {
						alert("휴대폰 번호를 올바르게 입력하세요.");
						phone2.focus();
						return;
					} else if (birth_date1Value == "" || birth_date2Value == ""
							|| birth_date3Value == ""
							|| !regexBirth_date.test(birth_date1Value)
							|| !regexBirth_date.test(birth_date2Value)
							|| !regexBirth_date.test(birth_date3Value)) {
						alert("생년월일을 입력하세요.");
						$("#birth_date").focus();
						return;
					} else if (postCode.value == "" || roadAddr.value == "") {
						alert("주소를 입력하세요.");
						$("#postCode").focus();
						return;
					} else if (!$("#agreement1").prop("checked")) {
						alert("이용약관에 동의해주세요.");
						return;
					} else if (!$("#agreement2").prop("checked")) {
						alert("개인정보 수집 및 이용에 동의해주세요.");
						return;
					}

					phone.value = phone1.value + phone2.value + phone3.value;
					address.value = postCode.value + " " + roadAddr.value + " "
							+ extraAddr.value + " " + detailAddr.value;

					$("#birth_date").val(
							birth_date1Value + birth_date2Value
									+ birth_date3Value);

					// 김준형이 추가함: 키, 몸무게를 select형식(드롭다운)으로 바꿈
					// 키, 몸무게 등 담기
					let heightValue = $("#selectedHeight option:selected")
							.val();
					let weightValue = $("#selectedWeight option:selected")
							.val();
					$("#height").val(heightValue);
					$("#weight").val(weightValue);

					//제출
					document.getElementById("signupForm").submit();

				})

		//체크박스 체크여부 
		$("input:checkbox").click(checkedChange);
		function checkedChange() {
			if ($(this).prop("checked")) {
				$("label[for=" + this.id + "]").text("동의되었습니다.");
				$("label[for=" + this.id + "]").css("color", "green");
			} else {
				$("label[for=" + this.id + "]").text("동의 해주시기 바랍니다.");
				$("label[for=" + this.id + "]").css("color", "red");
			}
		}

		//카카오주소 api
		let btnOpenPostCode = document.getElementById("btnOpenPostCode");
		btnOpenPostCode.addEventListener("click", function() {
			openPostCode();
		})
		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		function openPostCode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('postCode').value = data.zonecode;
							document.getElementById("roadAddr").value = roadAddr;

							// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
							if (roadAddr !== '') {
								document.getElementById("extraAddr").value = extraRoadAddr;
							} else {
								document.getElementById("extraAddr").value = '';
							}
						}
					}).open();
		}
	</script>
</body>
</html>