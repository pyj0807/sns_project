package sns.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;

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

import sns.repository.BoardDao;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDao boarddao;
	@Autowired
	Gson gson;
	@Autowired
	ServletContext svc;

	@GetMapping("/board_detail.do")
	public String board_datail(@RequestParam int num, ModelMap modelmap, WebRequest wr) {
		Map list = boarddao.getOneBoard(num);
		List liker = (List) list.get("liker"); // board테이블에 좋아요한 list
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String userEmail = (String) user.get("EMAIL");// 접속한 EMAIL
		if (liker.contains(userEmail)) {
			list.put("checked", true);// 체크 true
		} else {
			list.put("checked", false);// 체크 false
		}
//=================================================================================		
		//입력한내용에서 split 뽑기(띄어쓰기마다)
		String content = (String) list.get("content");
		String[] temp = content.split("\\s+"); //enter space tab 등 공백전부
//		for (int i = 0; i < temp.length; i++) {
//			System.out.println("temp 는 ="+temp[i]);
//		}
		//result =빈문자열, start =태그, end = 태그닫기
//		String result = "";
//		String start = "<a href = \"/sns_project/board/board_search.do?hashtag=#나는\">";
//		String end = "</a>";
		String path = svc.getContextPath();
		String result = "";
		String start = "<a href = \""+path+"/board/board_search.do?hashtag=";
		String mid = "\">";
		String end = "</a>";
		
		//몽고db에서 해스코드 컬럼값 뽑아서 list에 담기
		List hash = (List) list.get("hashcode");
		
		/* #을 파라미터로 받을수없어서 #을  UTF문자열로바꾸는 소스 쓸필요는없음 (# 은 %23 임)
		String shap="";
		try {
			shap = URLEncoder.encode("#","UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		*/
		
		//for문
		for (int i = 0; i < temp.length; i++) { //내용split 0부터 size까지
			if (hash.contains(temp[i])) {//hash = 몽고 hash코드, temp = 내용split
				result += start; //<a href = \"/board.do?hashtag=
				result += "%23"+temp[i].substring(1); //#뺴고 다시붙이기
				result += mid;   //<a href = \"/board.do?hashtag=내용>
				result += temp[i]; // <a href = \"/board.do>#안녕하세요
				result += end;   //<a href = \"/board.do>#안녕하세요</a>
				temp[i] = result; //temp[0] = <a href = \"/board.do>#안녕하세요</a>		
			}else {
				result +=temp[i]; //temp[1] = 어제잠을잤는데
			}
			result +=" ";
		}
		System.out.println(result);
		modelmap.put("hashtag", result); //해쉬태그
//================================================================================
		modelmap.put("boardOne", list);

		return "sns.board_detail";
	}

	// board one에서 like눌렀을때 처리
	@ResponseBody // 안해주면 view로 리턴함
	@PostMapping(path = "/like.do", produces = "application/json;charset=UTF-8")
	public String board_like(@RequestBody String param, WebRequest wr) {
		Map like = gson.fromJson(param, Map.class); // 방번호
		Double room_id = (double) like.get("_id");

		// 몽고디비 board테이블 liker컬럼에 추가
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String userEmail = (String) user.get("EMAIL");// 접속한 ID(Email)

		if (like.get("checked").equals(true)) {
			boarddao.addBoardLiker(room_id, userEmail); // 좋아요추가
		} else {
			boarddao.removeBoardLiker(room_id, userEmail); // 좋아요취소
		}
		// liker수 count해서 ajax리턴
		int room_num = room_id.intValue();// Double-->int
		Map boardOne = boarddao.getOneBoard(room_num);
		String json = gson.toJson(boardOne);

		// 리턴
		return json;
	}

	@RequestMapping("/likelist.do")
	public String boardLikelist(@RequestParam String num, ModelMap modelmap) {
		Map list = boarddao.getOneBoard(Integer.parseInt(num));
		modelmap.put("likes", list.get("liker")); // 좋아요한사람

		return "sns.board_detail.likelist";
	}
	
	//해당 해쉬태그 조회
	@RequestMapping("/board_search.do")
	public String boardHashlist(@RequestParam String[] hashtag, ModelMap modelmap) {
		List<Map> list = boarddao.getBoardHash(hashtag);
		modelmap.put("gethash_list", list);
		modelmap.put("select_code", hashtag);
		return "sns.board_hash";
	}
}
