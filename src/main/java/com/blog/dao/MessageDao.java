package com.blog.dao;

import com.blog.entity.Message;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 留言数据访问接口
 */
public interface MessageDao {
    
    /**
     * 根据ID查询留言
     */
    Message findById(@Param("id") Integer id);
    
    /**
     * 查询所有留言
     */
    List<Message> findAll();
    
    /**
     * 分页查询留言
     */
    List<Message> findByPage(@Param("offset") int offset, @Param("limit") int limit);
    
    /**
     * 查询未回复的留言
     */
    List<Message> findUnreplied();
    
    /**
     * 统计留言总数
     */
    long countAll();
    
    /**
     * 统计未回复留言数
     */
    long countUnreplied();
    
    /**
     * 插入留言
     */
    int insert(Message message);
    
    /**
     * 更新留言
     */
    int update(Message message);
    
    /**
     * 删除留言
     */
    int deleteById(@Param("id") Integer id);
    
    /**
     * 回复留言
     */
    int reply(@Param("id") Integer id, @Param("replyContent") String replyContent);
    
    /**
     * 更新留言状态
     */
    int updateStatus(@Param("id") Integer id, @Param("status") Integer status);
}