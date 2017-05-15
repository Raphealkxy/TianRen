package com.dao;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import com.dao.base.GenericDaoImpl;
import com.pojo.Movie;
import com.util.JSONMovie;
import com.util.PageBean;

public class MovieDao extends GenericDaoImpl<Movie, Integer> {

	public Movie selectById(Integer id) {
		return super.selectById(id);
	}

	public List<Movie> selectAll() {
		return super.selectAll();
	}

	public void insert(Movie movie) {
		super.insert(movie);
		getHibernateTemplate().clear();
	}

	public void delete(Movie movie) {
		super.delete(movie);
	}

	public void update(Movie movie) {
		super.update(movie);
	}

	public PageBean selectLikeByEntityByPage(Movie movie,
			String[] propertyNames, int currentPage, int pageSize) {
		return super.selectLikeByEntityByPage(movie, propertyNames,
				currentPage, pageSize);
	}

	public PageBean selectByPage(int currentPage, int pageSize) {
		return super.selectByPage(currentPage, pageSize);
	}

	public PageBean selectBeforeByPage(int currentPage, int pageSize) {
		Criteria criteria_data = createCriteria();
		criteria_data.setProjection(Projections.projectionList()
				.add(Projections.distinct(Projections.property("movieName")))
				.add(Projections.property("movieActor"))
				.add(Projections.property("movieDate"))
				.add(Projections.property("moviePhoto"))
				.add(Projections.property("movieInfo")));
		criteria_data.add(Restrictions.le("movieDate", new Date()));
		criteria_data.addOrder(Order.desc("movieDate"));

		criteria_data.setFirstResult((currentPage - 1) * pageSize);
		criteria_data.setMaxResults(pageSize);

		List list = criteria_data.list();

		List<Movie> beforeMovies = new ArrayList<Movie>();
		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[]) list.get(i);
			Movie movie = new Movie();
			movie.setMovieName(obj[0].toString());
			movie.setMovieActor(obj[1].toString());
			movie.setMovieDate((Timestamp) obj[2]);
			movie.setMoviePhoto(obj[3].toString());
			movie.setMovieInfo(obj[4].toString());

			beforeMovies.add(movie);
		}

		Criteria criteria_totalRows = createCriteria();
		criteria_totalRows
				.setProjection(Projections.countDistinct("movieName"));
		criteria_totalRows.add(Restrictions.le("movieDate", new Date()));
		int totalRows = Integer.parseInt(criteria_totalRows.uniqueResult()
				.toString());

		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(beforeMovies);

		return pageBean;
	}

	public PageBean selectAfterByPage(int currentPage, int pageSize) {
		Criteria criteria_data = createCriteria();
		criteria_data.setProjection(Projections.projectionList()
				.add(Projections.distinct(Projections.property("movieName")))
				.add(Projections.property("movieActor"))
				.add(Projections.property("movieDate"))
				.add(Projections.property("moviePhoto"))
				.add(Projections.property("movieInfo")));
		criteria_data.add(Restrictions.gt("movieDate", new Date()));
		criteria_data.addOrder(Order.asc("movieDate"));

		criteria_data.setFirstResult((currentPage - 1) * pageSize);
		criteria_data.setMaxResults(pageSize);

		List list = criteria_data.list();

		List<Movie> afterMovies = new ArrayList<Movie>();
		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[]) list.get(i);
			Movie movie = new Movie();
			movie.setMovieName(obj[0].toString());
			movie.setMovieActor(obj[1].toString());
			movie.setMovieDate((Timestamp) obj[2]);
			movie.setMoviePhoto(obj[3].toString());
			movie.setMovieInfo(obj[4].toString());

			afterMovies.add(movie);
		}

		Criteria criteria_totalRows = createCriteria();
		criteria_totalRows
				.setProjection(Projections.countDistinct("movieName"));
		criteria_totalRows.add(Restrictions.gt("movieDate", new Date()));
		int totalRows = Integer.parseInt(criteria_totalRows.uniqueResult()
				.toString());

		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(afterMovies);

		return pageBean;
	}

	public PageBean selectBeforeByPageByJson(int currentPage, int pageSize) {
		Criteria criteria_data = createCriteria();
		criteria_data.setProjection(Projections.projectionList()
				.add(Projections.distinct(Projections.property("movieName")))
				.add(Projections.property("movieActor"))
				.add(Projections.property("movieDate"))
				.add(Projections.property("moviePhoto"))
				.add(Projections.property("movieInfo")));
		criteria_data.add(Restrictions.le("movieDate", new Date()));
		criteria_data.addOrder(Order.desc("movieDate"));

		criteria_data.setFirstResult((currentPage - 1) * pageSize);
		criteria_data.setMaxResults(pageSize);

		List list = criteria_data.list();

		List<JSONMovie> JSONbeforeMovies = new ArrayList<JSONMovie>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[]) list.get(i);
			JSONMovie movie = new JSONMovie();
			movie.setMovieName(obj[0].toString());
			movie.setMovieActor(obj[1].toString());
			movie.setMovieDate(sdf.format(new Date(((Timestamp) obj[2])
					.getTime())));
			movie.setMoviePhoto(obj[3].toString());
			movie.setMovieInfo(obj[4].toString());

			JSONbeforeMovies.add(movie);
		}

		Criteria criteria_totalRows = createCriteria();
		criteria_totalRows
				.setProjection(Projections.countDistinct("movieName"));
		criteria_totalRows.add(Restrictions.le("movieDate", new Date()));
		int totalRows = Integer.parseInt(criteria_totalRows.uniqueResult()
				.toString());

		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(JSONbeforeMovies);

		return pageBean;
	}

	public PageBean selectAfterByPageByJson(int currentPage, int pageSize) {
		Criteria criteria_data = createCriteria();
		criteria_data.setProjection(Projections.projectionList()
				.add(Projections.distinct(Projections.property("movieName")))
				.add(Projections.property("movieActor"))
				.add(Projections.property("movieDate"))
				.add(Projections.property("moviePhoto"))
				.add(Projections.property("movieInfo")));
		criteria_data.add(Restrictions.gt("movieDate", new Date()));
		criteria_data.addOrder(Order.asc("movieDate"));

		criteria_data.setFirstResult((currentPage - 1) * pageSize);
		criteria_data.setMaxResults(pageSize);

		List list = criteria_data.list();

		List<JSONMovie> JSONafterMovies = new ArrayList<JSONMovie>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[]) list.get(i);
			JSONMovie movie = new JSONMovie();
			movie.setMovieName(obj[0].toString());
			movie.setMovieActor(obj[1].toString());
			movie.setMovieDate(sdf.format(new Date(((Timestamp) obj[2])
					.getTime())));
			movie.setMoviePhoto(obj[3].toString());
			movie.setMovieInfo(obj[4].toString().substring(0,30)+"...");

			JSONafterMovies.add(movie);
		}

		Criteria criteria_totalRows = createCriteria();
		criteria_totalRows
				.setProjection(Projections.countDistinct("movieName"));
		criteria_totalRows.add(Restrictions.gt("movieDate", new Date()));
		int totalRows = Integer.parseInt(criteria_totalRows.uniqueResult()
				.toString());

		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(JSONafterMovies);

		return pageBean;
	}
}
