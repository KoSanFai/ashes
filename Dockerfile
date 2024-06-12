# FROM node:latest as builder
# WORKDIR /app
# COPY package.json .
# RUN npm install --registry=http://registry.npm.taobao.org
# COPY . .
# RUN npm run build

# FROM nginx:latest
# COPY --from=builder /app/dist /Users/kosanfai/ecs/usr/share/nginx/html

# 使用官方 Node.js 镜像作为基础镜像
FROM node:latest

# 设置工作目录
WORKDIR /Users/kosanfai/app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 复制项目文件到工作目录
COPY . .

# 构建前端项目
RUN npm run build

# 使用 Nginx 作为 Web 服务器
FROM nginx:alpine

# 将构建的文件复制到 Nginx 默认的静态文件目录
COPY --from=0 /Users/kosanfai/app/dist /Users/kosanfai/ecs/usr/share/nginx/html

# 暴露 Nginx 端口
EXPOSE 80

# 启动 Nginx
CMD ["nginx", "-g", "daemon off;"]