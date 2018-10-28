package sns.controller.account;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
				boardRepository.insertOne(map);	//글등록Insert!
	
				return "redirect:/mypage.do";
		}
	}

	// 글쓰는페이지
	@GetMapping("/write.do")
	public String write(ModelMap modelmap) {
		// 글 관심사 선택, 1개만 선택 가능
		String[] data = "게임,운동,영화,음악,IT<br/>,연애,음식,여행,패션,기타".split(",");
		modelmap.put("interest", data);
		return "sns.write";
	}

	// 내가 좋아요한 글 목록 보기
	@RequestMapping("/liked.do")
	public String liked(WebRequest wr, ModelMap modelmap) {
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");

		List<Map> likedList = boardRepository.getBoardLiker(loginId);
		modelmap.put("getLikedList", likedList);

		return "sns.liked";
	}

	@RequestMapping("/test.do")
	public void test() {

//		@Autowired
//		BoardRepository boardRepository;
//		
//		// 좋아요 한 시간 몽고디비 liked 컬럼에 추가 
//		BoardController 에 board one 에서 like 눌렀을때 처리
//		long currentTime = System.currentTimeMillis();
//		Map liked = new HashMap<>();
//		liked.put("_id", room_id);
//		liked.put("likerId", userId);
//		liked.put("likedTime", currentTime);
//		boardRepository.insertLikerAndTime(liked);
//		boardRepository.removeLikerAndTime(liked);
//
//			디테일 뷰에서 내용 위에 관심사 : 해서 보여주기
//			1. board_detail.jsp 에 추가
//			<b>관심사:</b>${boardOne.interest }<br/>		

	}

}
