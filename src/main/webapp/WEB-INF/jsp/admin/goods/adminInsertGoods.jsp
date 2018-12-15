<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>first</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  

<link rel="stylesheet" type="text/css" href="<c:url value='/css/ui.css'/>" />

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>

<scRIPT language="Javascript">

function GOODS_CATEGORY1Change() {
 var x = document.frm.GOODS_CATEGORY1.options.selectedIndex;
 var groups=document.frm.GOODS_CATEGORY1.options.length;
 var group=new Array(groups);
 for (i=0; i<groups; i++)
  group[i]=new Array();
 
 group[0][0]=new Option("대분류를 먼저 선택하세요","");
 group[1][0]=new Option("가구 소분류 선택","");
 group[1][1]=new Option("침실가구","침실가구");
 group[1][2]=new Option("거실가구","거실가구");
 group[1][3]=new Option("주방가구","주방가구");
 group[1][4]=new Option("홈오피스","홈오피스");
 group[1][5]=new Option("테이블","테이블");
 group[1][6]=new Option("체어","체어");
 group[2][0]=new Option("가전 소분류 선택","");
 group[2][1]=new Option("생활가전","생활가전");
 group[2][2]=new Option("주방가전","주방가전");
 group[2][3]=new Option("시즌가전","시즌가전");
 group[3][0]=new Option("패브릭 소분류 선택","");
 group[3][1]=new Option("침구","침구");
 group[3][2]=new Option("커튼/블라인드","커튼/블라인드");
 group[3][3]=new Option("매트·러그","매트·러그");
 group[3][4]=new Option("패브릭소품","패브릭소품");
 group[4][0]=new Option("주방 소분류 선택","");
 group[4][1]=new Option("주방용품","주방용품");
 group[4][2]=new Option("주방수납","주방수납");
 group[4][3]=new Option("주방소품","주방소품");
 group[5][0]=new Option("생활·수납 소분류 선택","");
 group[5][1]=new Option("수납·정리","수납·정리");
 group[5][2]=new Option("홈케어","홈케어");
 group[5][3]=new Option("욕실용품","욕실용품");
 group[5][4]=new Option("생활용품","생활용품");
 group[6][0]=new Option("홈데코 소분류 선택","");
 group[6][1]=new Option("조명","조명");
 group[6][2]=new Option("시계","시계");
 group[6][3]=new Option("홈갤러리/액자","홈갤러리/액자");
 group[6][4]=new Option("캔들/디퓨저","캔들/디퓨저");
 group[6][5]=new Option("셀프/인테리어","셀프/인테리어");
 group[6][6]=new Option("라이프데코","라이프데코");
 group[7][0]=new Option("반려동식물 소분류 선택","");
 group[7][1]=new Option("펫","펫");
 group[7][2]=new Option("가드닝","가드닝");
 
 temp = document.frm.GOODS_CATEGORY2;
 for (m = temp.options.length-1 ; m > 0 ; m--)
  temp.options[m]=null
 for (i=0;i<group[x].length;i++){
  temp.options[i]=new Option(group[x][i].text,group[x][i].value)
 }
 temp.options[0].selected=true
}
/* function GOODS_CATEGORY2Change() {
 var GOODS_CATEGORY1 = document.frm.GOODS_CATEGORY1.options.selectedIndex;
 var x = document.frm.GOODS_CATEGORY2.options.selectedIndex;
 var groups=document.frm.GOODS_CATEGORY2.options.length;
 var group=new Array(groups);
 for (i=0; i<groups; i++)
  group[i]=new Array();
 if(GOODS_CATEGORY1 == 1) {
  group[0][0]=new Option("중분류를 먼저 선택하세요","");
  group[1][0]=new Option("삼성컴퓨터 선택","");
  group[1][1]=new Option("섬성 팬티엄III","ss3");
  group[1][2]=new Option("삼성 팬티엄IV","ss4");
  group[1][3]=new Option("삼성 센스 노트북","ssnote");
  group[2][0]=new Option("대우 컴퓨터 선택","");
  group[2][1]=new Option("대우 데스크탑 프로","dw");
  group[3][0]=new Option("엘지 컴퓨터 선택","");
  group[3][1]=new Option("LG IBM PC","lgpc");
  group[3][2]=new Option("LG IBM NOTEBOOK ","lgnote");
 } else if(GOODS_CATEGORY1 == 2) {
  group[0][0]=new Option("중분류를 먼저 선택하세요","");
  group[1][0]=new Option("엡손 프린터 선택","");
  group[1][1]=new Option("엡손 잉크","epson_ink");
  group[1][2]=new Option("엡손 레이져","epson_laser");
  group[2][0]=new Option("휴렛캑커드 프린터 선택","");
  group[2][1]=new Option("HP 잉크젯","hp_ink");
  group[2][2]=new Option("HP 레이져젯","hp_laser");
 }
 
 temp = document.frm.third;
 for (m = temp.options.length-1 ; m > 0 ; m--)
  temp.options[m]=null
 for (i=0;i<group[x].length;i++){
  temp.options[i]=new Option(group[x][i].text,group[x][i].value)
 }
 temp.options[0].selected=true
} */

</scRIPT>



</head>
<body>

<div class="row" style="padding-left:15px;width:900px;">    
	<h1 class="page-header">상품등록</h1>
</div>
	<form id="frm" name="frm" enctype="multipart/form-data">
		<table class="board_view">
			<colgroup>
				<col width="15%">
				<col width="*"/>
			</colgroup>
			<caption>상품 등록</caption>
			<tbody>
				<tr>
					<th scope="row">브랜드명</th>
					<td><input type="text" id="GOODS_BRNAME" name="GOODS_BRNAME" class="wdp_90"></input></td>
				</tr>
				<tr>
					<th scope="row">상품명</th>
					<td><input type="text" id="GOODS_NAME" name="GOODS_NAME" class="wdp_90"></input></td>
				</tr>
				<tr>
					<th scope="row">카테고리</th>
					<td>
						<select id="GOODS_CATEGORY1" name="GOODS_CATEGORY1" onchange="GOODS_CATEGORY1Change();" size=1>
						<OPTION value=''>대분류</OPTION>
						<OPTION value='가구'>가구</OPTION>
						<OPTION value='가전'>가전</OPTION>
						<OPTION value='패브릭'>패브릭</OPTION>
						<OPTION value='주방'>주방</OPTION>
						<OPTION value='생활·수납'>생활·수납</OPTION>
						<OPTION value='홈데코'>홈데코</OPTION>
						<OPTION value='반려동식물'>반려동식물</OPTION>
						</select>
						<SELECT id="GOODS_CATEGORY2" name="GOODS_CATEGORY2" size=1>
						 <OPTION value=''>대분류를 먼저 선택하세요</OPTION>
						</SELECT>
					</td>
				</tr>
				<tr>
					<th scope="row">썸네일 이미지</th>
					<td><input type="file" id="GOODS_THUMBNAIL" name="GOODS_THUMBNAIL"></td>
				</tr>
				<tr>
					<th scope="row">가격</th>
					<td><input type="text" id="GOODS_PRICE" name="GOODS_PRICE" class="wdp_90"></input></td>
				</tr>
				<tr>
					<th scope="row">할인 가격</th>
					<td><input type="text" id="GOODS_DISPRICE" name="GOODS_DISPRICE" class="wdp_90"></input></td>
				</tr>
				<tr>
					<th scope="row">할인 기간</th>
					<td><input type="text" id="GOODS_SALEDATE" name="GOODS_SALEDATE" class="wdp_90"></input></td>
				</tr>
				<tr>
					<td colspan="2" class="view_text">
						<textarea rows="5" cols="100" title="내용" id="GOODS_SHORTDESC" name="GOODS_SHORTDESC" placeholder="기본 설명"></textarea>
						<br/><br/>
						<textarea rows="10" cols="100" title="내용" id="GOODS_DESC" name="GOODS_DESC" placeholder="상세 설명"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					<a href="#this" class="btn" id="addKind">옵션/수량 추가</a><br/>
						<div id="kindDiv">
							<p>
							<!-- 
							<select id="GOODS_OPTION1" name="GOODS_OPTION1" size=1>
								<OPTION value=''>옵션1</OPTION>
								<OPTION value='BLACK1'>BLACK2</OPTION>
								<OPTION value='GRAY'>GRAY</OPTION>
								<OPTION value='BROWN'>BROWN</OPTION>
								<OPTION value='BURGUNDY'>BURGUNDY</OPTION>
								<OPTION value='PINK'>PINK</OPTION>
								<OPTION value='PURPLE'>PURPLE</OPTION>
								<OPTION value='WHITE'>WHITE</OPTION>
								<OPTION value='NAVY'>NAVY</OPTION>
								<OPTION value='BLUE'>BLUE</OPTION>
								<OPTION value='GREEN'>GREEN</OPTION>
								<OPTION value='YELLOW'>YELLOW</OPTION>
								<OPTION value='RED'>RED</OPTION>
								<OPTION value='SKYBLUE'>SKYBLUE</OPTION>
								<OPTION value='BEIGE'>BEIGE</OPTION>
							</select>
							 -->
							<input type="text" placeholder='옵션1' id="GOODS_OPTION1" name="GOODS_OPTION1"> 
							<input type="text" placeholder='옵션2' id="GOODS_OPTION2" name="GOODS_OPTION2"> 
							<input type="text" placeholder='수량' id="GOODS_AMOUNT" name="GOODS_AMOUNT">
							<a href="#this" class="btn" id="delete" name="delete">삭제</a>
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
					
					<a href="#this" class="btn" id="addFile">이미지 추가</a>
						<div id="fileDiv">
							<p>
							<input type="file" id="IMAGE" name="IMAGE">
							<a href="#this" class="btn" id="delete" name="delete">삭제</a>
							</p>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		
		<br/><br/>
		<a href="#this" class="btn" id="write">작성하기</a>
		<a href="#this" class="btn" id="list">목록으로</a>
	</form>
	<br/>
	<br/>
	
	<form id="commonForm" name="commonForm"></form>
	<script type="text/javascript">
		var gfv_count = 1;
		var gfc_count = 1;
	
		$(document).ready(function(){
			$("#list").on("click", function(e){ //목록으로 버튼
				e.preventDefault();
				fn_openGoodsList();
			});
			
			$("#write").on("click", function(e){ //작성하기 버튼
				e.preventDefault();
				 if($('#GOODS_NAME').val()==""){
					alert("상품명을 입력해 주세요.");
					return false;
				 } else if($('#GOODS_PRICE').val()==""){
					 alert("상품가격을 입력해 주세요.");
						return false;
				 } else if($('#GOODS_CATEGORY1').val()==''){
					 alert("상품 대분류를 선택해 주세요.");
						return false;
				 } else if($('#GOODS_CATEGORY2').val()==''){
					 alert("상품 소분류를 선택해 주세요.");
						return false;
				 } else if($('#GOODS_THUMBNAIL').val()==""){
					 alert("썸네일이미지를 등록해 주세요.");
						return false;
				 } else if($('#GOODS_AMOUNT').val()==""){
					 alert("상품 수량을 입력해 주세요.");
						return false;
				 } else if($('#IMAGE').val()==""){
					 alert("상품이미지를 등록해 주세요.");
						return false;
				 }
				 else{
				fn_insertGood();
				}
			});
			
			$("#addFile").on("click", function(e){ //파일 추가 버튼
				e.preventDefault();
				fn_addFile();
			});
			
			$("#addKind").on("click", function(e){ //파일 추가 버튼
				e.preventDefault();
				fn_addKind();
			});
			
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteKind($(this));
			});
		});
		
		function fn_openGoodsList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/admin/goodsList' />");
			comSubmit.submit();
		}
		
		function fn_insertGood(){
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/admin/goodsInsert' />");
			comSubmit.submit();
		}
		
		function fn_addKind(){
			var str = "<p><input type='text' placeholder='옵션1' name='GOODS_OPTION1' id='GOODS_OPTION1'> <input type='text' placeholder='옵션2' name='GOODS_OPTION2' id='GOODS_OPTION2'> <input type='text' placeholder='수량' name='GOODS_AMOUNT' id='GOODS_AMOUNT'> <a href='#this' class='btn' name='delete'>삭제</a></p>";
			$("#kindDiv").append(str);
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteKind($(this));
			});
		}
		
		function fn_deleteKind(obj){
			obj.parent().remove();
		}
		
		function fn_addFile(){
			var str = "<p><input type='file' name='IMAGE'> <a href='#this' class='btn' name='delete'>삭제</a></p>";
			$("#fileDiv").append(str);
			$("a[name='delete']").on("click", function(e){ //삭제 버튼
				e.preventDefault();
				fn_deleteFile($(this));
			});
		}
		
		function fn_deleteFile(obj){
			obj.parent().remove();
		}
		
	</script>
</body>
</html>