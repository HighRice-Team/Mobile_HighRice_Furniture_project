package com.bit_fr.controller;


import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.dao.OrderlistDao;
import com.bit_fr.dao.ProductDao;
import com.bit_fr.vo.MemberVo;
import com.bit_fr.vo.OrderlistVo;
import com.bit_fr.vo.ProductVo;
import com.bit_fr.vo.QnaBoardVo;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private ProductDao productDao;

	@Autowired
	private OrderlistDao orderlistDao;
	

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	public void setOrderlistDao(OrderlistDao orderlistDao) {
		this.orderlistDao = orderlistDao;
	}
	
	@RequestMapping("/myPage.do")
	public ModelAndView goMyPage(HttpSession session, @RequestParam(value = "min", defaultValue = "1") int min,String selectedMyPage) {
		ModelAndView mav = new ModelAndView();

		String member_id = (String) session.getAttribute("id");
		MemberVo member = memberDao.getOne_member(member_id);
		
		List<OrderlistVo>recentList = orderlistDao.getMyRecentlyOrder_orderlist(member_id);
		if(recentList.size()!=0) {
			mav.addObject("recentList", recentList);
			mav.addObject("chkRecentList", "ok");
		}else {
			mav.addObject("chkRecentList", null);
		}

		int max = min + 3;

		int rent1 = orderlistDao.getCountToMyCondition_orderlist(member_id, "입금완료");
		int rent2 = orderlistDao.getCountToMyCondition_orderlist(member_id, "대여중");
		int rent3 = orderlistDao.getCountToMyCondition_orderlist(member_id, "배송중");
		int rent4 = orderlistDao.getCountToMyCondition_orderlist(member_id, "반납");

		int total = productDao.getMySellCount_product(member_id);
		List<ProductVo> list = productDao.getMySellForPaging_product(member_id);

		mav.addObject("member", member);
		mav.addObject("rent1", rent1);
		mav.addObject("rent2", rent2);
		mav.addObject("rent3", rent3);
		mav.addObject("rent4", rent4);
		mav.addObject("total", total);
		mav.addObject("list", list);
		
		mav.addObject("selectedMyPage", selectedMyPage);
		mav.addObject("len", list.size());

		mav.addObject("viewPage", "myPage.jsp");

		mav.setViewName("main");

		return mav;
	}
	
	@RequestMapping("/aboutUs.do")
	public ModelAndView aboutUs() {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("viewPage", "board/aboutUs.jsp");

		return mav;
	}
	
	@RequestMapping("/faq.do")
	public ModelAndView faq() {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("viewPage", "board/faq.jsp");

		return mav;
	}
	
	@RequestMapping("/todoList.do")
	public ModelAndView todoList() {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("viewPage", "admin/todoList.jsp");

		return mav;
	}
	
	@RequestMapping("/todoRent.do")
	public ModelAndView todoRent() {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("viewPage", "admin/todoRent.jsp");

		return mav;
	}
	
	@RequestMapping("/todoPickup.do")
	public ModelAndView todoPickup() {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("viewPage", "admin/todoPickup.jsp");

		return mav;
	}
	
	@RequestMapping(value ="/signSave.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String signSave(HttpServletRequest request) {
		String sign = StringUtils.split(request.getParameter("sign"), ",")[1];
		String fileName = System.currentTimeMillis()+".png";
		//ex) fileName = member_id+"_"+product_id+".png" =>a1_4.png
		try {
			FileUtils.writeByteArrayToFile(new File("d:\\sign"+fileName), Base64.decodeBase64(sign));
			ObjectMapper om = new ObjectMapper();
			fileName = om.writeValueAsString(fileName);
		} catch (Exception e) {
			System.out.println(e);
		}
		return fileName;
	}

	@RequestMapping(value = "/sellWrite.do")
	public ModelAndView sellWrite(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String member_id = (String)session.getAttribute("id");
		mav.addObject("viewPage", "sell/sellWrite.jsp");
		mav.addObject("member_id", member_id);
		mav.setViewName("main");

		return mav;
	}

	@RequestMapping(value = "/orderlistByCondition.do")
	public ModelAndView orderlistByCondition() {
		ModelAndView mav = new ModelAndView();

		mav.addObject("viewPage", "orderlist/orderlistByCondition.jsp");
		mav.setViewName("main");

		return mav;
	}
}
