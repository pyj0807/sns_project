package sns.controller.account;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
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
		String userId = (String) user.get("ID");
		
		List<Map> mylist = boardRepository.findWriter(userId);
		wr.setAttribute("mylist", mylist, WebRequest.SCOPE_SESSION);
		
		int followerCnt = follow.getFollowerCnt(userId);
		int followingCnt = follow.getFollowingCnt(userId);
		wr.setAttribute("followerCnt", followerCnt, wr.SCOPE_REQUEST);
		wr.setAttribute("followingCnt", followingCnt, wr.SCOPE_REQUEST);
		
		return "sns.mypage";
	}

	@PostMapping("/mypage.do")
	public String mypage(@RequestParam Map map, @RequestParam MultipartFile file, WebRequest wr)
			throws IllegalStateException, IOException {
		String realpath = svc.getRealPath("upload");
		File dir = new File(realpath);
		if (!dir.exists()) {
			dir.mkdirs();
		}
		File insertfile = new File(dir, file.getOriginalFilename());
		file.transferTo(insertfile);

		String path = svc.getContextPath() + "/upload/" + file.getOriginalFilename();
		String type = file.getContentType();

		Map user = (Map) wr.getAttribute("user", wr.SCOPE_SESSION);
		String userId = (String) user.get("ID");

		map.put("_id", boardRepository.getBoardNo());
		map.put("writer", userId);
		map.put("file_attach", path);
		map.put("type", type.substring(0, 5));
		map.put("liker", new ArrayList<>());
		boardRepository.insertOne(map);
		return "redirect:/mypage.do";
	}

}
