<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>매거진 등록하기</title>
</head>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/ui.css'/>" />
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>
<div class="row" style="padding-left: 15px; width: 700px;">
	<h1 class="page-header">매거진</h1>
</div>
<body>
	<div class="row" style="padding-left: 15px; width: 700px;">
		<div class="panel panel-default">
			<div class="panel-heading">매거진 등록 페이지입니다.</div>
			<div class="panel-body">
			
				<form id="frm" name="mgContentInsert" action="/admin/mgContentInsert" method="post" enctype="multipart/form-data"
				onsubmit="return joinValidation(this)">
		
				<div class="member_number">
				<input type="hidden" id="member_number" name="MEMBER_NUMBER" value="${MEMBER_NUMBER}"> 
				<input type="hidden" id="mg_number" name="MG_NUMBER" value="${mgNew.MG_NUMBER}">
			</div>
					<table class="notice_view">
						<colgroup>
							<col width="15%">
							<col width="*" />
						</colgroup>
						<caption>게시글 작성</caption>
						<tbody>
							<tr>
								<th scope="row">사진</th>
								<td>
									<input type="file" id="mg_image" name="MG_IMAGE" class="wdp_90">
								</td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="2" class="view_text">
									<textarea rows="5" cols="80" title="내용" id="mg_image_content" name="MG_IMAGE_CONTENT"></textarea>
								</td>
							</tr>
							
						</tbody>
					</table>
					<br/>
					<!-- <input type="file" id="NOTIFY_IMAGE" name="NOTIFY_IMAGE" style="width: initial;" /> <br/> -->
					<input type="submit" name="업로드" value="작성하기" id="mgContentInsert" class="btn btn-primary"/>
					<!-- <button type="button" onclick="onWrite()" id="mgContentInsert" class="btn btn-primary">작성하기</button> -->
					<button type="button" onclick="onList()" id="mglist" class="btn btn-primary">완료</button>
				</form>
				<br><br>
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
			</div>
		</div>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#mglist").on("click", function(e) { //목록으로 버튼
					e.preventDefault();
					fn_mglist();
				});

				$("#mgContentInsert").on("click", function(e) { //작성하기 버튼
					e.preventDefault();
					fn_mgContentInsert();
					});
				});

				function fn_mglist() {
					var comSubmit = new ComSubmit();
					comSubmit.setUrl("<c:url value='/mglist' />");
					comSubmit.submit();
				}

				function fn_mgContentInsert() {
					var comSubmit = new ComSubmit("frm");
					comSubmit.setUrl("<c:url value='/admin/mgContentInsert' />");
					comSubmit.submit();
				}

				$('.searchOption').val($('.searchOptionVal').val());
				
				var onList = function() {
					location.href = 'mglist';
				};
				
				var onWrite = function() {
					location.href = '/admin/mgContentInsert';
				};
		</script>
</body>
</html>