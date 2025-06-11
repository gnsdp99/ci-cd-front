# Stage 1: Build the frontend application
FROM node:20-alpine as build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build # 이 명령은 package.json에 정의된 빌드 스크립트여야 합니다.

# Stage 2: Serve the frontend with Nginx
FROM nginx:alpine as production-stage

# Build stage에서 빌드된 정적 파일들을 Nginx의 기본 웹 루트로 복사합니다.
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]