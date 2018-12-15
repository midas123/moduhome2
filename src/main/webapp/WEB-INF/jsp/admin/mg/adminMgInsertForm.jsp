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
			
				<form id="frm" name="mgTitleInsert" action="/admin/mgTitleInsert" method="post" enctype="multipart/form-data"
				onsubmit="return joinValidation(this)">
				
				<div class="member_number">
				<input type="hidden" id="member_number" name="MEMBER_NUMBER" value="${MEMBER_NUMBER}"> 
			</div>
					<table class="notice_view">
						<colgroup>
							<col width="15%">
							<col width="*" />
						</colgroup>
						<caption>게시글 작성</caption>
						
							<tr>
								<th scope="row">제목 </th>
								<td>
									<input type="text" id="mg_title" name="MG_TITLE" class="wdp_90" />
								</td>
							</tr>
							<tr>
								<th scope="row">내용</th>
								<td colspan="2" class="view_text">
									<textarea rows="20" cols="80" title="내용" id="mg_content" name="MG_CONTENT"></textarea>
								</td>
							</tr>
							<!-- <tr>
								<th scope="row">해쉬태그</th>
								<td>
									<input type="text" id="mg_hashtag" name="MG_HASHTAG" class="wdp_90" />
								</td>
							</tr> -->
							</table>
			<table>
			<br>
			<tr>
			<td>
		   <SELECT id="mg_type" name="MG_TYPE" size=1>
                   <OPTION value=''>주거형태</OPTION>
                   <OPTION value='아파트'>아파트</OPTION>
                   <OPTION value='주택'>주택</OPTION>
                   <OPTION value='빌라'>빌라</OPTION>
                   <OPTION value='원룸'>원룸</OPTION>
                   <OPTION value='이색공간'>이색공간</OPTION>
                   <OPTION value='오피스텔'>오피스텔</OPTION>
           </SELECT>
        </td>
        <td>           
           <SELECT id="mg_style" name="MG_STYLE" size=1>
                   <OPTION value=''>스타일</OPTION>
                   <OPTION value='러블리'>러블리</OPTION>
                   <OPTION value='유니크'>유니크</OPTION>
                   <OPTION value='네추럴'>네추럴</OPTION>
                   <OPTION value='DIY'>DIY</OPTION>
                   <OPTION value='북유럽'>북유럽</OPTION>
                   <OPTION value='빈티지'>빈티지</OPTION>
                   <OPTION value='모던'>모던</OPTION>
                   <OPTION value='럭셔리'>럭셔리</OPTION>
                   <OPTION value='프렌치'>프렌치</OPTION>
                   <OPTION value='인더스트리얼'>인더스트리얼</OPTION>
                   <OPTION value='미니멀라이즈'>미니멀라이즈</OPTION>
           </SELECT>
       </td>
          <td>           
           <SELECT id="mg_space" name="MG_SPACE" size=1>
                   <OPTION value=''>공간</OPTION>
                   <OPTION value='거실'>거실</OPTION>
                   <OPTION value='주방'>주방</OPTION>
                   <OPTION value='침실'>침실</OPTION>
                   <OPTION value='서재'>서재</OPTION>
                   <OPTION value='베란다'>베란다</OPTION>
                   <OPTION value='현관'>현관</OPTION>
                   <OPTION value='욕실'>욕실</OPTION>
                   <OPTION value='드레스룸'>드레스룸</OPTION>
                   <OPTION value='원룸'>원룸</OPTION>
            </SELECT>
       </td>
            <td>           
           <SELECT id="mg_average" name="MG_AVERAGE" size=1>
                   <OPTION value=''>평수</OPTION>
                   <OPTION value='10평미만'>10평미만</OPTION>
                   <OPTION value='10평대'>10평대</OPTION>
                   <OPTION value='20평대'>20평대</OPTION>
                   <OPTION value='30평대'>30평대</OPTION>
                   <OPTION value='40평대'>40평대</OPTION>
                   <OPTION value='50평대'>50평이상</OPTION>
            </SELECT>
       </td>
       </tr>
       </table>
       <br>
       <table>
							<tr>
								<th scope="row">메인<br/>사진</th>
								<td><input type="file" id="mg_title_image" name="MG_TITLE_IMAGE" style="width: initial;" /></td>
							</tr>
							
						
					</table>
					<br/>
					<!-- <input type="file" id="NOTIFY_IMAGE" name="NOTIFY_IMAGE" style="width: initial;" /> <br/> -->
					<input type="submit" name="업로드" value="작성하기" id="mgTitleInsert" class="btn btn-primary"/>
					<!-- <button type="button" onclick="onWrite()" id="mgTitleInsert" class="btn btn-primary">작성하기</button> -->
					<button type="button" onclick="onList()" id="mglist" class="btn btn-primary">목록</button>
					
					
				</form>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#mglist").on("click", function(e) { //목록으로 버튼
					e.preventDefault();
					fn_mglist();
				});

				$("#mgTitleInsert").on("click", function(e) { //작성하기 버튼
					e.preventDefault();
					fn_mgTitleInsert();
					});
				});

				function fn_mglist() {
					var comSubmit = new ComSubmit();
					comSubmit.setUrl("<c:url value='/mglist' />");
					comSubmit.submit();
				}

				function fn_mgTitleInsert() {
					var comSubmit = new ComSubmit("frm");
					comSubmit.setUrl("<c:url value='/admin/mgTitleInsert' />");
					comSubmit.submit();
				}

				$('.searchOption').val($('.searchOptionVal').val());
				
				var onList = function() {
					location.href = 'mglist';
				};
				
				var onWrite = function() {
					location.href = '/admin/mgTitleInsert';
				};
		</script>
</body>
</html>