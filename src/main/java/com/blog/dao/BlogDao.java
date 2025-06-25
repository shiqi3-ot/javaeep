package com.blog.dao;

import com.blog.entity.Blog;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 博客数据访问接口
 */
public interface BlogDao {
    
    /**
     * 根据ID查询博客
     */
    Blog findById(@Param("id") Integer id);
    
    /**
     * 查询所有已发布的博客
     */
    List<Blog> findPublished();
    
    /**
     * 分页查询已发布的博客
     */
    List<Blog> findPublishedByPage(@Param("offset") int offset, @Param("limit") int limit);
    
    /**
     * 分页查询所有博客（管理员用）
     */
    List<Blog> findByPage(@Param("offset") int offset, @Param("limit") int limit);
    
    /**
     * 根据分类查询博客
     */
    List<Blog> findByCategoryId(@Param("categoryId") Integer categoryId);
    
    /**
     * 根据作者查询博客
     */
    List<Blog> findByAuthorId(@Param("authorId") Integer authorId);
    
    /**
     * 搜索博客（标题和内容）
     */
    List<Blog> searchBlogs(@Param("keyword") String keyword);
    
    /**
     * 统计已发布博客总数
     */
    long countPublished();
    
    /**
     * 统计所有博客总数
     */
    long countAll();
    
    /**
     * 插入博客
     */
    int insert(Blog blog);
    
    /**
     * 更新博客
     */
    int update(Blog blog);
    
    /**
     * 删除博客
     */
    int deleteById(@Param("id") Integer id);
    
    /**
     * 增加浏览次数
     */
    int incrementViewCount(@Param("id") Integer id);
    
    /**
     * 更新评论数量
     */
    int updateCommentCount(@Param("id") Integer id, @Param("count") Integer count);
}