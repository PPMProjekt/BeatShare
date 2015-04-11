package at.matthias.login.services;

import java.sql.SQLException;
import java.util.List;

import javax.ws.rs.DELETE;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;

import at.matthias.login.dao.LoginDAO;
import at.matthias.login.vo.User;



@Path("users")
public class UserService {

	@GET
	public List<User> getAllUsers() throws SQLException{
		LoginDAO dao = new LoginDAO();
		return dao.getAllUsers();
		
	}
	
	@POST
	 public void insertUser(User u) throws SQLException{
	 LoginDAO dao = new LoginDAO();
	 dao.insertUser(u);
	 }
	
	
	@GET
	@Path("/{id}")
	public User getUserById(@PathParam("u_id") int mid){
		User u = new User("user number " + mid,null, null, mid);
		return u;
	}
	
	@PUT
	 @Path("/{id}")
	 public void updateUser(@PathParam("u_id") int mid, User u) throws SQLException{
	 LoginDAO dao = new LoginDAO();
	 dao.updateUser(mid, u);
	 }
	
	@DELETE
	@Path("/{id}")
	public Response deleteUser(@PathParam("u_id") int mid){
		try{
			LoginDAO dao = new LoginDAO();
			dao.deleteUser(mid);
		}catch (Exception e){
			e.printStackTrace();
			return Response.serverError().build();
		}
		return Response.ok().build();
	}
	
	
	
	
}

