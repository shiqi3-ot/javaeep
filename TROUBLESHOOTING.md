# 故障排除指南

## 常见问题及解决方案

### 1. HTTP 404 错误 - 找不到页面

**问题描述**: 访问管理后台页面时出现404错误，如：
```
找不到以下 Web 地址的网页： http://localhost:9000/personal_blog_system_war_exploded/admin/blogs
HTTP ERROR 404
```

**原因分析**:
1. JSP页面文件不存在
2. 控制器映射路径错误
3. 项目上下文路径配置问题

**解决方案**:

#### 1.1 检查JSP页面是否存在
确保以下管理页面文件存在：
```
src/main/webapp/WEB-INF/views/admin/
├── dashboard.jsp      # 管理后台首页
├── login.jsp         # 管理员登录页面
├── blog-list.jsp     # 博客管理页面
├── blog-add.jsp      # 添加博客页面
├── user-list.jsp     # 用户管理页面
├── comment-list.jsp  # 评论管理页面
└── message-list.jsp  # 留言管理页面
```

#### 1.2 检查控制器映射
确认 `AdminController.java` 中的映射路径：
```java
@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @RequestMapping("/blogs")
    public String blogManage(@RequestParam(defaultValue = "1") int page, Model model) {
        PageInfo<Blog> pageInfo = blogService.findByPage(page, 10);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/blog-list";  // 对应 blog-list.jsp
    }
    
    // 其他映射...
}
```

#### 1.3 检查项目部署
1. **重新编译项目**:
   ```bash
   mvn clean compile
   ```

2. **检查WAR包部署**:
   - 确保项目正确打包为WAR文件
   - 检查Tomcat部署目录
   - 确认项目上下文路径

3. **正确的访问URL**:
   ```
   # 正确的URL格式
   http://localhost:8080/项目名/admin/blogs
   
   # 例如：
   http://localhost:8080/blog/admin/blogs
   ```

### 2. 数据库连接问题

**问题描述**: 应用启动时数据库连接失败

**解决方案**:
1. 检查数据库配置文件 `src/main/resources/config/database.properties`
2. 确认MySQL服务已启动
3. 验证数据库用户名和密码
4. 检查数据库是否已创建

### 3. 权限访问问题

**问题描述**: 访问管理页面时被重定向到登录页面

**解决方案**:
1. 确保已正确登录管理员账户
2. 检查Session是否有效
3. 验证拦截器配置是否正确

### 4. 静态资源加载失败

**问题描述**: CSS、JS文件无法加载

**解决方案**:
1. 检查静态资源路径配置
2. 确认Spring MVC静态资源映射
3. 验证CDN链接是否可访问

## 部署检查清单

### 开发环境部署
- [ ] JDK 8+ 已安装
- [ ] Maven 3.6+ 已安装
- [ ] MySQL 8.0+ 已安装并启动
- [ ] 数据库已创建并执行初始化脚本
- [ ] 项目编译成功 (`mvn clean compile`)
- [ ] 所有JSP页面文件存在
- [ ] 配置文件正确设置

### 生产环境部署
- [ ] Tomcat 9.0+ 已安装并配置
- [ ] WAR包正确部署到webapps目录
- [ ] 数据库连接配置正确
- [ ] 日志配置适合生产环境
- [ ] 安全配置已加强

## 调试技巧

### 1. 启用详细日志
在 `logback.xml` 中设置DEBUG级别：
```xml
<logger name="com.blog" level="DEBUG"/>
<logger name="org.springframework" level="DEBUG"/>
```

### 2. 检查控制台输出
启动应用时注意观察：
- Spring容器初始化日志
- 数据库连接日志
- 控制器映射日志

### 3. 使用浏览器开发者工具
- 检查网络请求状态
- 查看控制台错误信息
- 验证静态资源加载情况

## 联系支持

如果问题仍然存在，请提供以下信息：
1. 详细的错误信息和堆栈跟踪
2. 应用服务器日志
3. 浏览器控制台错误
4. 部署环境信息（JDK版本、Tomcat版本等）

## 更新日志

### v1.0.1 (2025-06-25)
- 修复管理后台404错误
- 添加完整的管理页面
- 完善故障排除文档

### v1.0.0 (2025-06-25)
- 初始版本发布
- 完整的SSM博客管理系统