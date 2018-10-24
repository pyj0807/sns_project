package sns.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

import sns.repository.BoardDao;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDao boarddao;
	@Autowired
	Gson gson;
	
	@GetMapping("/board_detail.do")
	public String board_datail(@RequestParam int num,ModelMap modelmap) {
		Map list = boarddao.getOneBoard(num);
		modelmap.put("boardOne", list);
		return "sns.board_detail"; 
	}
	
	//like눌렀을때 처리
	@PostMapping("/like.do")
	public String board_like(@RequestBody String param) {
		Map like = gson.fromJson(param, Map.class);
		System.out.println(like);
		Double id = (double)like.get("_id");
		
		//몽고디비에등록
		
		
		return "sns.board_detail";
	}
}
