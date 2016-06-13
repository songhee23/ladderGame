package DAO;

import java.sql.SQLException;
import java.util.ArrayList;
import DTO.DTO;



public interface IDAO
{


	// 유저 리스트 출력 메소드
	public ArrayList<DTO> UserList(String searchKey, String searchValue) throws SQLException;
	public ArrayList<DTO> UserListDesc(String searchKey, String searchValue) throws SQLException;

	// 유저 삭제 메소드 
	public int UserDelete(int user_id)throws SQLException;
	// 유저 추가 메소드
	public int UserInsert(DTO dto)throws SQLException;
	// 게임 결과 출력 메소드
	public ArrayList<DTO> GameResultList(int game_id)throws SQLException;
	// 지난 게임 리스트 출력 메소드  
	public ArrayList<DTO> selectUser(String user_name, String searchValue)throws SQLException;
	// 게임 (이름, 아이템 출력) 메소드 
	public ArrayList<DTO> Laddergame(int game_id)throws SQLException;
	// result 테이블에 게임 데이터 입력
	public int GameCreate()throws SQLException;
	// 생성된 게임에 유저 추가 * 참가한 유저 아이디 만큼
	public int UserAdd(int user_id)throws SQLException;
	// '사다리생성'페이지에 목록 뿌려주는 쿼리
	public ArrayList<DTO> GameReadyList()throws SQLException;
	// 라인별 상품 입력 란에 들어감 (user_item, user_id, game_id필요)
	public int UserItemUpdate(DTO dto)throws SQLException;
	// 게임 id별 날짜 출력 메소드 
	public String getDate(int game_id) throws SQLException;




}
