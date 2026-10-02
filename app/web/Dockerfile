FROM nginx:1.27-alpine

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# APP_API_URL is injected as an ECS task environment variable (internal ALB DNS name)
ENV APP_API_URL=http://localhost:8080

EXPOSE 80

# nginx:alpine's docker-entrypoint auto-runs envsubst on /etc/nginx/templates/*.template
# using APP_API_URL at container start, writing the result to /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
