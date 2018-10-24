package sns.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Repository
public class JoinDao {
	
	@Autowired
	SqlSessionTemplate template;
	
/*	@PostMapping
	public addAccountPostHandle(@RequestParam Map param, ModelMap map) {
		
	}*/
}
