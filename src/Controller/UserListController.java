package Controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import DAO.IDAO;
import DTO.DTO;



public class UserListController implements Controller
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
	
		
		

		// 검색 키와 검색값
		String searchKey = request.getParameter("searchKey");
		String searchValue = request.getParameter("searchValue");
		
		if (searchKey!=null)// -- 검색이 진행될 경우
		{
			// 넘어온 값이 GET 방식인지 확인 (한글일 경우 인코딩 방식이 필요하기 때문에 )
			if(request.getMethod().equalsIgnoreCase("GET"))
			{
				// java.net.URLDecoder ->import 하는거 확인
				searchValue=URLDecoder.decode(searchValue, "UTF-8");
				//-- 디코딩 시키기
				
			}
			
		}else
		{
			searchKey="user_name";
			searchValue="";
		}
		
		System.out.println(searchKey);
		System.out.println(searchValue);
		
		// DB 에서 해당 페이지 가져오기 (수정)
		ArrayList<DTO> list= dao.UserList(searchKey, searchValue);
		
		mav.addObject("list", list);
		mav.setViewName("/WEB-INF/views/UserList.jsp");
		
		return mav;
	}

}
