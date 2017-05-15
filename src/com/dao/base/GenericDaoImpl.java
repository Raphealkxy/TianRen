package com.dao.base;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;

import java.lang.reflect.Type;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Example;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.pojo.Movie;
import com.util.PageBean;

public class GenericDaoImpl<T, PK extends Serializable> extends
		HibernateDaoSupport implements IGenericDao<T, PK> {
	// 实体类类型(由构造方法自动赋值)
	private Class<T> entityClass;

	// 构造方法，根据实例类自动获取实体类类型
	public GenericDaoImpl() {
		this.entityClass = null;
		Class c = getClass();
		Type t = c.getGenericSuperclass();
		if (t instanceof ParameterizedType) {
			Type[] p = ((ParameterizedType) t).getActualTypeArguments();
			this.entityClass = (Class<T>) p[0];
		}
	}

	// -------------------- 基本检索、增加、修改、删除操作 --------------------
	// 根据主键获取实体。如果没有相应的实体，返回 null。
	public T selectById(PK id) {
		return getHibernateTemplate().get(entityClass, id);
	}

	// 获取全部实体
	public List<T> selectAll() {
		return (List<T>) getHibernateTemplate().loadAll(entityClass);
	}

	// 存储实体到数据库
	public void insert(T entity) {
		getHibernateTemplate().save(entity);
	}

	// 更新实体
	public void update(T entity) {
		getHibernateTemplate().update(entity);
	}

	// 删除指定的实体
	public void delete(T entity) {
		getHibernateTemplate().delete(entity);
	}

	// -------------------------------- Criteria ------------------------------

	// 创建与会话无关的检索标准
	public DetachedCriteria createDetachedCriteria() {
		return DetachedCriteria.forClass(this.entityClass);
	}

	// 创建与会话绑定的检索标准
	public Criteria createCriteria() {
		return this.createDetachedCriteria().getExecutableCriteria(
				this.getSession());
	}

	// 使用指定的实体及属性检索（满足除主键外属性＝实体值）数据
	// public List<T> selectEqualByEntity(T entity, String[] propertyNames) {
	// Criteria criteria = this.createCriteria();
	// Example exam = Example.create(entity);
	// exam.excludeZeroes();
	// String[] defPropertys = getSessionFactory().getClassMetadata(
	// entityClass).getPropertyNames();
	// for (String defProperty : defPropertys) {
	// int ii = 0;
	// for (ii = 0; ii < propertyNames.length; ++ii) {
	// if (defProperty.equals(propertyNames[ii])) {
	// criteria.addOrder(Order.asc(defProperty));
	// break;
	// }
	// }
	// if (ii == propertyNames.length) {
	// exam.excludeProperty(defProperty);
	// }
	// }
	// criteria.add(exam);
	// return (List<T>) criteria.list();
	// }

	// 使用指定的实体及属性检索（满足属性 like 串实体值）数据
	public PageBean selectLikeByEntityByPage(T entity, String[] propertyNames,int currentPage , int pageSize) {
		Criteria criteria = this.createCriteria();
		for (String property : propertyNames) {
			try {
				Object value = PropertyUtils.getProperty(entity, property);
				if (value instanceof String) {
					criteria.add(Restrictions.like(property, (String) value,
							MatchMode.ANYWHERE));
					criteria.addOrder(Order.asc(property));
				} 
//				else {
//					criteria.add(Restrictions.eq(property, value));
//					criteria.addOrder(Order.asc(property));
//				}
				criteria.setFirstResult((currentPage - 1) * pageSize);
				criteria.setMaxResults(pageSize);
			} catch (Exception ex) {
				// 忽略无效的检索参考数据。
			}
		}
		List<T> lstLikeEntity =(List<T>) criteria.list();
		
		Criteria criteria_totalRows = createCriteria();
		
		for (String property : propertyNames) {
			try {
				Object value = PropertyUtils.getProperty(entity, property);
				if (value instanceof String) {
					criteria_totalRows.add(Restrictions.like(property, (String) value,
							MatchMode.ANYWHERE));
				} 
			} catch (Exception ex) {
				// 忽略无效的检索参考数据。
			}
		}
		criteria_totalRows.setProjection(Projections.rowCount());
		
		int totalRows = Integer.parseInt(criteria_totalRows.uniqueResult()
				.toString());
		
		PageBean pageBean = new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(lstLikeEntity);

		return pageBean;
	}

	// 根据给定模型 查询类似于该持久化对象的数据
	public List<T> selectByExample(T entity) {
		Criteria criteria = this.createCriteria();
		criteria.add(Example.create(entity));
		return criteria.list();
	}
	
	//分页
	public PageBean selectByPage( int currentPage , int pageSize  ){
		Criteria criteria_data=createCriteria();
		criteria_data.setFirstResult((currentPage - 1) * pageSize);
		criteria_data.setMaxResults(pageSize);
		
		List<T> entityClass=criteria_data.list();
		
		Criteria criteria_totalRows=createCriteria();
		criteria_totalRows.setProjection(Projections.rowCount());
		int totalRows=Integer.parseInt(criteria_totalRows.uniqueResult().toString());
		
		PageBean pageBean=new PageBean();
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setTotalRows(totalRows);
		pageBean.setData(entityClass);
		
		return pageBean;		
	}
}
