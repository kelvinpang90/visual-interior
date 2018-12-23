package com.pwk.service;

import com.pwk.entity.Admin;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-10-25
 * Time: 下午6:47
 * To change this template use File | Settings | File Templates.
 */
public interface AdminService {
    public void add(Admin admin);
    public void update(Admin admin);
    public void changePassword(int id, String password);
    public int findAdmin(int id, String password) throws Exception;
    public Admin login(String loginName, String password);
    public Admin getUniqueAdmin();
    public Admin getUniqueAdminInfo();
}
