<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${blog.title} - 个人博客</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/message">留言板</a>
            </div>
        </div>
    </nav>

    <!-- 主要内容 -->
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8">
                <!-- 博客内容 -->
                <article class="card">
                    <div class="card-body">
                        <h1 class="card-title">${blog.title}</h1>
                        <div class="text-muted mb-3">
                            <span>作者：${blog.author.nickname}</span>
                            <span class="ms-3">发布时间：<fmt:formatDate value="${blog.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                            <span class="ms-3">浏览：${blog.viewCount}</span>
                            <c:if test="${not empty blog.category}">
                                <span class="ms-3">分类：${blog.category.name}</span>
                            </c:if>
                        </div>
                        <div class="blog-content">
                            ${blog.content}
                        </div>
                        <c:if test="${not empty blog.tags}">
                            <div class="mt-3">
                                <strong>标签：</strong>
                                <c:forEach var="tag" items="${blog.tags.split(',')}">
                                    <span class="badge bg-secondary me-1">${tag}</span>
                                </c:forEach>
                            </div>
                        </c:if>
                    </div>
                </article>

                <!-- 评论区 -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h5>评论 (${blog.commentCount})</h5>
                    </div>
                    <div class="card-body">
                        <!-- 发表评论表单 -->
                        <form id="commentForm" class="mb-4">
                            <div class="row">
                                <div class="col-md-6">
                                    <input type="text" class="form-control mb-2" id="authorName" placeholder="姓名" required>
                                </div>
                                <div class="col-md-6">
                                    <input type="email" class="form-control mb-2" id="authorEmail" placeholder="邮箱">
                                </div>
                            </div>
                            <textarea class="form-control mb-2" id="commentContent" rows="3" placeholder="请输入评论内容..." required></textarea>
                            <button type="submit" class="btn btn-primary">发表评论</button>
                        </form>

                        <!-- 评论列表 -->
                        <div id="commentList">
                            <c:forEach var="comment" items="${comments}">
                                <div class="comment-item border-bottom pb-3 mb-3">
                                    <div class="d-flex justify-content-between">
                                        <strong>${comment.authorName}</strong>
                                        <small class="text-muted">
                                            <fmt:formatDate value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                        </small>
                                    </div>
                                    <p class="mt-2">${comment.content}</p>
                                    
                                    <!-- 子评论 -->
                                    <c:if test="${not empty comment.replies}">
                                        <div class="replies ms-4 mt-3">
                                            <c:forEach var="reply" items="${comment.replies}">
                                                <div class="reply-item border-start border-3 ps-3 mb-2">
                                                    <div class="d-flex justify-content-between">
                                                        <strong>${reply.authorName}</strong>
                                                        <small class="text-muted">
                                                            <fmt:formatDate value="${reply.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                                        </small>
                                                    </div>
                                                    <p class="mt-1">${reply.content}</p>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:if>
                                    
                                    <button class="btn btn-sm btn-outline-primary reply-btn" data-parent-id="${comment.id}">回复</button>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 侧边栏 -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header">
                        <h6>博客信息</h6>
                    </div>
                    <div class="card-body">
                        <p><strong>作者：</strong>${blog.author.nickname}</p>
                        <p><strong>发布时间：</strong><fmt:formatDate value="${blog.createTime}" pattern="yyyy-MM-dd"/></p>
                        <p><strong>浏览次数：</strong>${blog.viewCount}</p>
                        <p><strong>评论数量：</strong>${blog.commentCount}</p>
                        <c:if test="${not empty blog.category}">
                            <p><strong>分类：</strong>${blog.category.name}</p>
                        </c:if>
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
            // 发表评论
            $('#commentForm').on('submit', function(e) {
                e.preventDefault();
                
                var comment = {
                    blogId: ${blog.id},
                    authorName: $('#authorName').val(),
                    authorEmail: $('#authorEmail').val(),
                    content: $('#commentContent').val(),
                    parentId: 0
                };
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/comment/add',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(comment),
                    success: function(result) {
                        if (result.success) {
                            alert('评论发表成功！');
                            location.reload();
                        } else {
                            alert('评论发表失败：' + result.message);
                        }
                    },
                    error: function() {
                        alert('系统错误，请稍后重试！');
                    }
                });
            });
            
            // 回复评论
            $('.reply-btn').on('click', function() {
                var parentId = $(this).data('parent-id');
                var authorName = prompt('请输入您的姓名：');
                var content = prompt('请输入回复内容：');
                
                if (authorName && content) {
                    var reply = {
                        blogId: ${blog.id},
                        authorName: authorName,
                        content: content,
                        parentId: parentId
                    };
                    
                    $.ajax({
                        url: '${pageContext.request.contextPath}/comment/add',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(reply),
                        success: function(result) {
                            if (result.success) {
                                alert('回复发表成功！');
                                location.reload();
                            } else {
                                alert('回复发表失败：' + result.message);
                            }
                        },
                        error: function() {
                            alert('系统错误，请稍后重试！');
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>