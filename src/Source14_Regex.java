import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Source14_Regex {

	public static void main(String[] args) {
		
		Pattern p = Pattern.compile("#원");
		String data="#";
		Matcher m = p.matcher(data); 
		System.out.println(m.find());
		
		
		
		
		
	}

}
