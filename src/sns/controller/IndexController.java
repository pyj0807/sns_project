package sns.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

import sns.repository.BoardDao;

@Controller
public class IndexController {
	@Autowired
	BoardDao boarddao;
	@Autowired
	Gson gson;
	
	@RequestMapping("/index.do")
	public String index(ModelMap modelmap) {
		
		//메인접속시 몽고db board테이블 정보 뽑기
		List<Map> list = boarddao.getAllBoard();
		modelmap.put("board_list", list);
				
		return "sns.home";
	}
}
