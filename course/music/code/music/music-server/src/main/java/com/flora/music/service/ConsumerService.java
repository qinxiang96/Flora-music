package com.flora.music.service;

import com.flora.music.domain.Consumer;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2023/1/2-下午6:18
 */
public interface ConsumerService {
    /**
     * 增加
     * @param consumer
     * @return
     */
    public boolean insert(Consumer consumer);

    /**
     * 更新
     * @param consumer
     * @return
     */
    public boolean update(Consumer consumer);

    /**
     * 删除
     * @param id
     * @return
     */
    public boolean delete(Integer id);

    /**
     * 根据主键查询整个对象
     * @param id
     * @return
     */
    public Consumer selectByPrimaryKey(Integer id);

    /**
     * 查询所有用户
     * @return
     */
    public List<Consumer> allConsumer();

    /**
     * 根据账号查询列表
     * @param username
     * @return
     */
    public List<Consumer> selectByUsername(String username);

    /**
     * 验证密码
     * @param username,password
     * @return
     */
    public boolean verifyPassword(String username, String password);
}
