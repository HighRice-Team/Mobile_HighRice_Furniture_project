package com.bit_fr.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hanb.sms.SmsSend;

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

	// 처음에만 대문을 팝업으로 쏴주고 다음에는 열리지 않게 하는 메소드
	@RequestMapping(value = "/onsite.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String onsite(HttpSession session) {
		String str = "";
		session.setAttribute("on", 1);

		return str;
	}

	// 로그인 필터에서 적용된 세션을 지워줘야함 안그러면 어떤 페이지를 들어가도 로그인 창이 계속 뜸
	@RequestMapping(value = "deleteSession.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public void deleteSession(HttpSession session) {
		String str = "";
		session.removeAttribute("needToLogin");
	}

	@RequestMapping("/myPage.do")
	public ModelAndView goMyPage(HttpSession session, @RequestParam(value = "min", defaultValue = "1") int min,
			String selectedMyPage) {
		ModelAndView mav = new ModelAndView();

		String member_id = (String) session.getAttribute("id");
		MemberVo member = memberDao.getOne_member(member_id);

		// List<OrderlistVo>recentList =
		// orderlistDao.getMyRecentlyOrder_orderlist(member_id);
		// if(recentList.size()!=0) {
		// mav.addObject("recentList", recentList);
		// mav.addObject("chkRecentList", "ok");
		// }else {
		// mav.addObject("chkRecentList", null);
		// }

		int max = min + 3;

		int rent1 = orderlistDao.getCountToMyCondition_orderlist(member_id, "입금완료");
		int rent2 = orderlistDao.getCountToMyCondition_orderlist(member_id, "대여중");
		int rent3 = orderlistDao.getCountToMyCondition_orderlist(member_id, "배송중");
		int rent4 = orderlistDao.getCountToMyCondition_orderlist(member_id, "반납");

		int cart_cnt = orderlistDao.getCountToMyCondition_orderlist(member_id, "물품게시");

		int sell_total = productDao.getMySellCount_product(member_id);

		// 판매리스트
		// List<ProductVo> list = productDao.getMySellForPaging_product(member_id);

		mav.addObject("member", member);
		mav.addObject("rent1", rent1);
		mav.addObject("rent2", rent2);
		mav.addObject("rent3", rent3);
		mav.addObject("rent4", rent4);
		mav.addObject("cart_cnt", cart_cnt);
		mav.addObject("sell_total", sell_total);
		// mav.addObject("list", list);

		mav.addObject("selectedMyPage", selectedMyPage);
		// mav.addObject("len", list.size());

		mav.addObject("viewPage", "myPage.jsp");

		mav.setViewName("template");

		return mav;
	}

	@RequestMapping("/aboutus.do")
	public ModelAndView aboutUs() {
		ModelAndView mav = new ModelAndView("template");
		mav.addObject("viewPage", "board/aboutUs.jsp");

		return mav;
	}

	@RequestMapping("/faq.do")
	public ModelAndView goFAQ() {
		ModelAndView mav = new ModelAndView("template");
		mav.addObject("viewPage", "board/faq.jsp");

		return mav;
	}

	// Node Sever HOST 설정
	private String node_IP = "203.236.209.226";
	private int node_PORT = 52273;

	// deliveryList : 비트맨의 배송목록 ajax통신
	@RequestMapping(value = "/todoListAjax_deliveryList.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String todoListAjax_deliveryList(HttpServletRequest request) {
		String str = "";

		try {
			URL url = new URL("http://" + node_IP + ":" + node_PORT + "/deliveryList");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			InputStream is = conn.getInputStream();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			byte[] buf = new byte[1024 * 8];
			int length = 0;
			while ((length = is.read(buf)) != -1) {
				out.write(buf, 0, length);
			}

			str = new String(out.toByteArray(), "UTF-8");

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	// SMS 메소드
	@RequestMapping(value = "chkphone.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String chkphone(String phone) {

		String str = "";

		int n = RNum();
		SmsSend.send(phone, n);

		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(n);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	// 랜덤번호 생성
	public static int RNum() {
		int r = (int) (Math.floor(Math.random() * 1000000) + 100000);
		if (r > 1000000) {
			r = r - 100000;
		}
		return r;

	}

	// returnList : 비트맨의 반납요청 목록 ajax통신
	@RequestMapping(value = "/todoListAjax_returnList.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String todoListAjax_returnList(HttpServletRequest request) {
		String str = "";

		try {
			URL url = new URL("http://" + node_IP + ":" + node_PORT + "/returnList");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			InputStream is = conn.getInputStream();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			byte[] buf = new byte[1024 * 8];
			int length = 0;
			while ((length = is.read(buf)) != -1) {
				out.write(buf, 0, length);
			}

			str = new String(out.toByteArray(), "UTF-8");

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	// collectList : 비트맨의 수거요청 목록 ajax통신
	@RequestMapping(value = "/todoListAjax_collectList.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String todoListAjax_collectList(HttpServletRequest request) {
		String str = "";

		try {
			URL url = new URL("http://" + node_IP + ":" + node_PORT + "/collectList");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			InputStream is = conn.getInputStream();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			byte[] buf = new byte[1024 * 8];
			int length = 0;
			while ((length = is.read(buf)) != -1) {
				out.write(buf, 0, length);
			}

			str = new String(out.toByteArray(), "UTF-8");

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping("/todoList.do")
	public ModelAndView todoList() {
		ModelAndView mav = new ModelAndView("template");
		mav.addObject("viewPage", "admin/todoList.jsp");

		return mav;
	}

	// 배송요청의 상세페이지
	@RequestMapping("/todoDelivery_Detail.do")
	public ModelAndView todoDelivery_Detail(String _id) {
		ModelAndView mav = new ModelAndView("template");

		String str = "";

		try {
			URL url = new URL("http://" + node_IP + ":" + node_PORT + "/delivery_Detail?_id=" + _id);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			InputStream is = conn.getInputStream();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			byte[] buf = new byte[1024 * 8];
			int length = 0;
			while ((length = is.read(buf)) != -1) {
				out.write(buf, 0, length);
			}

			str = new String(out.toByteArray(), "UTF-8");

		} catch (Exception e) {
			System.out.println(e);
		}

		mav.addObject("viewPage", "admin/todoDelivery_Detail.jsp");
		mav.addObject("json_delivery_Detail", str);

		return mav;
	}

	// 수거요청의 상세페이지
	@RequestMapping("/todoCollect_Detail.do")
	public ModelAndView todoCollect_Detail(String _id) {
		ModelAndView mav = new ModelAndView("template");

		String str = "";

		try {
			URL url = new URL("http://" + node_IP + ":" + node_PORT + "/collect_Detail?_id=" + _id);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			InputStream is = conn.getInputStream();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			byte[] buf = new byte[1024 * 8];
			int length = 0;
			while ((length = is.read(buf)) != -1) {
				out.write(buf, 0, length);
			}

			str = new String(out.toByteArray(), "UTF-8");

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		mav.addObject("viewPage", "admin/todoCollect_Detail.jsp");
		mav.addObject("json_collect_Detail", str);

		return mav;
	}

	// 반납요청의 상세페이지
	@RequestMapping("/todoReturn_Detail.do")
	public ModelAndView todoReturn_Detail(String _id) {
		ModelAndView mav = new ModelAndView("template");

		String str = "";

		try {
			URL url = new URL("http://" + node_IP + ":" + node_PORT + "/return_Detail?_id=" + _id);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			InputStream is = conn.getInputStream();
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			byte[] buf = new byte[1024 * 8];
			int length = 0;
			while ((length = is.read(buf)) != -1) {
				out.write(buf, 0, length);
			}

			str = new String(out.toByteArray(), "UTF-8");

		} catch (Exception e) {
			System.out.println(e);
		}

		mav.addObject("viewPage", "admin/todoReturn_Detail.jsp");
		mav.addObject("json_return_Detail", str);

		return mav;
	}

	@RequestMapping(value = "/signSave.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String signSave(HttpServletRequest request, String req) {
		String path = request.getRealPath("/resources/sign_store/" + req);

		String sign = StringUtils.split(request.getParameter("sign"), ",")[1];
		String fileName = System.currentTimeMillis() + ".png";
		// ex) fileName = member_id+"_"+product_id+".png" =>a1_4.png
		try {
			FileUtils.writeByteArrayToFile(new File(path + "/" + fileName), Base64.decodeBase64(sign));
			ObjectMapper om = new ObjectMapper();
			fileName = om.writeValueAsString(fileName);
		} catch (Exception e) {
			System.out.println(e);
		}
		return fileName;
	}

	@RequestMapping(value = "/sellWrite.do")
	public ModelAndView sellWrite(HttpSession session) {
		ModelAndView mav = new ModelAndView("template");
		String member_id = (String) session.getAttribute("id");
		mav.addObject("viewPage", "sell/sellWrite.jsp");
		mav.addObject("member_id", member_id);

		return mav;
	}

	@RequestMapping(value = "/orderlistByCondition.do")
	public ModelAndView orderlistByCondition() {
		ModelAndView mav = new ModelAndView("template");
		mav.addObject("viewPage", "orderlist/orderlistByCondition.jsp");

		return mav;
	}

	@RequestMapping("/admin.do")
	public ModelAndView admin(HttpSession session) {
		ModelAndView mav = new ModelAndView("./managementPage/adminPage");
		return mav;
	}

	// 회원정보 변경 다이얼로그
	@RequestMapping("/edit_Profile.do")
	public ModelAndView edit_Profile() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("template");
		mav.addObject("viewPage", "Edit_Profile.jsp");

		return mav;
	}

	// 어드민에서 프로덕트 리스트를 불러오기 위한 ajax
	@RequestMapping(value = "/admin_product.do", produces = "text/plain; charset=utf-8")
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

	// 어드민에서 오더리스트를 불러오기 위한 ajax
	@RequestMapping(value = "/admin_orderlist.do", produces = "text/plain; charset=utf-8")
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

	@RequestMapping(value = "/admin_member.do", produces = "text/plain; charset=utf-8")
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

	// 어드민에서 editing을 바로 하기 위한 ajax
	@RequestMapping(value = "/adminUpdate_product.do", produces = "text/plain; charset=utf-8")
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

	// 맴버 업데이트를 위한 ajax
	@RequestMapping(value = "/adminUpdate_member.do", produces = "text/plain; charset=utf-8")
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

	// 비밀번호 리셋을 위한 ajax
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

	// 입금완료 된 상품을 배송하기 위한 ajax
	@RequestMapping(value = "sellCompliate_product.do", produces = "text/plain; charset=UTF-8")
	@ResponseBody
	public String sellCompliate_product(int order_id, int price, String member_id) {

		String str = "";

		int rent_month = orderlistDao.getRentMonth_orderlist(order_id);

		if (rent_month == -1) {
			str = rent_month + "";
			return str;
		}
		int payback = (price * rent_month) / 10;

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

	// 검수가 된 물품을 실제로 게시하기 위한 메소드
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

		if (mainIMG != null) {
			try {
				byte[] mainbyte = mainIMG.getBytes();

				main_img = mainIMG.getOriginalFilename();
				mainFsize = mainbyte.length;

				FileOutputStream mainfos = new FileOutputStream(path + "/" + main_img);
				mainfos.write(mainbyte);

				mainfos.close();

				if (!main_img.equals(oldMain_img)) {

					p.setMain_img(main_img);

					File file = new File(path + "/" + oldMain_img);
					file.delete();
				}

			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if (subIMG != null) {
			try {
				byte[] subbyte = subIMG.getBytes();
				sub_img = subIMG.getOriginalFilename();

				subFsize = subbyte.length;
				FileOutputStream subfos = new FileOutputStream(path + "/" + sub_img);

				subfos.write(subbyte);
				subfos.close();

				if (!sub_img.equals(oldSub_img)) {
					p.setSub_img(sub_img);

					File file = new File(path + "/" + oldSub_img);
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

	@RequestMapping(value = "writeJSON.do", produces = "text/plain;charset=utf8")
	@ResponseBody
	public String writeJSON(OrderlistVo o) {
		String str = "";

		List<OrderlistVo> list = orderlistDao.getAll_orderlist(o);
		try {
			ObjectMapper om = new ObjectMapper();
			str = om.writeValueAsString(list);
			System.out.println(str);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "";
	}

	@RequestMapping(value = "/refund.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String refund(int order_id) {
		String str = "";

		OrderlistVo orderVo = orderlistDao.getOne_orderlist(order_id);
		String member_id = orderVo.getMember_id();

		MemberVo memverVo = memberDao.getOne_member(member_id);

		long memberBalance = memverVo.getBalance();

		int product_id = orderVo.getProduct_id();
		int price = productDao.getOne_product(product_id).getPrice();

		int refundAmount = orderVo.getRent_month() * price;

		memverVo.setBalance(memberBalance - refundAmount);

		memberDao.updateInfo_member(memverVo);
		memberDao.updateMasterForRefund_member(refundAmount);

		return str;
	}

	@RequestMapping("admin/deliveryInfo.do")
	public ModelAndView deliveryInfo(int order_id) {
		ModelAndView mav = new ModelAndView("managementPage/deliveryInfo");
		OrderlistVo orderV = orderlistDao.getOne_orderlist(order_id);
		List<MemberVo> bitManList = memberDao.getBitMan_member();
		String bitSelect = "<select name='bitman'>";

		for (MemberVo mv : bitManList) {
			bitSelect += "<option value='" + mv.getName() + "'>" + mv.getName() + "</option>";
		}
		bitSelect += "</select>";

		int product_id = orderV.getProduct_id();
		String member_id = orderV.getMember_id();
		MemberVo memberVo = memberDao.getOne_member(member_id);

		mav.addObject("bitSelect", bitSelect);
		ProductVo productVo = productDao.getOne_product(product_id);

		mav.addObject("product_info", productVo);
		mav.addObject("orderlist_info", orderV);
		mav.addObject("member_info", memberVo);

		return mav;
	}

	@RequestMapping("admin/collectInfo.do")
	public ModelAndView collectInfo(int product_id) {
		ModelAndView mav = new ModelAndView("managementPage/collectInfo");
		List<MemberVo> bitManList = memberDao.getBitMan_member();
		String bitSelect = "<select name='bitman'>";

		for (MemberVo mv : bitManList) {
			bitSelect += "<option value='" + mv.getName() + "'>" + mv.getName() + "</option>";
		}
		bitSelect += "</select>";

		ProductVo productVo = productDao.getOne_product(product_id);

		MemberVo memberVo = memberDao.getOne_member(productVo.getMember_id());

		mav.addObject("bitSelect", bitSelect);

		mav.addObject("product_info", productVo);
		mav.addObject("member_info", memberVo);

		return mav;
	}

	@RequestMapping("admin/returnInfo.do")
	public ModelAndView returnInfo(int order_id) {
		ModelAndView mav = new ModelAndView("managementPage/returnInfo");
		OrderlistVo orderV = orderlistDao.getOne_orderlist(order_id);
		List<MemberVo> bitManList = memberDao.getBitMan_member();
		String bitSelect = "<select name='bitman'>";

		for (MemberVo mv : bitManList) {
			bitSelect += "<option value='" + mv.getName() + "'>" + mv.getName() + "</option>";
		}
		bitSelect += "</select>";

		int product_id = orderV.getProduct_id();
		String member_id = orderV.getMember_id();
		MemberVo memberVo = memberDao.getOne_member(member_id);

		mav.addObject("bitSelect", bitSelect);
		ProductVo productVo = productDao.getOne_product(product_id);

		mav.addObject("product_info", productVo);
		mav.addObject("orderlist_info", orderV);
		mav.addObject("member_info", memberVo);

		return mav;
	}

}
