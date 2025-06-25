# 部署说明

## 环境要求

- JDK 8 或更高版本
- Maven 3.6 或更高版本
- MySQL 8.0 或更高版本
- Tomcat 9.0 或更高版本（可选，可使用Maven内置Tomcat）

## 快速启动

### 1. 数据库准备

1. 创建数据库：
```sql
CREATE DATABASE blog_system DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. 导入数据库结构：
```bash
mysql -u root -p blog_system < src/main/resources/blog_system.sql
```

3. 修改数据库配置：
编辑 `src/main/resources/config/database.properties` 文件，修改数据库连接信息：
```properties
jdbc.url=jdbc:mysql://localhost:3306/blog_system?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
jdbc.username=你的数据库用户名
jdbc.password=你的数据库密码
```

### 2. 使用启动脚本（推荐）

```bash
./start.sh
```

启动脚本会自动：
- 编译项目
- 打包项目
- 启动内置Tomcat服务器

### 3. 手动启动

1. 编译项目：
```bash
mvn clean compile
```

2. 打包项目：
```bash
mvn package
```

3. 启动服务器：
```bash
mvn tomcat7:run -Dmaven.tomcat.port=12000 -Dmaven.tomcat.path=/blog
```

## 访问地址

- **前台首页**: http://localhost:12000/blog/
- **管理后台**: http://localhost:12000/blog/admin/login
- **默认管理员账号**: admin / admin123

## 生产环境部署

### 1. 打包WAR文件

```bash
mvn clean package
```

生成的WAR文件位于 `target/personal-blog-system.war`

### 2. 部署到Tomcat

1. 将WAR文件复制到Tomcat的webapps目录
2. 启动Tomcat服务器
3. 访问 http://your-domain:8080/personal-blog-system/

### 3. 配置修改

生产环境部署前，请修改以下配置：

1. **数据库配置** (`src/main/resources/config/database.properties`)
   - 修改数据库连接信息
   - 使用生产环境数据库

2. **日志配置** (`src/main/resources/logback.xml`)
   - 调整日志级别
   - 配置日志文件路径

3. **安全配置**
   - 修改默认管理员密码
   - 配置HTTPS（推荐）

## 常见问题

### 1. 端口冲突

如果12000端口被占用，可以修改端口：
```bash
mvn tomcat7:run -Dmaven.tomcat.port=8080 -Dmaven.tomcat.path=/blog
```

### 2. 数据库连接失败

检查以下配置：
- 数据库服务是否启动
- 数据库连接信息是否正确
- 数据库用户权限是否足够

### 3. 编译失败

确保：
- JDK版本为8或更高
- Maven版本为3.6或更高
- 网络连接正常（需要下载依赖）

### 4. 内存不足

如果遇到内存不足错误，可以增加JVM内存：
```bash
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=256m"
mvn tomcat7:run
```

## 功能测试

### 前台功能测试

1. 访问首页，查看博客列表
2. 点击博客标题，查看博客详情
3. 在博客详情页发表评论
4. 访问留言板，发表留言
5. 使用搜索功能搜索博客

### 后台功能测试

1. 使用管理员账号登录后台
2. 查看仪表盘统计信息
3. 添加、编辑、删除博客文章
4. 管理用户信息
5. 审核和管理评论
6. 回复和管理留言

## 技术支持

如遇到问题，请检查：
1. 日志文件 (`logs/blog-system.log`)
2. 错误日志 (`logs/blog-system-error.log`)
3. Tomcat日志

或联系技术支持：admin@blog.com