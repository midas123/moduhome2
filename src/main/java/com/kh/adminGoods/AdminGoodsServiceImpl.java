package com.kh.adminGoods;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh.moduhome.GoodsImageUtils;

@Service("adminGoodsService")
public class AdminGoodsServiceImpl implements AdminGoodsService {

   @Resource(name = "adminGoodsDAO")
   private AdminGoodsDAO adminGoodsDAO;

   @Resource(name = "goodsImageUtils")
   private GoodsImageUtils goodsImageUtils;

   // 상품 리스트
   @Override
   public List<Map<String, Object>> goodsList(Map<String, Object> map) throws Exception {
      List<Map<String, Object>> goodsList = adminGoodsDAO.goodsList(map);
      return goodsList;
   }

   // 전체 상품 수
   @Override
   public Integer goodsCount() throws Exception {
      return new Integer(adminGoodsDAO.goodsCount());
   }

   // 상품 등록
   @Override
   public void insertGoods(Map<String, Object> map, HttpServletRequest request) throws Exception {

      adminGoodsDAO.insertGoods(map);

      map = goodsImageUtils.goodsThumbnail(map, request);
      adminGoodsDAO.insertGoodsThumnail(map);

      String[] option1 = request.getParameterValues("GOODS_OPTION1");
      String[] option2 = request.getParameterValues("GOODS_OPTION2");
      String[] amount = request.getParameterValues("GOODS_AMOUNT");

      for (int i = 0; i < option1.length; i++) {
         map.put("GOODS_OPTION1", option1[i]);
         map.put("GOODS_OPTION2", option2[i]);
         map.put("GOODS_AMOUNT", amount[i]);
         adminGoodsDAO.insertGoodsKind(map);
      }

      List<Map<String, Object>> goodsImageList = goodsImageUtils.parseInsertFileInfo(map, request);

      if (goodsImageList.size() > 0) {
         for (int i = 0; i < goodsImageList.size(); i++) {
            adminGoodsDAO.insertGoodsImage(goodsImageList.get(i));
         }
      }
   }

   // 상품 수정 폼으로 이동(상품 디테일)
   @Override
   public List<Map<String, Object>> modifyGoodsForm(Map<String, Object> map) throws Exception {
      List<Map<String, Object>> goodsDetail = adminGoodsDAO.modifyGoodsForm(map);
      return goodsDetail;
   }

   // 수정 폼 이동할때 상품 이미지 같이 가져오기
   @Override
   public List<Map<String, Object>> modifyGoodsFormImage(Map<String, Object> map) throws Exception {
      List<Map<String, Object>> goodsImage = adminGoodsDAO.modifyGoodsFormImage(map);
      return goodsImage;
   }

   // 상품 수정
   @Override
   public void modifyGoods(Map<String, Object> map, HttpServletRequest request) throws Exception {

      // 상품 기본정보 수정
      if (map.get("GOODS_ONOFF") == null) {
         map.put("GOODS_ONOFF", 1);
      }

      adminGoodsDAO.modifyGoods(map);

      MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;

      // 상품 썸네일 수정
      if (multipartHttpServletRequest.getFile("GOODS_THUMBNAIL").getSize() > 0) {
         map = goodsImageUtils.parseUpdateThumbImage(map, request);
         adminGoodsDAO.insertGoodsThumnail(map);
      }

      // 상품 종류 수정(기존거 수정/삭제)
      if (request.getParameterValues("ORG_GOODS_KIND_NUMBER") != null) {

         String[] ORG_GOODS_KIND_NUMBER = request.getParameterValues("ORG_GOODS_KIND_NUMBER");
         List<String> orgList = new ArrayList<String>();

         for (String a : ORG_GOODS_KIND_NUMBER) {
            orgList.add(a);
         }

         String[] ORG_OPTION1 = null;
         String[] ORG_OPTION2 = null;

         if (request.getParameterValues("ORG_GOODS_OPTION1") != null) {
        	 ORG_OPTION1 = request.getParameterValues("ORG_GOODS_OPTION1");
            ORG_OPTION2 = request.getParameterValues("ORG_GOODS_OPTION2");
         }

         // 상품 종류 정보 수정
         for (int i = 0; i < orgList.size(); i++) {
            if (map.get(orgList.get(i)) != null) {
               map.put("GOODS_KIND_NUMBER", orgList.get(i));
               map.put("MD_GOODS_OPTION1", ORG_OPTION1[i]);
               map.put("MD_GOODS_OPTION2", ORG_OPTION2[i]);
               String ADD = "addAmount_" + orgList.get(i);

               if (map.get(ADD).toString().length() > 0) {
                  map.put("addAmount", map.get(ADD));
               } else {
                  int cc = 0;
                  map.put("addAmount", cc);
               }
               adminGoodsDAO.modifyGoodsKind(map);
            } else {
               map.put("GOODS_KIND_NUMBER", orgList.get(i));
               adminGoodsDAO.deleteGoodsKind(map);
            }
         }
      }

      // 새로 입력된 상품 종류 등록
      if (request.getParameterValues("GOODS_OPTION1") != null) {
         String[] option1 = request.getParameterValues("GOODS_OPTION1");
         String[] option2 = request.getParameterValues("GOODS_OPTION2");
         String[] amount = request.getParameterValues("GOODS_AMOUNT");

         for (int i = 0; i < option1.length; i++) {
            map.put("GOODS_NUMBER", map.get("GOODS_NUMBER"));
            map.put("GOODS_OPTION1", option1[i]);
            map.put("GOODS_OPTION2", option2[i]);
            map.put("GOODS_AMOUNT", amount[i]);
            adminGoodsDAO.insertGoodsKind(map);
         }
      }

      // 상품 이미지 수정, 삭제
      System.out.println("이미지 : " + map.get("ORIGINAL_IMAGE"));

      if (map.get("ORIGINAL_IMAGE") != null) {
         List<Map<String, Object>> goodsImageList = goodsImageUtils.parseUpdateImages(map, request);

         if (goodsImageList.size() > 0) {
            for (int i = 0; i < goodsImageList.size(); i++) {
               adminGoodsDAO.modifyGoodsImage(goodsImageList.get(i));
            }
         }

         String[] ORIGINAL_IMAGE = request.getParameterValues("ORIGINAL_IMAGE");
         Map<String, Object> deleteImage = new HashMap<String, Object>();

         for (String b : ORIGINAL_IMAGE) {
            if (map.get(b) == null) {
               deleteImage.put("IMAGE", b);
               adminGoodsDAO.deleteGoodsImage(deleteImage);
            }
         }
      }

      // 새로 입력된 이미지 등록
      List<MultipartFile> IMAGES = multipartHttpServletRequest.getFiles("IMAGE");

      System.out.println("MAP이미지1 : " + multipartHttpServletRequest.getFile("IMAGE"));
      System.out.println("MAP이미지 : " + multipartHttpServletRequest.getFiles("IMAGE"));
      System.out.println("SIZE : " + IMAGES.size());

      if (IMAGES.size() > 0) {
         List<Map<String, Object>> goodsImageList = goodsImageUtils.parseInsertFileInfo(map, request);

         System.out.println("goodsImageList : " + goodsImageList);
         System.out.println("mapImage : " + map.get("IMAGE"));

         for (int i = 0; i < goodsImageList.size(); i++) {
            adminGoodsDAO.insertGoodsImage(goodsImageList.get(i));
         }
      }
   }

   // 상품 삭제
   @Override
   public void deleteGoods(Map<String, Object> map) throws Exception {
      List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();

      listMap = adminGoodsDAO.modifyGoodsForm(map);
      goodsImageUtils.parseDeleteThumbnail(listMap.get(0));

      listMap = adminGoodsDAO.modifyGoodsFormImage(map);

      for (int i = 0; i < listMap.size(); i++)
         goodsImageUtils.parseDeleteImages(listMap.get(i));

      adminGoodsDAO.deleteGoods(map);
   }

   // 주문 취소시 상품 수량 복구
   @Override
   public void addAmount(Map<String, Object> map) throws Exception {
      adminGoodsDAO.addAmount(map);
   }

   // 상품 검색(상품명)
   @Override
   public List<Map<String, Object>> adminGoodsSearch0(String isSearch) throws Exception {
      List<Map<String, Object>> goodsList = adminGoodsDAO.adminGoodsSearch0(isSearch);
      return goodsList;
   }

   // 상품 검색(상품 번호)
   @Override
   public List<Map<String, Object>> adminGoodsSearch1(String isSearch) throws Exception {
      List<Map<String, Object>> goodsList = adminGoodsDAO.adminGoodsSearch1(isSearch);
      return goodsList;
   }

   // 상품 검색(카테고리 검색)
   @Override
   public List<Map<String, Object>> adminGoodsSearch2(String isSearch) throws Exception {
      List<Map<String, Object>> goodsList = adminGoodsDAO.adminGoodsSearch2(isSearch);
      return goodsList;
   }

   // 상품 검색(판매 활성화 or 비활성화 구분)
   @Override
   public List<Map<String, Object>> adminGoodsSearch3(String isSearch) throws Exception {
      List<Map<String, Object>> goodsList = adminGoodsDAO.adminGoodsSearch3(isSearch);
      return goodsList;
   }

   // 상품 검색(재고가 0인 상품)
   @Override
   public List<Map<String, Object>> adminGoodsSearch4(String isSearch) throws Exception {
      List<Map<String, Object>> goodsList = adminGoodsDAO.adminGoodsSearch4(isSearch);
      return goodsList;
   }

   // 상품 정렬(판매량순)
   @Override
   public List<Map<String, Object>> adminGoodsSearch5(String isSearch) throws Exception {
      List<Map<String, Object>> goodsList = adminGoodsDAO.adminGoodsSearch5(isSearch);
      return goodsList;
   }

   // 상품 정렬(조회순)
   @Override
   public List<Map<String, Object>> adminGoodsSearch6(String isSearch) throws Exception {
      List<Map<String, Object>> goodsList = adminGoodsDAO.adminGoodsSearch6(isSearch);
      return goodsList;
   }
   
   // 상품 검색(브랜드명)
   @Override
   public List<Map<String, Object>> adminGoodsSearch7(String isSearch) throws Exception {
      List<Map<String, Object>> goodsList = adminGoodsDAO.adminGoodsSearch7(isSearch);
      return goodsList;
   }
}