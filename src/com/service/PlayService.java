package com.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.dao.EditionDao;
import com.dao.MovieDao;
import com.dao.PlayDao;
import com.pojo.Edition;
import com.pojo.Member;
import com.pojo.Movie;
import com.pojo.Play;
import com.pojo.Ticket;
import com.util.PageBean;

public class PlayService {
	private PlayDao playDao = new PlayDao();

	public void setPlayDao(PlayDao playDao) {
		this.playDao = playDao;
	}

	private MovieDao movieDao = new MovieDao();

	public void setMovieDao(MovieDao movieDao) {
		this.movieDao = movieDao;
	}

	/**
	 * 添加场次
	 * 
	 * @param play
	 * @param movie
	 */
	public void create(Play play, Integer movieId) {
		play.setMovie(movieDao.selectById(movieId));
		playDao.insert(play);
	}

	/**
	 * 分页查询
	 * 
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public PageBean findByPage(int currentPage, int pageSize) {
		return playDao.selectByPage(currentPage, pageSize);
	}

	/**
	 * 按场次时间段分页查询
	 * 
	 * @param beginTime
	 * @param endTime
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public PageBean findByTimeByPage(Timestamp beginTime, Timestamp endTime,
			int currentPage, int pageSize) {
		return playDao.selectByTimeByPage(beginTime, endTime, currentPage,
				pageSize);
	}

	/**
	 * 根据Id删除场次
	 * 
	 * @param playId
	 */
	public void remove(Play play) {
		playDao.delete(playDao.selectById(play.getPlayId()));
	}

	/**
	 * 根据Id查找场次
	 * 
	 * @param play
	 * @return
	 */
	public Play find(Play play) {
		return playDao.selectById(play.getPlayId());
	}
	
	/**
	 * 根据Id查找空座
	 * @param play
	 * @return
	 */
	public Play findSeat(Play play){
		return playDao.selectSeatByPlayId(play.getPlayId());
	}
	
	/**
	 * 修改场次
	 * 
	 * @param play
	 */
	public void modify(Play play) {
		Play newPlay = playDao.selectById(play.getPlayId());
		newPlay.setPlayPrice(play.getPlayPrice());
		newPlay.setPlayTime(play.getPlayTime());
		playDao.update(newPlay);
	}

	/**
	 * 查询放映时刻
	 * @param movieName
	 * @param time
	 * @param editionId
	 * @param TabbedPanel
	 * @return
	 */
	public List<Map<String,Object>> findByCondition(String movieName,
			String time, String editionId, Integer TabbedPanel) {
		Map<String, List> mapTime = playDao.selectByCondition(movieName, time,
				editionId, TabbedPanel);

		List<Play> lstPlaies = mapTime.get("lstPlaies");
		
		List<Map<String, Object>> lstMapMovies = mapTime
				.get("lstMapMovies");
		
		List<Map<String,Object>> lstMapPlay = new ArrayList<Map<String,Object>>();

		for (Map<String, Object> mapMovie : lstMapMovies) {
			Map<String, Object> mapPlay=new HashMap<String, Object>();
			List<Play> lstOneMoviePlaies=new ArrayList<Play>();

			for (Play play : lstPlaies) {
				if(mapMovie.get("movieName").equals(play.getMovie().getMovieName())){	
					List<Ticket> delList=new ArrayList<Ticket>();
					for(Object ticket:play.getTickets()){						
						if(!((Ticket) ticket).getTicketFlag()){
							delList.add((Ticket) ticket);
						}
					}
					play.getTickets().removeAll(delList);
					lstOneMoviePlaies.add(play);				
				}
			}
			
			mapPlay.put("lstPlaies", lstOneMoviePlaies);
			mapPlay.put("mapMovie", mapMovie);
			lstMapPlay.add(mapPlay);
		}

		return lstMapPlay;
	}
	
	/**
	 * JSON查询放映时刻
	 * @param movieName
	 * @param time
	 * @param editionId
	 * @param TabbedPanel
	 * @return
	 */
	public List<Map<String,Object>> findByConditionByJson(String movieName,
			String time, String editionId, Integer TabbedPanel) {
		Map<String, List> mapTime = playDao.selectByCondition(movieName, time,
				editionId, TabbedPanel);
			
			List<Play> lstPlaies = mapTime.get("lstPlaies");
			
			List<Map<String, Object>> lstMapMovies = mapTime
					.get("lstMapMovies");
			List<Map<String,Object>> lstMapPlay = new ArrayList<Map<String,Object>>();

			SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
			
			for (Map<String, Object> mapMovie : lstMapMovies) {
				Map<String, Object> mapPlay=new HashMap<String, Object>();
				List<Map<String,Object>> lstOneMoviePlaies=new ArrayList<Map<String,Object>>();

				for (Play play : lstPlaies) {
					if(mapMovie.get("movieName").equals(play.getMovie().getMovieName())){	
						Map<String,Object> mapMovies=new HashMap<String, Object>();
						mapMovies.put("playId", play.getPlayId());
						mapMovies.put("playTime", sdf.format(new Date(play.getPlayTime().getTime())));
						
						List<Ticket> delList=new ArrayList<Ticket>();
						for(Object ticket:play.getTickets()){						
							if(!((Ticket) ticket).getTicketFlag()){
								delList.add((Ticket) ticket);
							}
						}
						play.getTickets().removeAll(delList);
						
						mapMovies.put("ticketNum", play.getTickets().size());
						mapMovies.put("language", play.getMovie().getLanguage().getLanguageName());
						mapMovies.put("edition", play.getMovie().getEdition().getEditionName());
						mapMovies.put("playPrice", play.getPlayPrice());
						lstOneMoviePlaies.add(mapMovies);				
					}
				}
				
				mapPlay.put("lstPlaies", lstOneMoviePlaies);
				mapPlay.put("mapMovie", mapMovie);
				lstMapPlay.add(mapPlay);
			}
			
			return lstMapPlay;
	}
	
	/**
	 * 计算获取票价
	 * @param curMember
	 * @param play
	 * @return
	 */
	public Double getTicketPrice(Member curMember,Play play){
		Play curPlay=playDao.selectById(play.getPlayId());
		Double ticketPrice=curPlay.getPlayPrice();
		return ticketPrice;
	}
}
