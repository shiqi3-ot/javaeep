package com.blog.service.impl;

import com.blog.dao.BlogDao;
import com.blog.dao.CommentDao;
import com.blog.entity.Blog;
import com.blog.service.BlogService;
import com.blog.util.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 博客服务实现类
 */
@Service
@Transactional
public class BlogServiceImpl implements BlogService {
    
    @Autowired
    private BlogDao blogDao;
    
    @Autowired
    private CommentDao commentDao;
    
    @Override
    public Blog findById(Integer id) {
        return blogDao.findById(id);
    }
    
    @Override
    public PageInfo<Blog> findPublishedByPage(int pageNum, int pageSize) {
        int offset = (pageNum - 1) * pageSize;
        List<Blog> blogs = blogDao.findPublishedByPage(offset, pageSize);
        long total = blogDao.countPublished();
        return new PageInfo<>(pageNum, pageSize, total, blogs);
    }
    
    @Override
    public PageInfo<Blog> findByPage(int pageNum, int pageSize) {
        int offset = (pageNum - 1) * pageSize;
        List<Blog> blogs = blogDao.findByPage(offset, pageSize);
        long total = blogDao.countAll();
        return new PageInfo<>(pageNum, pageSize, total, blogs);
    }
    
    @Override
    public List<Blog> findByCategoryId(Integer categoryId) {
        return blogDao.findByCategoryId(categoryId);
    }
    
    @Override
    public List<Blog> findByAuthorId(Integer authorId) {
        return blogDao.findByAuthorId(authorId);
    }
    
    @Override
    public List<Blog> searchBlogs(String keyword) {
        return blogDao.searchBlogs(keyword);
    }
    
    @Override
    public boolean saveBlog(Blog blog) {
        // 设置默认值
        if (blog.getStatus() == null) {
            blog.setStatus(1); // 默认发布
        }
        if (blog.getIsTop() == null) {
            blog.setIsTop(0); // 默认不置顶
        }
        if (blog.getViewCount() == null) {
            blog.setViewCount(0);
        }
        if (blog.getCommentCount() == null) {
            blog.setCommentCount(0);
        }
        
        return blogDao.insert(blog) > 0;
    }
    
    @Override
    public boolean updateBlog(Blog blog) {
        return blogDao.update(blog) > 0;
    }
    
    @Override
    public boolean deleteBlog(Integer id) {
        return blogDao.deleteById(id) > 0;
    }
    
    @Override
    public boolean incrementViewCount(Integer id) {
        return blogDao.incrementViewCount(id) > 0;
    }
    
    @Override
    public boolean updateCommentCount(Integer blogId) {
        long count = commentDao.countByBlogId(blogId);
        return blogDao.updateCommentCount(blogId, (int) count) > 0;
    }
}