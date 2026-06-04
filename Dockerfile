# Stage 1: Build the React application
FROM node:22-alpine AS build
WORKDIR /app

# Copy dependency files to leverage Docker caching
COPY package*.json ./
RUN npm install

# Copy the rest of the application files and build
COPY . .
RUN npm run build

# Stage 2: Serve the static files with Nginx
FROM nginx:stable-alpine

# Copy the compiled build from Stage 1 to Nginx's public directory
# Note: Change "dist" to "build" if you are using Create React App instead of Vite
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for traffic
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]