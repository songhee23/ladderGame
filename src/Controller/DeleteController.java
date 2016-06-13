package Controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import DAO.IDAO;

public class DeleteController implements Controller
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
		
		
/*		
		// l
		String num = request.getParameter("participantgroup");
		
		System.out.println(num);
		*/
		
		String[] v= request.getParameterValues(("participantgroup"));
		String user_id;
		
		for(int i=0; i<v.length; i++){
			System.out.println(v[i]);
			user_id= v[i];
			int user_id2 = Integer.parseInt(user_id);
			dao.UserDelete(user_id2);
			
			
		}
		
		mav.setViewName("redirect:userlist.htm");
		

		return mav;
	}
	
}
