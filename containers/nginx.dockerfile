FROM nginx:1.23.1

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf