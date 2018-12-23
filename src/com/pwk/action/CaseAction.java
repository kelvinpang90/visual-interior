package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Case;
import com.pwk.entity.Image;
import com.pwk.service.CaseService;
import com.pwk.service.ImageService;
import com.pwk.tools.Message;
import com.pwk.tools.StringTools;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * Created by wenkai.peng on 10/23/2014.
 */
public class CaseAction extends BaseAction {

    @Resource
    private CaseService caseService;
    @Resource
    private ImageService imageService;

    private static final Logger LOG = LogManager.getLogger(CaseAction.class.getName());
    
    SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public String add(){
        try {
            String title = getRequest().getParameter("title");
            String[] picIds = getRequest().getParameterValues("picId");
            String description = getRequest().getParameter("description");
            Case cases = new Case();
            cases.setTitle(title);
            cases.setDescription(description);
            cases.setCreateDate(Timestamp.valueOf(format.format(new Date())));
            cases.setStatus("1");
            caseService.add(cases);

            //image
            for (String picId : picIds) {
                if (StringUtils.isNotBlank(picId)) {
                    Image image = imageService.getById(Integer.valueOf(picId));
                    image.setParentId(cases.getId());
                    image.setType("case");
                    imageService.update(image);
                }
            }

            Message.returnMessage("增加案例成功","../../back/cases/caseList.jsp","ok",getResponse());
            LOG.info("增加案例成功");
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String delete(){
        try {
            String id = getRequest().getParameter("id");
            caseService.delete(Integer.valueOf(id));
            getResponse().sendRedirect("../../back/cases/caseList.jsp");
            LOG.info("删除案例成功");
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String update(){
        try {
            String id = getRequest().getParameter("id");
            String title = getRequest().getParameter("title");
            String[] newPicIds = getRequest().getParameterValues("picId");
            String description = getRequest().getParameter("description");
            Case cases = caseService.getById(Integer.valueOf(id));
            cases.setTitle(title);
            cases.setDescription(description);
            cases.setCreateDate(Timestamp.valueOf(format.format(new Date())));

            Set<Image> images = cases.getImages();

            //删除旧图片
            Iterator<Image> oldImages = images.iterator();
            while (oldImages.hasNext()){
                boolean flag = false;
                Image oldImage = oldImages.next();
                for(String newPic:newPicIds){
                    if(oldImage.getId() == Integer.valueOf(newPic)){
                        flag = true;
                    }
                }
                if (!flag){
                    imageService.delete(oldImage.getId());
//                    cases.getImages().remove(oldImage);
                }
            }
            //添加新图片
            for(String newIds:newPicIds){
                Image newImage = imageService.getById(Integer.valueOf(newIds));
                newImage.setParentId(Integer.valueOf(id));
                newImage.setType("case");
                cases.getImages().add(newImage);
            }

            caseService.update(cases);
            Message.returnMessage("修改案例成功","../../back/cases/caseList.jsp","ok",getResponse());
            LOG.info("修改案例成功");
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public String loadMore(){
        try{
            String count = getParameter("count");
            List<Case> caseList = caseService.getByList(Integer.valueOf(count),5);
            String str = "";
            for(Case cases:caseList){
                str+="<div class='case_pic'>";
                str+="<div class='l_pic'>";
                Iterator<Image> imageIterator = cases.getImages().iterator();
                str+="<a href='/case_"+cases.getId()+".html' target='_blank'>";
                str+="<img src='/"+imageIterator.next().getPath()+"' width='701' height='438' />";
                str+="</a>";
                str+="</div>";
                str+="<div class='r_con'>";
                str+="<div class='title'><a href='/case_"+cases.getId()+".html' target='_blank' style='padding-bottom: 5px;border-bottom: 2px solid #000;'>"+cases.getTitle()+"</a></div>";
                str+="<div class='jianshu'  style='display: table-cell;vertical-align:middle;text-align: center;'><span style='display:inline-block;vertical-align:middle;'>"+(cases.getDescription().length()>150?(cases.getDescription().substring(0,150)+"..."):cases.getDescription())+"</span></div>";
                str+="<a href='/case_"+cases.getId()+".html' class='detail' target='_blank'>案例详情</a>";
                str+="</div>";
                str+="<div class='clear'></div>";
                str+="</div>";
            }
            getRequest().setCharacterEncoding("utf-8");  //这里不设置编码会有乱码
            getResponse().setContentType("text/html;charset=utf-8");
            getResponse().setHeader("Cache-Control", "no-cache");
            getResponse().getWriter().append(str);
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
