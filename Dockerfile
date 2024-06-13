# node block
FROM node:alpine3.20 as nodework
WORKDIR /myapp
COPY package.json .
RUN npm install
COPY  . .
RUN npm run build

# nginx blick
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=nodework /myapp/dist .
ENTRYPOINT [ "nginx","-g","daemon off;" ]
