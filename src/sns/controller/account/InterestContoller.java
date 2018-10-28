package sns.controller.account;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import sns.repository.BoardRepository;

@Controller
public class InterestContoller {
	@Autowired
	BoardRepository boardRepository;	
	
	@RequestMapping("/interest.do")
	public String interest(@RequestParam String theme, ModelMap modelmap){
		List<Map> list = boardRepository.getBoardTheme(theme);
		modelmap.put("theme", theme);
		modelmap.put("list", list);
		
		return "sns.theme";
	}
}
