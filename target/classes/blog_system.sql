-- 个人博客管理系统数据库初始化脚本
CREATE DATABASE IF NOT EXISTS blog_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE blog_system;

-- 用户表
CREATE TABLE IF NOT EXISTS user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码',
    email VARCHAR(100) COMMENT '邮箱',
    nickname VARCHAR(50) COMMENT '昵称',
    avatar VARCHAR(200) COMMENT '头像路径',
    role ENUM('admin', 'user') DEFAULT 'user' COMMENT '角色',
    status TINYINT DEFAULT 1 COMMENT '状态：1-正常，0-禁用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 博客分类表
CREATE TABLE IF NOT EXISTS category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL COMMENT '分类名称',
    description TEXT COMMENT '分类描述',
    sort_order INT DEFAULT 0 COMMENT '排序',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='博客分类表';

-- 博客文章表
CREATE TABLE IF NOT EXISTS blog (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL COMMENT '标题',
    content LONGTEXT NOT NULL COMMENT '内容',
    summary TEXT COMMENT '摘要',
    author_id INT NOT NULL COMMENT '作者ID',
    category_id INT COMMENT '分类ID',
    tags VARCHAR(200) COMMENT '标签，逗号分隔',
    view_count INT DEFAULT 0 COMMENT '浏览次数',
    comment_count INT DEFAULT 0 COMMENT '评论数量',
    status TINYINT DEFAULT 1 COMMENT '状态：1-发布，0-草稿',
    is_top TINYINT DEFAULT 0 COMMENT '是否置顶：1-是，0-否',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (author_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE SET NULL,
    INDEX idx_author_id (author_id),
    INDEX idx_category_id (category_id),
    INDEX idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='博客文章表';

-- 评论表
CREATE TABLE IF NOT EXISTS comment (
    id INT PRIMARY KEY AUTO_INCREMENT,
    blog_id INT NOT NULL COMMENT '博客ID',
    user_id INT COMMENT '用户ID',
    parent_id INT DEFAULT 0 COMMENT '父评论ID，0表示顶级评论',
    content TEXT NOT NULL COMMENT '评论内容',
    author_name VARCHAR(50) COMMENT '评论者姓名（游客）',
    author_email VARCHAR(100) COMMENT '评论者邮箱（游客）',
    ip_address VARCHAR(50) COMMENT 'IP地址',
    status TINYINT DEFAULT 1 COMMENT '状态：1-正常，0-隐藏',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    FOREIGN KEY (blog_id) REFERENCES blog(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_blog_id (blog_id),
    INDEX idx_user_id (user_id),
    INDEX idx_parent_id (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='评论表';

-- 留言表
CREATE TABLE IF NOT EXISTS message (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT COMMENT '用户ID',
    author_name VARCHAR(50) NOT NULL COMMENT '留言者姓名',
    author_email VARCHAR(100) COMMENT '留言者邮箱',
    content TEXT NOT NULL COMMENT '留言内容',
    reply_content TEXT COMMENT '回复内容',
    ip_address VARCHAR(50) COMMENT 'IP地址',
    status TINYINT DEFAULT 1 COMMENT '状态：1-正常，0-隐藏',
    is_replied TINYINT DEFAULT 0 COMMENT '是否已回复：1-是，0-否',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    reply_time DATETIME COMMENT '回复时间',
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='留言表';

-- 插入初始数据
-- 管理员用户 (密码: admin123)
INSERT INTO user (username, password, email, nickname, role) VALUES 
('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDi', 'admin@blog.com', '管理员', 'admin');

-- 默认分类
INSERT INTO category (name, description, sort_order) VALUES 
('技术分享', '分享技术相关的文章', 1),
('生活随笔', '记录生活中的点点滴滴', 2),
('学习笔记', '学习过程中的笔记和心得', 3);

-- 示例博客文章
INSERT INTO blog (title, content, summary, author_id, category_id, tags, status) VALUES 
('欢迎来到我的博客', '这是我的第一篇博客文章，欢迎大家来到我的个人博客！在这里我会分享技术文章、生活感悟和学习心得。', '博客开通第一篇文章', 1, 2, '欢迎,博客,开始', 1),
('Spring框架学习笔记', 'Spring是一个开源的Java企业级应用开发框架，主要用来开发Java应用，但是有些扩展是针对构建J2EE平台的web应用。Spring框架目标是简化Java企业级应用开发，并通过POJO为基础的编程模型促进良好的编程习惯。', 'Spring框架基础知识总结', 1, 3, 'Spring,Java,框架,学习', 1);