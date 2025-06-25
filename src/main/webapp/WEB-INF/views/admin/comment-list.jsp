<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>评论管理 - 个人博客管理系统</title>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users"></i> 用户管理
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/comments">
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
                    <h1 class="h2">评论管理</h1>
                </div>

                <!-- 评论列表 -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>评论内容</th>
                                <th>评论者</th>
                                <th>所属博客</th>
                                <th>状态</th>
                                <th>评论时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty pageInfo.list}">
                                    <c:forEach var="comment" items="${pageInfo.list}">
                                        <tr>
                                            <td>${comment.id}</td>
                                            <td>
                                                <div class="comment-content" style="max-width: 300px;">
                                                    <c:choose>
                                                        <c:when test="${comment.content.length() > 50}">
                                                            ${comment.content.substring(0, 50)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${comment.content}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty comment.username}">
                                                        ${comment.username}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${comment.nickname}
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/blog/${comment.blogId}" 
                                                   target="_blank" class="text-decoration-none">
                                                    博客#${comment.blogId}
                                                </a>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${comment.status == 1}">
                                                        <span class="badge bg-success">已审核</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning">待审核</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                            </td>
                                            <td>
                                                <div class="btn-group btn-group-sm" role="group">
                                                    <c:choose>
                                                        <c:when test="${comment.status == 1}">
                                                            <button type="button" class="btn btn-outline-warning" 
                                                                    onclick="updateCommentStatus(${comment.id}, 0)">
                                                                <i class="fas fa-eye-slash"></i> 隐藏
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" class="btn btn-outline-success" 
                                                                    onclick="updateCommentStatus(${comment.id}, 1)">
                                                                <i class="fas fa-check"></i> 审核
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <button type="button" class="btn btn-outline-info" 
                                                            onclick="viewComment(${comment.id}, '${comment.content}')">
                                                        <i class="fas fa-eye"></i> 查看
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            <i class="fas fa-comments fa-2x mb-2"></i><br>
                                            暂无评论数据
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- 分页 -->
                <c:if test="${pageInfo.pages > 1}">
                    <nav aria-label="评论分页">
                        <ul class="pagination justify-content-center">
                            <c:if test="${pageInfo.hasPreviousPage}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/comments?page=${pageInfo.prePage}">
                                        <i class="fas fa-chevron-left"></i> 上一页
                                    </a>
                                </li>
                            </c:if>
                            
                            <c:forEach var="num" items="${pageInfo.navigatepageNums}">
                                <li class="page-item ${num == pageInfo.pageNum ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/comments?page=${num}">${num}</a>
                                </li>
                            </c:forEach>
                            
                            <c:if test="${pageInfo.hasNextPage}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/comments?page=${pageInfo.nextPage}">
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

    <!-- 查看评论模态框 -->
    <div class="modal fade" id="commentModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">评论详情</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p id="commentContent"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function updateCommentStatus(id, status) {
            var action = status == 1 ? '审核通过' : '隐藏';
            if (confirm('确定要' + action + '这条评论吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/comment/status',
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

        function viewComment(id, content) {
            $('#commentContent').text(content);
            $('#commentModal').modal('show');
        }
    </script>
</body>
</html>