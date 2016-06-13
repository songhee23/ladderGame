package Controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;



import DAO.IDAO;
import DTO.DTO;

public class ResultController implements Controller
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
		// 게임 결과 출력 메소드 GameResultList
		
		String game_id = request.getParameter("game_id");
		int game_id_num = Integer.parseInt(game_id);
		
		ArrayList<DTO> list = dao.GameResultList(game_id_num);
		
		String date ="";
		date = dao.getDate(game_id_num);
		
		request.setAttribute("date", date);
		mav.addObject("list", list);
		mav.setViewName("/WEB-INF/views/Result.jsp");
		
		return mav;
		
	}
	
	

}
