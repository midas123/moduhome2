# 프로젝트 개요

moduhome은 셀프 인테리어 쇼핑몰과 정보를 공유하고 소통할 수 있는 커뮤니티 기능을 하는 공간을 제공하는 사이트 입니다.

개발기간 : 2018.07.30 ~ 2018.09.10

인원 : 6명

운영환경 : Apach Tomcat 6.0

사용기술 : JAVA, Spring-mcv,Javascript, jQuery, Ajax, HTML, CSS

프레임워크 : Spring4.0 Framework, MyBatis, Bootstrap

개발도구 : eclipse

이전 저장소: https://github.com/midas123/moduhome


<hr/>

# 리팩토링

## 문제점
메뉴 카테고리 명과 관련된 코드가 상품 컨트롤러(GoodsController.java)에서 불필요한 공간을 차지하고 있다. 또한 메뉴는 앞으로 계속해서 추가 및 수정 될 수 있고, 메뉴 카테고리 목록은 여러 뷰(jsp)에서 사용되고 있으므로 메뉴 카테고리를 테이블에서 관리하고 필요한 부분에서 사용 또는 출력 해주는게 바람직해 보인다. 


## 해결안
메인과 서브 메뉴 카테고리 테이블 각각 1개씩 생성하고 상품 컨트롤러의 메뉴 관련 코드를 삭제한다. 

※메인/서브 카테고리 메뉴 구조
<pre><code>
가구
  침실가구
  거실가구
  주방가구
  홈오피스
  테이블
  체어
</code></pre>

## 해결 과정
1. 메인 카테고리 테이블 생성(주요키)
<pre><code>
CREATE TABLE CATEGORY (
    id NUMBER NOT NULL,
    cg_name VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_CATEGORY PRIMARY KEY(cg_name)
    );
</code></pre>

2. 서브 카테고리 테이블 생성(참조키)
<pre><code>
CREATE TABLE SUB_CATEGORY (
    id NUMBER NOT NULL,
    cg_name VARCHAR2(20) NOT NULL,
    sub_cg_name VARCHAR2(20) NOT NULL,
    CONSTRAINT FK_SUB_CATEGORY FOREIGN KEY(cg_name) REFERENCES CATEGORY(cg_name)
    );
</code></pre>

3. 데이터 삽입
<pre><code>
INSERT INTO SUB_CATEGORY (ID, CG_NAME, SUB_CG_NAME) VALUES ('1', '가구', '체어');
</code></pre>

4. 상품 컨트롤러 클래스에서 카테고리 관련 코드 제거
<pre><code>
/*	 
if (categoryName.equals("가구")) {
	         goodsCategory.add("침실가구");
	         goodsCategory.add("거실가구");
	         goodsCategory.add("주방가구");
	         goodsCategory.add("홈오피스");
	         goodsCategory.add("테이블");
	         goodsCategory.add("체어");
		 }
*/
</code></pre>

5. 테이블에서 메뉴 목록을 가져오는 sql 쿼리 테스트
<pre><code>
SELECT cg_name FROM CATEGORY
SELECT sub_cg_name FROM SUB_CATEGORY WHERE cg_name = '가구';
</code></pre>

6. 상품 DAO, service 클래스에 메서드 추가 작성 및 myBatis Mapper XML 파일에 코드 추가        




7. 상품 컨트롤러에 카테고리 테이블 DAO 관련 코드 추가
<pre><code>
List<String> mainCategory = goodsService.getMainCategory();
List<String> subCategory = goodsService.getSubCategory(categoryName);
</code></pre>

8. 뷰(jsp)에서 카테고리 메뉴 리스트 출력
