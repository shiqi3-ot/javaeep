package com.blog.dao;

import com.blog.entity.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 分类数据访问接口
 */
public interface CategoryDao {
    
    /**
     * 根据ID查询分类
     */
    Category findById(@Param("id") Integer id);
    
    /**
     * 查询所有分类
     */
    List<Category> findAll();
    
    /**
     * 按排序查询分类
     */
    List<Category> findAllOrderBySort();
    
    /**
     * 插入分类
     */
    int insert(Category category);
    
    /**
     * 更新分类
     */
    int update(Category category);
    
    /**
     * 删除分类
     */
    int deleteById(@Param("id") Integer id);
}