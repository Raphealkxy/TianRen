package com.action;

import java.io.File;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.pojo.Movie;
import com.pojo.Play;
import com.service.MovieService;
import com.util.FileProcessUitl;
import com.util.PageBean;

public class MovieAction extends ActionSupport implements ModelDriven<Movie> {

	private Movie movie = new Movie();

	public Movie getModel() {
		// TODO Auto-generated method stub
		return movie;
	}

	public void setMovie(Movie movie) {
		this.movie = movie;
	}

	private File[] upload; // 代表上传的文件本身 ---> 图片A本身 图片B本身
	private String[] uploadContentType; // 代表文件类型 ---> png jpg
	private String[] uploadFileName; // 代表文件名 ---> A.PNG B.jpg

	public File[] getUpload() {
		return upload;
	}

	public void setUpload(File[] upload) {
		this.upload = upload;
	}

	public String[] getUploadContentType() {
		return uploadContentType;
	}

	public void setUploadContentType(String[] uploadContentType) {
		this.uploadContentType = uploadContentType;
	}

	public String[] getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String[] uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	private MovieService movieService;

	public void setMovieService(MovieService movieService) {
		this.movieService = movieService;
	}

	private Integer[] languageIds;

	public Integer[] getLanguageIds() {
		return languageIds;
	}

	public void setLanguageIds(Integer[] languageIds) {
		this.languageIds = languageIds;
	}

	private Integer[] editionIds;

	public Integer[] getEditionIds() {
		return editionIds;
	}

	public void setEditionIds(Integer[] editionIds) {
		this.editionIds = editionIds;
	}

	private Integer kindId;

	public Integer getKindId() {
		return kindId;
	}

	public void setKindId(Integer kindId) {
		this.kindId = kindId;
	}
	
	private Integer editionId;

	public Integer getEditionId() {
		return editionId;
	}

	public void setEditionId(Integer editionId) {
		this.editionId = editionId;
	}
	
	private Integer languageId;

	public Integer getLanguageId() {
		return languageId;
	}

	public void setLanguageId(Integer languageId) {
		this.languageId = languageId;
	}

	/**
	 * 保存影片
	 * 
	 * @return
	 * @throws Exception
	 */
	public String saveMovie() throws Exception {
		FileProcessUitl util = new FileProcessUitl();
		String path = util.processFileUpload("/uploadMovie", upload,
				uploadFileName);
		movie.setMoviePhoto(path);

		movieService.create(movie, languageIds, editionIds, kindId);

		List<Movie> lstMovie = movieService.findAll();
		Map<String, Object> application = ActionContext.getContext()
				.getApplication();
		application.put("lstMovie", lstMovie);
		return searchMoviesByPage();
	}

	/**
	 * 分页显示正在热播和即将上映的影片
	 * 
	 * @return
	 * @throws Exception
	 */
	public String showBeforeAndAfterMovieByPageOnIndex() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();

		int beforeCurrentPage = 1;		
		int beforePageSize = 8;
	
		PageBean beforeMovieByPage = movieService.findBeforeByPage(
				beforeCurrentPage, beforePageSize);

		request.setAttribute("beforeMovieByPage", beforeMovieByPage);

		int afterCurrentPage = 1;
		int afterPageSize = 8;
		
		PageBean afterMovieByPage = movieService.findAfterByPage(
				afterCurrentPage, afterPageSize);
		request.setAttribute("afterMovieByPage", afterMovieByPage);

		return "index";
	}

	public String showBeforeAndAfterMovieByPageOnMovies() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();

		int beforeCurrentPage = 1;
		if (request.getParameter("beforeCurrentPage") != null) {
			beforeCurrentPage = Integer.parseInt(request.getParameter(
					"beforeCurrentPage").toString());
		}

		int beforePageSize = 8;
		if (request.getParameter("beforePageSize") != null) {
			beforePageSize = Integer.parseInt(request.getParameter(
					"beforePageSize").toString());
		}
		PageBean beforeMovieByPage = movieService.findBeforeByPage(
				beforeCurrentPage, beforePageSize);

		request.setAttribute("beforeMovieByPage", beforeMovieByPage);

		int afterCurrentPage = 1;
		if (request.getParameter("afterCurrentPage") != null) {
			afterCurrentPage = Integer.parseInt(request.getParameter(
					"afterCurrentPage").toString());
		}

		int afterPageSize = 8;
		if (request.getParameter("afterPageSize") != null) {
			afterPageSize = Integer.parseInt(request.getParameter(
					"afterPageSize").toString());
		}
		PageBean afterMovieByPage = movieService.findAfterByPage(
				afterCurrentPage, afterPageSize);
		request.setAttribute("afterMovieByPage", afterMovieByPage);

		return "movies";
	}

	/**
	 * 模糊查询影片分页显示
	 * 
	 * @return
	 * @throws Exception
	 */
	public String searchMoviesByPage() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		if (request.getParameter("searchWord") != null) {
			movie.setMovieName(new String(request.getParameter("searchWord")
					.toString().trim().getBytes("ISO8859-1"), "UTF-8"));
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
		PageBean searchMoviesByPage = movieService.searchByPage(movie,
				new String[] { "movieName" }, currentPage, pageSize);

		request.setAttribute("searchMoviesByPage", searchMoviesByPage);
		request.setAttribute("searchWord", movie.getMovieName());
		return "showMovies";
	}

	/**
	 * 删除影片
	 * 
	 * @return
	 * @throws Exception
	 */
	public String removeMovie() throws Exception {
		movieService.remove(movie);

		List<Movie> lstMovie = movieService.findAll();
		Map<String, Object> application = ActionContext.getContext()
				.getApplication();
		application.put("lstMovie", lstMovie);

		return searchMoviesByPage();
	}

	/**
	 * 显示要修改的影片
	 * 
	 * @return
	 * @throws Exception
	 */
	public String showMovie() throws Exception {

		HttpServletRequest request = ServletActionContext.getRequest();
		Movie oneMovie = movieService.findById(movie);

		List<Play> lstPlaies = new ArrayList<Play>();
		for (Play play : ((Set<Play>) oneMovie.getPlaies()) ) {
			lstPlaies.add(play);
		}
		Collections.sort(lstPlaies, new Comparator<Play>() {

			public int compare(Play play1, Play play2) {
				return play2.getPlayTime().compareTo(play1.getPlayTime());
			}
		});
		
		request.setAttribute("lstPlaies", lstPlaies);
		request.setAttribute("movie", oneMovie);
		return "updateMovie";
	}

	/**
	 * 修改影片信息
	 * 
	 * @return
	 * @throws Exception
	 */
	public String modifyMovie() throws Exception {
		FileProcessUitl util = new FileProcessUitl();
		String path = util.processFileUpload("/uploadMovie", upload,
				uploadFileName);
		movie.setMoviePhoto(path);
		movieService.modify(movie,editionId,kindId,languageId);
		return searchMoviesByPage();
	}

	/**
	 * 根据Id查询影片
	 * 
	 * @throws Exception
	 */
	public void findMovieById() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(movieService.findById(movie).getMovieLong());
	}
	
	/**
	 * JSON查正在热播
	 * @throws Exception
	 */
	public void findBeforeByPageByJson() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		int beforeCurrentPage = 1;
		if (request.getParameter("beforeCurrentPage") != null) {
			beforeCurrentPage = Integer.parseInt(request.getParameter(
					"beforeCurrentPage").toString());
		}

		int beforePageSize = 8;
		if (request.getParameter("beforePageSize") != null) {
			beforePageSize = Integer.parseInt(request.getParameter(
					"beforePageSize").toString());
		}
		
		PageBean beforeMovieByPageByJson = movieService.findBeforeByPageByJson(beforeCurrentPage, beforePageSize);
	
		JSONArray array=JSONArray.fromObject(beforeMovieByPageByJson);

		out.print(array.toString());
		out.flush();
		out.close();
	}
	
	/**
	 * JSON查即将上映
	 * @throws Exception
	 */
	public void findAfterByPageByJson() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		int afterCurrentPage = 1;
		if (request.getParameter("afterCurrentPage") != null) {
			afterCurrentPage = Integer.parseInt(request.getParameter(
					"afterCurrentPage").toString());
		}

		int afterPageSize = 8;
		if (request.getParameter("afterPageSize") != null) {
			afterPageSize = Integer.parseInt(request.getParameter(
					"afterPageSize").toString());
		}
		
		PageBean afterMovieByPageByJson = movieService.findAfterByPageByJson(afterCurrentPage, afterPageSize);
		JSONArray array=JSONArray.fromObject(afterMovieByPageByJson);
		out.print(array.toString());
		out.flush();
		out.close();
	}
}
