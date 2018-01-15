package com.bit_fr.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resources;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.dao.OrderlistDao;
import com.bit_fr.dao.ProductDao;
import com.bit_fr.vo.MemberVo;
import com.bit_fr.vo.OrderlistVo;
import com.bit_fr.vo.ProductVo;
import com.fasterxml.jackson.core.JsonProcessingException;
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

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}

	@RequestMapping("myPage.do")
	public ModelAndView goMyPage(HttpSession session, @RequestParam(value = "min", defaultValue = "1") int min) {
		ModelAndView mav = new ModelAndView();

		String member_id = (String) session.getAttribute("id");
		MemberVo member = memberDao.getOne_member(member_id);

		int max = min + 3;

		int rent1 = orderlistDao.getCountToMyCondition_orderlist(member_id, "입금완료");
		int rent2 = orderlistDao.getCountToMyCondition_orderlist(member_id, "대여중");
		int rent3 = orderlistDao.getCountToMyCondition_orderlist(member_id, "배송중");
		int rent4 = orderlistDao.getCountToMyCondition_orderlist(member_id, "반납");

		int total = productDao.getMySellCount_product(member_id);
		List<ProductVo> list = productDao.getMySellForPaging_product(member_id, min, max);

		mav.addObject("member", member);
		mav.addObject("rent1", rent1);
		mav.addObject("rent2", rent2);
		mav.addObject("rent3", rent3);
		mav.addObject("rent4", rent4);
		mav.addObject("total", total);
		mav.addObject("list", list);
		mav.addObject("len", list.size());
		mav.addObject("min", min);

		mav.addObject("viewPage", "myPage.jsp");

		mav.setViewName("main");

		return mav;
	}

	@RequestMapping(value = "/sellWrite.do")
	public ModelAndView sellWrite() {
		ModelAndView mav = new ModelAndView();

		mav.addObject("viewPage", "sell/sellWrite.jsp");
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

	@RequestMapping("/admin.do")
	public ModelAndView admin() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main");
		mav.addObject("viewPage", "admin/adminPage.jsp");

		return mav;
	}

	@RequestMapping(value = "/admin_product.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String admin_product(HttpServletRequest request) {
		
		HashMap map = new HashMap();
	
		
		if(request.getParameter("product_id") !=null && !request.getParameter("product_id").equals("")) {
			map.put("product_id", request.getParameter("product_id"));
		}
		if(request.getParameter("category") !=null && !request.getParameter("category").equals("")) {
			map.put("category", request.getParameter("category"));
		}
		if(request.getParameter("product_name") !=null && !request.getParameter("product_name").equals("")) {
			map.put("product_name", request.getParameter("product_name"));
		}
		if(request.getParameter("member_id") !=null && !request.getParameter("member_id").equals("")) {
			map.put("member_id", request.getParameter("product_id"));
		}
		if(request.getParameter("quality") !=null && !request.getParameter("quality").equals("")) {
			map.put("quality", request.getParameter("quality"));
		}
		if(request.getParameter("price") !=null && !request.getParameter("price").equals("")) {
			map.put("price", request.getParameter("price"));
		}
		if(request.getParameter("condition") !=null && !request.getParameter("condition").equals("")) {
			map.put("condition", request.getParameter("condition"));
		}
		
		
		String str = "";

		List<ProductVo> list = productDao.getAll_productAdmin(map);
		ObjectMapper mapper = new ObjectMapper();

		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/admin_orderlist.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String admin_orderlist(HttpServletRequest request) {
		String str = "";

		HashMap map = new HashMap();
		
		if(request.getParameter("order_id") !=null && !request.getParameter("order_id").equals("")) {
			map.put("order_id", request.getParameter("order_id"));
		}
		if(request.getParameter("product_id") !=null && !request.getParameter("product_id").equals("")) {
			map.put("product_id", request.getParameter("product_id"));
		}
		if(request.getParameter("pay_date") !=null && !request.getParameter("pay_date").equals("")) {
			map.put("pay_date", request.getParameter("pay_date"));
		}
		if(request.getParameter("member_id") !=null && !request.getParameter("member_id").equals("")) {
			map.put("member_id", request.getParameter("product_id"));
		}
		if(request.getParameter("rent_start") !=null && !request.getParameter("rent_start").equals("")) {
			map.put("rent_start", request.getParameter("rent_start"));
		}
		if(request.getParameter("rent_end") !=null && !request.getParameter("rent_end").equals("")) {
			map.put("rent_end", request.getParameter("rent_end"));
		}
		if(request.getParameter("rent_month") !=null && !request.getParameter("rent_month").equals("")) {
			map.put("rent_month", request.getParameter("rent_month"));
		}
		
		List<OrderlistVo> list = orderlistDao.getAll_orderlist(map);
		ObjectMapper mapper = new ObjectMapper();

		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/admin_member.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String admin_member(HttpServletRequest request) {
		String str = "";
		List<MemberVo> list = memberDao.getAll_member();
		ObjectMapper mapper = new ObjectMapper();

		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/adminUpdate_product.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String adminUpdate_product(ProductVo p) {
		String str = "";

		int re = productDao.updateAdmin_product(p);

		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping("/adminUpdate_orderlist.do")
	@ResponseBody
	public String adminUpdate_orderlist(OrderlistVo o) {
		String str = "";

		return str;
	}

//	@RequestMapping(value = "/adminUpdate_member.do", produces="text/plain; charset=utf-8")
//	@ResponseBody
//	public String adminUpdate_member(MemberVo m) {
//		String str = "";
//
//		int re = memberDao.updateInfo_member(m);
//
//		ObjectMapper mapper = new ObjectMapper();
//		try {
//			str = mapper.writeValueAsString(re);
//		} catch (Exception e) {
//			// TODO: handle exception
//			System.out.println(e);
//		}
//
//		return str;
//	}
	
	@RequestMapping(value = "/updateResetPwd_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateResetPwd_member(String member_id) {
		String str = "";
		ObjectMapper om = new ObjectMapper();
		int re = memberDao.updateResetPwd_member(member_id);

		try {
			 str = om.writeValueAsString(re);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}
	

}