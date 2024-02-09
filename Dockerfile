# Stage 1: Build Angular application
FROM node:18.13 as builder
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Stage 2: Serve Angular application using Nginx
FROM nginx:1.15.1-alpine
# WORKDIR /var/www/html
# RUN rm -rf ./*
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT [ "nginx","-g","daemon off;" ]
