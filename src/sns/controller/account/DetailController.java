package sns.controller.account;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sns.repository.BoardDao;

@Controller
public class DetailController {
	
	@Autowired
	BoardDao boarddao;
	
	@GetMapping("/content.do")
	public String detail(@RequestParam int num,ModelMap modelmap) {
		Map list = boarddao.getOneBoard(num);
		modelmap.put("boardOne", list);
		return "sns.board_detail";
	}
}
