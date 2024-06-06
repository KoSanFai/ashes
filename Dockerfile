FROM node:latest as builder
WORKDIR /app
COPY package.json .
RUN npm install --registry=http://registry.npm.taobao.org
COPY . .
RUN npm run build

FROM nginx:latest
COPY --from=builder /app/dist /usr/share/nginx/html