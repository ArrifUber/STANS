# Build

FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . .
RUN npm run build
RUN npm prune --production

# Serve

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]