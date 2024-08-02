# Use the official Node.js as a base image
FROM node:16-alpine as build-stage

# Install pnpm

# Set working directory
WORKDIR /app

# Copy package.json and pnpm-lock.yaml to the working directory
COPY package.json ./

# Install dependencies using pnpm
RUN npm install

# Copy the rest of the application code
COPY . .

# Run the build command (replace with your actual build command)
RUN  npm run build

# Second stage: Use Nginx to serve the built static files
FROM nginx:1.21

# Copy the built static files from the previous stage to Nginx's default static directory
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose Nginx's default port (80)
EXPOSE 80

# Start Nginx in the foreground when the container starts
CMD ["nginx", "-g", "daemon off;"]
