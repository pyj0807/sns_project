package sns.controller.account;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.multipart.MultipartFile;

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

	@GetMapping("/mypage.do")
	public String mypage(WebRequest wr) {
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String userEmail = (String) user.get("EMAIL");

		List<Map> mylist = boardRepository.findWriter(userEmail);
		wr.setAttribute("mylist", mylist, WebRequest.SCOPE_SESSION);

		int followerCnt = follow.getFollowerCnt(userEmail);
		int followingCnt = follow.getFollowingCnt(userEmail);
		wr.setAttribute("followerCnt", followerCnt, wr.SCOPE_REQUEST);
		wr.setAttribute("followingCnt", followingCnt, wr.SCOPE_REQUEST);

		return "sns.mypage";
	}

	@PostMapping("/mypage.do")
	public String mypage(@RequestParam Map map, @RequestParam MultipartFile file, WebRequest wr, ModelMap modelmap)
			throws IllegalStateException, IOException {
		String realpath = svc.getRealPath("upload");
		File dir = new File(realpath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String userEmail = (String) user.get("EMAIL");
		String userId = (String) user.get("ID");

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
			modelmap.put("err", "on");
			System.out.println("파일 타입이 Image나 Video가 아님");
			return "sns.write";
		} else {
			// 파일 이름 리네임
			long currentTime = System.currentTimeMillis();
			String filename = file.getOriginalFilename();
			String ext = "." + FilenameUtils.getExtension(filename);
			filename = currentTime + userId + ext;
			File insertfile = new File(dir, filename);
			file.transferTo(insertfile);
			String path = svc.getContextPath() + "/upload/" + filename;

//			String content_enter = (String) map.get("content");
//			content_enter = content_enter.replace("\r\n", "<br>");

			map.put("_id", boardRepository.getBoardNo());
			map.put("writer", userEmail);
//			map.put("content", content_enter);
			map.put("file_attach", path);
			map.put("type", type);
			map.put("liker", new ArrayList<>());
			map.put("hashcode", hash);
			map.put("time", currentTime);
			boardRepository.insertOne(map);

			return "redirect:/mypage.do";
		}
	}

	@GetMapping("/write.do")
	public String write(ModelMap modelmap) {
		String[] data = "운동,영화,음악,음식,여행,패션,게임,기타".split(",");
		modelmap.put("interest", data);
		return "sns.write";
	}
}
