package com.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.dao.EditionDao;
import com.dao.KindDao;
import com.dao.LanguageDao;
import com.dao.MovieDao;
import com.mysql.jdbc.EscapeTokenizer;
import com.pojo.Edition;
import com.pojo.Kind;
import com.pojo.Language;
import com.pojo.Movie;
import com.pojo.Play;
import com.util.PageBean;

public class MovieService {

	private MovieDao movieDao;

	public void setMovieDao(MovieDao movieDao) {
		this.movieDao = movieDao;
	}

	private LanguageDao languageDao;

	public void setLanguageDao(LanguageDao languageDao) {
		this.languageDao = languageDao;
	}

	private EditionDao editionDao;

	public void setEditionDao(EditionDao editionDao) {
		this.editionDao = editionDao;
	}

	private KindDao kindDao;

	public void setKindDao(KindDao kindDao) {
		this.kindDao = kindDao;
	}

	public PageBean searchByPage(Movie movie, String[] propertyNames,
			int currentPage, int pageSize) {
		return movieDao.selectLikeByEntityByPage(movie, propertyNames,
				currentPage, pageSize);
	}

	public void create(Movie movie, Integer[] languageIds,
			Integer[] editionIds, Integer kindId) {
		for (Integer languageId : languageIds) {
			Kind kind = kindDao.selectById(kindId);
			movie.setKind(kind);
			Language language = languageDao.selectById(languageId);
			movie.setLanguage(language);
			for (Integer editionId : editionIds) {
				Edition edition = editionDao.selectById(editionId);
				movie.setEdition(edition);

				movieDao.insert(movie);
			}
		}
	}

	public List<Movie> findAll() {
		return movieDao.selectAll();
	}

	public PageBean findByPage(int currentPage, int pageSize) {
		return movieDao.selectByPage(currentPage, pageSize);
	}

	public PageBean findBeforeByPage(int currentPage, int pageSize) {
		return movieDao.selectBeforeByPage(currentPage, pageSize);
	}

	public PageBean findAfterByPage(int currentPage, int pageSize) {
		return movieDao.selectAfterByPage(currentPage, pageSize);
	}

	public void remove(Movie movie) {
		movieDao.delete(movieDao.selectById(movie.getMovieId()));
	}

	public Movie findByExample(Movie movie) {
		List<Movie> lstMovies = movieDao.selectByExample(movie);
		if (lstMovies.size() == 0) {
			return null;
		} else {
			return lstMovies.get(0);
		}
	}

	public void modify(Movie movie, Integer editionId, Integer kindId,
			Integer languageId) {
		Movie oldMovie = movieDao.selectById(movie.getMovieId());

		oldMovie.setEdition(editionDao.selectById(editionId));
		oldMovie.setKind(kindDao.selectById(kindId));
		oldMovie.setLanguage(languageDao.selectById(languageId));

		oldMovie.setMovieActor(movie.getMovieActor());
		oldMovie.setMovieDate(movie.getMovieDate());
		oldMovie.setMovieDirector(movie.getMovieDirector());
		oldMovie.setMovieInfo(movie.getMovieInfo());
		oldMovie.setMovieLong(movie.getMovieLong());
		oldMovie.setMovieName(movie.getMovieName());

		if (movie.getMoviePhoto() != null && movie.getMoviePhoto() != "") {
			oldMovie.setMoviePhoto(movie.getMoviePhoto());
		}

		movieDao.update(oldMovie);
	}

	/**
	 * 根据Id查询
	 * 
	 * @param movie
	 * @return
	 */
	public Movie findById(Movie movie) {
		return movieDao.selectById(movie.getMovieId());
	}
	
	/**
	 * JSON查正在热播
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public PageBean findBeforeByPageByJson(int currentPage, int pageSize) {
		return movieDao.selectBeforeByPageByJson(currentPage, pageSize);
	}

	/**
	 * JSON查即将上映
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public PageBean findAfterByPageByJson(int currentPage, int pageSize) {
		return movieDao.selectAfterByPageByJson(currentPage, pageSize);
	}
}
