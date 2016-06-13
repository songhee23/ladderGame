package Controller;

import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import DAO.IDAO;
import DTO.DTO;

public class GameReadyController implements Controller
{
	
	private IDAO dao;
	
	public void setDao(IDAO dao)
	{
		this.dao = dao;
		
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		ArrayList<DTO> dto = new ArrayList<DTO>();
		DTO dto_ = new DTO();
		
		request.setCharacterEncoding("UTF-8");
		


		// result 테이블에 게임 데이터 입력
		try
		{

				dao.GameCreate();
				
				
		} catch (Exception e)
		{
				System.out.println(e.toString());
		}
		
	
		// 생성된 게임에 유저 추가 * 참가한 유저 아이디 만큼
		String[] v= request.getParameterValues(("participantgroup"));
		String user_id;
		
		for(int i=0; i<v.length; i++){
			System.out.println(v[i]);
			user_id= v[i];
			int user_id2 = Integer.parseInt(user_id);
			dao.UserAdd(user_id2);
			
			
		}
		// '사다리생성'페이지에 목록 뿌려주는 쿼리
		ArrayList<DTO> list= dao.GameReadyList();
		

		
		mav.addObject("list", list);
		mav.setViewName("/WEB-INF/views/GameReady.jsp");
		
		return mav;
	}


}
