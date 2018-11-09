package sns.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.context.request.WebRequest;

import com.sun.java.swing.plaf.windows.resources.windows;

import sns.repository.AccountDao;
import sns.repository.ChangePassDao;

@Controller
public class ChangeController {

	@Autowired
	ChangePassDao cpdao;
	
	@Autowired
	AccountDao accdao;

	@GetMapping("/change.do")
	public String changeGetHandle(Map map, @RequestParam Map ma, ModelMap model,WebRequest wr) {
		String[] data = "게임,운동,영화,음악,IT,연애,음식,여행,패션,애니,애견,기타,".split(",");
		map.put("interest", data);
		Map mmm=accdao.accountselect((String)wr.getAttribute("userId", wr.SCOPE_SESSION));
		model.put("intermy", mmm.get("INTEREST"));
		if (ma.get("internone") != null) {
			model.put("intererr", "on");
		}

		if (ma.get("passno") != null) {
			model.put("passno", "on");
		}
		if(ma.get("op")!=null) {
			model.put("pass", ma.get("op"));
		}
		if(ma.get("np")!=null) {
			model.put("pass1", ma.get("np"));
		}

		return "index/changePass";
	}

	@PostMapping("/change.do")
	public String changePostHandle(@SessionAttribute Map user, @RequestParam Map map, WebRequest wr) {
		Map mmm=accdao.accountselect((String)wr.getAttribute("userId", wr.SCOPE_SESSION));
		String cp = (String) mmm.get("PASS");
		String op = (String) map.get("opass");
		String np = (String) map.get("npass");
		String[] inter = wr.getParameterValues("interest");
		String interest = Arrays.toString(inter);

		Map passmap = new HashMap<>();
		passmap.put("id", user.get("ID"));
		passmap.put("npass", np);
		passmap.put("interest", interest);
		if (op.length() < 1 || np.length() < 1) {

			return "redirect:/change.do?passno=no&op="+op+"&np="+np;
		}
		if (inter == null) {
			return "redirect:/change.do?internone=nono&op="+op+"&np="+np;
		}

		if (op.equals(cp)) {
			int r = cpdao.changePass(passmap);

			if (r > 0) {

				return "redirect:/mypage.do";
			}
		}

		return "redirect:/change.do?passno=no";

	}

}
