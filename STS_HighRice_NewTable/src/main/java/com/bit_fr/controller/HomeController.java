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
	
//	처음에만 대문을 팝업으로 쏴주고 다음에는 열리지 않게 하는 메소드
	@RequestMapping(value="/onsite.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String onsite(HttpSession session) {
		String str = "";
		session.setAttribute("on", 1);
		
		return str;
	}
	
	//로그인 필터에서 적용된 세션을 지워줘야함 안그러면 어떤 페이지를 들어가도 로그인 창이 계속 뜸
	@RequestMapping(value="deleteSession.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public void deleteSession(HttpSession session) {
		String str = "";
		session.removeAttribute("needToLogin");
	}
	
	
	@RequestMapping("/myPage.do")
	public ModelAndView goMyPage(HttpSession session, @RequestParam(value = "min", defaultValue = "1") int min,String selectedMyPage) {
		ModelAndView mav = new ModelAndView();

		String member_id = (String) session.getAttribute("id");
		MemberVo member = memberDao.getOne_member(member_id);
		
//		List<OrderlistVo>recentList = orderlistDao.getMyRecentlyOrder_orderlist(member_id);
//		if(recentList.size()!=0) {
//			mav.addObject("recentList", recentList);
//			mav.addObject("chkRecentList", "ok");
//		}else {
//			mav.addObject("chkRecentList", null);
//		}

		int max = min + 3;

		int rent1 = orderlistDao.getCountToMyCondition_orderlist(member_id, "입금완료");
		int rent2 = orderlistDao.getCountToMyCondition_orderlist(member_id, "대여중");
		int rent3 = orderlistDao.getCountToMyCondition_orderlist(member_id, "배송중");
		int rent4 = orderlistDao.getCountToMyCondition_orderlist(member_id, "반납");
		
		int cart_cnt = orderlistDao.getCountToMyCondition_orderlist(member_id, "물품게시");
		
		int sell_total = productDao.getMySellCount_product(member_id);
		
		//판매리스트
		//List<ProductVo> list = productDao.getMySellForPaging_product(member_id);

		mav.addObject("member", member);
		mav.addObject("rent1", rent1);
		mav.addObject("rent2", rent2);
		mav.addObject("rent3", rent3);
		mav.addObject("rent4", rent4);
		mav.addObject("cart_cnt", cart_cnt);
		mav.addObject("sell_total", sell_total);
		//mav.addObject("list", list);
		
		mav.addObject("selectedMyPage", selectedMyPage);
		//mav.addObject("len", list.size());

		mav.addObject("viewPage", "myPage.jsp");

		mav.setViewName("main");

		return mav;
	}
	

	@RequestMapping("/aboutus.do")
	public ModelAndView aboutUs() {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("viewPage", "board/aboutUs.jsp");

		return mav;
	}
	

	@RequestMapping(value = "/faq.do")
	public ModelAndView goFAQ() {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("viewPage","board/faq.jsp" );
		mav.setViewName("main");
		
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

	@RequestMapping("/admin.do")
	public ModelAndView admin() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main");
		mav.addObject("viewPage", "admin/adminPage.jsp");

		return mav;
	}
	
	//회원정보 변경 다이얼로그
	@RequestMapping("/edit_Profile.do")
	public ModelAndView edit_Profile() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("main");
		mav.addObject("viewPage", "Edit_Profile.jsp");

		return mav;
	}

	//어드민에서 프로덕트 리스트를 불러오기 위한 ajax
	@RequestMapping(value = "/admin_product.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String admin_product(ProductVo v) {
		String str = "";
		
		List<ProductVo> list = productDao.getAll_productAdmin(v);

		ObjectMapper mapper = new ObjectMapper();
		
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	//어드민에서 오더리스트를 불러오기 위한 ajax
	@RequestMapping(value = "/admin_orderlist.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String admin_orderlist(OrderlistVo v) {
		String str = "";
		
		List<OrderlistVo> list = orderlistDao.getAll_orderlist(v);
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
	public String admin_member(MemberVo m) {
				
		String str = "";
		List<MemberVo> list = memberDao.getAll_member(m);
		ObjectMapper mapper = new ObjectMapper();
			
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	//어드민에서 editing을 바로 하기 위한 ajax
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

	//맴버 업데이트를 위한 ajax
	@RequestMapping(value = "/adminUpdate_member.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String adminUpdate_member(MemberVo m) {
		String str = "";

		int re = memberDao.updateInfo_member(m);

		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}
	
	//비밀번호 리셋을 위한 ajax
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
	
	//입금완료 된 상품을 배송하기 위한 ajax
	@RequestMapping(value = "sellCompliate_product.do", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public String sellCompliate_product(int order_id, int price, String member_id) {
		
		
		String str = "";	
		
		int rent_month = orderlistDao.getRentMonth_orderlist(order_id);
	
		if(rent_month == -1) {
			str = rent_month+"";
			return str;
		}
		int payback = (price*rent_month)/10;
		
		int re = memberDao.updatePayback_member(member_id, payback);
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		
		return str;
	}
	
	//검수가 된 물품을 실제로 게시하기 위한 메소드
	@RequestMapping("adminSell_product.do")
	public ModelAndView adminSell_product(HttpServletRequest request, ProductVo p) {
		ModelAndView mav = new ModelAndView();
	
		String main_img = "";
		String sub_img = "";
		
		String path = request.getRealPath("/resources/img/product");
		String oldMain_img = p.getMain_img();
		String oldSub_img = p.getSub_img();
		int mainFsize = 0;
		int subFsize = 0;
		
		MultipartFile mainIMG = p.getMainIMG();
		MultipartFile subIMG = p.getSubIMG();
		
		if(mainIMG != null) {
			try {
				byte[] mainbyte = mainIMG.getBytes();
			
				main_img = mainIMG.getOriginalFilename();
				mainFsize = mainbyte.length;
				
				FileOutputStream mainfos = new FileOutputStream(path+"/"+main_img);
				mainfos.write(mainbyte);
				
				mainfos.close();
				
				if(!main_img.equals(oldMain_img)) {
					
					p.setMain_img(main_img);
					
					File file = new File(path+"/"+oldMain_img);
					file.delete();
				}
			
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		if(subIMG != null) {
			try {
				byte[] subbyte = subIMG.getBytes();
				sub_img = subIMG.getOriginalFilename();
				
				subFsize = subbyte.length;
				FileOutputStream subfos = new FileOutputStream(path+"/"+sub_img);
				
				subfos.write(subbyte);
				subfos.close();
				
				if(!sub_img.equals(oldSub_img)) {
					p.setSub_img(sub_img);
					
					File file = new File(path+"/"+oldSub_img);
					file.delete();
				}
				
			} catch (Exception e) {
				// TODO: handle exception
				System.out.println(e);
			}
		}
		
		productDao.updateAdmin_product(p);
		mav.setViewName("redirect:/admin.do");
		
		return mav;
	}
}
