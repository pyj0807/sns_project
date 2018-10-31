package sns.controller.account;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;

import org.apache.commons.io.FilenameUtils;
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
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import sns.repository.BoardDao;
import sns.repository.BoardRepository;
import sns.repository.FollowRepository;
import sns.repository.MyBoardDao;

@Controller
public class MyPageController {
	@Autowired
	ServletContext svc;
	@Autowired
	MyBoardDao myboarddao;
	@Autowired
	BoardRepository boardRepository;
	@Autowired
	BoardDao boarddao;
	@Autowired
	FollowRepository follow;
	@Autowired
	Gson gson;

	// 마이페이지 입장
	@GetMapping("/mypage.do")
	public String mypage(WebRequest wr) {
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");

		// 내가 쓴 글 목록 조회하기 위해
		List<Map> mylist = boardRepository.findWriter(loginId);
		for(int i=0; i<mylist.size(); i++) {
			long writetime = (long)mylist.get(i).get("time");
			long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
			mylist.get(i).put("lasttime", lasttime);
		}
		int msize = mylist.size(); // 내가 쓴 게시물수 보여주기 위해
		wr.setAttribute("mylist", mylist, WebRequest.SCOPE_REQUEST);
		wr.setAttribute("msize", msize, WebRequest.SCOPE_REQUEST);

		int followerCnt = follow.getFollowerCnt(loginId); // 내 팔로워수
		int followingCnt = follow.getFollowingCnt(loginId); // 내 팔로잉수
		wr.setAttribute("followerCnt", followerCnt, wr.SCOPE_REQUEST);
		wr.setAttribute("followingCnt", followingCnt, wr.SCOPE_REQUEST);

		// 내 관심사
		List inter = gson.fromJson((String) user.get("INTEREST"), List.class);
		wr.setAttribute("myInter", inter, wr.SCOPE_REQUEST);
		
		String[] interest = "게임,운동,영화,음악,IT,연애,음식,여행,패션,기타".split(",");
		String sInter = Arrays.toString(interest);
		List listInter = gson.fromJson(sInter, List.class);
		wr.setAttribute("allInter", listInter, wr.SCOPE_REQUEST);
		return "sns.mypage";
	}

	// write.do 에서 글쓰고 넘어오는 페이지(실질적 글 업로드 과정)
	@PostMapping("/mypage.do")
	public String mypage(@RequestParam Map map, @RequestParam MultipartFile file, WebRequest wr, ModelMap modelmap)
			throws IllegalStateException, IOException {
		System.out.println("★★★★★:"+map);
		// 파일 업로드 경로 생성
		String realpath = svc.getRealPath("upload");
		File dir = new File(realpath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");

		//해쉬태그뽑아서 저장하기============================
		String content = (String)map.get("content");
		String regex = "\\#([0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]*)";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(content);
		List hash = new ArrayList<>();
		while(m.find()) {
			hash.add(m.group());
		}
		//===========================================

		// 파일 타입 확인하고 image 랑 video 만 가능하게
		String type = file.getContentType().substring(0, 5);
		if (!(type.equals("image") || type.equals("video"))) {
			modelmap.put("err", "type");
			return "sns.write";
		} else if(map.get("interest").equals(null)){
			modelmap.put("errr", "inter");
			return "sns.write";
		}else {
				// 파일 이름 리네임(현재시간+글쓴이아이디+확장자)
				long currentTime = System.currentTimeMillis();
				String filename = file.getOriginalFilename();
				String ext = "." + FilenameUtils.getExtension(filename);
				filename = currentTime + loginId + ext;
				File insertfile = new File(dir, filename);
				file.transferTo(insertfile);
				String path = svc.getContextPath() + "/upload/" + filename;
	
	//			String content_enter = (String) map.get("content");
	//			content_enter = content_enter.replace("\r\n", "<br>");
	
				map.put("_id", boardRepository.getBoardNo());	// 글번호
				map.put("writer", loginId);	// 글쓴이
	//			map.put("content", content_enter);
				map.put("file_attach", path);	// 경로
				map.put("type", type);	// 파일타입
				map.put("liker", new ArrayList<>());	// 좋아요 
				map.put("hashcode", hash);	// 해쉬태그
				map.put("time", currentTime);	// 글등록시간
				map.put("longi", map.get("longi")); //경도
				map.put("lat", map.get("lat")); //경도
				map.put("area", map.get("area")); //주소
				boardRepository.insertOne(map);	//글등록Insert!
	
				return "redirect:/mypage.do";
		}
	}
	//글수정페이지20181029
	@PostMapping("/update_install.do")
	public String update_install(@RequestParam Map map) {
		String num = (String)map.get("num");
		int room_num = Integer.parseInt(num);
		String interest = (String)map.get("interest");
		
		//해쉬태그뽑은거 list에 담아서 수정하기위하여=============
		String content = (String)map.get("content");
		String regex = "\\#([0-9a-zA-Z가-힣ㄱ-ㅎㅏ-ㅣ]*)";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(content);
		List hash = new ArrayList<>();
		while(m.find()) {
			hash.add(m.group());
		}
		String lat = (String)map.get("lat");
		String longi = (String)map.get("longi");
		String area = (String)map.get("area");
		//===========================================
		//수정처리
		boarddao.updateBoard(room_num, content, interest,hash,lat,longi,area);
		//수정시 해시태그가되야함
		return "redirect:/mypage.do";
	}
	// 글쓰는페이지
	@GetMapping("/write.do")
	public String write(ModelMap modelmap) {
		// 글 관심사 선택, 1개만 선택 가능
		String[] data = "게임,운동,영화,음악,IT,연애,음식,여행,패션,기타".split(",");
		modelmap.put("interest", data);
		return "sns.write";
	}
	//글수정페이지(글내용 관심사만 수정가능)
	@GetMapping("/update.do")
	public String board_update(@RequestParam int num,ModelMap modelmap) {
		String[] data = "게임,운동,영화,음악,IT,연애,음식,여행,패션,기타".split(",");
		modelmap.put("interest", data);
		Map map = boarddao.getOneBoard(num);
		modelmap.put("Oneboard", map);
		return "sns.update";
	}
	//글삭제페이지
	@GetMapping("/delete.do")
	public String board_delete(@RequestParam int num) {
		//삭제처리(board,board_reply,like)
		boarddao.deleteBoard(num);
		return "redirect:/index.do";
	}
	
	// 내가 좋아요한 글 목록 보기
	@RequestMapping("/liked.do")
	public String liked(WebRequest wr, ModelMap modelmap) {
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");

		List<Map> likedList = boardRepository.getBoardLiker(loginId);
		for(int i=0; i<likedList.size(); i++) {
			long writetime = (long)likedList.get(i).get("time");
			long lasttime = (System.currentTimeMillis()-writetime)/(1000); //초!
			likedList.get(i).put("lasttime", lasttime);
		}
		modelmap.put("getLikedList", likedList);

		return "sns.liked";
	}

	// 마이페이지에서 관심사 버튼 중 한개를 눌렀을때 처리
	@ResponseBody // 안해주면 view로 리턴함
	@PostMapping(path="/inte.do", produces="application/json;charset=UTF-8")
	public String inte(@RequestBody String body, WebRequest wr) {
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");
		
		// 예를들어 RequestParam 으로 게임이 들어왔다. 그러면 게임에 관심이 있는 사람들의 목록을 보여준다.
		System.out.println(body);
		Map mm = gson.fromJson(body, Map.class);
		String inte = (String) mm.get("inte");
		
		// 관심사가 같은 회원 정보 뽑기
		List<Map> allUserInfo = follow.getAllUserInfo(); // 모든회원정보
		List<Map> sameInterUser = new ArrayList<>();	// 같은 관심사를 가진 회원이 담긴 리스트
		for(int i=0; i<allUserInfo.size();i++) {
			boolean boo = allUserInfo.get(i).get("INTEREST").toString().contains(inte);
			if(boo) {
				sameInterUser.add(allUserInfo.get(i));
			}
		}
		
		Map realSame =  new HashMap<>();
		for(int i=0; i<3; i++) {
			int ran = (int) (Math.random()*sameInterUser.size()); 
			 if(realSame.containsValue(sameInterUser.get(ran)) || sameInterUser.get(ran).get("ID").equals(loginId)) {
				 i--;
			 }else {
				 realSame.put(1+i, sameInterUser.get(ran));
			 }
		}
		return gson.toJson(realSame);
	}
	
	

}
