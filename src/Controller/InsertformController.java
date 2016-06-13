package Controller;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import DAO.IDAO;
import DTO.DTO;

public class InsertformController implements Controller
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
		
		request.setCharacterEncoding("UTF-8");
	
		
		

		mav.setViewName("/WEB-INF/views/insertform.jsp");

		return mav;
	}
	

}
