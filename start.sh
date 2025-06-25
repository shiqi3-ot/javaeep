#!/bin/bash

# 个人博客管理系统启动脚本

echo "正在启动个人博客管理系统..."

# 检查Maven是否安装
if ! command -v mvn &> /dev/null; then
    echo "错误：Maven未安装，请先安装Maven"
    exit 1
fi

# 检查Java是否安装
if ! command -v java &> /dev/null; then
    echo "错误：Java未安装，请先安装Java"
    exit 1
fi

# 清理并编译项目
echo "正在编译项目..."
mvn clean compile

if [ $? -ne 0 ]; then
    echo "错误：项目编译失败"
    exit 1
fi

# 打包项目
echo "正在打包项目..."
mvn package -DskipTests

if [ $? -ne 0 ]; then
    echo "错误：项目打包失败"
    exit 1
fi

# 使用Maven Tomcat插件运行项目
echo "正在启动Tomcat服务器..."
echo "项目将在以下地址运行："
echo "- 前台地址: http://localhost:12000/blog"
echo "- 管理后台: http://localhost:12000/blog/admin/login"
echo "- 默认管理员账号: admin / admin123"
echo ""
echo "按 Ctrl+C 停止服务器"
echo ""

mvn tomcat7:run -Dmaven.tomcat.port=12000 -Dmaven.tomcat.path=/blog