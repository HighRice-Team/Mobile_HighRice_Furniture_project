package com.bit_fr.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.dao.OrderlistDao;
import com.bit_fr.dao.ProductDao;
import com.bit_fr.vo.MemberVo;
import com.bit_fr.vo.OrderlistVo;
import com.bit_fr.vo.ProductVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class OrderlistController {

	@Autowired
	private OrderlistDao orderlistDao;

	public void setOrderlistDao(OrderlistDao orderlistDao) {
		this.orderlistDao = orderlistDao;
	}

	@Autowired
	private MemberDao memberDao;

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	@Autowired
	private ProductDao productDao;

	public void setProductDao(ProductDao productDao) {
		this.productDao = productDao;
	}

	@RequestMapping(value = "/getMyOrderlist.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getMyOrderlist(HttpSession session) {
		String str = "";
		String member_id = (String) session.getAttribute("id");
		List<OrderlistVo> list = orderlistDao.getAllMyOrder_orderlist(member_id, null);
		try {
			ObjectMapper om = new ObjectMapper();
			str = om.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
		}

		return str;

	}
	
	@RequestMapping(value = "/order_condition_changeRequest.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String order_condition_changeRequest(HttpSession session, int order_id, String changeRequest) {
		String str = "";
		String member_id = (String) session.getAttribute("id");
		int result = -1;
		
		if(changeRequest != null && order_id != 0) {
			result = orderlistDao.updateOrderCondition_changeRequest(member_id ,order_id, changeRequest);
		}
		 		
		try {
			ObjectMapper om = new ObjectMapper();
			str = om.writeValueAsString(result);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return str;
		
	}
	
	//나의 주문정보 페이지
	@RequestMapping(value = "/myOrderList.do", produces = "text/plain;charset=utf-8")
	public ModelAndView myOrderList(HttpSession session, String condition, String category) {
		ModelAndView mav = new ModelAndView("template");

		String member_id = (String) session.getAttribute("id");
		HashMap map = new HashMap();
		if(condition != null) {
			map.put("condition", condition);
		}
		if(category != null) {
			map.put("category", category);
		}
		
		
		List<OrderlistVo> list = orderlistDao.getAllMyOrder_orderlist(member_id, map);
		mav.addObject("member", memberDao.getOne_member(member_id));
		mav.addObject("list", list);
		mav.addObject("viewPage", "order/myOrderList.jsp");
		return mav;
	}

	@RequestMapping(value = "/goPayment.do", produces = "text/plain;charset=utf-8")
	public ModelAndView goPayment(HttpSession session, int rentMonth, int product_id) {
		ModelAndView mav = new ModelAndView("template");

		String member_id = (String) session.getAttribute("id");


		ProductVo pv = productDao.getOne_product(product_id);
		int price = pv.getPrice();

		MemberVo mv = memberDao.getOne_member(member_id);
		String pwd = mv.getPwd();

		long paymentOne = rentMonth * price;

		mav.addObject("pwd", pwd);
		mav.addObject("product_id", product_id);
		mav.addObject("paymentOne", paymentOne);
		mav.addObject("rentMonth", rentMonth);
		mav.addObject("viewPage", "pay/payment.jsp");
		return mav;
	}
	
	@RequestMapping(value = "/goMultiplePayment.do", produces = "text/plain;charset=utf-8")
	public ModelAndView goMultiplePayment(HttpSession session,String order_id,int paymentPrice,int cntProduct) {
		ModelAndView mav = new ModelAndView("template");
		String member_id=(String)session.getAttribute("id");
		order_id = order_id.substring(0, order_id.length()-1);
		
		String sql = "select * from (select rownum rnum,order_id,product_name,main_img,price,rent_month,pr,con from ( select product_name,order_id,main_img,price,rent_month,o.product_id pr,p.condition con from orderlist o,product p where o.product_id=p.product_id and o.member_id='"+member_id+"' and o.order_id in ("+order_id+") and p.condition='물품게시' order by order_id desc))";

		List<OrderlistVo>list = orderlistDao.getMyCartList_orderlist(sql);
		MemberVo memberVo = memberDao.getOne_member(member_id);
		
		mav.addObject("list",list);
		mav.addObject("member",memberVo);
		mav.addObject("paymentPrice",paymentPrice);
		mav.addObject("order_id",order_id);
		mav.addObject("cntProduct",cntProduct);
		mav.addObject("viewPage","pay/goMultiplePayment.jsp");
		
		
		return mav;
	}
	@RequestMapping(value = "/MultiplePayment.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String MultiplePayment(HttpSession session,String order_id,int paymentPrice) {
		String str ="";
		String member_id = (String)session.getAttribute("id");
		MemberVo memverVo =  memberDao.getOne_member(member_id);
		long member_balance = memverVo.getBalance();
		if(member_balance-paymentPrice>=0) {
			List<OrderlistVo>list = orderlistDao.getOrders_orderlist(order_id);
			for(OrderlistVo order : list) {
				orderlistDao.updatePaydate_orderlist(order.getProduct_id());
				productDao.updateCondition_product(order.getProduct_id(),"입금완료");
				order.setOrderlist_condition("입금완료");
				orderlistDao.updateAll_orderlist(order);
				orderlistDao.updateRentalDateFromCartlistPayment_orderlist(order.getOrder_id(), order.getRent_month());
			}
			orderlistDao.updateDepositToMaster_orderlist(paymentPrice);
			memverVo.setBalance(member_balance-paymentPrice);
			memberDao.updateInfo_member(memverVo);
			
			str = "결제완료";
			
		}else {
			str = "결제오류 : 잔액 부족";
			
			return str;
		}
		
		return str;
	}

	@RequestMapping(value = "/goPaymentInfo.do", produces = "text/plain;charset=utf-8")
	public ModelAndView goPaymentInfo(HttpSession session, int product_id, int rentMonth) {
		ModelAndView mav = new ModelAndView("template");

		String member_id = (String) session.getAttribute("id");
		

		ProductVo productVo = productDao.getOne_product(product_id);
		MemberVo memberVo = memberDao.getOne_member(member_id);

		mav.addObject("productVo", productVo);
		mav.addObject("memberVo", memberVo);
		mav.addObject("rentMonth", rentMonth);
		mav.addObject("viewPage", "pay/paymentInfo.jsp");
		mav.setViewName("template");


		return mav;
	}

	@RequestMapping(value = "/cartList.do", produces = "text/plain;charset=utf-8")
	public ModelAndView goCartList(HttpSession session, @RequestParam(defaultValue = "1") int pageNUM) {
		ModelAndView mav = new ModelAndView("template");

		int orderlistMAX = 10;
		int endNUM = pageNUM * orderlistMAX;
		int startNUM = endNUM - (orderlistMAX - 1);

		String member_id = (String) session.getAttribute("id");

		String sql = "select * from (" + "select rownum rnum,order_id,product_name,main_img,price,rent_month,pr,con "
				+ "from ( select product_name,order_id,main_img,price,rent_month,o.product_id pr,p.condition con from orderlist o,product p where o.product_id=p.product_id and o.member_id='"
				+ member_id + "' and p.condition='물품게시' order by order_id desc))";

		// SQL
		List<OrderlistVo> list = orderlistDao.getMyCartList_orderlist(sql);
		mav.addObject("len", list.size());

		int pageMAX = list.size() / orderlistMAX;
		if (list.size() % orderlistMAX != 0) {
			pageMAX++;
		}
		
		
		

		sql += "where rnum >= " + startNUM + " and rnum <= " + endNUM;

		list = orderlistDao.getMyCartList_orderlist(sql);

		// member_id 값에 따른 회원정보 가져오기.
		MemberVo mv = memberDao.getOne_member(member_id);
		// 회원의 주소
		String adr = "";
		adr += mv.getAddress();
		adr += " ";
		adr += mv.getAddress_detail();

		mav.addObject("adr", adr);
		mav.addObject("mv", mv);
		mav.addObject("list", list);
		mav.addObject("listSize", list.size());
		mav.addObject("pageMAX", pageMAX);
		mav.addObject("viewPage", "cart/cartList.jsp");

		return mav;
	}

	@RequestMapping(value = "paymentOkAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String paymentOkAjax(HttpSession session, int rentMonth, int product_id, long paymentOne) {
		String str = "";

		String member_id = (String) session.getAttribute("id");
		

		int re = -1;

		// 멤버의 잔고 & 결제하기.
		MemberVo mv = memberDao.getOne_member(member_id);
		long balance = mv.getBalance();

		// 결제하기.
		if ((balance - paymentOne) >= 0) {
			// 결제하기위한 잔액이 충분할 때.
			re = orderlistDao.updatePaymentProduct_orderlist(member_id, paymentOne);

			// 관리자 통장에 입금되기.
			re = orderlistDao.updateDepositToMaster_orderlist(paymentOne);

			// 잔액차감 성공.
			if (re == 1) {
				String condition = "입금완료";
				re = productDao.updateCondition_product(product_id, condition);
				
				orderlistDao.updatePaydate_orderlist(product_id);
				
				// Orderlist 생성하기.
				int nextOreder_id = orderlistDao.getCountNextOrderId_orderlist();
				
				OrderlistVo v = new OrderlistVo();
				v.setOrderlist_condition(condition);
				System.out.println(v.getOrderlist_condition());
				v.setOrder_id(nextOreder_id);
				v.setMember_id(member_id);
				v.setProduct_id(product_id);
				v.setRent_month(rentMonth);
				v.toString();
				// 결제한 Orderlist 생성.
				re = orderlistDao.insertPayment_orderlist(v);
				
			}
		} else {
			// 잔액부족.
			re = -10;
		}

		ObjectMapper mapper = new ObjectMapper();

		try {

			str = mapper.writeValueAsString(re);

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}
	
	@RequestMapping(value = "/insertOrderListAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String insertOrderListAjax(HttpSession session, int rent_month, int product_id) {
		String str = "";
		String member_id = (String) session.getAttribute("id");
		if(rent_month==0) {
			rent_month = 6;
		}

		int re = -1;
		int chk_exist = orderlistDao.getCheckExist_orderlist(member_id, product_id);
		
		if (chk_exist < 1) {
			OrderlistVo v = new OrderlistVo();

			int nextOreder_id = orderlistDao.getCountNextOrderId_orderlist();

			v.setOrder_id(nextOreder_id);
			v.setMember_id(member_id);
			v.setProduct_id(product_id);
			v.setRent_month(rent_month);

			orderlistDao.insertCartlist_orderlist(v);

		}

		re = chk_exist;

		ObjectMapper mapper = new ObjectMapper();

		try {

			str = mapper.writeValueAsString(re);

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/deleteOrderListAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String deleteOrderListAjax(HttpSession session, int product_id) {
		String str = "";
		String member_id = (String) session.getAttribute("id");

		int re = orderlistDao.delete_orderlist(member_id, product_id);

		ObjectMapper mapper = new ObjectMapper();

		try {

			str = mapper.writeValueAsString(re);

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/updateRentPeriodOrderListAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateRentPeriodOrderListAjax(int order_id,int rent_month) {
		String str = "";
		
		orderlistDao.updateRentMonth_orderlist(order_id, rent_month);

		return str;
	}
	
	@RequestMapping(value="deleteOrders_orderlist.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String deleteOrders_orderlist(String order_id) {
		String str ="";
		order_id = order_id.substring(0, order_id.length()-1);
		str = orderlistDao.deleteOrders_orderlist(order_id)+"";
		
		return str;
	}

}
