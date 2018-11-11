package sns.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import sns.repository.AccountDao;
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
	
	@Autowired
	AccountDao accdao;
	Map<String, HttpSession> sessions;

	public IndexController() {
		sessions = new HashMap<>();
	}

	@RequestMapping("/index.do")
	public String index(ModelMap modelmap, WebRequest wr,HttpServletRequest req,HttpServletResponse res) {

		if(req.getCookies()!=null) {
			Cookie[] aa=  req.getCookies();
		for(int i=0;i<aa.length;i++) {
			if(aa[i].getName().equals("idd")){
				System.out.println("꺄르르>"+aa[i].getName()+"////"+aa[i].getValue());
				Map user=accdao.accountselect(aa[i].getValue());
				wr.setAttribute("userId",aa[i].getValue(), wr.SCOPE_SESSION);
				wr.setAttribute("Id",aa[i].getValue(), wr.SCOPE_SESSION);
				wr.setAttribute("user",user, wr.SCOPE_SESSION);
				wr.setAttribute("auth",aa[i].getValue(), wr.SCOPE_SESSION);
			}
		}
		}
		// 메인접속시 몽고db board테이블 정보 뽑기
		List<Map> list = boarddao.getAllBoard();
		for (int i = 0; i < list.size(); i++) {
			long writetime = (long) list.get(i).get("time");
			long lasttime = (System.currentTimeMillis() - writetime) / (1000); // 초!
			list.get(i).put("lasttime", lasttime);
		}
		//리스트 9개만 보여주는것
		if(list.size()<=9) {
			modelmap.put("board_list", list);			
			modelmap.put("more", false);
		}else {
			modelmap.put("board_list", list.subList(0, 9));
			modelmap.put("more", true);
		}
		/*
		 * if (wr.getAttribute("auth", wr.SCOPE_SESSION) == null) {
		 * 
		 * return "/index/login"; } else {
		 */
		String[] interest = "게임,운동,영화,음악,IT,연애,음식,여행,패션,애니,동물,기타".split(",");
		String sInter = Arrays.toString(interest);
		List listInter = gson.fromJson(sInter, List.class);
		wr.setAttribute("allInter", listInter, wr.SCOPE_SESSION);

		return "sns.home";
		/* } */
	}
	
	//무한스크롤
	  @RequestMapping("/moreHtml.do") 
      public String moreHtml(ModelMap modelmap, @RequestParam(required=false) String p) {
      
         List<Map> list = boarddao.getAllBoard();
         for (int i = 0; i < list.size(); i++) {
            long writetime = (long) list.get(i).get("time");
            long lasttime = (System.currentTimeMillis() - writetime) / (1000); // 초!
            list.get(i).put("lasttime", lasttime);
         }
         
         int b1 = (list.size()%9)== 0 ? list.size()/9-1 : (list.size()/9); // 글이 38개 , 4 page 

         int page = Integer.parseInt(p);
         System.out.println(page);
               
    	if(page < b1) { //page는 1부터
          modelmap.put("board_list", list.subList(page*9,(page+1)*9));
          modelmap.put("more", true);
    	 }else { //마지막페이지이면
    		System.out.println("hello !!world");
          modelmap.put("board_list", list.subList(page*9,list.size()));
          //page =1 이면 (10,19), 2이면 (19,28)
          modelmap.put("more", false);
    	}
         
         return "main/moreHTML";
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

	public String loginHandler(HttpServletRequest req,HttpServletResponse res,ModelMap modelmap, WebRequest wr) {
		
		if(wr.getParameter("newpass")!=null) {
			modelmap.put("newpass", "on");
		}
		if(req.getCookies()!=null) {
			Cookie[] aa=  req.getCookies();
		for(int i=0;i<aa.length;i++) {
			if(aa[i].getName().equals("idd")){
				System.out.println("꺄르르>"+aa[i].getName()+"////"+aa[i].getValue());
				Map user=accdao.accountselect(aa[i].getValue());
				wr.setAttribute("userId",aa[i].getValue(), wr.SCOPE_SESSION);
				wr.setAttribute("Id",aa[i].getValue(), wr.SCOPE_SESSION);
				wr.setAttribute("user",user, wr.SCOPE_SESSION);
				wr.setAttribute("auth",aa[i].getValue(), wr.SCOPE_SESSION);
			}
		}
		}
		
		if (wr.getAttribute("dest", wr.SCOPE_SESSION) == null&&wr.getAttribute("auth", wr.SCOPE_SESSION)!=null) { // dest:경로 입력했을때 주소저장
			return "redirect:/index.do";
		} else if(wr.getAttribute("auth", wr.SCOPE_SESSION)!=null&&wr.getAttribute("dest", wr.SCOPE_SESSION)!=null){
			return "redirect:" + wr.getAttribute("dest", wr.SCOPE_SESSION);
		}

		return "/index/login";
	}

	@PostMapping("/login.do")
	public String loginHandle(WebRequest wr, ModelMap map, HttpSession session,HttpServletRequest req,HttpServletResponse res) {

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

			wr.setAttribute("auth", id, wr.SCOPE_SESSION);
			wr.setAttribute("user", log, wr.SCOPE_SESSION);
			if(wr.getParameter("dd")!=null) {
			Cookie a =new Cookie("idd", id);
			a.setMaxAge(60*60*24);
			res.addCookie(a);
			}
			if (wr.getAttribute("dest", wr.SCOPE_SESSION) == null) { // dest:경로 입력했을때 주소저장
				return "redirect:/index.do";
			} else {
				return "redirect:" + wr.getAttribute("dest", wr.SCOPE_SESSION);
			}
		} else {
			return "redirect:/login.do?nopass=no";
		}

	}

	@GetMapping("logout.do")
	public String logout(WebRequest wr, HttpSession session,HttpServletRequest req,HttpServletResponse res) {
		/* sessions.get(id).invalidate(); */
		String id = (String) wr.getAttribute("userId", wr.SCOPE_SESSION);
		session.invalidate();
		sessions.remove(id);
		wr.removeAttribute("auth", wr.SCOPE_SESSION);
		Cookie[] a=req.getCookies();
	
		for(int i=0;i<a.length;i++) {
			
				
				a[i].setMaxAge(0);
				res.addCookie(a[i]);
			
			
		}
		return "redirect:index.do";
	}
}
