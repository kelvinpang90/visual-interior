package com.pwk.tools;

import com.pwk.service.AdminService;
import com.pwk.service.CaseService;
import com.pwk.service.ImageService;
import com.pwk.service.NewsService;

public class Engine {
    public static AdminService adminService;
    public static CaseService caseService;
    public static ImageService imageService;
    public static NewsService newsService;

    public void setAdminService(AdminService adminService) {
        Engine.adminService = adminService;
    }

    public void setCaseService(CaseService caseService) {
        Engine.caseService = caseService;
    }

    public void setImageService(ImageService imageService) {
        Engine.imageService = imageService;
    }

    public void setNewsService(NewsService newsService) {
        Engine.newsService = newsService;
    }
}
