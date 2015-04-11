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



@Path("tasks")
public class UserService {

	@GET
	public List<User> getAllTasks() throws SQLException{
		UserDAO dao = new UserDAO();
		return dao.getAllUsers();
		
	}
	
	@POST
	 public void insertTask(User u) throws SQLException{
	 UserDAO dao = new UserDAO();
	 dao.insertTask(u);
	 }
	
	
	@GET
	@Path("/{id}")
	public User getTaskById(@PathParam("id") int mid){
		User u = new User("task number " + mid,null, null, mid);
		return u;
	}
	
	@PUT
	 @Path("/{id}")
	 public void updateUser(@PathParam("id") int mid, User u) throws SQLException{
	 UserDAO dao = new UserDAO();
	 dao.updateUser(mid, u);
	 }
	
	@DELETE
	@Path("/{id}")
	public Response deleteTask(@PathParam("id") int mid){
		try{
			TaskDAO dao = new TaskDAO();
			dao.deleteTask(mid);
		}catch (Exception e){
			e.printStackTrace();
			return Response.serverError().build();
		}
		return Response.ok().build();
	}
	
	
	
	
}

