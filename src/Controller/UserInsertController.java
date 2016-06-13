package Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;


import DAO.IDAO;
import DTO.DTO;

public class UserInsertController implements Controller
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
		
		request.setCharacterEncoding("UTF-8");
		
		String user_name = request.getParameter("user_name");
		String user_tel = request.getParameter("user_tel");
		String user_email = request.getParameter("user_email");
		String user_des = request.getParameter("user_des");
	
		System.out.println(user_name);
		System.out.println(user_tel);
		System.out.println(user_email);
		System.out.println(user_des);
		
		try
		{
			DTO dto = new DTO();
			dto.setUser_name(user_name);
			dto.setUser_tel(user_tel);
			dto.setUser_email(user_email);
			dto.setUser_des(user_des);
			
			dao.UserInsert(dto);
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
	
	
		mav.setViewName("redirect:userlist.htm");

		
		return mav; 
	}

}
