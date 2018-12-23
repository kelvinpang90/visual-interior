package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Image;
import com.pwk.entity.News;
import com.pwk.service.ImageService;
import com.pwk.service.NewsService;
import com.pwk.tools.Message;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;

/**
 * Created by pwk on 3/1/2016.
 */
public class NewsAction extends BaseAction {

    @Resource
    private NewsService newsService;

    @Resource
    private ImageService imageService;

    private static final Logger LOG = LogManager.getLogger(CaseAction.class.getName());

    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public String add(){
        try {
            String title = getParameter("title");
            String content = getParameter("content");
            String time = getParameter("time");
            String picId = getParameter("picId");

            News news = new News();
            news.setTitle(title);
            news.setTime(time);
            news.setContent(content);
            Timestamp currentTime = Timestamp.valueOf(format.format(new Date()));
            news.setCreateTime(currentTime);
            news.setUpdateTime(currentTime);
            news.setStatus(1);
            newsService.add(news);

            Image image = imageService.getById(Integer.valueOf(picId));
            image.setParentId(news.getId());
            imageService.update(image);

            Message.returnMessage("增加新闻成功","../../back/news/newsList.jsp","ok",getResponse());
            LOG.info("增加新闻成功");
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String update(){
        try {
            String id = getParameter("id");
            String title = getParameter("title");
            String time = getParameter("time");
            String picId = getParameter("picId");
            String content = getParameter("content");

            News news = newsService.getById(Integer.valueOf(id));
            news.setTitle(title);
            news.setTime(time);
            news.setContent(content);
            Timestamp currentTime = Timestamp.valueOf(format.format(new Date()));
            news.setUpdateTime(currentTime);
            newsService.update(news);

            Iterator<Image> it = news.getImages().iterator();
            while(it.hasNext()){
                Image oldImage = it.next();
                if(oldImage.getId() != Integer.valueOf(picId)){
                    imageService.delete(oldImage.getId());
                    Image newImage = imageService.getById(Integer.valueOf(picId));
                    newImage.setParentId(Integer.valueOf(picId));
                    imageService.update(newImage);
                }
            }
            Message.returnMessage("修改新闻成功","../../back/news/newsList.jsp","ok",getResponse());
            LOG.info("修改新闻成功");
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String delete(){
        try {
            String id = getParameter("id");
            newsService.delete(Integer.valueOf(id));
            getResponse().sendRedirect("../../back/news/newsList.jsp");
            LOG.info("删除新闻成功");
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
