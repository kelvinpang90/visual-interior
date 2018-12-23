package com.pwk.entity;


import javax.persistence.*;
import java.sql.Timestamp;

/**
 * Created by wenkai.peng on 9/19/2014.
 */
@Entity
@Table(name = "image",catalog = "visual_interior")
public class Image {

    private int id;

    private String type; //图片属于哪个栏目

    private int parentId;   //父类对应item的id

    private String path;     //保存路径

    private String miniPath;     //mini保存路径

    private Timestamp createTime;

    @Id
    @GeneratedValue
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "type")
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Column(name = "parent_id")
    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    @Column(name = "path")
    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    @Column(name = "mini_path")
    public String getMiniPath() {
        return miniPath;
    }

    public void setMiniPath(String miniPath) {
        this.miniPath = miniPath;
    }

    @Column(name = "create_time")
    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }
}
