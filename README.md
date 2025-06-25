# 基于SSM的个人博客管理系统

## 项目简介

本项目是一个基于SSM（Spring + Spring MVC + MyBatis）框架开发的个人博客管理系统，实现了博客文章的发布、管理，用户评论、留言等功能。系统分为前台展示和后台管理两个部分。

## 技术栈

- **后端框架**: Spring 5.3.21 + Spring MVC + MyBatis 3.5.10
- **数据库**: MySQL 8.0
- **连接池**: Druid 1.2.11
- **前端技术**: JSP + Bootstrap 5 + jQuery
- **构建工具**: Maven 3.6+
- **服务器**: Tomcat 9.0+
- **JDK版本**: JDK 8+

## 功能特性

### 前台功能
- ✅ 博客文章列表展示
- ✅ 博客文章详情查看
- ✅ 博客文章搜索
- ✅ 文章评论功能（支持回复）
- ✅ 留言板功能
- ✅ 响应式设计，支持移动端

### 后台管理功能
- ✅ 管理员登录/退出
- ✅ 仪表盘统计
- ✅ 博客文章管理（增删改查）
- ✅ 用户管理
- ✅ 评论管理
- ✅ 留言管理
- ✅ 权限控制

## 项目结构

```
src/
├── main/
│   ├── java/
│   │   └── com/blog/
│   │       ├── controller/     # 控制层
│   │       ├── service/        # 业务逻辑层
│   │       ├── dao/           # 数据访问层
│   │       ├── entity/        # 实体类
│   │       ├── util/          # 工具类
│   │       └── interceptor/   # 拦截器
│   ├── resources/
│   │   ├── config/           # 配置文件
│   │   ├── mapper/           # MyBatis映射文件
│   │   └── blog_system.sql   # 数据库初始化脚本
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── views/        # JSP视图文件
│       │   └── web.xml       # Web配置
│       ├── css/              # 样式文件
│       ├── js/               # JavaScript文件
│       └── images/           # 图片资源
└── test/                     # 测试代码
```

## 数据库设计

### 主要数据表
- `user` - 用户表
- `blog` - 博客文章表
- `category` - 博客分类表
- `comment` - 评论表
- `message` - 留言表

## 快速开始

### 1. 环境准备
- JDK 8+
- Maven 3.6+
- MySQL 8.0+
- Tomcat 9.0+

### 2. 数据库配置
1. 创建数据库：
```sql
CREATE DATABASE blog_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. 执行初始化脚本：
```bash
mysql -u root -p blog_system < src/main/resources/blog_system.sql
```

3. 修改数据库连接配置：
编辑 `src/main/resources/config/database.properties` 文件，修改数据库连接信息。

### 3. 编译和部署
1. 编译项目：
```bash
mvn clean compile
```

2. 打包项目：
```bash
mvn clean package
```

3. 部署到Tomcat：
将生成的 `target/personal-blog-system.war` 文件部署到Tomcat的webapps目录。

### 4. 使用Maven Tomcat插件运行
```bash
mvn tomcat7:run
```

访问地址：http://localhost:12000/blog

## 默认账号

### 管理员账号
- 用户名：admin
- 密码：admin123

## 主要页面

### 前台页面
- 首页：`/`
- 博客详情：`/blog/{id}`
- 搜索结果：`/search?keyword=关键词`
- 留言板：`/message`

### 后台页面
- 管理员登录：`/admin/login`
- 管理后台：`/admin/dashboard`
- 博客管理：`/admin/blogs`
- 用户管理：`/admin/users`
- 评论管理：`/admin/comments`
- 留言管理：`/admin/messages`

## 配置说明

### Spring配置
- `spring-context.xml` - Spring核心配置
- `spring-mvc.xml` - Spring MVC配置
- `mybatis-config.xml` - MyBatis配置

### 数据库配置
- `database.properties` - 数据库连接配置

### 日志配置
- `logback.xml` - 日志配置

## 开发说明

### 添加新功能
1. 在对应的包中创建实体类、DAO接口、Service接口和实现类、Controller
2. 创建对应的MyBatis映射文件
3. 创建JSP视图文件
4. 更新相关配置文件

### 自定义配置
- 修改 `database.properties` 配置数据库连接
- 修改 `pom.xml` 中的Tomcat端口配置
- 修改 `web.xml` 中的会话超时时间等配置

## 注意事项

1. 确保MySQL服务正在运行
2. 确保数据库连接配置正确
3. 首次运行需要执行数据库初始化脚本
4. 生产环境部署时请修改默认管理员密码
5. 建议使用HTTPS协议保证数据传输安全

## 许可证

本项目采用 MIT 许可证，详情请参阅 LICENSE 文件。

## 联系方式

如有问题或建议，请通过以下方式联系：
- 邮箱：admin@blog.com
- GitHub Issues

## 更新日志

### v1.0.0 (2024-06-25)
- 初始版本发布
- 实现基本的博客管理功能
- 实现用户评论和留言功能
- 实现后台管理功能
## 项目状态

✅ 开发完成
✅ 测试通过
✅ 文档完整
