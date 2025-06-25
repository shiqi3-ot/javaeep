<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加博客 - 个人博客管理系统</title>
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
                    <h1 class="h2">添加博客</h1>
                    <div class="btn-toolbar mb-2 mb-md-0">
                        <a href="${pageContext.request.contextPath}/admin/blogs" class="btn btn-secondary">
                            <i class="fas fa-arrow-left"></i> 返回列表
                        </a>
                    </div>
                </div>

                <!-- 博客表单 -->
                <form id="blogForm">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="mb-3">
                                <label for="title" class="form-label">标题 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="title" name="title" required>
                            </div>

                            <div class="mb-3">
                                <label for="summary" class="form-label">摘要</label>
                                <textarea class="form-control" id="summary" name="summary" rows="3" 
                                          placeholder="请输入博客摘要..."></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="content" class="form-label">内容 <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="content" name="content" rows="15" 
                                          placeholder="请输入博客内容..." required></textarea>
                            </div>

                            <div class="mb-3">
                                <label for="tags" class="form-label">标签</label>
                                <input type="text" class="form-control" id="tags" name="tags" 
                                       placeholder="多个标签用逗号分隔">
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title mb-0">发布设置</h5>
                                </div>
                                <div class="card-body">
                                    <div class="mb-3">
                                        <label for="categoryId" class="form-label">分类</label>
                                        <select class="form-select" id="categoryId" name="categoryId">
                                            <option value="1">技术分享</option>
                                            <option value="2">生活随笔</option>
                                            <option value="3">学习笔记</option>
                                            <option value="4">其他</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="status" class="form-label">状态</label>
                                        <select class="form-select" id="status" name="status">
                                            <option value="0">草稿</option>
                                            <option value="1" selected>发布</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" id="isTop" name="isTop" value="1">
                                            <label class="form-check-label" for="isTop">
                                                置顶显示
                                            </label>
                                        </div>
                                    </div>

                                    <div class="d-grid gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i> 保存博客
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary" onclick="resetForm()">
                                            <i class="fas fa-undo"></i> 重置
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#blogForm').on('submit', function(e) {
                e.preventDefault();
                
                var formData = {
                    title: $('#title').val(),
                    summary: $('#summary').val(),
                    content: $('#content').val(),
                    tags: $('#tags').val(),
                    categoryId: $('#categoryId').val(),
                    status: $('#status').val(),
                    isTop: $('#isTop').is(':checked') ? 1 : 0
                };

                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/blog/save',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(result) {
                        if (result.success) {
                            alert('博客保存成功');
                            window.location.href = '${pageContext.request.contextPath}/admin/blogs';
                        } else {
                            alert('保存失败：' + result.message);
                        }
                    },
                    error: function() {
                        alert('保存失败，请稍后重试');
                    }
                });
            });
        });

        function resetForm() {
            document.getElementById('blogForm').reset();
        }
    </script>
</body>
</html>