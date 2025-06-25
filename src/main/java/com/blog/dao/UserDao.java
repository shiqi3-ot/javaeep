package com.blog.dao;

import com.blog.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户数据访问接口
 */
public interface UserDao {
    
    /**
     * 根据用户名查询用户
     */
    User findByUsername(@Param("username") String username);
    
    /**
     * 根据ID查询用户
     */
    User findById(@Param("id") Integer id);
    
    /**
     * 查询所有用户
     */
    List<User> findAll();
    
    /**
     * 分页查询用户
     */
    List<User> findByPage(@Param("offset") int offset, @Param("limit") int limit);
    
    /**
     * 统计用户总数
     */
    long countAll();
    
    /**
     * 插入用户
     */
    int insert(User user);
    
    /**
     * 更新用户
     */
    int update(User user);
    
    /**
     * 删除用户
     */
    int deleteById(@Param("id") Integer id);
    
    /**
     * 更新用户状态
     */
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);
}