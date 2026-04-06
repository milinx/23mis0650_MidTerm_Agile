# Use Nginx as the lightweight web server
FROM nginx:alpine

# Copy your HTML file to the Nginx public folder
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
