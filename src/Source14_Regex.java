import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Source14_Regex {

	public static void main(String[] args) {
		
		Pattern p = Pattern.compile("#원피");
		String data="#원피스";
		Matcher m = p.matcher(data); 
		System.out.println(m.find());
		
		
		
		
		
	}

}
