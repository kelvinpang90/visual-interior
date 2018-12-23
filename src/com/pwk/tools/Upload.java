package com.pwk.tools;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import net.sf.json.JSONObject;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.List;

/**
 * Created by Administrator on 14-1-13.
 */
public class Upload {

    public static JSONObject uploadPics(HttpServletRequest request,List<File> files,List<String> names, String path, float compressQuality,String type) {
        try {
            if (ServletFileUpload.isMultipartContent(request)) {
                String uploadPath = request.getSession().getServletContext().getRealPath("/") + path;
                File uploadFile = new File(uploadPath);
                if (!uploadFile.exists()) {
                    uploadFile.mkdirs();
                }
                JSONObject returnObject = new JSONObject();
                for(int i = 0;i < files.size();i++){
                    File file = files.get(i);
                    String format = StringTools.getFileType(names.get(i));
                    File newFile = new File(uploadPath, String.valueOf(System.currentTimeMillis()) + "." + format );
                    FileUtils.copyFile(file,newFile);
                    returnObject.put("pic",path + "/" + newFile.getName());
                    returnObject.put("miniPic",path + "/" + newFile.getName());
                }
                return returnObject;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     *
     * @param temp 源文件路径
     * @param width
     * @param height
     * @param per 质量百分比
     */
    private static void toSmallerImage(File temp, int width, int height,float per){
        try {
            Image src = ImageIO.read(temp);
            int old_w=src.getWidth(null); //得到源图宽
            int old_h=src.getHeight(null);   //得到源图长

            int new_w=0;
            int new_h=0;
            double w2=(old_w*1.00)/(width*1.00);    //w2:原图宽/目标图宽
            double h2=(old_h*1.00)/(height*1.00);  //h2:原图高/目标图高

            //图片跟据长宽留白，成一个正方形图。
            BufferedImage oldPic;
            if(old_w>old_h)
            {
                oldPic=new BufferedImage(old_w,old_w,BufferedImage.TYPE_INT_RGB);
            }else {
                if (old_w < old_h) {
                    oldPic = new BufferedImage(old_h, old_h, BufferedImage.TYPE_INT_RGB);
                } else {
                    oldPic = new BufferedImage(old_w, old_h, BufferedImage.TYPE_INT_RGB);
                }
            }

            Graphics2D g = oldPic.createGraphics();
            g.setColor(Color.white);

            if(old_w>old_h)
            {
                g.fillRect(0, 0, old_w, old_w);
                g.drawImage(src, 0, (old_w - old_h) / 2, old_w, old_h, Color.white, null);
            }else{
                if(old_w<old_h){
                    g.fillRect(0,0,old_h,old_h);
                    g.drawImage(src, (old_h - old_w) / 2, 0, old_w, old_h, Color.white, null);
                }else{
                    g.drawImage(src.getScaledInstance(old_w, old_h,  Image.SCALE_SMOOTH), 0,0,null);
                }
            }
            g.dispose();
            src = oldPic; //图片调整为方形结束

            if(old_w>width)
                new_w=(int)Math.round(old_w/w2);   //new_w 原图宽/w2
            else
                new_w=old_w;
            if(old_h>height)
                new_h=(int)Math.round(old_h/h2);//计算新图长宽  //new_h 原图高/h2
            else
                new_h=old_h;

            BufferedImage tag = new BufferedImage(new_w,new_h,BufferedImage.TYPE_INT_RGB);
            tag.getGraphics().drawImage(src.getScaledInstance(new_w, new_h,  Image.SCALE_SMOOTH), 0,0,null);
            File destFile = new File(temp.getParent()+"/mini/");
            if(!destFile.exists())
                destFile.mkdirs();
            FileOutputStream newImage=new FileOutputStream(new File(destFile,temp.getName()));
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newImage);

             /* compression quality */
            encoder.encode(tag);

            newImage.flush();
            newImage.close();

            //watermark
//            WaterMark.markImage(new File(destFile,temp.getName()), new File("/opt/pic_bak/", "watermark.png"), 0.8f, WaterMark.MARK_RIGHT_BOTTOM);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    private static void resizeImage(File temp,File newFile, int width, int height, String format) throws IOException {
        Image src = ImageIO.read(temp);
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
        OutputStream os = new FileOutputStream(newFile);
        image.getGraphics().drawImage(src, 0, 0, width, height, null);
        JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
        encoder.encode(image);
        os.flush();
        os.close();
    }
    /**
     * 异步上传后返回数据的方法
     * @param request
     * @param response
     * @param returnObject
     */
    public static void returnAjaxUpload(HttpServletRequest request, HttpServletResponse response,String returnObject){
        try {
            response.setContentType("text/xml;charset=UTF-8");
            response.setHeader("Cache-Control", "no-cache");
            PrintWriter out = response.getWriter();
            String callback = request.getParameter("CKEditorFuncNum");
            if(StringUtils.isNotBlank(callback)){
                out.println("<script type='text/javascript'>");
                out.println("window.parent.CKEDITOR.tools.callFunction("+ callback + ",'/"+ returnObject + "','')");
                out.println("</script>");
            }else{
                out.print(returnObject);
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }


}
