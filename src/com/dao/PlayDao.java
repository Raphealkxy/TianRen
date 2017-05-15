package com.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;

import com.dao.base.GenericDaoImpl;
import com.pojo.Edition;
import com.pojo.Play;
import com.util.PageBean;

public class PlayDao extends GenericDaoImpl<Play, Integer> {

	public Play selectById(Integer id) {
		return super.selectById(id);
	}

	public List<Play> select() {
		return super.selectAll();
	}

	public void insert(Play play) {
		super.insert(play);
	}

	public void delete(Play play) {
		super.delete(play);
	}

	public void update(Play play) {
		super.update(play);
		getHibernateTemplate().flush();
	}

	public PageBean selectByPage(int currentPage, int pageSize) {
		Criteria criteria_data = createCriteria();
		criteria_data.addOrder(Order.desc("playTime"));
		criteria_data.setFirstResult((currentPage - 1) * pageSize);
		criteria_data.setMaxResults(pageSize);

		List<Play> lstPlay = criteria_data.list();

		Criteria criteria_totalRows = createCriteria();
		criteria_totalRows.setProjection(Projections.rowCount());
		int totalRows = Integer.parseInt(criteria_totalRows.uniqueResult()
				.toString());

		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(lstPlay);

		return pageBean;
	}

	/**
	 * 按时间段分页查询
	 * 
	 * @param beginTime
	 * @param endTime
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public PageBean selectByTimeByPage(Timestamp beginTime, Timestamp endTime,
			int currentPage, int pageSize) {
		Criteria criteria_data = createCriteria();

		if (beginTime != null) {
			criteria_data.add(Restrictions.ge("playTime", beginTime));
		}
		if (endTime != null) {
			criteria_data.add(Restrictions.le("playTime", endTime));
		}

		criteria_data.addOrder(Order.desc("playTime"));
		criteria_data.setFirstResult((currentPage - 1) * pageSize);
		criteria_data.setMaxResults(pageSize);

		List<Play> lstPlay = criteria_data.list();

		Criteria criteria_totalRows = createCriteria();
		if (beginTime != null) {
			criteria_totalRows.add(Restrictions.ge("playTime", beginTime));
		}
		if (endTime != null) {
			criteria_totalRows.add(Restrictions.le("playTime", endTime));
		}
		criteria_totalRows.setProjection(Projections.rowCount());
		int totalRows = Integer.parseInt(criteria_totalRows.uniqueResult()
				.toString());

		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(lstPlay);

		return pageBean;
	}

	/**
	 * 按条件查询
	 * 
	 * @param flag
	 * @return
	 */
	public Map<String, List> selectByCondition(String movieName, String time,
			String editionId, int TabbedPanel) {
		Calendar cd = Calendar.getInstance();
		// 当前时间
		Timestamp now = new Timestamp(cd.getTimeInMillis());

		int year = cd.get(Calendar.YEAR);
		int month = cd.get(Calendar.MONTH);
		int day = cd.get(Calendar.DAY_OF_MONTH);

		// 今天开始时间
		cd.set(year, month, day, 0, 0, 0);
		Timestamp todayBegin = new Timestamp(cd.getTimeInMillis());

		// 今天中午
		cd.set(year, month, day, 12, 0, 0);
		Timestamp todayNoon = new Timestamp(cd.getTimeInMillis());

		// 今天下午结束
		cd.set(year, month, day, 18, 0, 0);
		Timestamp todayPmEnd = new Timestamp(cd.getTimeInMillis());

		// 今天结束（明天开始）时间
		cd.set(year, month, day + 1, 0, 0, 0);
		Timestamp tomorrowBegin = new Timestamp(cd.getTimeInMillis());

		// 明天中午
		cd.set(year, month, day + 1, 12, 0, 0);
		Timestamp tomorrowNoon = new Timestamp(cd.getTimeInMillis());

		// 明天下午结束
		cd.set(year, month, day+1, 18, 0, 0);
		Timestamp tomorrowPmEnd = new Timestamp(cd.getTimeInMillis());

		// 明天结束时间
		cd.set(year, month, day+1, 23, 59, 59);
		Timestamp tomorrowEnd = new Timestamp(cd.getTimeInMillis());

		Timestamp beginTime = null;
		Timestamp endTime = null;

		Criteria criteria = createCriteria();

		if ("".equalsIgnoreCase(time) && TabbedPanel==1) {
			beginTime = now;
			endTime = tomorrowBegin;
		} else if ("am".equalsIgnoreCase(time) && TabbedPanel==1) {
			beginTime = todayBegin;
			endTime = todayNoon;
		} else if ("pm".equalsIgnoreCase(time) && TabbedPanel==1) {
			beginTime = todayNoon;
			endTime = todayPmEnd;
		} else if ("night".equalsIgnoreCase(time) && TabbedPanel==1) {
			beginTime = todayPmEnd;
			endTime = tomorrowBegin;
		} else if ("".equalsIgnoreCase(time) && TabbedPanel==2) {
			beginTime = tomorrowBegin;
			endTime = tomorrowEnd;
		} else if ("am".equalsIgnoreCase(time) && TabbedPanel==2) {
			beginTime = tomorrowBegin;
			endTime = tomorrowNoon;
		} else if ("pm".equalsIgnoreCase(time) && TabbedPanel==2) {
			beginTime = tomorrowNoon;
			endTime = tomorrowPmEnd;
		} else if ("night".equalsIgnoreCase(time) && TabbedPanel==2) {
			beginTime = tomorrowPmEnd;
			endTime = tomorrowEnd;
		}
		
		criteria.add(Restrictions.gt("playTime", now));
		criteria.add(Restrictions.gt("playTime", beginTime));
		criteria.add(Restrictions.le("playTime", endTime));

		Criteria criteria_movie = criteria.createAlias("movie", "movie");
		criteria_movie.add(Restrictions.like("movie.movieName", movieName,
				MatchMode.ANYWHERE));
		criteria_movie.addOrder(Order.asc("movie.movieName"));
		
		if (!"".equals(editionId.trim()) && editionId.trim().length() != 0) {
		Criteria criteria_edition = criteria_movie
					.createAlias("movie.edition", "edition");			
			criteria_edition.add(Restrictions.eq("edition.editionId", Integer.valueOf(editionId.trim())));
		}

		criteria.addOrder(Order.asc("playTime"));

		List<Play> lstPlaies = criteria.list();
		Criteria criteria_kind = criteria_movie
				.createAlias("movie.kind", "kind");	
		criteria_kind.setProjection(Projections.projectionList()
				.add(Projections.groupProperty("movie.movieName"))	
				.add(Projections.property("kind.kindName"))
				.add(Projections.property("movie.movieLong"))
				.add(Projections.property("movie.movieActor"))
				.add(Projections.property("movie.movieDate"))
				.add(Projections.property("movie.movieDirector"))
				.add(Projections.property("movie.movieInfo"))
				.add(Projections.property("movie.moviePhoto")));
		List list = criteria.list();

		List<Map<String, Object>> lstMapMovies = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[]) list.get(i);
			Map<String, Object> mapMovies = new HashMap<String, Object>();

			mapMovies.put("movieName", obj[0].toString().trim());
			mapMovies.put("movieKindName", obj[1].toString().trim());
			mapMovies.put("movieLong",
					Integer.parseInt(obj[2].toString().trim()));
			mapMovies.put("movieActor", obj[3].toString().trim());
			mapMovies.put("movieDate", (Timestamp)obj[4]);
			mapMovies.put("movieDirector", obj[5].toString().trim());
			mapMovies.put("movieInfo", obj[6].toString().trim());
			mapMovies.put("moviePhoto", obj[7].toString().trim());
			lstMapMovies.add(mapMovies);

		}

		Map<String, List> mapTime = new HashMap<String, List>();
		mapTime.put("lstPlaies", lstPlaies);
		mapTime.put("lstMapMovies", lstMapMovies);
		return mapTime;
	}

	/**
	 * 根据Id查找空座
	 * @param playId
	 * @return
	 */
	public Play selectSeatByPlayId(int playId){
		Criteria criteria = createCriteria();
		criteria.add(Restrictions.idEq(playId));
		//Criteria criteria_ticket = criteria.createAlias("tickets", "ticket");
		//criteria_ticket.add(Restrictions.ne("ticket.ticketFlag", false));
		Play play=(Play) criteria.uniqueResult();
		return play;
	}
}
