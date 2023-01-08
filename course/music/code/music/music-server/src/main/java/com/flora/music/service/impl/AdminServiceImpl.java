package com.flora.music.service.impl;

import com.flora.music.dao.AdminMapper;
import com.flora.music.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author qinxiang
 * @Date 2022/12/29-下午11:05
 * 管理员service实现类
 */
@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private AdminMapper adminMapper;
    /**
     * 验证密码是否正确
     *
     * @param username
     * @param password
     * @return
     */
    @Override
    public boolean verifyPassword(String username, String password) {
        return adminMapper.verifyPassword(username, password)>0;
    }
}
