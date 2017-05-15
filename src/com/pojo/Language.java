package com.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 * Language entity. @author MyEclipse Persistence Tools
 */

public class Language implements java.io.Serializable {

	// Fields

	private Integer languageId;
	private String languageName;
	private Set movies = new HashSet(0);

	// Constructors

	/** default constructor */
	public Language() {
	}

	/** minimal constructor */
	public Language(String languageName) {
		this.languageName = languageName;
	}

	/** full constructor */
	public Language(String languageName, Set movies) {
		this.languageName = languageName;
		this.movies = movies;
	}

	// Property accessors

	public Integer getLanguageId() {
		return this.languageId;
	}

	public void setLanguageId(Integer languageId) {
		this.languageId = languageId;
	}

	public String getLanguageName() {
		return this.languageName;
	}

	public void setLanguageName(String languageName) {
		this.languageName = languageName;
	}

	public Set getMovies() {
		return this.movies;
	}

	public void setMovies(Set movies) {
		this.movies = movies;
	}

}