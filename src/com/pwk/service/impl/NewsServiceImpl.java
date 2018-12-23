package com.pwk.service.impl;

import com.pwk.entity.News;
import com.pwk.service.NewsService;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by pwk on 3/1/2016.
 */
@Transactional
public class NewsServiceImpl implements NewsService {

    @Resource
    private SessionFactory sessionFactory;

    @Override
    public void add(News news) {
        sessionFactory.getCurrentSession().save(news);
    }

    @Override
    public void update(News news) {
        sessionFactory.getCurrentSession().update(news);
    }

    @Override
    public void delete(int id) {
        sessionFactory.getCurrentSession().delete(this.getById(id));
    }

    @Override
    public News getById(int id) {
        return (News)sessionFactory.getCurrentSession().get(News.class,id);
    }

    @Override
    public List<News> getByList(int page, int size) {
        Query query = sessionFactory.getCurrentSession().createQuery(" from News ");
        if (page != 0 && size != 0) {
            query.setFirstResult(size * (page - 1));
            query.setMaxResults(size);
        }
        return query.list();
    }

    @Override
    public int getTotal() {
        return sessionFactory.getCurrentSession().createQuery(" from News ").list().size();
    }
}
