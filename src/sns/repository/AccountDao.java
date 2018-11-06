package sns.repository;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccountDao {
	@Autowired
	SqlSessionTemplate sqltemplate;
	
	public Map accountselect(String id) {
		
		return sqltemplate.selectOne("account.getOneUserInfo", id);
		
	}
}
