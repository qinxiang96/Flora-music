package com.flora.music.service;

/**
 * @Author qinxiang
 * @Date 2022/12/29-下午11:03
 * 管理员service接口
 */
public interface AdminService {
    /**
     * 验证密码是否正确
     * @param username
     * @param password
     * @return
     */
    public boolean verifyPassword(String username, String password);
}
