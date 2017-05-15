package com.pojo;

import java.util.HashSet;
import java.util.Set;

/**
 * Kind entity. @author MyEclipse Persistence Tools
 */

public class Kind implements java.io.Serializable {

	// Fields

	private Integer kindId;
	private String kindName;
	private Set movies = new HashSet(0);

	// Constructors

	/** default constructor */
	public Kind() {
	}

	/** minimal constructor */
	public Kind(String kindName) {
		this.kindName = kindName;
	}

	/** full constructor */
	public Kind(String kindName, Set movies) {
		this.kindName = kindName;
		this.movies = movies;
	}

	// Property accessors

	public Integer getKindId() {
		return this.kindId;
	}

	public void setKindId(Integer kindId) {
		this.kindId = kindId;
	}

	public String getKindName() {
		return this.kindName;
	}

	public void setKindName(String kindName) {
		this.kindName = kindName;
	}

	public Set getMovies() {
		return this.movies;
	}

	public void setMovies(Set movies) {
		this.movies = movies;
	}

}