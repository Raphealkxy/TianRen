package com.action;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pojo.Member;
import com.pojo.Movie;
import com.pojo.Play;
import com.service.MovieService;
import com.service.PlayService;
import com.util.PageBean;

public class PlayAction extends ActionSupport implements ModelDriven<Play> {
	private Play play = new Play();

	public Play getModel() {
		// TODO Auto-generated method stub
		return play;
	}

	private PlayService playService = new PlayService();

	public void setPlayService(PlayService playService) {
		this.playService = playService;
	}

	private MovieService movieService=new MovieService();
	
	public void setMovieService(MovieService movieService) {
		this.movieService = movieService;
	}

	private String movieName = new String();

	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}

	private String movieTime = new String();

	public void setMovieTime(String movieTime) {
		this.movieTime = movieTime;
	}

	private String movieEdition = new String();

	public void setMovieEdition(String movieEdition) {
		this.movieEdition = movieEdition;
	}

	private String movieDate = new String();

	public void setMovieDate(String movieDate) {
		this.movieDate = movieDate;
	}

	/**
	 * 添加场次
	 * 
	 * @return
	 * @throws Exception
	 */
	public String savePlay() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		Integer movieId = Integer.parseInt(request.getParameter("movieId")
				.toString().trim());
		String playDay = request.getParameter("playDay").toString().trim();
		Integer playHour = Integer.parseInt(request.getParameter("playHour")
				.toString().trim());
		Integer playMinute = Integer.parseInt(request
				.getParameter("playMinute").toString().trim());

		String[] yearMonthDate = playDay.split("-");
		int year = Integer.parseInt(yearMonthDate[0].trim());
		int month = Integer.parseInt(yearMonthDate[1].trim());
		int date = Integer.parseInt(yearMonthDate[2].trim().substring(0, 2));
		Calendar cd = Calendar.getInstance();
		cd.set(year, month - 1, date, playHour, playMinute, 0);
		play.setPlayTime(new Timestamp(cd.getTimeInMillis()));

		playService.create(play, movieId);

		return findPlaiesByTimeByPage();
	}

	/**
	 * 分页查询场次
	 * 
	 * @return
	 * @throws Exception
	 */
	public String findPlaiesByPage() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();

		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage")
					.toString());
		}

		int pageSize = 8;
		if (request.getParameter("pageSize") != null) {
			pageSize = Integer.parseInt(request.getParameter("pageSize")
					.toString());
		}
		PageBean plaiesByPage = playService.findByPage(currentPage, pageSize);

		Map<String, Object> session = ServletActionContext.getContext()
				.getSession();
		session.put("plaiesByPage", plaiesByPage);

		return "showPlaies";
	}

	/**
	 * 按场次时间分页查询
	 * 
	 * @return
	 * @throws Exception
	 */
	public String findPlaiesByTimeByPage() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();

		Timestamp beginTime = null;
		if (request.getParameter("beginDay") != null) {
			String beginDay = request.getParameter("beginDay").toString()
					.trim();
			if (beginDay != "") {
				String[] beginYearMonthDate = beginDay.split("-");
				int beginYear = Integer.parseInt(beginYearMonthDate[0].trim());
				int beginMonth = Integer.parseInt(beginYearMonthDate[1].trim());
				int beginDate = Integer.parseInt(beginYearMonthDate[2].trim()
						.substring(0, 2));
				Calendar beginCd = Calendar.getInstance();
				beginCd.set(beginYear, beginMonth - 1, beginDate, 0, 0, 0);
				beginTime = new Timestamp(beginCd.getTimeInMillis());
			}
		}

		Timestamp endTime = null;
		if (request.getParameter("endDay") != null) {
			String endDay = request.getParameter("endDay").toString().trim();
			if (endDay != "") {
				String[] endYearMonthDate = endDay.split("-");
				int endYear = Integer.parseInt(endYearMonthDate[0].trim());
				int endMonth = Integer.parseInt(endYearMonthDate[1].trim());
				int endDate = Integer.parseInt(endYearMonthDate[2].trim()
						.substring(0, 2));
				Calendar endCd = Calendar.getInstance();
				endCd.set(endYear, endMonth - 1, endDate, 23, 59, 59);
				endTime = new Timestamp(endCd.getTimeInMillis());
			}
		}

		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage")
					.toString());
		}

		int pageSize = 8;
		if (request.getParameter("pageSize") != null) {
			pageSize = Integer.parseInt(request.getParameter("pageSize")
					.toString());
		}
		System.out.println("beginTime:" + beginTime + ";endTime:" + endTime
				+ ";pageSize:" + pageSize + ";currentPage:" + currentPage);
		PageBean plaiesByTimeByPage = playService.findByTimeByPage(beginTime,
				endTime, currentPage, pageSize);

		request.setAttribute("plaiesByTimeByPage", plaiesByTimeByPage);
		request.setAttribute("beginTime", beginTime);
		request.setAttribute("endTime", endTime);
		return "showPlaies";
	}

	/**
	 * 删除场次
	 * 
	 * @return
	 * @throws Exception
	 */
	public String romevePlay() throws Exception {
		playService.remove(play);
		return findPlaiesByTimeByPage();
	}

	/**
	 * 查询场次
	 * 
	 * @return
	 * @throws Exception
	 */
	public String findPlay() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		Play updatePlay = playService.find(play);
		Calendar cd = Calendar.getInstance();
		cd.setTime(updatePlay.getPlayTime());

		request.setAttribute("hour", cd.get(Calendar.HOUR_OF_DAY));
		request.setAttribute("minute", cd.get(Calendar.MINUTE));
		request.setAttribute("play", updatePlay);
		return "updatePlay";
	}

	/**
	 * 修改场次
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyPlay() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();

		String playDay = request.getParameter("playDay").toString().trim();
		Integer playHour = Integer.parseInt(request.getParameter("playHour")
				.toString().trim());
		Integer playMinute = Integer.parseInt(request
				.getParameter("playMinute").toString().trim());

		String[] yearMonthDate = playDay.split("-");
		int year = Integer.parseInt(yearMonthDate[0].trim());
		int month = Integer.parseInt(yearMonthDate[1].trim());
		int date = Integer.parseInt(yearMonthDate[2].trim().substring(0, 2));
		Calendar cd = Calendar.getInstance();
		cd.set(year, month - 1, date, playHour, playMinute, 0);
		play.setPlayTime(new Timestamp(cd.getTimeInMillis()));

		playService.modify(play);

		return findPlaiesByTimeByPage();
	}

	/**
	 * 显示放映时刻表
	 * 
	 * @return
	 * @throws Exception
	 */
	public String showPlayTable() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		if(movieName==null){
			movieName="";
		}
		List<Map<String, Object>> todayLstMapTime = playService
				.findByCondition(movieName, "", "", 1);
		List<Map<String, Object>> tomorrowLstMapTime = playService
				.findByCondition(movieName, "", "", 2);
		request.setAttribute("todayLstMapTime", todayLstMapTime);
		request.setAttribute("tomorrowLstMapTime", tomorrowLstMapTime);
		return "time";
	}

	/**
	 * JOSN显示放映时刻表
	 * 
	 * @throws Exception
	 */
	public void showPlayTableByCondition() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();

		String name = new String(request.getParameter("name").trim()
				.getBytes("ISO8859-1"), "UTF-8");
		String time = request.getParameter("time");
		String edition = request.getParameter("edition");
		int TabbedPanels = Integer.parseInt(request
				.getParameter("TabbedPanels").toString().trim());

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		List<Map<String, Object>> lstMapTime = playService.findByConditionByJson(
				name, time, edition, TabbedPanels);
		
		JSONArray array=JSONArray.fromObject(lstMapTime);
		
		out.print(array.toString());
		out.flush();
		out.close();
	}

	/**
	 * 显示单部影片场次
	 * 
	 * @return
	 * @throws Exception
	 */
	public String showOneMoviePlaies() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();

		String name = new String(movieName.getBytes("ISO8859-1"), "UTF-8");

		Movie movie=new Movie();
		movie.setMovieName(name);
		
		request.setAttribute("movie", movieService.findByExample(movie));
		
		String movieTime="";
		if(request.getParameter("movieTime")!=null){
			movieTime=request.getParameter("movieTime");
		}
		
		String editionId="";
		if(request.getParameter("editionId")!=null){
			editionId=request.getParameter("editionId");
		}
					
		int movieDate=1;
		if(request.getParameter("movieDate")!=null){
			movieDate=Integer.valueOf(request.getParameter("movieDate"));
		}		
		
		List<Map<String, Object>> lstMapOneMovieTime = playService
				.findByCondition(name, movieTime, editionId, movieDate);
		
		request.setAttribute("lstMapOneMovieTime", lstMapOneMovieTime);
		
		return "oneMovie";
	}

	/**
	 * JSON显示单部影片场次
	 * @throws Exception
	 */
	public void showOneMovieByConditionByJson() throws Exception {	
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		List<Map<String, Object>> lstMapOneMovieTime = playService
				.findByConditionByJson(new String(movieName.getBytes("ISO8859-1"), "UTF-8"), movieTime, movieEdition,
						Integer.valueOf(movieDate.trim()));
		
		JSONArray array=JSONArray.fromObject(lstMapOneMovieTime);

		out.print(array.toString());
		out.flush();
		out.close();
	}
	
	/**
	 * 显示座位
	 * @return
	 * @throws Exception
	 */
	public String showSeat() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		System.out.println("-------------"+play);
		request.setAttribute("play", playService.findSeat(play));
		return "seat";
	}
	
	/**
	 * 显示支付
	 * @return
	 * @throws Exception
	 */
	public String showPay() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		
		play.setPlayId(Integer.valueOf(request.getParameter("playId")));
		request.setAttribute("play", playService.find(play));
		
		int[] chooseSeatsNum=new int[request.getParameter("chooseSeatsNum").split(",").length];
		for (int i = 0; i < request.getParameter("chooseSeatsNum").split(",").length; i++) {
			chooseSeatsNum[i] = Integer.valueOf(request.getParameter("chooseSeatsNum").split(",")[i]);
		}		
		request.setAttribute("chooseSeatsNum", chooseSeatsNum);
		
		Map<String, Object> session = ActionContext.getContext().getSession();
		Member curMember=(Member) session.get("curMember");
		Double ticketPrice=playService.getTicketPrice(curMember, play);
		request.setAttribute("ticketPrice", ticketPrice);
		
		return "pay";
	}
}
