package ino.web.freeBoard.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ino.web.freeBoard.dto.FreeBoardDto;
import ino.web.freeBoard.service.FreeBoardService;

@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService freeBoardService;

	@RequestMapping("/main.ino")
	public ModelAndView main(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		List<FreeBoardDto> list = freeBoardService.freeBoardList();

		mav.setViewName("boardMain");
		mav.addObject("freeBoardList",list);
		return mav;
	}

	@RequestMapping("/freeBoardInsert.ino")
	public String freeBoardInsert(){
		return "freeBoardInsert";
		}

	@ResponseBody
	@RequestMapping(value = "/freeBoardInsertPro.ino", method = RequestMethod.POST )
	public HashMap<String,Object> freeBoardInsertPro(HttpServletRequest request, FreeBoardDto dto){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.freeBoardInsertPro(dto);
			map.put("num", freeBoardService.getNewNum());
			map.put("mv", true);
			System.out.println("Exception e = ");
		} catch (Exception e) {
			map.put("err", "게시글 작성 실패");
			map.put("mv", false);
			System.out.println("Exception e = " + e.getMessage());
		}
		return map;
	}
 
	@ResponseBody
	@RequestMapping("/freeBoardDetail.ino")
	public ModelAndView freeBoardDetail(HttpServletRequest request, FreeBoardDto dto){
		FreeBoardDto dtoo = freeBoardService.getDetailByNum(dto.getNum());
		return new ModelAndView("freeBoardDetail", "freeBoardDto", dtoo);
	}

	@ResponseBody
	@RequestMapping(value = "/freeBoardModify.ino",  method = RequestMethod.POST)
	public HashMap<String, Object> freeBoardModify(HttpServletRequest request, FreeBoardDto dto){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.freeBoardModify(dto);
			map.put("num", freeBoardService.getNewNum());
			map.put("mv", true);
			System.out.println("Exception e = ");
		} catch (Exception e) {
			map.put("err", "수정 실패");
			map.put("mv", false);
			System.out.println("Exception e = " + e.getMessage());
		}
		return map;
	}

	@ResponseBody
	@RequestMapping(value ="/freeBoardDelete.ino", method = RequestMethod.POST)
	public HashMap<String, Object> FreeBoardDelete(int num){
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			freeBoardService.FreeBoardDelete(num);
			map.put("num", freeBoardService.getNewNum());
			map.put("mv", true);
			System.out.println("Exception e = ");
		} catch (Exception e) {
			map.put("err", "수정 실패");
			map.put("mv", false);
			System.out.println("Exception e = " + e.getMessage());
		}
		return map;
	}
	

}