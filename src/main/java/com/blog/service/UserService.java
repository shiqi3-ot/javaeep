package com.blog.service;

import com.blog.entity.User;
import com.blog.util.PageInfo;

/**
 * 用户服务接口
 */
public interface UserService {
    
    /**
     * 用户登录
     */
    User login(String username, String password);
    
    /**
     * 用户注册
     */
    boolean register(User user);
    
    /**
     * 根据ID查询用户
     */
    User findById(Integer id);
    
    /**
     * 根据用户名查询用户
     */
    User findByUsername(String username);
    
    /**
     * 分页查询用户
     */
    PageInfo<User> findByPage(int pageNum, int pageSize);
    
    /**
     * 更新用户信息
     */
    boolean updateUser(User user);
    
    /**
     * 删除用户
     */
    boolean deleteUser(Integer id);
    
    /**
     * 更新用户状态
     */
    boolean updateUserStatus(Integer id, Integer status);
    
    /**
     * 检查用户名是否存在
     */
    boolean isUsernameExists(String username);
}