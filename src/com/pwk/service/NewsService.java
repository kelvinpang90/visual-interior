package com.pwk.service;

import com.pwk.entity.News;

import java.util.List;

/**
 * Created by pwk on 3/1/2016.
 */
public interface NewsService {
    public void add(News news);
    public void update(News news);
    public void delete(int id);

    public News getById(int id);

    public List<News> getByList(int page,int size);

    public int getTotal();
}
