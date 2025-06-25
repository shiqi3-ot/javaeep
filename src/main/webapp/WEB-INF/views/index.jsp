<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人博客管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">我的博客</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/">首页</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/message">留言板</a>
                    </li>
                </ul>
                <form class="d-flex" action="${pageContext.request.contextPath}/search" method="get">
                    <input class="form-control me-2" type="search" name="keyword" placeholder="搜索博客..." aria-label="Search">
                    <button class="btn btn-outline-light" type="submit">搜索</button>
                </form>
            </div>
        </div>
    </nav>

    <!-- 主要内容 -->
    <div class="container mt-4">
        <div class="row">
            <!-- 博客列表 -->
            <div class="col-md-8">
                <h2>最新博客</h2>
                <c:forEach var="blog" items="${pageInfo.list}">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">
                                <a href="${pageContext.request.contextPath}/blog/${blog.id}" class="text-decoration-none">
                                    ${blog.title}
                                    <c:if test="${blog.isTop == 1}">
                                        <span class="badge bg-danger">置顶</span>
                                    </c:if>
                                </a>
                            </h5>
                            <p class="card-text">${blog.summary}</p>
                            <div class="text-muted small">
                                <span>作者：${blog.author.nickname}</span>
                                <span class="ms-3">发布时间：<fmt:formatDate value="${blog.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                <span class="ms-3">浏览：${blog.viewCount}</span>
                                <span class="ms-3">评论：${blog.commentCount}</span>
                                <c:if test="${not empty blog.category}">
                                    <span class="ms-3">分类：${blog.category.name}</span>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <!-- 分页 -->
                <c:if test="${pageInfo.pages > 1}">
                    <nav aria-label="博客分页">
                        <ul class="pagination justify-content-center">
                            <c:if test="${pageInfo.hasPrevious}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${pageInfo.pageNum - 1}">上一页</a>
                                </li>
                            </c:if>
                            
                            <c:forEach begin="1" end="${pageInfo.pages}" var="i">
                                <li class="page-item ${i == pageInfo.pageNum ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            
                            <c:if test="${pageInfo.hasNext}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${pageInfo.pageNum + 1}">下一页</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </div>

            <!-- 侧边栏 -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h6>关于博客</h6>
                    </div>
                    <div class="card-body">
                        <p>欢迎来到我的个人博客！这里记录了我的技术学习心得、生活感悟和各种有趣的想法。</p>
                        <p>希望我的分享能对你有所帮助。</p>
                    </div>
                </div>

                <div class="card mt-3">
                    <div class="card-header">
                        <h6>管理员入口</h6>
                    </div>
                    <div class="card-body">
                        <a href="${pageContext.request.contextPath}/admin/login" class="btn btn-primary btn-sm">管理员登录</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 页脚 -->
    <footer class="bg-dark text-light text-center py-3 mt-5">
        <div class="container">
            <p>&copy; 2024 个人博客管理系统. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>