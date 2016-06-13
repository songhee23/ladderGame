package DTO;

public class DTO
{
	// user 테이블 
	private int rownum;			//-- 줄번호 
	private int user_id;		//-- 유저 아이디(번호)
	private String user_name; 	//-- 유저 이름
	private String user_tel; 	//-- 유저 전화번호
	private String user_email;	//-- 유저 이메일
	private String user_des;	//-- 유저 설명
	
	// result 테이블 
	private int game_id;		//-- 게임 아이디(번호)
	private String game_date;	//-- 게임 날짜

	// result_detail 테이블(foreign key - game_id,user_id)
	private String user_item;	//-- 게임 아이템 

	public int getRownum()
	{
		return rownum;
	}

	public void setRownum(int rownum)
	{
		this.rownum = rownum;
	}

	public int getUser_id()
	{
		return user_id;
	}

	public void setUser_id(int user_id)
	{
		this.user_id = user_id;
	}

	public String getUser_name()
	{
		return user_name;
	}

	public void setUser_name(String user_name)
	{
		this.user_name = user_name;
	}

	public String getUser_tel()
	{
		return user_tel;
	}

	public void setUser_tel(String user_tel)
	{
		this.user_tel = user_tel;
	}

	public String getUser_email()
	{
		return user_email;
	}

	public void setUser_email(String user_email)
	{
		this.user_email = user_email;
	}

	public String getUser_des()
	{
		return user_des;
	}

	public void setUser_des(String user_des)
	{
		this.user_des = user_des;
	}

	public int getGame_id()
	{
		return game_id;
	}

	public void setGame_id(int game_id)
	{
		this.game_id = game_id;
	}

	public String getGame_date()
	{
		return game_date;
	}

	public void setGame_date(String game_date)
	{
		this.game_date = game_date;
	}

	public String getUser_item()
	{
		return user_item;
	}

	public void setUser_item(String user_item)
	{
		this.user_item = user_item;
	}
	
	

	
}
