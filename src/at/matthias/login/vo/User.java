package at.matthias.login.vo;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class User {
	private String username;
	private String password;
	private String email;
	private int u_id;

	public User(){
		
	}
	
	public User(String username, String password, String email, int u_id) {
		super();
		this.username = username;
		this.password = password;
		this.email = email;
		this.u_id = u_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getU_id() {
		return u_id;
	}

	public void setU_id(int u_id) {
		this.u_id = u_id;
	}

	
}
