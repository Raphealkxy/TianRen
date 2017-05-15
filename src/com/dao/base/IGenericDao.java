package com.dao.base;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;

import com.util.PageBean;

public interface IGenericDao<T, PK extends Serializable> {

	// -------------------- 基本检索、增加、修改、删除操作 --------------------

	// 根据主键获取实体。如果没有相应的实体，返回 null。
	public abstract T selectById(PK id);

	// 获取全部实体
	public abstract List<T> selectAll();

	// 存储实体到数据库
	public abstract void insert(T entity);

	// 更新实体
	public abstract void update(T entity);

	// 删除指定的实体
	public abstract void delete(T entity);

	// -------------------------------- Criteria ------------------------------

	// 创建与会话无关的检索标准对象
	public DetachedCriteria createDetachedCriteria();

	// 创建与会话绑定的检索标准对象
	public Criteria createCriteria();

	// 使用指定的实体及属性检索（满足除主键外属性＝实体值）数据
	//public List<T> selectEqualByEntity(T entity, String[] propertyNames);

	// 使用指定的实体及属性(非主键)检索（满足属性 like 串实体值）数据
	public PageBean selectLikeByEntityByPage(T entity, String[] propertyNames,int currentPage , int pageSize);
	
	//根据给定模型  查询类似于该持久化对象的数据
	public List<T> selectByExample(T entity);

	//分页
	public PageBean selectByPage( int currentPage , int pageSize  );
}
