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
	
	Map<String, HttpSession> sessions;
	public IndexController() {
		sessions = new HashMap<>();
	}

	@RequestMapping("/index.do")
	public String index(ModelMap modelmap, WebRequest wr) {

		// 메인접속시 몽고db board테이블 정보 뽑기

		List<Map> list = boarddao.getAllBoard();
		modelmap.put("board_list", list);
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
			Map msgg = new HashMap();
			msgg.put("mode", "erlogin");
			msgg.put("actor", id);
			if(sessions.containsKey(id)) {
				sessions.get(id).invalidate();
				sessions.remove(id);
				
				
				service.sendOne(msgg, id);
			}
			sessions.put(id,session);
			
			
			wr.setAttribute("userId", id, wr.SCOPE_SESSION);
			wr.setAttribute("Id", log.get("ID"), wr.SCOPE_SESSION);

			wr.setAttribute("auth", true, wr.SCOPE_SESSION);
			wr.setAttribute("user", log, wr.SCOPE_SESSION);

			return "redirect:/index.do";
		} else {

			return "/index/login";
		}

	}
	
	@GetMapping("logout.do")
	public String logout(WebRequest wr) {
		String id= (String)wr.getAttribute("userId", wr.SCOPE_SESSION);
		/*sessions.get(id).invalidate();*/
		sessions.remove(id);
		wr.removeAttribute("auth", wr.SCOPE_SESSION);
		return "redirect:index.do";
	}
}
