package sns.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sun.org.apache.xalan.internal.xsltc.compiler.Template;

@Repository
public class SearchDao {
	@Autowired
	SqlSessionTemplate sqltemplate;
	
	public List<Map> Allaccount(String vlaue){
		
		return sqltemplate.selectList("account.allAccount",vlaue+"%");
	}
	
	
	
}
