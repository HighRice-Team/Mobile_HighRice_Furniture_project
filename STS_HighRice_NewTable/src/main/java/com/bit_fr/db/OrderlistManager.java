package com.bit_fr.db;

import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.TimeZone;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit_fr.vo.OrderlistVo;

public class OrderlistManager {
	private static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/bit_fr/db/sqlMapConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
	}

	public static List<OrderlistVo> getOrders_orderlist(String order_id) {
		SqlSession session = factory.openSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("order_id", order_id);
		List<OrderlistVo> list = session.selectList("orderlist.getOrders_orderlist", map);
		session.close();

		return list;
	}

	public static List<OrderlistVo> getMyRecentlyOrder_orderlist(String member_id) {
		SqlSession session = factory.openSession();
		HashMap<String, String> map = new HashMap<String, String>();
		Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
		cal.add(Calendar.DATE, -14);
		SimpleDateFormat df = new SimpleDateFormat();
		df.applyPattern("yyyy/MM/dd");
		map.put("today", df.format(cal.getTime()));
		map.put("member_id", member_id);
		List<OrderlistVo> list = session.selectList("orderlist.getMyRecentlyOrder_orderlist", map);
		session.close();

		return list;
	}

	public static int getCheckExist_orderlist(String member_id, int product_id) {
		int count = -1;
		SqlSession session = factory.openSession();

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("product_id", product_id);

		count = session.selectOne("orderlist.getCheckExist_orderlist", map);
		session.close();

		return count;
	}

	public static int getCountNextOrderId_orderlist() {
		int nextOrderID = -1;
		SqlSession session = factory.openSession();

		nextOrderID = session.selectOne("orderlist.getCountNextOrderId_orderlist");
		session.close();

		return nextOrderID;
	}

	public static int getCountToMyCondition_orderlist(String member_id, String condition) {
		int count_MyProduct = -1;
		SqlSession session = factory.openSession();

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("condition", condition);

		count_MyProduct = session.selectOne("orderlist.getCountToMyCondition_orderlist", map);
		session.close();

		return count_MyProduct;
	}

	public static List<OrderlistVo> getAll_orderlist(OrderlistVo o) {
		SqlSession session = factory.openSession();

		HashMap<String, String> map = new HashMap<String, String>();

		if (o.getOrder_id() != 0) {
			map.put("order_id", o.getOrder_id() + "");
		}
		if (o.getMember_id() != null && !o.getMember_id().equals("")) {
			map.put("member_id", "%" + o.getMember_id() + "%");
		}
		if (o.getProduct_id() != 0) {
			map.put("product_id", o.getProduct_id() + "");
		}
		if (!o.getPay_date().equals("")) {
			map.put("pay_date", "%" + o.getPay_date() + "%");
		}
		if (!o.getRent_start().equals("")) {
			map.put("rent_start", "%" + o.getRent_start() + "%");
		}
		if (o.getRent_month() != 0) {
			map.put("rent_month", o.getRent_month() + "");
		}
		if (!o.getRent_end().equals("")) {
			map.put("rent_end", "%" + o.getRent_end() + "%");
		}

		List<OrderlistVo> list = session.selectList("orderlist.getAll_orderlist", map);
		session.close();

		return list;
	}

	public static List<OrderlistVo> getMyOrderlistToCondition_orderlist(String member_id, String condition) {
		SqlSession session = factory.openSession();

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("condition", condition);

		List<OrderlistVo> list = session.selectList("orderlist.getMyOrderlistToCondition_orderlist", map);
		session.close();

		return list;
	}

	public static List<OrderlistVo> getAllMyOrder_orderlist(String member_id, HashMap map) {

		map.put("member_id", member_id);

		// if(!v.getProduct_name().equals("")) {
		// map.put("product_name","%"+v.getProduct_name()+"%");
		// }if(!v.getPrice().equals("")) {
		// map.put("price", v.getPrice());
		// }if(!v.getCon().equals("")) {
		// map.put("condition",v.getCon());
		// }

		SqlSession session = factory.openSession();

		List<OrderlistVo> list = session.selectList("orderlist.getAllMyOrder_orderlist", map);
		session.close();

		return list;
	}

	public static List<OrderlistVo> getMyCartList_orderlist(String sql) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("sql", sql);

		SqlSession session = factory.openSession();
		List<OrderlistVo> list = session.selectList("orderlist.getMyCartList_orderlist", map);
		session.close();

		return list;
	}

	// for rent_month of payback
	public static int getRentMonth_orderlist(int order_id) {
		HashMap<String, String> map = new HashMap<String, String>();

		map.put("order_id", order_id + "");

		SqlSession session = factory.openSession();

		// int rent_month = -1;

		int rent_month = session.selectOne("orderlist.getRentMonth_orderlist", map);

		session.close();

		return rent_month;
	}

	public static int getMyRentMonth_orderlist(String member_id, int product_id) {
		int rent_month = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("product_id", product_id);

		rent_month = session.selectOne("orderlist.getMyRentMonth_orderlist", map);
		session.close();

		return rent_month;
	}

	public static int insertCartlist_orderlist(OrderlistVo v) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("order_id", v.getOrder_id());
		map.put("member_id", v.getMember_id());
		map.put("product_id", v.getProduct_id());
		map.put("rent_month", v.getRent_month());

		re = session.insert("orderlist.insertCartlist_orderlist", map);
		session.close();

		return re;
	}

	public static int insertPayment_orderlist(OrderlistVo v) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("order_id", v.getOrder_id());
		map.put("member_id", v.getMember_id());
		map.put("product_id", v.getProduct_id());
		map.put("rent_month", v.getRent_month());
		map.put("orderlist_condition", v.getOrderlist_condition());

		re = session.insert("orderlist.insertPayment_orderlist", map);
		session.close();

		return re;
	}

	public static int updateRentMonth_orderlist(int order_id, int rent_month) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();

		map.put("order_id", order_id);
		map.put("rent_month", rent_month);

		re = session.update("orderlist.updateRentMonth_orderlist", map);
		session.close();

		return re;
	}

	public static int updateRentEnd_orderlist(int order_id) {
		int re = -1;
		HashMap map = new HashMap();
		map.put("order_id", order_id);

		SqlSession session = factory.openSession(true);

		re = session.update("orderlist.updateRentEnd_orderlist", map);
		session.close();

		return re;
	}

	public static int updatePaymentProduct_orderlist(String member_id, long paymentOne) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("paymentOne", paymentOne);

		re = session.update("orderlist.updatePaymentProduct_orderlist", map);
		session.close();

		return re;
	}

	public static int updatePaydate_orderlist(int product_id) {
		int re = -1;

		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("product_id", product_id);

		re = session.update("orderlist.updatePaydate_orderlist", map);
		session.close();

		return re;
	}

	public static int updateRentalDateFromCartlistPayment_orderlist(int order_id, int rent_month) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("rent_month", rent_month);
		map.put("order_id", order_id);

		re = session.update("orderlist.updateRentalDateFromCartlistPayment_orderlist", map);
		session.close();

		return re;
	}

	public static int updateAll_orderlist(OrderlistVo v) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.update("orderlist.updateAll_orderlist", v);
		session.close();

		return re;
	}

	public static int updateDepositToMaster_orderlist(long paymentOne) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("paymentOne", paymentOne);

		re = session.update("orderlist.updateDepositToMaster_orderlist", map);
		session.close();

		return re;
	}

	public static int delete_orderlist(String member_id, int product_id) {
		int re = -1;
		SqlSession session = factory.openSession(true);

		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("product_id", product_id);

		re = session.delete("orderlist.delete_orderlist", map);
		session.close();

		return re;
	}

	public static int deleteOrders_orderlist(String order_id) {
		int re = -1;
		HashMap map = new HashMap();
		map.put("order_id", order_id);
		SqlSession session = factory.openSession(true);
		re = session.delete("orderlist.deleteOrders_orderlist", map);
		return re;
	}

	public static int updateOrderCondition_changeRequest(String member_id, int order_id, String changeRequest) {
		int re = -1;
		HashMap map = new HashMap();
		map.put("member_id", member_id);
		map.put("order_id", order_id);
		map.put("changeRequest", changeRequest);

		SqlSession session = factory.openSession(true);
		System.out.println("changeRequest매니저: "+changeRequest);
		re = session.update("orderlist.updateOrderCondition_changeRequest", map);
		return re;
	}

}
