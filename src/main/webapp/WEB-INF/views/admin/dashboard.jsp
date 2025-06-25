<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理后台 - 个人博客管理系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background: #343a40;
        }
        .sidebar .nav-link {
            color: #adb5bd;
            padding: 1rem;
        }
        .sidebar .nav-link:hover {
            color: #fff;
            background: #495057;
        }
        .sidebar .nav-link.active {
            color: #fff;
            background: #007bff;
        }
        .main-content {
            padding: 2rem;
        }
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
        }
        .stats-card h3 {
            font-size: 2rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- 侧边栏 -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky pt-3">
                    <div class="text-center text-white mb-4">
                        <h5>博客管理系统</h5>
                        <small>欢迎，${sessionScope.admin.nickname}</small>
                    </div>
                    
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>
                                仪表盘
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/blogs">
                                <i class="fas fa-blog me-2"></i>
                                博客管理
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users me-2"></i>
                                用户管理
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/comments">
                                <i class="fas fa-comments me-2"></i>
                                评论管理
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/messages">
                                <i class="fas fa-envelope me-2"></i>
                                留言管理
                            </a>
                        </li>
                        <li class="nav-item mt-3">
                            <a class="nav-link" href="${pageContext.request.contextPath}/" target="_blank">
                                <i class="fas fa-external-link-alt me-2"></i>
                                查看网站
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>
                                退出登录
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- 主要内容 -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                <div class="main-content">
                    <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                        <h1 class="h2">仪表盘</h1>
                    </div>

                    <!-- 统计卡片 -->
                    <div class="row">
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h3 id="blogCount">0</h3>
                                        <p>博客文章</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-blog fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h3 id="userCount">0</h3>
                                        <p>注册用户</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-users fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h3 id="commentCount">0</h3>
                                        <p>评论数量</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-comments fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="stats-card">
                                <div class="d-flex justify-content-between">
                                    <div>
                                        <h3 id="messageCount">0</h3>
                                        <p>留言数量</p>
                                    </div>
                                    <div class="align-self-center">
                                        <i class="fas fa-envelope fa-2x"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 快捷操作 -->
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5>快捷操作</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <a href="${pageContext.request.contextPath}/admin/blog/add" class="btn btn-primary btn-lg w-100 mb-2">
                                                <i class="fas fa-plus me-2"></i>
                                                写新博客
                                            </a>
                                        </div>
                                        <div class="col-md-3">
                                            <a href="${pageContext.request.contextPath}/admin/blogs" class="btn btn-info btn-lg w-100 mb-2">
                                                <i class="fas fa-list me-2"></i>
                                                管理博客
                                            </a>
                                        </div>
                                        <div class="col-md-3">
                                            <a href="${pageContext.request.contextPath}/admin/comments" class="btn btn-warning btn-lg w-100 mb-2">
                                                <i class="fas fa-comments me-2"></i>
                                                管理评论
                                            </a>
                                        </div>
                                        <div class="col-md-3">
                                            <a href="${pageContext.request.contextPath}/admin/messages" class="btn btn-success btn-lg w-100 mb-2">
                                                <i class="fas fa-envelope me-2"></i>
                                                管理留言
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 系统信息 -->
                    <div class="row mt-4">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h5>系统信息</h5>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <p><strong>系统名称：</strong>个人博客管理系统</p>
                                            <p><strong>版本：</strong>1.0.0</p>
                                            <p><strong>技术栈：</strong>Spring + Spring MVC + MyBatis</p>
                                        </div>
                                        <div class="col-md-6">
                                            <p><strong>当前用户：</strong>${sessionScope.admin.nickname}</p>
                                            <p><strong>用户角色：</strong>${sessionScope.admin.role}</p>
                                            <p><strong>登录时间：</strong><span id="currentTime"></span></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            // 显示当前时间
            function updateTime() {
                var now = new Date();
                $('#currentTime').text(now.toLocaleString());
            }
            updateTime();
            setInterval(updateTime, 1000);
            
            // 这里可以添加AJAX请求来获取统计数据
            // 暂时使用模拟数据
            $('#blogCount').text('12');
            $('#userCount').text('8');
            $('#commentCount').text('25');
            $('#messageCount').text('15');
        });
    </script>
</body>
</html>