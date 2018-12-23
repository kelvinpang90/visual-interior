package com.pwk.taglib;

import com.pwk.entity.News;
import com.pwk.tools.Engine;

import java.util.List;

/**
 * Created by pwk on 3/1/2016.
 */
public class NewsFunction {

    public static News getById(int id){
        return Engine.newsService.getById(id);
    }

    public static List<News> getByList(int page,int size){
        return Engine.newsService.getByList(page,size);
    }

    public static int getTotal(){
        return Engine.newsService.getTotal();
    }
}
