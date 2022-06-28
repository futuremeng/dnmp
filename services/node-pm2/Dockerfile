#Dockerfile
#制定node镜像的版本
ARG  NODE_VERSION
FROM ${NODE_VERSION}

ARG TZ

ARG CONTAINER_PACKAGE_URL

# 修改镜像源
# RUN if [ "${CONTAINER_PACKAGE_URL}" != "" ]; then \
#         sed -i "s/dl-cdn.alpinelinux.org/${CONTAINER_PACKAGE_URL}/g" /etc/apk/repositories; \
#     fi


# 解决could not get uid/gid问题，https://www.jianshu.com/p/d460ec3c693f
# RUN npm config set unsafe-perm true
# 安装指定版本，解决与node和npm的版本兼容问题
# RUN npm install pm2@3.2.8 -g

# Set working directory
# WORKDIR /usr/app

# Install PM2 globally
RUN npm install --global pm2

WORKDIR /usr/apps

# Copy "package.json" and "package-lock.json" before other files
# Utilise Docker cache to save re-installing dependencies if unchanged
# COPY ./package*.json ./

# Install dependencies
# RUN npm install --production

# Copy all files
# COPY ./ ./

# Build app
# RUN npm run build

# Expose the listening port
# EXPOSE 3000

# Run container as non-root (unprivileged) user
# The "node" user is provided in the Node.js Alpine base image
# USER node

# Launch app with PM2
# CMD [ "pm2-runtime", "start", "npm", "--", "start" ]
# pm2-runtime start /usr/process.yml
# CMD ["pm2-runtime", "start", "/usr/process.yml"]