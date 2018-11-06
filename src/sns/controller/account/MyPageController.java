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
		String loginPic = (String) user.get("PROFILE_ATTACH");
		wr.setAttribute("loginPic", loginPic, wr.SCOPE_REQUEST);

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
	public String mypage(@RequestParam Map map, @RequestParam MultipartFile[] file, WebRequest wr, ModelMap modelmap)
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

		//관심사등록안하면 에러발생
		if(map.get("interest")==null){
			modelmap.put("errr", "inter");
			return "redirect:/write.do?errr=inter";
		}
		//List 2개 만들기
		List path_list = new ArrayList<>();
		List type_list = new ArrayList<>();

		// 파일 타입 확인하고 image 랑 video 만 가능하게
		for(int i=0; i<file.length; i++) {
			String type = file[i].getContentType().substring(0, 5);
			if (!(type.equals("image") || type.equals("video"))) {
				modelmap.put("err", "type");
				return "redirect:/write.do?err=type";
			}else { //비디오파일이나, 사진파일이면
				// 파일 이름 리네임(현재시간+글쓴이아이디+확장자)
				long currentTime = System.currentTimeMillis();
				String filename = file[i].getOriginalFilename();
				String ext = "." + FilenameUtils.getExtension(filename);
				filename = currentTime + loginId + ext;
				File insertfile = new File(dir, filename);
				file[i].transferTo(insertfile);
				String path = svc.getContextPath() + "/upload/" + filename;
				System.out.println("type:"+type+"/path"+path);
				//리스트에담아서
				type_list.add(type);
				path_list.add(path);
				
				map.put("_id", boardRepository.getBoardNo());	// 글번호
				map.put("writer", loginId);	// 글쓴이
				//map.put("file_attach", path);	// 경로
				map.put("file_attach", path_list);	// 경로
				//map.put("type", type);	// 파일타입
				map.put("type", type_list);	// 파일타입
				map.put("liker", new ArrayList<>());	// 좋아요 
				map.put("hashcode", hash);	// 해쉬태그
				map.put("time", currentTime);	// 글등록시간
				map.put("longi", map.get("longi")); //경도
				map.put("lat", map.get("lat")); //경도
				map.put("area", map.get("area")); //주소	
			}				
		}
		boardRepository.insertOne(map);	//글등록Insert!
		return "redirect:/mypage.do";
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
	public String write(ModelMap modelmap,@RequestParam Map map) {
		// 글 관심사 선택, 1개만 선택 가능
		String[] data = "게임,운동,영화,음악,IT,연애,음식,여행,패션,기타".split(",");
		modelmap.put("interest", data);
		System.out.println("호로록="+map.get("err"));
		System.out.println("호로록="+map.get("errr"));
		if(map.get("err")!=null) {
			modelmap.put("err", "type");	
		}
		if(map.get("errr")!=null) {
			modelmap.put("errr", "inter");
		}
		
		
		return "sns.write";
	}
	
	//글수정페이지(글내용 관심사만 수정가능)
	@GetMapping("/update.do")
	public String board_update(@RequestParam int num,ModelMap modelmap) {
		String[] data = "게임,운동,영화,음악,IT,연애,음식,여행,패션,기타".split(",");
		modelmap.put("interest", data);
		Map map = boarddao.getOneBoard(num);
		//update시에 map에 area가없으면 강제로 위도 경도 없으면 초기값찍어줘서 update.jsp보내줌
		//등록시에는 null로들어가는게 아니라 아예들어가지않음 
//		if(map.containsKey("area")==false) {
//			map.put("lat", "37.49242638484167");
//			map.put("longi", "127.0309201030125");
//			//map.put("area", "");
//		}
		//수정을하면 null로 데이터가들어감
		if(map.get("area").equals("")) {
			map.put("lat", "37.49242638484167");
			map.put("longi", "127.0309201030125");
		}
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
	
	// 프로필 사진을 누르면 프로필 사진을 바꿀수 있는 팝업창을 열어준다.
	@GetMapping("changepic.do")
	public String getPic() {
		return "sns.getpic";
	}
	
	// 프로필 사진을 바꿔준다.
	@PostMapping("changepic.do")
	public String  postPic(WebRequest wr, @RequestParam MultipartFile file, ModelMap modelmap) throws IllegalStateException, IOException {
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String loginId = (String) user.get("ID");
		String oldPic = (String) user.get("PROFILE_ATTACH");
		System.out.println("현재프사 : "+oldPic);
		
		String realpath = svc.getRealPath("pic");
		File dir = new File(realpath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		
		// 파일타입확인하고 이미지만 업로드 가능하게 하자
		String type = file.getContentType().substring(0, 5);
		if (!(type.equals("image"))) {
			modelmap.put("err", "type");
			System.out.println("이미지파일만 업로드 가능합니다.");
			return "redirect:/changepic.do";
		}else {
			// 파일 이름 리네임(현재시간+글쓴이아이디+확장자)
			long currentTime = System.currentTimeMillis(); // 현재시간
			String filename = file.getOriginalFilename(); // 원래 파일이름 가져오고
			String ext = "." + FilenameUtils.getExtension(filename); // .확장자 붙여주고
			filename = currentTime + loginId + ext; // 현재시간+글쓴이아이디+확장자
			File insertfile = new File(dir, filename); // 파일 넣어주고
			file.transferTo(insertfile); // 변환해주고
			
			Map map = new HashMap<>();
			map.put("file", filename);
			map.put("id", loginId);
			System.out.println(map.toString());
			System.out.println("바뀐프사 : " + filename);
			System.out.println(follow.changePic(map)); // 업데이트 매퍼 실행 
			System.out.println("변경완료");
			wr.setAttribute("loginPic", filename, wr.SCOPE_SESSION);
			System.out.println("newPic : " + filename);
			user.put("PROFILE_ATTACH", filename);
			String newPic = (String) user.get("PROFILE_ATTACH");
			System.out.println("뉴픽 : " + newPic);
			System.out.println(user.toString());
			
			return "redirect:/mypage.do";
		}	


	}
	

}