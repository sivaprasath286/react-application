# This will be used for production
#We will be using multi-step build process: Refer to OneNote/ML/Docker/Docker in Production

#Below is the base image of node (Build Phase)
FROM node:16-alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


#Below is the base image of NGINX (Run Phase)
FROM nginx
#The below copies a folder from a different phase (build phase) to the '/usr/share/nginxhtml'
COPY --from=builder /app/build /usr/share/nginx/html   



