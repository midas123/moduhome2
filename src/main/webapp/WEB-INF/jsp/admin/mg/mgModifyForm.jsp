<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>
<script type="text/javascript">
	function joinValidation(frm) {
		if (frm.NOTIFY_TITLE.value == "") {
			alert("제목을 입력해 주세요.");
			return false;
		} else if (frm.NOTIFY_CONTENT.value == "") {
			alert("내용을 입력해 주세요.");
			return false;
		}
		alert("수정되었습니다.")
	}

	$('.searchOption').val($('.searchOptionVal').val());

	var onList = function() {
		location.href = '/ModuHome/admin/mglist';
	};
</script>
</head>
<!-- 메뉴 시작 -->
<div class="row" style="padding-left: 15px; width: 700px;">
	<h1 class="page-header">게시글 수정</h1>
</div>

<div class="row" style="padding-left: 15px; width: 700px;">
	<div class="panel panel-default">
		<div class="panel-heading">공지사항 수정 페이지입니다.</div>
		<div class="panel-body">
		
			<form:form id="adminMgModify" action="mgModify"
				method="post" name="joinform" onsubmit="return joinValidation(this)"
				enctype="multipart/form-data">

			<input type="hidden" id="MG_NUMBER" name="MG_NUMBER" value="${mgDetail.MG_NUMBER}">
			<input type="hidden" id="MG_NUMBER2" name="MG_NUMBER2" value="${mgContentList.MG_NUMBER}">
				
				<div class="form-group">
					<label>등록일자</label>
					<fmt:formatDate value="${mgDetail.MG_REGDATE}"
						pattern="YYYY.MM.dd" />
				</div>
				<div class="form-group">
					<label>제목</label> <input type="text" class="form-control"
						id="mg_title" name="MG_TITLE"
						value="${mgDetail.MG_TITLE }" style="width: 500px;" />
				</div>
				<div class="form-group">
					<label>내용</label> <input type="text" class="form-control"
						id="mg_content" name="MG_CONTENT"
						value="${mgDetail.MG_CONTENT}" style="width: 500px;" /> 
				</div>
				<%-- <div class="form-group">
					<label>해쉬태그</label> <input type="text" class="form-control"
						id="mg_hashtag" name="MG_HASHTAG"
						value="${mgDetail.MG_HASHTAG}" style="width: 500px;" /> 
				</div> --%>
				<div class="form-group">
				<%-- 기존 이미지 : <img
						src="/ModuHome/images/mgMain/mg_${mgDetail.MG_NUMBER}.jpg"
						width="60" height="60" alt=""
						onerror="this.src='/ModuHome/images/noimg_130.gif'" /> --%><br>
					<label>메인사진 수정하기 ${mgContentList.MG_NUMBER } ${mgContentList.MG_IMAGE_CONTENT}</label> <input type="file" class="form-control"
						id="mg_title_image" name="MG_TITLE_IMAGE"
						value="${mgDetail.MG_TITLE_IMAGE}" style="width: 500px;" /> 
				</div>
				<div class="form-group">
				<c:forEach items="${mgContentList}" var="mgContentList" >
        					<c:if test="${mgNew.MG_NUMBER eq mgContentList.MG_NUMBER}">
                   				<table class="notice_view">
                   					<tr>
                   						<th scope="row">내용</th>
                   						<td colspan="2" class="view_text">${mgContentList.MG_IMAGE_CONTENT}</td>
                   					</tr>
                   					<tr>
                   						<th scope="row">이미지</th>
                   						<td colspan="2" class="view_text"><img src="/ModuHome/images/mgContent/${mgContentList.MG_IMAGE}" width="60" height="60" ></td>
                   					</tr>
                   			   	</table>
                   			   	<br>
                   			</c:if>
           	</c:forEach>
           	</div>
				<button type="submit" class="btn btn-success">수정</button>
				<button type="reset" class="btn btn-success">초기화</button>
				<button type="button" onclick="onList()" id="faqList"
					class="btn btn-success">목록</button>
			</form:form>
		</div>
	</div>
</div>
