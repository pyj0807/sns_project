package sns.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.google.gson.Gson;
import com.sun.java.swing.plaf.windows.resources.windows;

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
		for (int i = 0; i < list.size(); i++) {
			long writetime = (long) list.get(i).get("time");
			long lasttime = (System.currentTimeMillis() - writetime) / (1000); // 초!
			list.get(i).put("lasttime", lasttime);
		}

		modelmap.put("board_list", list);
		/*
		 * if (wr.getAttribute("auth", wr.SCOPE_SESSION) == null) {
		 * 
		 * return "/index/login"; } else {
		 */
		String[] interest = "게임,운동,영화,음악,IT,연애,음식,여행,패션,기타".split(",");
		String sInter = Arrays.toString(interest);
		List listInter = gson.fromJson(sInter, List.class);
		wr.setAttribute("allInter", listInter, wr.SCOPE_SESSION);

		return "sns.home";
		/* } */
	}

	@ResponseBody
	@PostMapping(path = "/indexAjax.do", produces = "application/json;charset=UTF-8")
	public String indexAjax(@RequestParam int room_no) {
		List<Map> list = boarddao.getBoardReply(room_no);
		String json = gson.toJson(list);
		return json;
	}

	@Autowired
	AlertService service;

	@GetMapping("/login.do")
	public String loginHandler() {

		return "/index/login";
	}

	@PostMapping("/login.do")
	public String loginHandle(WebRequest wr, ModelMap map, HttpSession session) {

		String id = (String) wr.getParameter("id");
		String subid = (String) wr.getParameter("subid");

		if (sessions.get(id) != null) {
			session.invalidate();
			sessions.remove(id);
		}
		String pass = (String) wr.getParameter("pass");

		Map data = new HashMap<>();
		data.put("id", id);
		data.put("pass", pass);


		Map log = ldao.login(data);

		// 중복로그인 체크
		if (log != null) {
			Map msgg = new HashMap();
			msgg.put("mode", "erlogin");
			msgg.put("actor", id);
			if (sessions.containsKey(id)) {
				sessions.get(id).invalidate();
				sessions.remove(id);

				service.sendOne(msgg, id);
			}
			sessions.put(id, session);

			wr.setAttribute("userId", id, wr.SCOPE_SESSION);
			wr.setAttribute("Id", log.get("ID"), wr.SCOPE_SESSION);

			wr.setAttribute("auth", true, wr.SCOPE_SESSION);
			wr.setAttribute("user", log, wr.SCOPE_SESSION);

			if (wr.getAttribute("dest", wr.SCOPE_SESSION) == null) { // dest:경로 입력했을때 주소저장
				return "redirect:/index.do";
			} else {
				return "redirect:" + wr.getAttribute("dest", wr.SCOPE_SESSION);
			}
		} else {

			return "/index/login";
		}

	}

	@GetMapping("logout.do")
	public String logout(WebRequest wr, HttpSession session) {
		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		/* sessions.get(id).invalidate(); */
		session.invalidate();
		sessions.remove(id);
		wr.removeAttribute("auth", wr.SCOPE_SESSION);
		return "redirect:index.do";
	}
}
