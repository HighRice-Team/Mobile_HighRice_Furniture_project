package com.bit_fr.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.bit_fr.dao.QnaBoardDao;
import com.bit_fr.vo.QnaBoardVo;

@Controller
public class QnaBoardController {
	@Autowired
	private QnaBoardDao dao;

	public void setDao(QnaBoardDao dao) {
		this.dao = dao;
	}

	String str = "";

	@RequestMapping("qnaBoard.do")
	public ModelAndView qnaBoard() {
		ModelAndView view = new ModelAndView("template");
		
		view.addObject("list", dao.getAll_qnaBoard()); 
		
		view.addObject("viewPage", "qnaBoard/qnaBoard.jsp");
		return view;
	}

	@RequestMapping("detailQna.do")
	public ModelAndView detail(int board_id) {
		ModelAndView view = new ModelAndView("template");
		view.addObject("qnaboard", dao.getOne_qnaBoard(board_id));
		view.addObject("viewPage", "qnaBoard/detail.jsp");

		return view;
	}
	
	@RequestMapping(value="getCountRef_qnaboard.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String getCountRef_qnaboard(int b_ref) {
		String str = "";
		int re = dao.getCountRef_qnaboard(b_ref);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		
		return str;
	}
	
	@RequestMapping(value="getComment.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String getComment_qnaboard(int b_ref) {
		String str = "";
		QnaBoardVo qb = dao.getComment_qnaBoard(b_ref);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(qb);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		
		return str;
	}

	@RequestMapping(value = "insertQna.do", method=RequestMethod.GET)
	public ModelAndView insert_form() {
		ModelAndView view = new ModelAndView("template");
		view.addObject("viewPage", "qnaBoard/insert.jsp");
		return view;
	}
	
	@RequestMapping(value = "insertQna.do", method=RequestMethod.POST)
	public ModelAndView insert_submit(QnaBoardVo qb, HttpSession session) {
		ModelAndView view = new ModelAndView("template");
		String member_id = (String) session.getAttribute("id");
		
		int board_id = dao.getNextId_qnaBoard();
		qb.setMember_id(member_id);
		qb.setBoard_id(board_id);
		
		if(qb.getPost_type() == null || qb.getPost_type().equals(""))
			qb.setPost_type("일반 문의");
		
		qb.setB_ref(board_id);
		qb.setB_level(0);
		
		int re = dao.insert_qnaBoard(qb);
		
		view.addObject("viewPage", "qnaBoard/insert.jsp");
		view.setViewName("redirect:/qnaBoard.do");
		return view;
	}
	
	

	@RequestMapping("reply.do")
	public ModelAndView reply() {
		ModelAndView view = new ModelAndView("template");
		view.addObject("viewPage", "qnaBoard/reply.jsp");
		return view;
	}



	@RequestMapping("/insert_qnaBoard.do")
	@ResponseBody
	public String insert_qnaBoard(QnaBoardVo qnaboard, HttpSession session) {
		int board_id = dao.getNextId_qnaBoard();
		qnaboard.setMember_id((String)session.getAttribute("id"));
		qnaboard.setBoard_id(board_id);
		qnaboard.setB_ref(board_id);
		qnaboard.setB_level(0);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(qnaboard);
		} catch (Exception e) {
			System.out.println(e);
		}
		dao.insert_qnaBoard(qnaboard);
		return str;
	}

	@RequestMapping("/insertAdminReply.do")
	@ResponseBody
	public String insert_Reply(QnaBoardVo qnaboard, HttpSession session) {
		
		
		int board_id = qnaboard.getBoard_id();
		qnaboard.setMember_id((String)session.getAttribute("id"));
		qnaboard.setBoard_id(board_id * -1);
		qnaboard.setPost_type("답글");
		qnaboard.setB_ref(board_id);
		qnaboard.setB_level(2);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(qnaboard);
		} catch (Exception e) {
			System.out.println(e);
		}
		dao.updateParents_qnaBoard(board_id);
		dao.insert_qnaBoard(qnaboard);
		return str;
	}

	@RequestMapping("/update_qnaBoard.do")
	public ModelAndView update_form(int board_id) {
		
		ModelAndView mav = new ModelAndView("template");
		QnaBoardVo qb = dao.getOne_qnaBoard(board_id);
		
		mav.addObject("viewPage", "qnaBoard/update.jsp");
		mav.addObject("qb", qb);
		return mav;
	}
	
	
	
	@RequestMapping(value="/updateAjax_qnaBoard.do", produces="text/plain; charset=utf-8")
	@ResponseBody
	public String update_submit(QnaBoardVo qnaboard) {
		
		String str = "";
		int re = dao.update_qnaBoard(qnaboard);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(re);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		return str;
	}

	@RequestMapping("/delete_qnaBoard.do")
	public ModelAndView delete_qnaBoard(int board_id) {
		ModelAndView mav = new ModelAndView();			
		int re = dao.delete_qnaBoard(board_id);
		
		mav.setViewName("redirect:/qnaBoard.do");
		
		return mav;
	}

	@RequestMapping("/hidden_qnaBoard.do")
	@ResponseBody
	public void hidden_qnaBoard(int board_id) {
		dao.hidden_qnaBoard(board_id);
	}
}