package com.pwk.entity;

import org.hibernate.annotations.IndexColumn;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * Created by wenkai.peng on 10/23/2014.
 */
@Entity
@Table(name = "case", catalog = "visual_interior")
public class Case {

    private int id;

    private String title;

    private String description;

    private String status;

    private Timestamp createDate;


    @OneToMany(targetEntity = Image.class,fetch = FetchType.EAGER,mappedBy = "case",cascade = CascadeType.ALL)
    private Set<Image> images = new HashSet<Image>();

    @Id
    @GeneratedValue
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Column(name = "title")
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "create_date")
    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public Set<Image> getImages() {
        return images;
    }

    public void setImages(Set<Image> images) {
        this.images = images;
    }
}
