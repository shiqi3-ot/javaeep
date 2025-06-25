package com.blog.service.impl;

import com.blog.dao.CommentDao;
import com.blog.entity.Comment;
import com.blog.service.BlogService;
import com.blog.service.CommentService;
import com.blog.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 评论服务实现类
 */
@Service
@Transactional
public class CommentServiceImpl implements CommentService {
    
    @Autowired
    private CommentDao commentDao;
    
    @Autowired
    private BlogService blogService;
    
    @Override
    public Comment findById(Integer id) {
        return commentDao.findById(id);
    }
    
    @Override
    public List<Comment> findByBlogId(Integer blogId) {
        return commentDao.findByBlogId(blogId);
    }
    
    @Override
    public List<Comment> findParentComments(Integer blogId) {
        List<Comment> parentComments = commentDao.findParentComments(blogId);
        // 为每个父评论加载子评论
        for (Comment comment : parentComments) {
            List<Comment> replies = commentDao.findReplies(comment.getId());
            comment.setReplies(replies);
        }
        return parentComments;
    }
    
    @Override
    public List<Comment> findReplies(Integer parentId) {
        return commentDao.findReplies(parentId);
    }
    
    @Override
    public PageInfo<Comment> findByPage(int pageNum, int pageSize) {
        int offset = (pageNum - 1) * pageSize;
        List<Comment> comments = commentDao.findByPage(offset, pageSize);
        long total = commentDao.countAll();
        return new PageInfo<>(pageNum, pageSize, total, comments);
    }
    
    @Override
    public boolean addComment(Comment comment) {
        // 设置默认值
        if (comment.getStatus() == null) {
            comment.setStatus(1); // 默认显示
        }
        if (comment.getParentId() == null) {
            comment.setParentId(0); // 默认为顶级评论
        }
        
        boolean result = commentDao.insert(comment) > 0;
        
        // 更新博客评论数量
        if (result && comment.getBlogId() != null) {
            blogService.updateCommentCount(comment.getBlogId());
        }
        
        return result;
    }
    
    @Override
    public boolean updateComment(Comment comment) {
        return commentDao.update(comment) > 0;
    }
    
    @Override
    public boolean deleteComment(Integer id) {
        Comment comment = commentDao.findById(id);
        boolean result = commentDao.deleteById(id) > 0;
        
        // 更新博客评论数量
        if (result && comment != null && comment.getBlogId() != null) {
            blogService.updateCommentCount(comment.getBlogId());
        }
        
        return result;
    }
    
    @Override
    public boolean updateCommentStatus(Integer id, Integer status) {
        return commentDao.updateStatus(id, status) > 0;
    }
}