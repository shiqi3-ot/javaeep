<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员登录 - 个人博客管理系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            width: 100%;
            max-width: 400px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        .login-header h2 {
            color: #333;
            font-weight: 600;
        }
        .form-control {
            border-radius: 10px;
            border: 1px solid #ddd;
            padding: 12px 15px;
            margin-bottom: 1rem;
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            width: 100%;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="login-header">
            <h2>管理员登录</h2>
            <p class="text-muted">个人博客管理系统</p>
        </div>
        
        <form id="loginForm">
            <div class="mb-3">
                <input type="text" class="form-control" id="username" name="username" placeholder="用户名" required>
            </div>
            <div class="mb-3">
                <input type="password" class="form-control" id="password" name="password" placeholder="密码" required>
            </div>
            <button type="submit" class="btn btn-primary btn-login">登录</button>
        </form>
        
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/" class="text-decoration-none">返回首页</a>
        </div>
        
        <div class="text-center mt-4">
            <small class="text-muted">
                默认管理员账号：admin / admin123
            </small>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#loginForm').on('submit', function(e) {
                e.preventDefault();
                
                var formData = {
                    username: $('#username').val(),
                    password: $('#password').val()
                };
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/login',
                    type: 'POST',
                    data: formData,
                    success: function(result) {
                        if (result.success) {
                            alert('登录成功！');
                            window.location.href = '${pageContext.request.contextPath}/admin/dashboard';
                        } else {
                            alert('登录失败：' + result.message);
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