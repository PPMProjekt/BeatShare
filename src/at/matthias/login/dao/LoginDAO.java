package at.matthias.login.dao;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

import at.matthias.login.vo.User;

public class LoginDAO {

	public List<User> getAllUsers() throws SQLException {
		List<User> uList = new ArrayList<User>();

		String sql = "SELECT * FROM tbl_user";
		PreparedStatement ps = getConnection().prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		if (!rs.first()) {
			return uList;
		}

		while (!rs.isAfterLast()) {
			User u = new User(rs.getString(2), rs.getString(3), rs.getString(4), rs.getInt(1));
			System.out.println(rs.getString(2));
			uList.add(u);
			rs.next();
		}

		return uList;
	}

	public void insertUser(User u) throws SQLException {

		String sql = "INSERT INTO tbl_user (username, password, email) VALUES (?,?,?)";
		PreparedStatement ps = getConnection().prepareStatement(sql);
		ps.setString(1, u.getUsername());
		ps.setString(1, u.getEmail());
		ps.setString(1, u.getPassword());
		ps.execute();
	}

	public void updateUser(int mid, User u) throws SQLException {

		String sql = "UPDATE tbl_user SET username = ?, password = ?, email = ? WHERE u_id = ?";
		PreparedStatement ps = getConnection().prepareStatement(sql);
		ps.setString(1, u.getUsername());
		ps.setString(1, u.getEmail());
		ps.setString(1, u.getPassword());
		ps.setInt(2, mid);
		ps.executeUpdate();
	}

	public void deleteUser(int mid) {

		String deleteStatement = "DELETE FROM tbl_user WHERE u_id = ?";
		PreparedStatement ps;

		try {
			ps = getConnection().prepareStatement(deleteStatement);
			ps.setInt(1, mid);
			ps.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	private Connection getConnection() throws SQLException {

		try {
			Connection con;
			// this will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager
					.getConnection("jdbc:mysql://localhost/beatshare?user=root&password=");
			return con;
		} catch (ClassNotFoundException e) {
			return null;
		}
	}

}