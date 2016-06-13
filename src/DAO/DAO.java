package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

import DTO.DTO;



public class DAO implements IDAO
{
	
	private DataSource dataSource;

	// setter구성
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	} 

	
	// 유저 리스트 출력 메소드
	@Override
	public ArrayList<DTO> UserList(String searchKey, String searchValue) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		ArrayList<DTO> result = new ArrayList<DTO>();		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		DTO dto = null;
		
		try
		{
			searchValue = "%"+searchValue+"%";
			

			
			sql = "select"
					+ " @rownum := @rownum+1 as rownum, user_name, user_tel, user_email, user_des, user_id "
					+ "	from "
					+ " user,(select @rownum:=0) r 		"
					+ " where  "+searchKey+" like ?"
					+ " order by"
					+ "	user_name";
					
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				dto = new DTO();
				dto.setRownum(rs.getInt("rownum"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_tel(rs.getString("user_tel"));
				dto.setUser_email(rs.getString("user_email"));
				dto.setUser_des(rs.getString("user_des"));
				dto.setUser_id(rs.getInt("user_id"));
				
				result.add(dto);
			}
			rs.close();
			pstmt.close();
				
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;
	}


	// 유저 리스트 출력 (이름기준 DESC)
		@Override
		public ArrayList<DTO> UserListDesc(String searchKey, String searchValue) throws SQLException
		{
			Connection conn = dataSource.getConnection();
			ArrayList<DTO> result = new ArrayList<DTO>();		
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			DTO dto = null;
			
			try
			{
				searchValue = "%"+searchValue+"%";
				

				
				sql = "select"
						+ " @rownum := @rownum+1 as rownum, user_name, user_tel, user_email, user_des, user_id "
						+ "	from "
						+ " user,(select @rownum:=0) r 		"
						+ " where  "+searchKey+" like ?"
						+ " order by"
						+ "	user_name desc";
						
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, searchValue);
				rs = pstmt.executeQuery();
				
				while(rs.next())
				{
					dto = new DTO();
					dto.setRownum(rs.getInt("rownum"));
					dto.setUser_name(rs.getString("user_name"));
					dto.setUser_tel(rs.getString("user_tel"));
					dto.setUser_email(rs.getString("user_email"));
					dto.setUser_des(rs.getString("user_des"));
					dto.setUser_id(rs.getInt("user_id"));
					
					result.add(dto);
				}
				rs.close();
				pstmt.close();
					
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
			
			
			return result;
		}


	// 유저 삭제 메소드 
	@Override
	public int UserDelete(int user_id) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql ="";
		
		try
		{
			sql = "delete from user where user_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_id);
			result = pstmt.executeUpdate();
			pstmt.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;

	}

	// 유저 추가 메소드
	@Override
	public int UserInsert(DTO dto) throws SQLException
	{
		int result = 0;
		Connection conn = dataSource.getConnection();
		PreparedStatement pstmt = null;
		String sql;
		
		try
		{
			sql = "insert into 	user(user_name, user_tel, user_email, user_des)"
					+ "	values(?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_name());
			pstmt.setString(2, dto.getUser_tel());
			pstmt.setString(3, dto.getUser_email());
			pstmt.setString(4, dto.getUser_des());
		
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e)
		{	
			System.out.println(e.toString());
		}
		return result;
		
	}

	// 게임 결과 출력 메소드
	@Override
	public ArrayList<DTO> GameResultList(int game_id) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		ArrayList<DTO> result = new ArrayList<DTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try
		{
			sql = "	select  @rownum := @rownum+1 as rownum,  user_name, user_des, user_item, r.game_date game_date "
					+ " from result r join result_detail  d join user u "
					+ " on r.game_id=d.game_id and  u.user_id=d.user_id,  (select @rownum:=0) r "
					+ " where d.game_id=? "
					+ " order by d.user_item";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, game_id);
			rs = pstmt.executeQuery();
			
			
			DTO dto = null;
			while(rs.next())
			{
				dto = new DTO();
				
				dto.setRownum(rs.getInt("rownum"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_des(rs.getString("user_des"));
				dto.setUser_item(rs.getString("user_item"));
				dto.setGame_date(rs.getString("game_date"));
				result.add(dto);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;

	}
	
	
	// 게임 id별 날짜 출력 메소드 
	@Override
	public String getDate(int game_id) throws SQLException
	{
		String result = "";
		Connection conn = dataSource.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try
		{
			sql = "select game_date "
					+ "from result "
					+ "where game_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, game_id);
			rs = pstmt.executeQuery();
			
			
			DTO dto = null;
			while(rs.next())
			{
				result = rs.getString("game_date");
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;

	}

	// 지난 게임 리스트 출력 메소드
	@Override
	public ArrayList<DTO> selectUser(String user_name, String searchValue) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		ArrayList<DTO> result = new ArrayList<DTO>();		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		DTO dto = null;
		
		try
		{
			searchValue = "%"+searchValue+"%";
			

			
			sql = "select  d.game_id game_id, r.game_date game_date "
					+ "from result r join result_detail d join user u "
					+ "on r.game_id=d.game_id and  u.user_id=d.user_id "
					+ "where "+user_name+" like ? "
					+ "group by r.game_id "
					+ " order by r.game_date desc";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, searchValue);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				dto = new DTO();
				dto.setGame_id(rs.getInt("game_id"));
				dto.setGame_date(rs.getString("game_date"));
				
				result.add(dto);
			}
			rs.close();
			pstmt.close();
				
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;
	}

	// 게임 (이름, 아이템 출력) 메소드
	@Override
	public ArrayList<DTO> Laddergame(int game_id) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		ArrayList<DTO> result = new ArrayList<DTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try
		{
			sql = "	select "
					+ "		 @rownum := @rownum+1 as rownum,  user_name,user_item"
					+ " from  "
					+ "		result_detail  r join user u "
					+ "	on  "
					+ "		r.user_id=u.user_id,  (select @rownum:=0) r "
					+ "	where  "
					+ "		game_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, game_id);
			rs = pstmt.executeQuery();
			
			
			DTO dto = null;
			while(rs.next())
			{
				dto = new DTO();
				
				dto.setRownum(rs.getInt("rownum"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_item(rs.getString("user_item"));
				result.add(dto);
			}
			rs.close();
			pstmt.close();
			conn.close();
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;
		
	}

	// result 테이블에 게임 데이터 입력
	@Override
	public int GameCreate() throws SQLException
	{
		int result = 0;
		Connection conn = dataSource.getConnection();
		PreparedStatement pstmt = null;
		String sql;
		
		try
		{
			sql = "insert into result(game_date) values (now())";
			pstmt = conn.prepareStatement(sql);
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		return result;

		
	}

	// 생성된 게임에 유저 추가 * 참가한 유저 아이디 만큼
	@Override
	public int UserAdd(int user_id) throws SQLException
	{
		int result = 0;
		Connection conn = dataSource.getConnection();
		PreparedStatement pstmt = null;
		String sql;
		
		try
		{
			sql = "insert into result_detail(user_id, game_id) "
					+ "		values (?,(select max(game_id)"
					+ "  from result))";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, user_id);
	
		
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e)
		{	
			System.out.println(e.toString());
		}
		return result;

	}

	// '사다리생성'페이지에 목록 뿌려주는 쿼리
	@Override
	public ArrayList<DTO> GameReadyList() throws SQLException
	{
		Connection conn = dataSource.getConnection();
		ArrayList<DTO> result = new ArrayList<DTO>();		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		DTO dto = null;
		
		try
		{
		
			
			sql = "	select  "
					+ "		@rownum := @rownum+1 as rownum,  user_name, user_des, user_item"
					+ "        ,u.user_id user_id, r.game_id game_id"
					+ " from "
					+ "		result_detail  r join user u "
					+ "	on "
					+ " 		r.user_id=u.user_id, (select @rownum:=0) f "
					+ "	where  "
					+ "		r.game_id=(select max(game_id) "
					+ "				   from result) "
					+ "	order "
					+ "		by user_name";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				dto = new DTO();
				dto.setRownum(rs.getInt("rownum"));
				dto.setUser_name(rs.getString("user_name"));
				dto.setUser_des(rs.getString("user_des"));
				dto.setUser_item(rs.getString("user_item"));
				dto.setUser_id(rs.getInt("user_id"));
				dto.setGame_id(rs.getInt("game_id"));
				
				result.add(dto);
			}
			rs.close();
			pstmt.close();
				
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		return result;
	}

	// 라인별 상품 입력 란에 들어감 (user_item, user_id, game_id필요)
	@Override
	public int UserItemUpdate(DTO dto) throws SQLException
	{
		int result = 0;
		Connection conn = dataSource.getConnection();
	
		PreparedStatement pstmt = null;
		String sql = "";

			sql = "update result_detail "
					+ "set user_item=? "
					+ "where user_id=? and game_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getUser_item());
			pstmt.setInt(2, dto.getUser_id());
			pstmt.setInt(3, dto.getGame_id());
			result = pstmt.executeUpdate();
			
			pstmt.close();
			conn.close();
		
		return result;
	}


	
	
}
