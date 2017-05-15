package com.pojo;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Movie entity. @author MyEclipse Persistence Tools
 */

public class Movie implements java.io.Serializable {

	// Fields

	private Integer movieId;
	private Language language;
	private Edition edition;
	private Kind kind;
	private String movieName;
	private String movieDirector;
	private String movieActor;
	private String movieInfo;
	private String moviePhoto;
	private Integer movieLong;
	private Timestamp movieDate;
	private Set plaies = new HashSet(0);

	// Constructors

	/** default constructor */
	public Movie() {
	}

	/** minimal constructor */
	public Movie(Language language, Edition edition, Kind kind,
			String movieName, String movieDirector, String movieActor,
			String movieInfo, String moviePhoto, Integer movieLong) {
		this.language = language;
		this.edition = edition;
		this.kind = kind;
		this.movieName = movieName;
		this.movieDirector = movieDirector;
		this.movieActor = movieActor;
		this.movieInfo = movieInfo;
		this.moviePhoto = moviePhoto;
		this.movieLong = movieLong;
	}

	/** full constructor */
	public Movie(Language language, Edition edition, Kind kind,
			String movieName, String movieDirector, String movieActor,
			String movieInfo, String moviePhoto, Integer movieLong,
			Timestamp movieDate, Set plaies) {
		this.language = language;
		this.edition = edition;
		this.kind = kind;
		this.movieName = movieName;
		this.movieDirector = movieDirector;
		this.movieActor = movieActor;
		this.movieInfo = movieInfo;
		this.moviePhoto = moviePhoto;
		this.movieLong = movieLong;
		this.movieDate = movieDate;
		this.plaies = plaies;
	}

	// Property accessors

	public Integer getMovieId() {
		return this.movieId;
	}

	public void setMovieId(Integer movieId) {
		this.movieId = movieId;
	}

	public Language getLanguage() {
		return this.language;
	}

	public void setLanguage(Language language) {
		this.language = language;
	}

	public Edition getEdition() {
		return this.edition;
	}

	public void setEdition(Edition edition) {
		this.edition = edition;
	}

	public Kind getKind() {
		return this.kind;
	}

	public void setKind(Kind kind) {
		this.kind = kind;
	}

	public String getMovieName() {
		return this.movieName;
	}

	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}

	public String getMovieDirector() {
		return this.movieDirector;
	}

	public void setMovieDirector(String movieDirector) {
		this.movieDirector = movieDirector;
	}

	public String getMovieActor() {
		return this.movieActor;
	}

	public void setMovieActor(String movieActor) {
		this.movieActor = movieActor;
	}

	public String getMovieInfo() {
		return this.movieInfo;
	}

	public void setMovieInfo(String movieInfo) {
		this.movieInfo = movieInfo;
	}

	public String getMoviePhoto() {
		return this.moviePhoto;
	}

	public void setMoviePhoto(String moviePhoto) {
		this.moviePhoto = moviePhoto;
	}

	public Integer getMovieLong() {
		return this.movieLong;
	}

	public void setMovieLong(Integer movieLong) {
		this.movieLong = movieLong;
	}

	public Timestamp getMovieDate() {
		return this.movieDate;
	}

	public void setMovieDate(Timestamp movieDate) {
		this.movieDate = movieDate;
	}

	public Set getPlaies() {
		return this.plaies;
	}

	public void setPlaies(Set plaies) {
		this.plaies = plaies;
	}

}