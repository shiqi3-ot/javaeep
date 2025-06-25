<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理 - 个人博客管理系统</title>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/blogs">
                                <i class="fas fa-blog"></i> 博客管理
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
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
                    <h1 class="h2">用户管理</h1>
                </div>

                <!-- 用户列表 -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>用户名</th>
                                <th>昵称</th>
                                <th>邮箱</th>
                                <th>角色</th>
                                <th>状态</th>
                                <th>注册时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty pageInfo.list}">
                                    <c:forEach var="user" items="${pageInfo.list}">
                                        <tr>
                                            <td>${user.id}</td>
                                            <td>${user.username}</td>
                                            <td>${user.nickname}</td>
                                            <td>${user.email}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.role == 'admin'}">
                                                        <span class="badge bg-danger">管理员</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-primary">普通用户</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${user.status == 1}">
                                                        <span class="badge bg-success">正常</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">禁用</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                            </td>
                                            <td>
                                                <c:if test="${user.role != 'admin'}">
                                                    <div class="btn-group btn-group-sm" role="group">
                                                        <c:choose>
                                                            <c:when test="${user.status == 1}">
                                                                <button type="button" class="btn btn-outline-warning" 
                                                                        onclick="updateUserStatus(${user.id}, 0)">
                                                                    <i class="fas fa-ban"></i> 禁用
                                                                </button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="button" class="btn btn-outline-success" 
                                                                        onclick="updateUserStatus(${user.id}, 1)">
                                                                    <i class="fas fa-check"></i> 启用
                                                                </button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="text-center text-muted py-4">
                                            <i class="fas fa-users fa-2x mb-2"></i><br>
                                            暂无用户数据
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- 分页 -->
                <c:if test="${pageInfo.pages > 1}">
                    <nav aria-label="用户分页">
                        <ul class="pagination justify-content-center">
                            <c:if test="${pageInfo.hasPreviousPage}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${pageInfo.prePage}">
                                        <i class="fas fa-chevron-left"></i> 上一页
                                    </a>
                                </li>
                            </c:if>
                            
                            <c:forEach var="num" items="${pageInfo.navigatepageNums}">
                                <li class="page-item ${num == pageInfo.pageNum ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${num}">${num}</a>
                                </li>
                            </c:forEach>
                            
                            <c:if test="${pageInfo.hasNextPage}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${pageInfo.nextPage}">
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
        function updateUserStatus(id, status) {
            var action = status == 1 ? '启用' : '禁用';
            if (confirm('确定要' + action + '这个用户吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/user/status',
                    type: 'POST',
                    data: {
                        id: id,
                        status: status
                    },
                    success: function(result) {
                        if (result.success) {
                            alert(action + '成功');
                            location.reload();
                        } else {
                            alert(action + '失败：' + result.message);
                        }
                    },
                    error: function() {
                        alert(action + '失败，请稍后重试');
                    }
                });
            }
        }
    </script>
</body>
</html>