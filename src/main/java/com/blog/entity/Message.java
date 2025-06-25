package com.blog.entity;

import java.util.Date;

/**
 * 留言实体类
 */
public class Message {
    private Integer id;
    private Integer userId;
    private String authorName;
    private String authorEmail;
    private String content;
    private String replyContent;
    private String ipAddress;
    private Integer status;
    private Integer isReplied;
    private Date createTime;
    private Date replyTime;

    // 关联对象
    private User user;

    public Message() {}

    public Message(String authorName, String authorEmail, String content) {
        this.authorName = authorName;
        this.authorEmail = authorEmail;
        this.content = content;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getAuthorEmail() {
        return authorEmail;
    }

    public void setAuthorEmail(String authorEmail) {
        this.authorEmail = authorEmail;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getIsReplied() {
        return isReplied;
    }

    public void setIsReplied(Integer isReplied) {
        this.isReplied = isReplied;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getReplyTime() {
        return replyTime;
    }

    public void setReplyTime(Date replyTime) {
        this.replyTime = replyTime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", userId=" + userId +
                ", authorName='" + authorName + '\'' +
                ", content='" + content + '\'' +
                ", status=" + status +
                ", isReplied=" + isReplied +
                ", createTime=" + createTime +
                '}';
    }
}