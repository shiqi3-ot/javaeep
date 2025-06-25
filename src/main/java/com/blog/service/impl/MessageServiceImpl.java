package com.blog.service.impl;

import com.blog.dao.MessageDao;
import com.blog.entity.Message;
import com.blog.service.MessageService;
import com.blog.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 留言服务实现类
 */
@Service
@Transactional
public class MessageServiceImpl implements MessageService {
    
    @Autowired
    private MessageDao messageDao;
    
    @Override
    public Message findById(Integer id) {
        return messageDao.findById(id);
    }
    
    @Override
    public List<Message> findAll() {
        return messageDao.findAll();
    }
    
    @Override
    public PageInfo<Message> findByPage(int pageNum, int pageSize) {
        int offset = (pageNum - 1) * pageSize;
        List<Message> messages = messageDao.findByPage(offset, pageSize);
        long total = messageDao.countAll();
        return new PageInfo<>(pageNum, pageSize, total, messages);
    }
    
    @Override
    public List<Message> findUnreplied() {
        return messageDao.findUnreplied();
    }
    
    @Override
    public boolean addMessage(Message message) {
        // 设置默认值
        if (message.getStatus() == null) {
            message.setStatus(1); // 默认显示
        }
        if (message.getIsReplied() == null) {
            message.setIsReplied(0); // 默认未回复
        }
        
        return messageDao.insert(message) > 0;
    }
    
    @Override
    public boolean updateMessage(Message message) {
        return messageDao.update(message) > 0;
    }
    
    @Override
    public boolean deleteMessage(Integer id) {
        return messageDao.deleteById(id) > 0;
    }
    
    @Override
    public boolean replyMessage(Integer id, String replyContent) {
        return messageDao.reply(id, replyContent) > 0;
    }
    
    @Override
    public boolean updateMessageStatus(Integer id, Integer status) {
        return messageDao.updateStatus(id, status) > 0;
    }
}