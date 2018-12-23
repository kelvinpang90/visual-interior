package com.pwk.action;

import com.pwk.action.base.BaseAction;
import com.pwk.entity.Admin;
import com.pwk.service.AdminService;
import com.pwk.tools.DigestTool;
import com.pwk.tools.Message;
import org.apache.commons.lang.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-25
 * Time: 下午6:45
 * To change this template use File | Settings | File Templates.
 */
public class AdminAction extends BaseAction {

    @Resource
    private AdminService adminService;

    private static final Logger LOG = LogManager.getLogger(AdminAction.class.getName());

    public String initiative() throws Exception {
        Admin admin = null;
        try {
            adminService.getUniqueAdmin();
        }catch (Exception e){
            admin = new Admin();
            admin.setLoginName("admin");
            admin.setPassword(DigestTool.digest("123456"));
            adminService.add(admin);
            LOG.info("admin初始化成功！");
        }
        return null;
    }
    public String changePassword() {
        try {
            Admin admin = (Admin) getSession().getAttribute("admin");
            int id = admin.getId();
            String oldPassword = getRequest().getParameter("oldPassword");
            String newPassword = getRequest().getParameter("newPassword");
            String newPassword1 = getRequest().getParameter("newPassword1");
            if (!StringUtils.equals(newPassword, newPassword1)) {
                Message.returnMessage("新密码不一致！", "", "err", getResponse());
                return null;
            }

            if (!StringUtils.equals(DigestTool.digest(oldPassword), admin.getPassword())) {
                Message.returnMessage("旧密码不正确！", "", "err", getResponse());
                return null;
            }
            adminService.changePassword(id, DigestTool.digest(newPassword));
            LOG.info("admin修改密码成功！");
            Message.returnMessage("修改密码成功！", "../login/index.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("admin修改密码异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String login() {
        try {
            String loginName = getRequest().getParameter("loginName");
            String password = getRequest().getParameter("password");
            Admin admin = adminService.login(loginName,DigestTool.digest(password));
            if (admin == null) {
                Message.returnMessage("账号或者密码错误！", "", "err", getResponse());
                return null;
            }
            getRequest().getSession().setAttribute("admin", admin);
            LOG.info("admin登录成功！");
            Message.returnMessage("", "../back/cases/newsList.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("admin登录异常！");
            e.printStackTrace();
        }
        return null;
    }

    public String loginOut() {
        try {
            getRequest().getSession().removeAttribute("admin");
            LOG.info("admin登出成功！");
            getResponse().sendRedirect("../login/index.jsp");
        } catch (Exception e) {
            LOG.error("admin登出成功！");
            e.printStackTrace();
        }
        return null;
    }

    public String reset() {
        try {
            adminService.changePassword(1,DigestTool.digest("123456"));
            LOG.info("admin重置密码成功！");
            Message.returnMessage("", "../login/index.jsp", "ok", getResponse());
        } catch (Exception e) {
            LOG.error("admin重置密码异常！");
            e.printStackTrace();
        }
        return null;
    }

}
