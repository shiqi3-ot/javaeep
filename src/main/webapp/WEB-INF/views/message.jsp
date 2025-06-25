<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>留言板 - 个人博客</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">我的博客</a>
            <div class="navbar-nav">
                <a class="nav-link" href="${pageContext.request.contextPath}/">首页</a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/message">留言板</a>
            </div>
        </div>
    </nav>

    <!-- 主要内容 -->
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8">
                <h2>留言板</h2>
                
                <!-- 留言表单 -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5>发表留言</h5>
                    </div>
                    <div class="card-body">
                        <form id="messageForm">
                            <div class="row">
                                <div class="col-md-6">
                                    <input type="text" class="form-control mb-3" id="authorName" placeholder="姓名" required>
                                </div>
                                <div class="col-md-6">
                                    <input type="email" class="form-control mb-3" id="authorEmail" placeholder="邮箱">
                                </div>
                            </div>
                            <textarea class="form-control mb-3" id="messageContent" rows="4" placeholder="请输入留言内容..." required></textarea>
                            <button type="submit" class="btn btn-primary">提交留言</button>
                        </form>
                    </div>
                </div>

                <!-- 留言列表 -->
                <div class="card">
                    <div class="card-header">
                        <h5>留言列表</h5>
                    </div>
                    <div class="card-body">
                        <c:forEach var="message" items="${messages}">
                            <div class="message-item border-bottom pb-3 mb-3">
                                <div class="d-flex justify-content-between">
                                    <strong>${message.authorName}</strong>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${message.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                    </small>
                                </div>
                                <p class="mt-2">${message.content}</p>
                                
                                <!-- 管理员回复 -->
                                <c:if test="${message.isReplied == 1 and not empty message.replyContent}">
                                    <div class="reply-content bg-light p-3 mt-3 rounded">
                                        <strong class="text-primary">管理员回复：</strong>
                                        <p class="mt-1 mb-1">${message.replyContent}</p>
                                        <small class="text-muted">
                                            回复时间：<fmt:formatDate value="${message.replyTime}" pattern="yyyy-MM-dd HH:mm"/>
                                        </small>
                                    </div>
                                </c:if>
                            </div>
                        </c:forEach>
                        
                        <c:if test="${empty messages}">
                            <p class="text-center text-muted">暂无留言，快来发表第一条留言吧！</p>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- 侧边栏 -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h6>留言须知</h6>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled">
                            <li>• 请文明留言，遵守相关法律法规</li>
                            <li>• 留言内容不得包含违法、违规信息</li>
                            <li>• 管理员会及时回复您的留言</li>
                            <li>• 感谢您的支持与关注</li>
                        </ul>
                    </div>
                </div>

                <div class="card mt-3">
                    <div class="card-header">
                        <h6>联系方式</h6>
                    </div>
                    <div class="card-body">
                        <p>如有紧急事务，可通过以下方式联系：</p>
                        <p><strong>邮箱：</strong>admin@blog.com</p>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            // 提交留言
            $('#messageForm').on('submit', function(e) {
                e.preventDefault();
                
                var message = {
                    authorName: $('#authorName').val(),
                    authorEmail: $('#authorEmail').val(),
                    content: $('#messageContent').val()
                };
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/message/add',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(message),
                    success: function(result) {
                        if (result.success) {
                            alert('留言提交成功！');
                            location.reload();
                        } else {
                            alert('留言提交失败：' + result.message);
                        }
                    },
                    error: function() {
                        alert('系统错误，请稍后重试！');
                    }
                });
            });
        });
    </script>
</body>
</html>