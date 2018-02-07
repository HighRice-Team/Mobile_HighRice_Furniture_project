package com.bit_fr.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit_fr.dao.MemberDao;
import com.bit_fr.vo.MemberVo;
//import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MemberController {

	@Autowired
	private JavaMailSender mailSender;

	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	@Autowired
	private MemberDao member_dao;

	public void setDao(MemberDao dao) {
		this.member_dao = dao;
	}

	@RequestMapping("search.do")
	public void goSearchAddress() {
	}

	////////////삭제해야함
	@RequestMapping("testMain.do")
	public ModelAndView testMain() {
		ModelAndView mav = new ModelAndView("join/testMain");
		return mav;
	}///////////////////
	
	@RequestMapping("findMember.do")
	public ModelAndView gotofindMemberPage() {
		ModelAndView mav = new ModelAndView("join/findMember");
		return mav;
	}

	@RequestMapping("/joinAccess.do")
	public ModelAndView gotoJoinAccess() {
		ModelAndView mav = new ModelAndView("join/step1_access");
		return mav;
	}

	@RequestMapping(value="/joinCheck.do", method=RequestMethod.GET)
	public ModelAndView gotoJoinCheck() {
		ModelAndView mav = new ModelAndView("join/step2_check");
		return mav;
	}
	
	@RequestMapping(value="/joinCheck.do", method=RequestMethod.POST)
	public ModelAndView goToInsertMember(MemberVo v, int jumin1) {
		ModelAndView mav = new ModelAndView("join/step3_insert");
		String jumin = v.getJumin();
		mav.addObject("v", v);
		mav.addObject("jumin1", jumin1);
		mav.addObject("jumin", jumin);
		return mav;
	}
	
	@RequestMapping(value="/insert_member.do", method=RequestMethod.POST)
	public ModelAndView insert_member(MemberVo v) {
		ModelAndView mav = new ModelAndView("join/step4_complete");
		member_dao.insert_member(v);
		return mav;
	}
	

	////////////삭제해야함
	@RequestMapping(value="/test.do")
	public ModelAndView test(MemberVo v) {
		ModelAndView mav = new ModelAndView("join/step4_complete");
		return mav;
	}///////////////////
	
	
	
	// Select
	@RequestMapping(value = "/logout.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String logout(HttpSession session) {
		String str = "";

		session.invalidate();

		return str;
	}

	@RequestMapping(value = "/login.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String login(MemberVo v, HttpSession session) {
		String str = "";

		MemberVo v2 = member_dao.getOne_member(v.getMember_id());

		String input_pwd = v.getPwd();

		if (v2 != null && !v2.equals("")) {

			String pwd = v2.getPwd();
			if (pwd.equals(input_pwd)) {
				str = "1";
				session.setAttribute("needToLogin", null);
				session.setAttribute("id", v.getMember_id());
				session.setAttribute("grade", v2.getGrade());
				session.setAttribute("pwd", v2.getPwd());

			} else {
				str = "0";
			}
		} else {
			str = "-1";
		}

		return str;
	}

	@RequestMapping(value = "/getOne_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getOne_member(String member_id) {
		String str = "";
		MemberVo v = member_dao.getOne_member(member_id);

		try {

			ObjectMapper om = new ObjectMapper();
			str = om.writeValueAsString(v);

		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}

	@RequestMapping(value = "/getOne_member_ajax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getOne_member_ajax(String member_id) {

		String str = "";
		MemberVo m = member_dao.getOne_member(member_id);
		try {
			ObjectMapper mapper = new ObjectMapper();
			str = mapper.writeValueAsString(m);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/getId_member.do", method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getId_member(MemberVo v) {
		String str = "";

		if (member_dao.getId_member(v) != null && !member_dao.getId_member(v).equals("")) {
			str = member_dao.getId_member(v);
		}

		return str;
	}

	@RequestMapping("/getCount_member.do")
	public ModelAndView getCount_member() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("countMember", member_dao.getCount_member());

		return mav;
	}
	// Insert



	// Update은 Ajax을 이용.

	@RequestMapping(value = "/changePwdChk.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String changePwdChk(HttpSession session, String old_pwd, String input_pwd, String input_pwd2) {
		String id = (String) session.getAttribute("id");
		MemberVo memberVo = member_dao.getOne_member(id);

		String str = "";
		String pwd = memberVo.getPwd();

		if (input_pwd.equals(input_pwd2)) {
			if (old_pwd.equals(pwd)) {
				str = "일치";
			} else {
				str = "비밀번호가 일치하지 않습니다.";
			}
		} else {
			str = "입력한 두 번호가 일치하지 않습니다.";
		}

		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(str);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return str;
	}

	@RequestMapping(value = "/updatePwd_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updatePwd_member(MemberVo v) {
		String str = "";
		// ObjectMapper om = new ObjectMapper();

		int re = member_dao.updatePwd_member(v);

		try {
			// str = om.writeValueAsString(re);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}

	@RequestMapping(value = "/updateInfo_member.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateInfo_member(MemberVo v, HttpSession session) {
		String str = "";
		ObjectMapper om = new ObjectMapper();
		String member_id = (String) session.getAttribute("id");
		v.setMember_id(member_id);
		int re = member_dao.updateInfo_member(v);

		try {
			str = om.writeValueAsString(re);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}

	@RequestMapping(value = "sendMail.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String mail(String member_id, String confirmText) {
		String str = "";
		MemberVo v = member_dao.getOne_member(member_id);

		SimpleMailMessage mailMessage = new SimpleMailMessage();

		mailMessage.setFrom("bitfr@naver.com");

		if (v != null) {
			mailMessage.setSubject("[BIT FR]비밀번호 안내.");
			mailMessage.setText("귀하의 비밀번호는 < " + v.getPwd() + " > 입니다.");
		} else {
			mailMessage.setSubject("[BIT FR]인증번호 메일 발송.");
			mailMessage.setText("[BIT FR]인증번호 [" + confirmText + "]를 입력해 주세요.");
		}
		mailMessage.setTo(member_id);

		try {
			mailSender.send(mailMessage);
		} catch (Exception e) {
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/getMemberInfoAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String getMemberInfoAjax(HttpSession session) {
		String str = "";
		String member_id = (String) session.getAttribute("id");

		MemberVo v = member_dao.getOne_member(member_id);

		ObjectMapper mapper = new ObjectMapper();

		try {

			str = mapper.writeValueAsString(v);

		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return str;
	}

	@RequestMapping(value = "/updateMemberOkAjax.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String updateMemberOkAjax(HttpSession session, String j_pwd, String pwd_chk, MemberVo v) {
		String str = "";

		String pwd = (String) session.getAttribute("pwd");
		int grade = (Integer) session.getAttribute("grade");
		String input_pwd = j_pwd;
		String input_pwd2 = pwd_chk;

		if (input_pwd.equals(input_pwd2)) {

			String member_id = (String) session.getAttribute("id");
			v.setMember_id(member_id);
			v.setGrade(grade);
			v.setBalance((member_dao.getOne_member(member_id)).getBalance());
			v.setPayback((member_dao.getOne_member(member_id)).getPayback());

			if (input_pwd.equals(pwd)) {

				member_dao.updateInfo_member(v);

				str = "회원정보 변경 완료";

			} else {
				str = "비밀번호 오류.";
			}
		} else {
			str = "입력한 두 비밀번호가 일치하지 않습니다.";
		}

		return str;
	}

	@RequestMapping(value = "/pwdChk.do", produces = "text/plain;charset=utf-8")
	@ResponseBody
	public String pwdChk(HttpSession session, String pwd, String pwd2) {
		String member_id = (String) session.getAttribute("id");
		MemberVo memberVo = member_dao.getOne_member(member_id);

		String str = "";
		String db_pwd = memberVo.getPwd();

		if (pwd.equals(pwd2)) {
			if (db_pwd.equals(pwd)) {
				str = "일치";
			} else {
				str = "비밀번호가 일치하지 않습니다.";
			}
		} else {
			str = "입력한 두 번호가 일치하지 않습니다.";
		}

		return str;
	}

}
