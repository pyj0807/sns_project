package sns.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sns.repository.BoardDao;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDao boarddao;
	
	@GetMapping("/board_detail.do")
	public String board_datail(@RequestParam int num,ModelMap modelmap) {
		List<Map> list = boarddao.getOneBoard(num);
		modelmap.put("boardOne", list);
		return "sns.board_detail"; 
	}
}
