package com.blog.dao;

import com.blog.entity.Comment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 评论数据访问接口
 */
public interface CommentDao {
    
    /**
     * 根据ID查询评论
     */
    Comment findById(@Param("id") Integer id);
    
    /**
     * 根据博客ID查询评论
     */
    List<Comment> findByBlogId(@Param("blogId") Integer blogId);
    
    /**
     * 查询顶级评论（父评论）
     */
    List<Comment> findParentComments(@Param("blogId") Integer blogId);
    
    /**
     * 查询子评论
     */
    List<Comment> findReplies(@Param("parentId") Integer parentId);
    
    /**
     * 分页查询所有评论（管理员用）
     */
    List<Comment> findByPage(@Param("offset") int offset, @Param("limit") int limit);
    
    /**
     * 统计博客评论数量
     */
    long countByBlogId(@Param("blogId") Integer blogId);
    
    /**
     * 统计所有评论数量
     */
    long countAll();
    
    /**
     * 插入评论
     */
    int insert(Comment comment);
    
    /**
     * 更新评论
     */
    int update(Comment comment);
    
    /**
     * 删除评论
     */
    int deleteById(@Param("id") Integer id);
    
    /**
     * 更新评论状态
     */
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);
}