package com.pwk.tools;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.imageio.*;
import javax.imageio.plugins.jpeg.JPEGImageWriteParam;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.io.*;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 14-1-22
 * Time: 下午8:19
 * To change this template use File | Settings | File Templates.
 */

public class CompressPic {

    private static final Logger LOG = LogManager.getLogger(CompressPic.class.getName());

    /**
     * 按照指定质量压缩图片
     *
     * @param srcPath
     * @param quality
     * @return
     */
    public static boolean compress(File srcPath, float quality) {
        BufferedImage src = null;
        FileOutputStream out = null;
        try {
            ImageWriter imageWriter;
            ImageWriteParam imageWriteParam;

            imageWriter = ImageIO.getImageWritersByFormatName("jpg").next();
            imageWriteParam = new JPEGImageWriteParam(null);

            imageWriteParam.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
            imageWriteParam.setCompressionQuality(quality);
            imageWriteParam.setProgressiveMode(ImageWriteParam.MODE_DISABLED);

            ColorModel colorModel = ColorModel.getRGBdefault();

            imageWriteParam.setDestinationType(new ImageTypeSpecifier(colorModel, colorModel.createCompatibleSampleModel(32, 32)));

            if (srcPath != null) {
                src = ImageIO.read(srcPath);
                File destPath = new File(srcPath.getParent(), srcPath.getName().split("\\.")[0] + "(min)." + getFileName(srcPath.getName()));
                out = new FileOutputStream(destPath);

                imageWriter.reset();
                imageWriter.setOutput(ImageIO.createImageOutputStream(out));

                imageWriter.write(null, new IIOImage(src, null, null), imageWriteParam);
                LOG.info("图片压缩成功！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            LOG.error("图片压缩失败！");
            return false;
        } finally {
            try {
                out.flush();
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return true;
    }

    private static String getFileName(String file) {
        if (StringUtils.isNotBlank(file)) {
            int dot = file.lastIndexOf('.');
            if ((dot > -1) && (dot < (file.length() - 1))) {
                return file.substring(dot + 1);
            }
        }
        return null;
    }

    /**
     * 指定固定宽度，按照长宽比例压缩图片
     *
     * @param srcFile
     * @param type
     * @return
     */
    public static String compress(File srcFile, String type) {
        String destPath = null;
        try {
            destPath = srcFile.getPath().split("\\.")[0] + "(min)." + getFileName(srcFile.getName());
            if (!srcFile.exists()) {
                LOG.error("压缩图片：图片文件不存在!");
                throw new Exception("压缩图片：图片文件不存在");
            }
            Image image = ImageIO.read(srcFile);
            // 判断图片格式是否正确
            if (image.getWidth(null) == -1) {
                LOG.error("压缩图片：图片格式不正确!");
                throw new Exception("压缩图片：图片格式不正确");
            }
            Map<String, Long> map = getImgInfo(srcFile);
            BigDecimal oldWidth = new BigDecimal(map.get("width"));
            BigDecimal oldHeight = new BigDecimal(map.get("height"));
            BigDecimal newWidth = null;
            BigDecimal newHeight = null;
            if (StringUtils.equals(type, "service")) {
                newWidth = new BigDecimal("357");
                newHeight = new BigDecimal("311");
            } else if (StringUtils.equals(type, "case")) {
                newWidth = new BigDecimal("260");
                newHeight = new BigDecimal("147");
            }else {
                LOG.error("压缩图片：无法获取图片信息");
                throw new Exception("压缩图片：无法获取图片信息");
            }
            LOG.info("压缩图片：type="+type+"   height("+oldHeight+"->"+newHeight+")  width("+oldWidth+"->"+newWidth+")");

            BufferedImage tag = new BufferedImage(newWidth.intValue(), newHeight.intValue(), BufferedImage.TYPE_INT_RGB);
            tag.getGraphics().drawImage(image.getScaledInstance(newWidth.intValue(), newHeight.intValue(), Image.SCALE_SMOOTH), 0, 0, null);
            FileOutputStream out = new FileOutputStream(destPath);
            JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
            encoder.encode(tag);
            out.close();

            LOG.info("图片压缩成功！ "+destPath);
        } catch (Exception e) {
            LOG.error("图片压缩异常！");
            e.printStackTrace();
        }
        return srcFile.getName().split("\\.")[0] + "(min)." + getFileName(srcFile.getName());
    }

    /**
     * 获取图片宽度，高度，大小
     *
     * @param imgfile
     * @return
     */
    private static Map<String, Long> getImgInfo(File imgfile) {
        Map<String, Long> map = new HashMap<String, Long>(3);
        try {
            FileInputStream fis = new FileInputStream(imgfile);
            BufferedImage buff = ImageIO.read(imgfile);
            map.put("width", buff.getWidth() * 1L);
            map.put("height", buff.getHeight() * 1L);
            map.put("size", imgfile.length());
            fis.close();
        } catch (FileNotFoundException e) {
            LOG.error("所给的图片文件" + imgfile.getPath() + "不存在！计算图片尺寸大小信息失败！");
            map = null;
        } catch (IOException e) {
            LOG.error("计算图片" + imgfile.getPath() + "尺寸大小信息失败！");
            map = null;
        }
        return map;
    }

}
