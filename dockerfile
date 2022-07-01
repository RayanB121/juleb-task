FROM node:18 As development
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .


FROM node:18 as build 
WORKDIR /app
COPY package*.json ./
COPY  --from=development /app/node_modules ./node_modules
COPY . .
RUN npm run build
RUN npm ci --only=production && npm cache clean --force


FROM node:18-alpine as production
COPY --from=development /app/build ./build
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
EXPOSE 8080
CMD ["node","dist/main"]