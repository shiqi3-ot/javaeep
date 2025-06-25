<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>留言管理 - 个人博客管理系统</title>
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/comments">
                                <i class="fas fa-comments"></i> 评论管理
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/messages">
                                <i class="fas fa-envelope"></i> 留言管理
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- 主内容区 -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                    <h1 class="h2">留言管理</h1>
                </div>

                <!-- 留言列表 -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>留言内容</th>
                                <th>留言者</th>
                                <th>联系方式</th>
                                <th>状态</th>
                                <th>留言时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty pageInfo.list}">
                                    <c:forEach var="message" items="${pageInfo.list}">
                                        <tr>
                                            <td>${message.id}</td>
                                            <td>
                                                <div class="message-content" style="max-width: 300px;">
                                                    <c:choose>
                                                        <c:when test="${message.content.length() > 50}">
                                                            ${message.content.substring(0, 50)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${message.content}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <c:if test="${not empty message.replyContent}">
                                                    <div class="mt-2 p-2 bg-light rounded">
                                                        <small class="text-muted">管理员回复：</small><br>
                                                        <c:choose>
                                                            <c:when test="${message.replyContent.length() > 30}">
                                                                ${message.replyContent.substring(0, 30)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${message.replyContent}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </c:if>
                                            </td>
                                            <td>${message.authorName}</td>
                                            <td>${message.authorEmail}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${message.status == 1}">
                                                        <span class="badge bg-success">已显示</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-warning">待审核</span>
                                                    </c:otherwise>
                                                </c:choose>
                                                <c:if test="${not empty message.replyContent}">
                                                    <br><span class="badge bg-info mt-1">已回复</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${message.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                            </td>
                                            <td>
                                                <div class="btn-group btn-group-sm" role="group">
                                                    <button type="button" class="btn btn-outline-info" 
                                                            onclick="viewMessage(${message.id}, '${message.content}', '${message.replyContent}')">
                                                        <i class="fas fa-eye"></i> 查看
                                                    </button>
                                                    <button type="button" class="btn btn-outline-primary" 
                                                            onclick="replyMessage(${message.id})">
                                                        <i class="fas fa-reply"></i> 回复
                                                    </button>
                                                    <button type="button" class="btn btn-outline-danger" 
                                                            onclick="deleteMessage(${message.id})">
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
                                            <i class="fas fa-envelope fa-2x mb-2"></i><br>
                                            暂无留言数据
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- 分页 -->
                <c:if test="${pageInfo.pages > 1}">
                    <nav aria-label="留言分页">
                        <ul class="pagination justify-content-center">
                            <c:if test="${pageInfo.hasPrevious}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/messages?page=${pageInfo.pageNum-1}">
                                        <i class="fas fa-chevron-left"></i> 上一页
                                    </a>
                                </li>
                            </c:if>
                            
                            <c:forEach var="num" items="${pageInfo.pages}">
                                <li class="page-item ${num == pageInfo.pageNum ? 'active' : ''}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/messages?page=${num}">${num}</a>
                                </li>
                            </c:forEach>
                            
                            <c:if test="${pageInfo.hasNext}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/admin/messages?page=${pageInfo.pageNum+1}">
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

    <!-- 查看留言模态框 -->
    <div class="modal fade" id="messageModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">留言详情</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-bold">留言内容：</label>
                        <p id="messageContent" class="border p-3 rounded bg-light"></p>
                    </div>
                    <div id="replySection" style="display: none;">
                        <label class="form-label fw-bold">管理员回复：</label>
                        <p id="replyContent" class="border p-3 rounded bg-info bg-opacity-10"></p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 回复留言模态框 -->
    <div class="modal fade" id="replyModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">回复留言</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="replyForm">
                        <input type="hidden" id="replyMessageId">
                        <div class="mb-3">
                            <label for="replyContentInput" class="form-label">回复内容</label>
                            <textarea class="form-control" id="replyContentInput" rows="4" 
                                      placeholder="请输入回复内容..." required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="submitReply()">发送回复</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function viewMessage(id, content, replyContent) {
            $('#messageContent').text(content);
            if (replyContent && replyContent.trim() !== '' && replyContent !== 'null') {
                $('#replyContent').text(replyContent);
                $('#replySection').show();
            } else {
                $('#replySection').hide();
            }
            $('#messageModal').modal('show');
        }

        function replyMessage(id) {
            $('#replyMessageId').val(id);
            $('#replyContentInput').val('');
            $('#replyModal').modal('show');
        }

        function submitReply() {
            var id = $('#replyMessageId').val();
            var content = $('#replyContentInput').val().trim();
            
            if (!content) {
                alert('请输入回复内容');
                return;
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/admin/message/reply',
                type: 'POST',
                data: {
                    id: id,
                    replyContent: content
                },
                success: function(result) {
                    if (result.success) {
                        alert('回复成功');
                        $('#replyModal').modal('hide');
                        location.reload();
                    } else {
                        alert('回复失败：' + result.message);
                    }
                },
                error: function() {
                    alert('回复失败，请稍后重试');
                }
            });
        }

        function deleteMessage(id) {
            if (confirm('确定要删除这条留言吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/message/delete/' + id,
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