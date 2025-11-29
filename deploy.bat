@echo off
chcp 65001 >nul
title 自动部署 Hugo 网站

echo ========================================
echo    Hugo 网站自动部署脚本
echo ========================================
echo.

echo [1/7] 切换到网站目录...
cd /d "G:\网站列表\NovaAtsne"
if %errorlevel% neq 0 (
    echo ❌ 错误：无法切换到指定目录
    pause
    exit /b 1
)
echo ✅ 目录切换成功

echo.
echo [2/7] 构建 Hugo 网站...
hugo
if %errorlevel% neq 0 (
    echo ❌ 错误：Hugo 构建失败
    pause
    exit /b 1
)
echo ✅ Hugo 构建完成

echo.
echo [3/7] 进入 public 目录...
cd public
if %errorlevel% neq 0 (
    echo ❌ 错误：无法进入 public 目录
    pause
    exit /b 1
)
echo ✅ 进入 public 目录成功

echo.
echo [4/7] 初始化 Git 仓库...
git init
git branch -m main

echo.
echo [5/7] 添加文件到 Git...
git add .
if %errorlevel% neq 0 (
    echo ❌ 错误：Git add 失败
    pause
    exit /b 1
)
echo ✅ 文件添加成功

echo.
echo [6/7] 提交更改...
git commit -m "更新网站 - %date% %time%"
if %errorlevel% neq 0 (
    echo ⚠️ 警告：提交失败，可能是没有更改或已经初始化
)

echo.
echo [7/7] 推送到远程仓库...
git remote add origin https://github.com/NovaAtsne/novaatsne.github.io.git 2>nul
git push -f origin main
if %errorlevel% neq 0 (
    echo ❌ 错误：推送失败
    pause
    exit /b 1
)

echo.
echo ========================================
echo   🎉 网站部署完成！
echo ========================================
echo.
echo 网站地址：https://novaatsne.github.io
echo.

timeout /t 5 >nul