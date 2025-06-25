package com.blog.service.impl;

import com.blog.dao.UserDao;
import com.blog.entity.User;
import com.blog.service.UserService;
import com.blog.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 用户服务实现类
 */
@Service
@Transactional
public class UserServiceImpl implements UserService {
    
    @Autowired
    private UserDao userDao;
    
    @Override
    public User login(String username, String password) {
        User user = userDao.findByUsername(username);
        if (user != null && user.getPassword().equals(password) && user.getStatus() == 1) {
            return user;
        }
        return null;
    }
    
    @Override
    public boolean register(User user) {
        // 检查用户名是否已存在
        if (isUsernameExists(user.getUsername())) {
            return false;
        }
        
        // 设置默认值
        if (user.getRole() == null) {
            user.setRole("user");
        }
        if (user.getStatus() == null) {
            user.setStatus(1);
        }
        
        return userDao.insert(user) > 0;
    }
    
    @Override
    public User findById(Integer id) {
        return userDao.findById(id);
    }
    
    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }
    
    @Override
    public PageInfo<User> findByPage(int pageNum, int pageSize) {
        int offset = (pageNum - 1) * pageSize;
        List<User> users = userDao.findByPage(offset, pageSize);
        long total = userDao.countAll();
        return new PageInfo<>(pageNum, pageSize, total, users);
    }
    
    @Override
    public boolean updateUser(User user) {
        return userDao.update(user) > 0;
    }
    
    @Override
    public boolean deleteUser(Integer id) {
        return userDao.deleteById(id) > 0;
    }
    
    @Override
    public boolean updateUserStatus(Integer id, Integer status) {
        return userDao.updateStatus(id, status) > 0;
    }
    
    @Override
    public boolean isUsernameExists(String username) {
        return userDao.findByUsername(username) != null;
    }
}