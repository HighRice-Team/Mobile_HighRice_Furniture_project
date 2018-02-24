
package com.bit_fr.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.bit_fr.vo.MemberVo;
import com.bit_fr.vo.OrderlistVo;

public class MemberManager {
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

	// Select

	public static List<MemberVo> getAll_member(MemberVo m) { // Member 테이블의 모든 객체를 member_id 순으로 정렬한 결과를 List로 반환한다.
		SqlSession session = factory.openSession();

		HashMap<String, String> map = new HashMap<String, String>();

		if (m.getMember_id() != null && !m.getMember_id().equals("")) {
			map.put("member_id", "%" + m.getMember_id() + "%");
		}
		if (m.getPwd() != null && !m.getPwd().equals("")) {
			map.put("pwd", m.getPwd());
		}
		if (!m.getName().equals("")) {
			map.put("name", "%" + m.getName() + "%");
		}
		if (!m.getTel().equals("")) {
			map.put("tel", "%" + m.getTel() + "%");
		}
		if (m.getJumin() != null && !m.getJumin().equals("")) {
			map.put("jumin", "%" + m.getJumin() + "%");
		}
		if (!m.getPwd_q().equals("")) {
			map.put("pwd_q", "%" + m.getPwd_q() + "%");
		}
		if (!m.getPwd_a().equals("")) {
			map.put("pwd_a", "%" + m.getPwd_a() + "%");
		}
		if (!m.getAddress().equals("")) {
			map.put("address", "%" + m.getAddress() + "%");
		}
		if (!m.getAddress_detail().equals("")) {
			map.put("address_detail", "%" + m.getAddress_detail() + "%");
		}
		if (m.getPayback() != 0) {
			map.put("payback", m.getPayback() + "");
		}
		if (!m.getAccount_no().equals("")) {
			map.put("account_no", "%" + m.getAccount_no() + "%");
		}
		if (!m.getBank().equals("")) {
			map.put("bank", "%" + m.getBank() + "%");
		}
		if (m.getBalance() != 0) {
			map.put("balance", m.getBalance() + "");
		}
		if (m.getGrade() != 0) {
			map.put("grade", m.getGrade() + "");
		}

		List<MemberVo> list = session.selectList("member.getAll_member", map);
		session.close();

		return list;
	}
	
	public static List<String> getAllJumin_member(){
		SqlSession session = factory.openSession();
		List<String> list = session.selectList("member.getAllJumin_member");
		session.close();
		
		return list;
	}

	public static MemberVo getOne_member(String member_id) { // member_id를 매개변수로 받아 해당 member의 정보를 Vo로 반환한다.
		HashMap map = new HashMap();
		map.put("member_id", member_id);

		SqlSession session = factory.openSession();
		MemberVo v = session.selectOne("member.getOne_member", map);
		session.close();

		return v;
	}

	public static String getId_member(MemberVo v) { // 회원정보 찾기. jumin을 매개변수로 받아 일치하는 member의 member_id값을 반환
		SqlSession session = factory.openSession();
		String member_id = session.selectOne("member.getId_member", v);
		session.close();

		return member_id;
	}

	public static int getCount_member() { // 모든 회원의 수를 반환.
		SqlSession session = factory.openSession();
		int re = session.selectOne("member.getCount_member");
		session.close();

		return re;
	}

	// 매니저 분류
	public static int getGrade_member(String member_id) {
		SqlSession session = factory.openSession();
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		int re = session.selectOne("member.getGrade_member", map);

		session.close();

		return re;
	}

	// Insert

	public static int insert_member(MemberVo v) { // 회원가입. 일반회원과 관리자 구분없이 아이디 생성이 이루어짐. 구분은 속성 값 grade로 구별한다.
		SqlSession session = factory.openSession(true);
		int re = session.insert("member.insert_member", v);
		session.close();

		return re;
	}

	// Update

	public static int updateResetPwd_member(String member_id) { // 회원계정의 비밀번호 초기화
		SqlSession session = factory.openSession(true);
		int re = session.update("member.updateResetPwd_member", member_id);
		session.close();

		return re;
	}

	public static int updatePwd_member(MemberVo v) { // 회원계정의 비밀번호 변경
		SqlSession session = factory.openSession(true);
		int re = session.update("member.updatePwd_member", v);
		session.close();

		return re;
	}

	public static int updateInfo_member(MemberVo v) { // 회원계정의 정보변경
		SqlSession session = factory.openSession(true);
		int re = session.update("member.updateInfo_member", v);
		session.close();

		return re;
	}

	public static int updatePayback_member(String member_id, int payback) {
		int re = -1;
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("payback", payback + "");
		SqlSession session = factory.openSession();
		re = session.update("member.paybackMaster_member", map);
		session.update("member.updatePayback_member", map);
		if (re <= 0) {
			session.rollback();
		} else {
			session.commit();
		}

		return re;
	}
	
	public static int updateBalance_member(MemberVo v) {
		SqlSession session = factory.openSession(true);
		int re = session.update("member.updateBalance_member", v);
		session.close();

		return re;
	}

	public static int updateAddr_member(MemberVo v) {
		SqlSession session = factory.openSession(true);
		int re = session.update("member.updateAddr_member", v);
		session.close();

		return re;
	}

	public static List<String> getPwd_q() {
		SqlSession session = factory.openSession();
		List<String> list = session.selectList("member.getPwd_q");
		session.close();

		return list;
	}

	// Delete


}
