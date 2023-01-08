package com.flora.music.dao;

import org.springframework.stereotype.Repository;

/**
 * @Author qinxiang
 * @Date 2022/12/29-下午10:56
 * 管理员Dao
 */
@Repository
public interface AdminMapper {
    /**
     * 验证密码是否正确
     */
    public int verifyPassword(String username, String password);

}
