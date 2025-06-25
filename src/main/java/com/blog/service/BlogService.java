package com.blog.service;

import com.blog.entity.Blog;
import com.blog.util.PageInfo;

import java.util.List;

/**
 * 博客服务接口
 */
public interface BlogService {
    
    /**
     * 根据ID查询博客
     */
    Blog findById(Integer id);
    
    /**
     * 分页查询已发布的博客
     */
    PageInfo<Blog> findPublishedByPage(int pageNum, int pageSize);
    
    /**
     * 分页查询所有博客（管理员用）
     */
    PageInfo<Blog> findByPage(int pageNum, int pageSize);
    
    /**
     * 根据分类查询博客
     */
    List<Blog> findByCategoryId(Integer categoryId);
    
    /**
     * 根据作者查询博客
     */
    List<Blog> findByAuthorId(Integer authorId);
    
    /**
     * 搜索博客
     */
    List<Blog> searchBlogs(String keyword);
    
    /**
     * 保存博客
     */
    boolean saveBlog(Blog blog);
    
    /**
     * 更新博客
     */
    boolean updateBlog(Blog blog);
    
    /**
     * 删除博客
     */
    boolean deleteBlog(Integer id);
    
    /**
     * 增加浏览次数
     */
    boolean incrementViewCount(Integer id);
    
    /**
     * 更新评论数量
     */
    boolean updateCommentCount(Integer blogId);
}