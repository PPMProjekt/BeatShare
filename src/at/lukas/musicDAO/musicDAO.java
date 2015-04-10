package at.lukas.musicDAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import at.lukas.music.music;

public class musicDAO
{

	public static List<music> getTheMusic()
	{
		List<music> musiclist = new ArrayList<music>();

		music song2 = new music("song2", "blur", "Rock");
		music musi = new music("music", "john miles", "Rock");
		music panic = new music("panic", "Caravan Palace", "Jazz/Elektro");
		musiclist.add(song2);
		musiclist.add(musi);
		musiclist.add(panic);

		return musiclist;
	}

}
