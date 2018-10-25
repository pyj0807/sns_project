package sns.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
	
	@GetMapping("/board_detail.do")
	public String board_datail(@RequestParam int num,ModelMap modelmap,WebRequest wr) {
		Map list = boarddao.getOneBoard(num);
		List liker = (List)list.get("liker"); //board테이블에 좋아요한 list 
		Map user = (Map)wr.getAttribute("user", wr.SCOPE_SESSION);
		String userId = (String)user.get("ID");//접속한  ID
		if(liker.contains(userId)) {
			list.put("checked", true);//체크 true
		}else {
			list.put("checked", false);//체크 false
		}	
		modelmap.put("boardOne", list);
		
		//내용 해쉬태그뽑기===============================
		String content = (String)list.get("content");
		String regex = "\\#([0-9a-zA-Z가-힣]*)";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(content);
		
		List hash = new ArrayList<>();
		while(m.find()) {
			//System.out.println(m.group());
			hash.add(m.group());
		}
		System.out.println(hash);
		//===========================================
		
		return "sns.board_detail"; 
	}
	
	//board one에서 like눌렀을때 처리
	@ResponseBody //안해주면 view로 리턴함
	@PostMapping(path="/like.do", produces="application/json;charset=UTF-8")
	public String board_like(@RequestBody String param,WebRequest wr) {
		Map like = gson.fromJson(param, Map.class); //방번호
		Double room_id = (double)like.get("_id");
		
		//몽고디비 board테이블 liker컬럼에 추가
		Map user = (Map)wr.getAttribute("user", wr.SCOPE_SESSION);
		String userId = (String)user.get("ID");//접속한  ID
		
		if(like.get("checked").equals(true)) {
			boarddao.addBoardLiker(room_id, userId); //좋아요추가
		}else {
			boarddao.removeBoardLiker(room_id, userId); //좋아요취소
		}
		//liker수 count해서 ajax리턴
		int room_num = room_id.intValue();//Double-->int
		Map boardOne = boarddao.getOneBoard(room_num);
		String json = gson.toJson(boardOne);
		
		//리턴
		return json;
	}
	
	@RequestMapping("/likelist.do")
	public String boardLikelist(@RequestParam String num, ModelMap modelmap) {
		Map list = boarddao.getOneBoard(Integer.parseInt(num));
		modelmap.put("likes", list.get("liker")); //좋아요한사람
		
		return "sns.board_detail.likelist";
	}
}
