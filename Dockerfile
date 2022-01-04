# Using as creates a build step that will follow all instructions below until another FROM is found
FROM node:16-alpine as builder
WORKDIR '/app'

COPY ./package.json ./
RUN npm install

COPY ./ ./
RUN npm run build

# When copying we can use --from to use data from the previous build step
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html