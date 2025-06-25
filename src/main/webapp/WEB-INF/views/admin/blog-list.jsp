<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>博客管理 - 个人博客管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="fas fa-tachometer-alt"></i> 管理后台
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/logout">
                    <i class="fas fa-sign-out-alt"></i> 退出
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- 侧边栏 -->
            <nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt"></i> 仪表盘
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/blogs">
                                <i class="fas fa-blog"></i> 博客管理
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users"></i> 用户管理
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/comments">
                                <i class="fas fa-comments"></i> 评论管理
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/messages">
                                <i class="fas fa-envelope"></i> 留言管理
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- 主内容区 -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">博客管理</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/blog/add" class="btn btn-primary">
                            <i class="fas fa-plus"></i> 添加博客
                        </a>
                    </div>
                </div>

                <!-- 博客列表 -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>标题</th>
                                <th>分类</th>
                                <th>状态</th>
                                <th>浏览量</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty pageInfo.list}">
                                    <c:forEach var="blog" items="${pageInfo.list}">
                                        <tr>
                                            <td>${blog.id}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/blog/${blog.id}" target="_blank" class="text-decoration-none">
                                                    ${blog.title}
                                                </a>
                                                <c:if test="${blog.isTop == 1}">
                                                    <span class="badge bg-warning ms-1">置顶</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${blog.categoryId == 1}">技术分享</c:when>
                                                    <c:when test="${blog.categoryId == 2}">生活随笔</c:when>
                                                    <c:when test="${blog.categoryId == 3}">学习笔记</c:when>
                                                    <c:otherwise>其他</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${blog.status == 1}">
                                                        <span class="badge bg-success">已发布</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">草稿</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${blog.viewCount}</td>
                                            <td>
                                                <fmt:formatDate value="${blog.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                            </td>
                                            <td>
                                                <div class="btn-group btn-group-sm" role="group">
                                                    <a href="${pageContext.request.contextPath}/admin/blog/edit/${blog.id}" 
                                                       class="btn btn-outline-primary">
                                                        <i class="fas fa-edit"></i> 编辑
                                                    </a>
                                                    <button type="button" class="btn btn-outline-danger" 
                                                            onclick="deleteBlog(${blog.id})">
                                                        <i class="fas fa-trash"></i> 删除
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            <i class="fas fa-inbox fa-2x mb-2"></i><br>
                                            暂无博客数据
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- 分页 -->
                <c:if test="${pageInfo.pages > 1}">
                    <nav aria-label="博客分页">
                        <ul class="pagination justify-content-center">
                            <c:if test="${pageInfo.hasPreviousPage}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/blogs?page=${pageInfo.prePage}">
                                        <i class="fas fa-chevron-left"></i> 上一页
                                    </a>
                                </li>
                            </c:if>
                            
                            <c:forEach var="num" items="${pageInfo.navigatepageNums}">
                                <li class="page-item ${num == pageInfo.pageNum ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/blogs?page=${num}">${num}</a>
                                </li>
                            </c:forEach>
                            
                            <c:if test="${pageInfo.hasNextPage}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/blogs?page=${pageInfo.nextPage}">
                                        下一页 <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function deleteBlog(id) {
            if (confirm('确定要删除这篇博客吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/blog/delete/' + id,
                    type: 'POST',
                    success: function(result) {
                        if (result.success) {
                            alert('删除成功');
                            location.reload();
                        } else {
                            alert('删除失败：' + result.message);
                        }
                    },
                    error: function() {
                        alert('删除失败，请稍后重试');
                    }
                });
            }
        }
    </script>
</body>
</html>