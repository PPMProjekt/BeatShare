package at.lukas.music;

public class music
{

	private String name;
	private String interpret;
	private String genre;

	public music()
	{
		super();
	}

	public music(String name, String interpret, String genre)
	{
		super();
		this.name = name;
		this.interpret = interpret;
		this.genre = genre;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getInterpret()
	{
		return interpret;
	}

	public void setInterpret(String interpret)
	{
		this.interpret = interpret;
	}

	public String getGenre()
	{
		return genre;
	}

	public void setGenre(String genre)
	{
		this.genre = genre;
	}
}
