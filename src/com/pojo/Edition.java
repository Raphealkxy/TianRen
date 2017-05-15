package com.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 * Edition entity. @author MyEclipse Persistence Tools
 */

public class Edition implements java.io.Serializable {

	// Fields

	private Integer editionId;
	private String editionName;
	private Set movies = new HashSet(0);

	// Constructors

	/** default constructor */
	public Edition() {
	}

	/** minimal constructor */
	public Edition(String editionName) {
		this.editionName = editionName;
	}

	/** full constructor */
	public Edition(String editionName, Set movies) {
		this.editionName = editionName;
		this.movies = movies;
	}

	// Property accessors

	public Integer getEditionId() {
		return this.editionId;
	}

	public void setEditionId(Integer editionId) {
		this.editionId = editionId;
	}

	public String getEditionName() {
		return this.editionName;
	}

	public void setEditionName(String editionName) {
		this.editionName = editionName;
	}

	public Set getMovies() {
		return this.movies;
	}

	public void setMovies(Set movies) {
		this.movies = movies;
	}

}