package com.flora.music.dao;

import com.flora.music.domain.Consumer;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @Author qinxiang
 * @Date 2022/12/30-下午1:48
 * 用户Dao
 */
@Repository
public interface ConsumerMapper {
    /**
     * 增加
     * @param consumer
     * @return
     */
    public int insert(Consumer consumer);

    /**
     * 更新
     * @param consumer
     * @return
     */
    public int update(Consumer consumer);

    /**
     * 删除
     * @param id
     * @return
     */
    public int delete(Integer id);

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
    public int verifyPassword(String username, String password);
}
