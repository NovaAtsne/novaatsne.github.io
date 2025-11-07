@echo off
chcp 65001 >nul
echo 正在导航到目录...
cd /d "G:/网站列表/find1134"

if errorlevel 1 (
    echo Error：无法切换到目录 G:\网站列表\find1134
    echo 当前目录：%CD%
    dir G:\网站列表
    pause
    exit /b 1
)

echo 正在构建Hugo网站...
hugo

if errorlevel 1 (
    echo Error：Hugo构建失败！
    pause
    exit /b 1
)

echo 复制 README.md 到公共文件夹...
copy README.md public\README.md >nul

if errorlevel 1 (
    echo Error：复制失败！
    pause
    exit /b 1
)

echo 正在部署到GitHub...
cd public

git init
git add .
git commit -m "更新网站"

echo 正在推送到GitHub...
git remote add origin https://github.com/Find1134/find1134.github.io.git
git branch -M main
git push -f origin main

cd ..
echo 清理临时文件...
rd /S /Q public

echo.
echo 网站部署完成！
pause