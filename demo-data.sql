-- 演示数据插入脚本
-- 注意：请先执行 blog_system.sql 创建表结构

USE blog_system;

-- 插入演示用户数据
INSERT INTO `user` (`username`, `password`, `nickname`, `email`, `role`, `status`, `create_time`) VALUES
('admin', 'e10adc3949ba59abbe56e057f20f883e', '系统管理员', 'admin@blog.com', 'admin', 1, NOW()),
('author1', 'e10adc3949ba59abbe56e057f20f883e', '技术博主', 'author1@blog.com', 'user', 1, NOW()),
('reader1', 'e10adc3949ba59abbe56e057f20f883e', '普通读者', 'reader1@blog.com', 'user', 1, NOW());

-- 插入博客分类数据
INSERT INTO `category` (`name`, `description`, `sort_order`, `status`, `create_time`) VALUES
('技术分享', 'Java、Spring、数据库等技术文章', 1, 1, NOW()),
('生活随笔', '日常生活感悟和随想', 2, 1, NOW()),
('学习笔记', '学习过程中的笔记和总结', 3, 1, NOW()),
('项目实战', '实际项目开发经验分享', 4, 1, NOW());

-- 插入博客文章数据
INSERT INTO `blog` (`title`, `summary`, `content`, `author_id`, `category_id`, `tags`, `status`, `is_top`, `view_count`, `comment_count`, `create_time`, `update_time`) VALUES
('基于SSM框架的个人博客系统开发实战', 
'本文详细介绍了如何使用Spring + Spring MVC + MyBatis框架开发一个功能完整的个人博客管理系统。', 
'<h2>项目简介</h2><p>个人博客管理系统是一个基于SSM框架开发的Web应用，主要功能包括博客文章管理、用户管理、评论管理等。</p><h2>技术栈</h2><ul><li>Spring 5.3.21</li><li>Spring MVC</li><li>MyBatis 3.5.10</li><li>MySQL 8.0</li><li>Bootstrap 5</li></ul><h2>核心功能</h2><p>系统分为前台展示和后台管理两个部分：</p><h3>前台功能</h3><ul><li>博客文章列表展示</li><li>博客文章详情查看</li><li>文章搜索功能</li><li>评论和回复功能</li><li>留言板功能</li></ul><h3>后台管理</h3><ul><li>博客文章管理</li><li>用户管理</li><li>评论管理</li><li>留言管理</li><li>系统统计</li></ul><p>项目采用了现代化的前端设计，响应式布局，支持移动端访问。</p>', 
1, 1, 'SSM,Spring,MyBatis,博客系统', 1, 1, 156, 8, NOW(), NOW()),

('Java Web开发中的常见问题及解决方案', 
'总结了Java Web开发过程中经常遇到的问题，并提供了相应的解决方案。', 
'<h2>前言</h2><p>在Java Web开发过程中，我们经常会遇到各种各样的问题。本文总结了一些常见问题及其解决方案。</p><h2>数据库连接问题</h2><p>数据库连接是Web应用的基础，常见问题包括：</p><ul><li>连接池配置不当</li><li>数据库驱动版本不匹配</li><li>连接超时设置</li></ul><h3>解决方案</h3><p>使用Druid连接池，合理配置连接参数：</p><pre><code>druid.initialSize=5\ndruid.minIdle=5\ndruid.maxActive=20</code></pre><h2>编码问题</h2><p>中文乱码是常见问题，需要统一设置编码格式为UTF-8。</p><h2>性能优化</h2><p>包括SQL优化、缓存使用、静态资源优化等方面。</p>', 
2, 1, 'Java,Web开发,问题解决', 1, 0, 89, 5, DATE_SUB(NOW(), INTERVAL 2 DAY), DATE_SUB(NOW(), INTERVAL 2 DAY)),

('Spring框架学习笔记', 
'Spring框架是Java企业级开发的核心框架，本文记录了学习Spring的心得体会。', 
'<h2>Spring简介</h2><p>Spring是一个开源的Java企业级应用框架，主要用来开发Java应用。</p><h2>核心特性</h2><ul><li>依赖注入（DI）</li><li>面向切面编程（AOP）</li><li>事务管理</li><li>MVC框架</li></ul><h2>依赖注入</h2><p>依赖注入是Spring的核心特性之一，它可以让我们的代码更加松耦合。</p><h3>三种注入方式</h3><ol><li>构造器注入</li><li>Setter注入</li><li>字段注入</li></ol><h2>AOP编程</h2><p>面向切面编程可以将横切关注点从业务逻辑中分离出来。</p><p>常见应用场景：日志记录、性能监控、事务管理等。</p>', 
2, 3, 'Spring,学习笔记,框架', 1, 0, 67, 3, DATE_SUB(NOW(), INTERVAL 5 DAY), DATE_SUB(NOW(), INTERVAL 5 DAY)),

('我的编程学习之路', 
'分享我从编程小白到能够独立开发项目的学习经历和心得体会。', 
'<h2>初识编程</h2><p>还记得第一次接触编程是在大学的计算机基础课上，那时候对着黑乎乎的命令行界面，感觉既神秘又恐惧。</p><h2>学习历程</h2><h3>第一阶段：基础语法</h3><p>从最基本的变量、循环、条件判断开始学起，每天坚持写代码练习。</p><h3>第二阶段：面向对象</h3><p>理解类、对象、继承、多态等概念，这是一个思维转变的过程。</p><h3>第三阶段：框架学习</h3><p>开始接触Spring、MyBatis等企业级框架，学会了如何开发Web应用。</p><h2>学习心得</h2><ul><li>坚持每天写代码</li><li>多做项目实践</li><li>善于总结和分享</li><li>保持学习的热情</li></ul><p>编程是一个需要持续学习的领域，技术在不断更新，我们也要跟上时代的步伐。</p>', 
2, 2, '学习经历,编程,心得体会', 1, 0, 45, 2, DATE_SUB(NOW(), INTERVAL 7 DAY), DATE_SUB(NOW(), INTERVAL 7 DAY)),

('数据库设计最佳实践', 
'良好的数据库设计是系统性能的基础，本文分享数据库设计的一些最佳实践。', 
'<h2>数据库设计原则</h2><p>好的数据库设计应该遵循以下原则：</p><ul><li>规范化设计</li><li>性能优化</li><li>可扩展性</li><li>数据完整性</li></ul><h2>表结构设计</h2><h3>命名规范</h3><p>表名和字段名应该具有明确的含义，使用下划线分隔单词。</p><h3>数据类型选择</h3><p>根据实际需要选择合适的数据类型，避免浪费存储空间。</p><h2>索引设计</h2><p>合理使用索引可以大大提高查询性能：</p><ul><li>主键索引</li><li>唯一索引</li><li>普通索引</li><li>复合索引</li></ul><h2>性能优化</h2><p>包括查询优化、索引优化、表结构优化等方面。</p>', 
1, 1, '数据库,设计,最佳实践', 1, 0, 78, 4, DATE_SUB(NOW(), INTERVAL 10 DAY), DATE_SUB(NOW(), INTERVAL 10 DAY));

-- 插入评论数据
INSERT INTO `comment` (`blog_id`, `author_name`, `author_email`, `content`, `parent_id`, `status`, `ip_address`, `create_time`) VALUES
(1, '张三', 'zhangsan@example.com', '这个项目很不错，学到了很多东西！', 0, 1, '192.168.1.100', NOW()),
(1, '李四', 'lisi@example.com', '代码写得很规范，值得学习。', 0, 1, '192.168.1.101', NOW()),
(1, '王五', 'wangwu@example.com', '感谢分享，正好需要这样的项目。', 0, 1, '192.168.1.102', NOW()),
(1, '作者', 'author1@blog.com', '谢谢大家的支持！', 1, 1, '192.168.1.1', NOW()),
(2, '小明', 'xiaoming@example.com', '这些问题我也遇到过，解决方案很实用。', 0, 1, '192.168.1.103', NOW()),
(2, '小红', 'xiaohong@example.com', '收藏了，以后遇到问题可以参考。', 0, 1, '192.168.1.104', NOW()),
(3, '学习者', 'learner@example.com', 'Spring确实是很重要的框架。', 0, 1, '192.168.1.105', NOW()),
(4, '同路人', 'fellow@example.com', '我也是这样学过来的，加油！', 0, 1, '192.168.1.106', NOW());

-- 插入留言数据
INSERT INTO `message` (`author_name`, `author_email`, `content`, `is_replied`, `reply_content`, `reply_time`, `status`, `ip_address`, `create_time`) VALUES
('访客A', 'visitor1@example.com', '博客内容很丰富，希望能继续更新！', 1, '谢谢支持，我会继续努力的！', NOW(), 1, '192.168.1.200', DATE_SUB(NOW(), INTERVAL 1 DAY)),
('技术爱好者', 'tech@example.com', '能否分享一些前端技术的文章？', 1, '好建议，我会考虑写一些前端相关的内容。', NOW(), 1, '192.168.1.201', DATE_SUB(NOW(), INTERVAL 2 DAY)),
('新手程序员', 'newbie@example.com', '作为新手，从哪里开始学习比较好？', 0, NULL, NULL, 1, '192.168.1.202', DATE_SUB(NOW(), INTERVAL 3 DAY)),
('老读者', 'oldreader@example.com', '一直在关注你的博客，内容质量很高！', 1, '感谢长期关注，你的支持是我前进的动力！', NOW(), 1, '192.168.1.203', DATE_SUB(NOW(), INTERVAL 5 DAY)),
('求助者', 'help@example.com', '在项目部署时遇到了问题，能帮忙看看吗？', 0, NULL, NULL, 1, '192.168.1.204', DATE_SUB(NOW(), INTERVAL 1 HOUR));

-- 更新博客的评论数量
UPDATE blog SET comment_count = (SELECT COUNT(*) FROM comment WHERE blog_id = blog.id AND status = 1);

COMMIT;