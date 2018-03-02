package com.bit_fr.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.bit_fr.db.MemberManager;
import com.bit_fr.vo.MemberVo;

@Repository
public class MemberDao {
	public List<String> getAllJumin_member(){
		return MemberManager.getAllJumin_member();
	}
	
	public List<MemberVo> getBitMan_member(){
		return MemberManager.getBitMan_member();
	}
	
	public List<MemberVo> getAll_member(MemberVo m) {
		return MemberManager.getAll_member(m);
	}

	public MemberVo getOne_member(String member_id) {
		return MemberManager.getOne_member(member_id);
	}

	public String getId_member(MemberVo v) {
		return MemberManager.getId_member(v);
	}

	public int getCount_member() {
		return MemberManager.getCount_member();
	}

	public List<String> getPwd_q() {
		return MemberManager.getPwd_q();
	}

	public int getGrade_member(String member_id) {
		return MemberManager.getGrade_member(member_id);
	}

	public int insert_member(MemberVo v) {
		return MemberManager.insert_member(v);
	}

	public int updateResetPwd_member(String member_id) {
		return MemberManager.updateResetPwd_member(member_id);
	}

	public int updatePwd_member(MemberVo v) {
		return MemberManager.updatePwd_member(v);
	}

	public int updateInfo_member(MemberVo v) {
		return MemberManager.updateInfo_member(v);
	}

	
	public int updateBalance_member(MemberVo v) {
		return MemberManager.updateBalance_member(v);
	}

	public int updateAddr_member(MemberVo v) {
		return MemberManager.updateAddr_member(v);
	}

	public int updatePayback_member(String member_id, int payback) {
		return MemberManager.updatePayback_member(member_id, payback);
	}
	
	public int updateMasterForRefund_member(int payback) {
		return MemberManager.updateMasterForRefund_member(payback);
	}
}
