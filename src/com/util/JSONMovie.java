package com.util;

public class JSONMovie {
	
	private String moviePhoto;
	private String movieName;
	private String movieDate;
	private String movieInfo;
	private String movieActor;
	
	public JSONMovie() {
		super();
		// TODO Auto-generated constructor stub
	}

	public JSONMovie(String moviePhoto, String movieName, String movieDate,
			String movieInfo, String movieActor) {
		super();
		this.moviePhoto = moviePhoto;
		this.movieName = movieName;
		this.movieDate = movieDate;
		this.movieInfo = movieInfo;
		this.movieActor = movieActor;
	}

	public String getMoviePhoto() {
		return moviePhoto;
	}

	public void setMoviePhoto(String moviePhoto) {
		this.moviePhoto = moviePhoto;
	}

	public String getMovieName() {
		return movieName;
	}

	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}

	public String getMovieDate() {
		return movieDate;
	}

	public void setMovieDate(String movieDate) {
		this.movieDate = movieDate;
	}

	public String getMovieInfo() {
		return movieInfo;
	}

	public void setMovieInfo(String movieInfo) {
		this.movieInfo = movieInfo;
	}

	public String getMovieActor() {
		return movieActor;
	}

	public void setMovieActor(String movieActor) {
		this.movieActor = movieActor;
	}
	
}
