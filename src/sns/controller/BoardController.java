package sns.controller;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.socket.TextMessage;

import com.google.gson.Gson;

import sns.repository.AlertService;
import sns.repository.BoardDao;
import sns.repository.BoardRepository;
import sns.repository.FollowLikemongoalert;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardDao boarddao;
	@Autowired
	Gson gson;
	@Autowired
	ServletContext svc;
	@Autowired
	BoardRepository boardRepository;
	
	@Autowired
	FollowLikemongoalert mongoalert;
	@Autowired
	AlertService service;

	@GetMapping("/board_detail.do")
	public String board_datail(@RequestParam int num, ModelMap modelmap, WebRequest wr) {
		Map list = boarddao.getOneBoard(num);
		List liker = (List) list.get("liker"); // board테이블에 좋아요한 list
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String userId = (String) user.get("ID");// 접속한 EMAIL
		if (liker.contains(userId)) {
			list.put("checked", true);// 체크 true
		} else {
			list.put("checked", false);// 체크 false
		}
		//없는값조회
		if(list.get("area").equals("")) {
			list.put("lat", "33.450701");
			list.put("longi", "126.570667");
			list.put("area", "");
		}
		
		//댓글조회
		List<Map> reply_list = boarddao.getBoardReply(num);		
		for(int i=0; i<reply_list.size(); i++) {
			long writetime = (long)reply_list.get(i).get("time");
			long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
			reply_list.get(i).put("lasttime", lasttime);
			String replyWriter = (String)reply_list.get(i).get("writer");
			reply_list.get(i).put("pic", boardRepository.getOneUserInfo(replyWriter).get("PROFILE_ATTACH"));
		}
		
		// 프로필 사진 뽑기 위해 글 작성자 모든 정보 한 줄(맵)을 뽑았다
		Map writerMap = boardRepository.getOneUserInfo((String)list.get("writer"));
		modelmap.put("writerMap", writerMap);
		
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
		modelmap.put("reply_list", reply_list);
		
		return "sns.board_detail";
	}

	// board one에서 like눌렀을때 처리
	@ResponseBody // 안해주면 view로 리턴함
	@PostMapping(path = "/like.do", produces = "application/json;charset=UTF-8")
	public String board_like(@RequestBody String param, WebRequest wr) {
		Map like = gson.fromJson(param, Map.class); // 방번호
		Double room_id = (double) like.get("_id");
		int room_num = room_id.intValue();// Double-->int

		// 몽고디비 board테이블 liker컬럼에 추가
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String userId = (String) user.get("ID");// 접속한 ID
		SimpleDateFormat sf =new SimpleDateFormat("YYYY-MM-dd HH:mm");
		
		//=========================얼럿용
		
		
		//얼럿용=========================
		
		// 좋아요 한 시간 몽고디비 liked 컬럼에 추가 
		long currentTime = System.currentTimeMillis();
		Map liked = new HashMap<>();
		liked.put("roomId", room_id);
		liked.put("likerId", userId);
 
		if (like.get("checked").equals(true)) {
			liked.put("likedTime", currentTime);
			boarddao.addBoardLiker(room_id, userId); // 좋아요추가
			boardRepository.insertLikerAndTime(liked);  // 몽고디비 like 테이블 한줄 추가
			Map boardOnee = boarddao.getOneBoard(room_num);
			String jsonn = gson.toJson(boardOnee);
			
			
			String contentstr="";
			Map sendMap=new HashMap<>();
			sendMap.put("mode", "followinglike");
			sendMap.put("moded", "like");
			sendMap.put("id",userId);
			sendMap.put("receiver",boardOnee.get("writer"));
			sendMap.put("senddate", (long)System.currentTimeMillis());
			if(((String)boardOnee.get("content")).length()>7) {
				contentstr=	((String)boardOnee.get("content")).substring(1, 7);
			sendMap.put("content", " 님이 당신의 글 ("+contentstr+"...)에 좋아요를 누르셨습니다.");
			}else {
				sendMap.put("content", " 님이 당신의 글 ("+boardOnee.get("content")+")에 좋아요를 누르셨습니다.");
			}
			sendMap.put("senddatejsp", sf.format(System.currentTimeMillis()));
			sendMap.put("num", room_num);
			mongoalert.Mongofollowservice(sendMap);
			TextMessage msg =new TextMessage(gson.toJson(sendMap));
			
			for(int i=0;i<service.list.size();i++) {
				if(service.list.get(i).getAttributes().get("userId").equals(boardOnee.get("writer"))) {
					try {
						service.list.get(i).sendMessage(msg);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		} else {
			
			boarddao.removeBoardLiker(room_id, userId); // 좋아요취소
			boardRepository.removeLikerAndTime(userId,room_id.intValue()); // 몽고디비 like 테이블 한줄 삭제
			Map boardOnee = boarddao.getOneBoard(room_num);
			String jsonn = gson.toJson(boardOnee);
			String contentstr= "";
			Map sendMap=new HashMap<>();
			sendMap.put("mode", "followinglike");
			sendMap.put("moded", "like");
			sendMap.put("id",userId);
			sendMap.put("receiver",boardOnee.get("writer"));
			sendMap.put("senddate", (long)System.currentTimeMillis());
			
			if(((String)boardOnee.get("content")).length()>7) {
				contentstr=	((String)boardOnee.get("content")).substring(1, 7);
				sendMap.put("content", " 님이 당신의 글 ("+contentstr+"...)에 좋아요를 취소하셨습니다.");
			}else {
			sendMap.put("content", " 님이 당신의 글 ("+boardOnee.get("content")+")에 좋아요를 취소하셨습니다.");
			}
			sendMap.put("senddatejsp", sf.format(System.currentTimeMillis()));
			sendMap.put("num", room_num);
			mongoalert.Mongofollowservice(sendMap);
			TextMessage msg =new TextMessage(gson.toJson(sendMap));
			
			for(int i=0;i<service.list.size();i++) {
				if(service.list.get(i).getAttributes().get("userId").equals(boardOnee.get("writer"))) {
					try {
						service.list.get(i).sendMessage(msg);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		// liker수 count해서 ajax리턴
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
	@RequestMapping(path="/board_search.do",produces="application/json;charset=UTF-8")
	public String boardHashlist(@RequestParam String[] hashtag, ModelMap modelmap) {
		System.out.println(hashtag);
		List<Map> list = boarddao.getBoardHash(hashtag);
		for(int i=0; i<list.size(); i++) {
			long writetime = (long)list.get(i).get("time");
			long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
			list.get(i).put("lasttime", lasttime);
		}
		modelmap.put("gethash_list", list);
		modelmap.put("select_code", hashtag);
		return "sns.board_hash";
	}
	
	//댓글달기
	@ResponseBody
	@PostMapping(path ="/reply.do",produces="application/json;charset=UTF-8")
	public String boardAddReply(@RequestBody String param,WebRequest wr) {
		long currentTime = System.currentTimeMillis();
		Map map = gson.fromJson(param, Map.class);
		Map user = (Map)wr.getAttribute("user", wr.SCOPE_SESSION);
		map.put("writer", user.get("ID"));
		map.put("time", currentTime);
		map.put("key", UUID.randomUUID().toString().split("-")[0]);
		System.out.println(map);
		//추가
		boarddao.addBoardReply(map);
		//조회 (방번호받아와야함)
		Double id = (double)map.get("id");
		List<Map> reply_list = boarddao.getBoardReply(id.intValue());
		//지난시간받아오기
		for(int i=0; i<reply_list.size(); i++) {
			long writetime = (long)reply_list.get(i).get("time");
			long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
			reply_list.get(i).put("lasttime", lasttime);
			String replyWriter = (String)reply_list.get(i).get("writer");
			reply_list.get(i).put("pic", boardRepository.getOneUserInfo(replyWriter).get("PROFILE_ATTACH"));
		}
		
		String json = gson.toJson(reply_list);
		
		return json;
	}
	
	//댓글삭제
	@ResponseBody
	@PostMapping(path="/delete_reply.do",produces="application/json;charset=UTF-8")
	public String delete_reply(@RequestBody String param) {
		//button 에서 키값을 두개로 받아오기떄문에 배열로 처리해야함
		Map map = gson.fromJson(param, Map.class);
		String key = (String)map.get("key");
		String[] keys =key.split(",");
		//댓글삭제처리
		//keys[0] = 댓글의키값 , keys[1] = 댓글이달려있는방번호(double)
		boarddao.deleteBoardReply(keys[0]);
		//댓글다시조회하여 ajax처리
		
		Double d1 = Double.parseDouble(keys[1]); //double casting
		List<Map> reply_list = boarddao.getBoardReply(d1.intValue()); //double--> int casting
		//지난시간가져오기
		for(int i=0; i<reply_list.size(); i++) {
			long writetime = (long)reply_list.get(i).get("time");
			long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
			reply_list.get(i).put("lasttime", lasttime);
			String replyWriter = (String)reply_list.get(i).get("writer");
			reply_list.get(i).put("pic", boardRepository.getOneUserInfo(replyWriter).get("PROFILE_ATTACH"));
		}
		
		String json = gson.toJson(reply_list);
		
		return json;
	}
	
	//지도 조회
	@GetMapping("/map.do")
	public String map(@RequestParam String location,ModelMap modelmap) {		
		List<Map> list = boarddao.searchMap(location);
		String lat=""; //위도
		String longi=""; //경도
		String area="";//위치
		for(int i=0; i<list.size(); i++) {
			//map
			lat =(String)list.get(0).get("lat");
			longi = (String)list.get(0).get("longi");
			area = (String)list.get(0).get("area");
			//list(시간)
			long writetime = (long)list.get(i).get("time");
			long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
			list.get(i).put("lasttime", lasttime);
		}
		Map map = new HashMap<>();
		map.put("lat", lat);
		map.put("longi", longi);
		map.put("area", area);		
		
		modelmap.put("map", list);
		modelmap.put("mapinfo", map); //지도의 맵정보(맵으로만들어서보냄)
				
		return "sns.board_map";
	};
	
}
