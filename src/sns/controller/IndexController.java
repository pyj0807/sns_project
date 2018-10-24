package sns.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;

import sns.repository.BoardDao;
import sns.repository.AlertService;
import sns.repository.LoingDao;

@Controller
public class IndexController {

	@Autowired
	BoardDao boarddao;
	@Autowired
	Gson gson;
	@Autowired
	LoingDao ldao;

	@RequestMapping("/index.do")
	public String index(ModelMap modelmap) {
		// 메인접속시 몽고db board테이블 정보 뽑기
		List<Map> list = boarddao.getAllBoard();
		modelmap.put("board_list", list);

		return "sns.home";
	}

	@GetMapping("/login.do")
	public String index(WebRequest wr) {
		System.out.println("index 옴");

		if (wr.getAttribute("auth", wr.SCOPE_SESSION) == null) {
			return "/index/login";
		} else {
			return "sns.home";
		}
	}

	@Autowired
	AlertService service;

	@PostMapping("/login.do")
	public String loginHandle(WebRequest wr, ModelMap map, HttpSession session) {
		System.out.println("login 옴");

		String id = (String) wr.getParameter("id");
		String subid = (String) wr.getParameter("subid");

		String pass = (String) wr.getParameter("pass");

		Map data = new HashMap<>();
		data.put("email", id);
		data.put("pass", pass);

		System.out.println("data = " + data);

		Map log = ldao.login(data);

		if (log != null) {
			wr.setAttribute("userId", id, wr.SCOPE_SESSION);
			wr.setAttribute("auth", true, wr.SCOPE_SESSION);
			wr.setAttribute("user", log, wr.SCOPE_SESSION);

			return "sns.home";

		} else {

			return "/index/login";
		}

	}
}
