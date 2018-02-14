package com.bit_fr.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit_fr.db.OrderlistManager;
import com.bit_fr.vo.OrderlistVo;

@Repository
public class OrderlistDao {
	
	public List<OrderlistVo> getOrders_orderlist(String order_id){
		return OrderlistManager.getOrders_orderlist(order_id);
	}
	
	public int getCheckExist_orderlist(String member_id, int product_id) {
		return OrderlistManager.getCheckExist_orderlist(member_id, product_id);
	}
	
	public List<OrderlistVo>getMyRecentlyOrder_orderlist(String member_id){
		return OrderlistManager.getMyRecentlyOrder_orderlist(member_id);
	}

	public int getCountNextOrderId_orderlist() {
		return OrderlistManager.getCountNextOrderId_orderlist();
	}

	public int getCountToMyCondition_orderlist(String member_id, String condition) {
		return OrderlistManager.getCountToMyCondition_orderlist(member_id, condition);
	}

	public List<OrderlistVo> getAll_orderlist(OrderlistVo o) {
		return OrderlistManager.getAll_orderlist(o);
	}

	public List<OrderlistVo> getMyOrderlistToCondition_orderlist(String member_id, String condition) {
		return OrderlistManager.getMyOrderlistToCondition_orderlist(member_id, condition);
	}

	public List<OrderlistVo> getAllMyOrder_orderlist(String member_id,OrderlistVo v) {
		return OrderlistManager.getAllMyOrder_orderlist(member_id,v);
	}

	public List<OrderlistVo> getMyCartList_orderlist(String sql) {
		return OrderlistManager.getMyCartList_orderlist(sql);
	}
	
	public int getRentMonth_orderlist(int order_id) {
		return OrderlistManager.getRentMonth_orderlist(order_id);
	}

	public int insertCartlist_orderlist(OrderlistVo v) {
		return OrderlistManager.insertCartlist_orderlist(v);
	}

	public int updateRentMonth_orderlist(int order_id,int rent_month) {
		return OrderlistManager.updateRentMonth_orderlist(order_id, rent_month);
	}

	// Controller 에서 order_id 가 dao.getNUM_NextOrderID 으로 받아와짐.
	public int updateRentEnd_orderlist(int order_id) {
		return OrderlistManager.updateRentEnd_orderlist(order_id);
	}

	public int delete_orderlist(String member_id, int product_id) {
		return OrderlistManager.delete_orderlist(member_id, product_id);
	}

	public int updatePaymentProduct_orderlist(String member_id, long paymentOne) {
		return OrderlistManager.updatePaymentProduct_orderlist(member_id, paymentOne);
	}

	public int updateRentalDateFromCartlistPayment_orderlist(int order_id, int rent_month) {
		return OrderlistManager.updateRentalDateFromCartlistPayment_orderlist(order_id, rent_month);
	}

	public int getMyRentMonth_orderlist(String member_id, int product_id) {
		return OrderlistManager.getMyRentMonth_orderlist(member_id, product_id);
	}
	
	public int updatePaydate_orderlist(String order_id) {
		return OrderlistManager.updatePaydate_orderlist(order_id);
	}
	
	public int updateAll_orderlist(OrderlistVo v) {
		return OrderlistManager.updateAll_orderlist(v);
	}

	public int updateDepositToMaster_orderlist(long paymentOne) {
		return OrderlistManager.updateDepositToMaster_orderlist(paymentOne);
	}

	public int insertPayment_orderlist(OrderlistVo v) {
		return OrderlistManager.insertPayment_orderlist(v);
	}
	
	public int deleteOrders_orderlist(String order_id) {
		return OrderlistManager.deleteOrders_orderlist(order_id);
	}
	

}
