package com.blog.service;

import com.blog.entity.Message;
import com.blog.util.PageInfo;

import java.util.List;

/**
 * 留言服务接口
 */
public interface MessageService {
    
    /**
     * 根据ID查询留言
     */
    Message findById(Integer id);
    
    /**
     * 查询所有留言
     */
    List<Message> findAll();
    
    /**
     * 分页查询留言
     */
    PageInfo<Message> findByPage(int pageNum, int pageSize);
    
    /**
     * 查询未回复的留言
     */
    List<Message> findUnreplied();
    
    /**
     * 添加留言
     */
    boolean addMessage(Message message);
    
    /**
     * 更新留言
     */
    boolean updateMessage(Message message);
    
    /**
     * 删除留言
     */
    boolean deleteMessage(Integer id);
    
    /**
     * 回复留言
     */
    boolean replyMessage(Integer id, String replyContent);
    
    /**
     * 更新留言状态
     */
    boolean updateMessageStatus(Integer id, Integer status);
}