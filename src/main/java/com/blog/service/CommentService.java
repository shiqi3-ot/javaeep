package com.blog.service;

import com.blog.entity.Comment;
import com.blog.util.PageInfo;

import java.util.List;

/**
 * 评论服务接口
 */
public interface CommentService {
    
    /**
     * 根据ID查询评论
     */
    Comment findById(Integer id);
    
    /**
     * 根据博客ID查询评论
     */
    List<Comment> findByBlogId(Integer blogId);
    
    /**
     * 查询顶级评论
     */
    List<Comment> findParentComments(Integer blogId);
    
    /**
     * 查询子评论
     */
    List<Comment> findReplies(Integer parentId);
    
    /**
     * 分页查询所有评论（管理员用）
     */
    PageInfo<Comment> findByPage(int pageNum, int pageSize);
    
    /**
     * 添加评论
     */
    boolean addComment(Comment comment);
    
    /**
     * 更新评论
     */
    boolean updateComment(Comment comment);
    
    /**
     * 删除评论
     */
    boolean deleteComment(Integer id);
    
    /**
     * 更新评论状态
     */
    boolean updateCommentStatus(Integer id, Integer status);
}