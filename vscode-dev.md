# for development
本说明适用于前后端分离的本地化开发调试，尤其是对域名有一定依赖的项目，通过本地域名模拟线上服务。本地域名解析管理推荐使用SwitchHosts。

## for vue

在vue.config.js中设置
```
  devServer: {
    port: 7070,
    publicPath: process.env.VUE_APP_PUBLIC_PATH || '/',
    disableHostCheck: process.env.NODE_ENV === 'development',
    proxy: {
      '/api': {
        target: process.env.VUE_APP_API_DEBUG_HOST ? process.env.VUE_APP_API_DEBUG_HOST : 'http://local.project.domain.com/api',
        ws: true,
        changeOrigin: true,
        pathRewrite: {
          '^/api': ''
        }
      }
    }
  },
```
VUE_APP_API_DEBUG_HOST的保留是为了在开发时可以通过在.env.local中临时修改这个配置，调整为生产或预览环境的api地址。

1. 通过port指定一个固定的端口。这样设置的理由是便于通过当npm run serve时在固定端口启动，然后在nginx向这个端口代理。
2. 设置proxy，将api代理到local.project.domain.com下的api。
3. 在nginx中增加一个站点local.domain.com。实现第1条中的代理。其中host.docker.internal为mac上docker容器内访问宿主机的地址。portal只是举例，也可以是其他path或者根/。
    location /portal/ {
        proxy_pass http://host.docker.internal:7070/portal/;
        proxy_set_header Host            $host;
        proxy_set_header X-Real-IP       $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
4. 在nginx中增加一个站点local.project.domain.com。这个站点负责实现接口服务的本地部署。
5. local.domain.com和local.project.domain.com都解析到127.0.0.1。


在浏览器中打开local.domain.com，就能够看到正在debug的前端页面了。

前端页面调用过程：
1. 浏览器，local.domain.com/portal
2. nginx，proxy_pass到http://host.docker.internal:7070/portal/
3. vscode或开发主机的终端中运行的npm run serve

后端接口调用过程
4. 当前端调用api接口时，首先访问的是local.domain.com/api
5. devServer中的proxy设置将api的请求代理到http://local.project.domain.com/api或者VUE_APP_API_DEBUG_HOST指定的地址。

## for api

在nginx中增加一个站点local.project.domain.com。这个站点负责实现接口服务的本地部署。