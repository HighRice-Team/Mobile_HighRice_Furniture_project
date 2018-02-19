package com.bit_fr.controller;

import java.util.List;
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

	@RequestMapping(value = "insertQna.do", method=RequestMethod.GET)
	public ModelAndView insert_form() {
		ModelAndView view = new ModelAndView("template");
		view.addObject("viewPage", "qnaBoard/insert.jsp");
		return view;
	}
	
	@RequestMapping(value = "insertQna.do", method=RequestMethod.POST)
	public ModelAndView insert_submit() {
		ModelAndView view = new ModelAndView("template");
		view.addObject("viewPage", "qnaBoard/insert.jsp");
		return view;
	}

	@RequestMapping("reply.do")
	public ModelAndView reply() {
		ModelAndView view = new ModelAndView("template");
		view.addObject("viewPage", "qnaBoard/reply.jsp");
		return view;
	}

	@RequestMapping(value = "/getAll_qnaBoard.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String getAll_qnaBoard() {
		List<QnaBoardVo> list = dao.getAll_qnaBoard();
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}

	@RequestMapping(value="/getDetail_qnaBoard.do", produces="text/plain;charset=utf-8")
	@ResponseBody
	public String getDetail_qnaBoard(int board_id) {
		List<QnaBoardVo> list = dao.getDetail_qnaBoard(board_id);
		ObjectMapper mapper = new ObjectMapper();
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			System.out.println(e);
		}
		return str;
	}

	@RequestMapping("/insert_qnaBoard.do")
	@ResponseBody
	public String insert_qnaBoard(QnaBoardVo qnaboard) {
		int board_id = dao.getNextId_qnaBoard();
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
	public String insert_qnaBoard(QnaBoardVo qnaboard, int board_id) {
		qnaboard.setBoard_id(board_id * -1);
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
	@ResponseBody
	public void update_qnaBoard(QnaBoardVo qnaboard) {
		dao.update_qnaBoard(qnaboard);
	}

	@RequestMapping("/delete_qnaBoard.do")
	@ResponseBody
	public void delete_qnaBoard(int board_id) {
		dao.delete_qnaBoard(board_id);
	}

	@RequestMapping("/hidden_qnaBoard.do")
	@ResponseBody
	public void hidden_qnaBoard(int board_id) {
		dao.hidden_qnaBoard(board_id);
	}
}