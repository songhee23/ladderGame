package Controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import DAO.IDAO;
import DTO.DTO;

public class LadderController implements Controller
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
	
		// 수평바 수 
		int vertical_num = Integer.parseInt(request.getParameter(("searchKey")));
		
		// 아이템 받아서 업데이트 되어야 함 UserItemUpdate
		String[] user_id= request.getParameterValues(("user_id"));
		String[] game_id= request.getParameterValues(("game_id"));
		String[] user_item= request.getParameterValues(("user_item"));
		
		Random rnd = new Random();
		int[] changed_user_item =new int[user_item.length];
		
		/*searchValue=URLDecoder.decode(searchValue, "UTF-8");*/
		
		int cnt = 0; //-- 카운드변수(루프변수)
		int n; //-- 발생한 난수를 담아서 처리할 변수 
/*		// item을 랜덤 클래스로 위치를 바꿔줘야 함 // item
		for (int i = 0; i < user_item.length; i++)
		{
			changed_user_item =  rnd.nextInt(user_item.length)+1;//item개수만큼 난수 1개 발생
			
			for(int j=0; i<cnt; i++)
			{
				if(changed_user_item==)
			}
			
		}*/
		
		jump:
		while (cnt<user_item.length)
		{
			n =  rnd.nextInt(user_item.length);  //item개수만큼 난수 1개 발생
			
			for(int i=0; i<cnt; i++)
			{
				if(changed_user_item[i]==n)
				continue jump;
			}
			changed_user_item[cnt++]=n;
			
		}

		// 랜덤하게 숫자 찍혔나 확인 
		for (int i = 0; i < user_item.length; i++)
		{
			System.out.println();
			System.out.println(changed_user_item[i]);
		}
		
/*		// 랜덤값 순서에 user_item 넣기 
		for (int i = 0; i < user_item.length; i++)
		{
			i= changed_user_item[i];
			System.out.println(user_item[i]);
		}
		
		*/
		
		
		
		// 참여 수 
		int participant_num = user_id.length;
		

		String user_id1="";
		String user_item1="";
		String game_id1="";
		DTO dto1 = new DTO();
		
		for(int i=0; i<user_id.length; i++){
			
			
			user_id1=user_id[i];
			int user_id2 = Integer.parseInt(user_id1);
			dto1.setUser_id(user_id2);
			
			
			user_item1 = user_item[changed_user_item[i]];
			//user_item1 = user_item[i];
			dto1.setUser_item(user_item1);
			
			game_id1 = game_id[i];
			int game_id2 = Integer.parseInt(game_id1);
			dto1.setGame_id(game_id2);
			
			
			dao.UserItemUpdate(dto1);
			
			
		}
		
		

		
		// 이름과 item 출력 메서드 Laddergame
	/*	-------------------------------------
	 
		이름    이름
		  |		  |
		  |-------|
		  |       |
		item    item
		
		-------------------------------------
		*/
		
		String game_id3 =  game_id[0];
		int game_id4 = Integer.parseInt(game_id3);
		ArrayList<DTO> list = dao.Laddergame(game_id4);
		
		mav.addObject("list", list);
		
		request.setAttribute("nodes", vertical_num);
		request.setAttribute("join_num", participant_num);
		request.setAttribute("game_id", game_id4);
		mav.setViewName("/WEB-INF/views/Ladder.jsp");
		return mav;
		
	}
	

}
