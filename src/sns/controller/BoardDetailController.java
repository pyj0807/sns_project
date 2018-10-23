package sns.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/board")
public class BoardDetailController {
	@RequestMapping("/board_detail.do")
	public String board_datail() {
		return "sns.board_detail";
	}
}
