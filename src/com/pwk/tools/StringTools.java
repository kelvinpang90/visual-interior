package com.pwk.tools;

import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-1-19
 * Time: 下午9:27
 * To change this template use File | Settings | File Templates.
 */
public class StringTools {
    public static List<String> getPics(String pic){
        List<String> list = new ArrayList<String>();
        String[] pics = pic.split("###");
        for(String picture :pics){
            if(StringUtils.isBlank(StringUtils.trim(picture))||StringUtils.contains(picture,"#")){
                 continue;
            }else{
                list.add(picture);
            }
        }
        return  list;
    }
    public static List<String> getSmallPics(String pic){
        List<String> list = new ArrayList<String>();
        String[] pics = pic.split("###");
        for(String picture :pics){
            if(StringUtils.isBlank(StringUtils.trim(picture))||StringUtils.contains(picture,"#")){
                continue;
            }
            String filePath = getFilePath(pic)+"(min)."+getFileType(pic);
            System.out.println("压缩文件："+filePath);
            list.add(filePath);
        }
        return  list;
    }

    public static String getFileType(String file) {
        if (StringUtils.isNotBlank(file)) {
            int dot = file.lastIndexOf('.');
            if ((dot > -1) && (dot < (file.length() - 1))) {
                return file.substring(dot + 1);
            }
        }
        return null;
    }

    public static String getFilePath(String file) {
        if (StringUtils.isNotBlank(file)) {
            int dot = file.lastIndexOf('.');
            if ((dot > -1) && (dot < (file.length() - 1))) {
                return file.substring(dot);
            }
        }
        return null;
    }

    public static String getImageDir(){
        return "/opt/pic_bak";
    }
}
