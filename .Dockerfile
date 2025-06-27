FROM nginx:1.26.1

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential \
	libpcre3-dev \
	zlib1g-dev \
	libssl-dev \
	git \
	curl \
	&& rm -rf /var/lib/apt/lists/*

# Download NGINX and nginx-rtmp-module source
ARG NGINX_VERSION=1.26.1
ARG NGINX_RTMP_MODULE_VERSION=1.2.2
WORKDIR /usr/src
RUN curl -O http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
	&& tar -xzf nginx-${NGINX_VERSION}.tar.gz \
	&& git clone https://github.com/arut/nginx-rtmp-module.git \
	&& mv nginx-rtmp-module nginx-${NGINX_VERSION}/nginx-rtmp-module

# Compile NGINX with the RTMP module
WORKDIR /usr/src/nginx-${NGINX_VERSION}
RUN ./configure --with-compat --add-module=./nginx-rtmp-module \
	&& make modules \
	&& cp objs/*.so /etc/nginx/modules/

# Configure NGINX to load the module and set up RTMP
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 1935 8080
CMD ["nginx", "-g", "daemon off;"]