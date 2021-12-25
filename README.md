# vaultwarden-compose

[vaultwarden](https://github.com/dani-garcia/vaultwarden) 的 docker-compose 一站式解决方案，免去准备环境的困惑，减少迁移服务器的成本。

### Usage

#### 先行准备

1. 一个域名

2. 一台预装了 `docker` 、 `docker-compose` 的服务器

3. 将域名解析到你的服务器 ip ，我们这里假设他为 `bit.example.com` 

4. 决定好你的 https 方式：如 `cloudflare` 边缘证书，`Let's Encrypt` 等


#### 打开方式

1. 拉取 / 上传本项目的文件到你的服务器，将本项目 `opt/*` 内的 `bitwarden` 与 `nginx` 文件夹置于服务器的 `/opt` 文件夹下，我们将使用 `/opt/bitwarden` 存放数据，`/opt/nginx` 存放 nginx 配置

2. 修改 `/opt/nginx/configs/site/template.conf` 文件：

     - 配置域名：替换全部的 `{{SITE_DOMAIN}}` 为你的域名，如 `bit.example.com`

     - 配置 https ：配置好证书存在位置的选项 `ssl_certificate` 和 `ssl_certificate_key` （我们约定存放于 `/opt/nginx/configs/pem/{{SITE_DOMAIN}}/*` 内）

3. 将 `docker/docker-compose.yml` 放到服务器任意一个你想存放的地方，然后在该目录下执行：

    ```bash
        docker-compose up -d
    ```

4. 打开服务器 `80` 和 `443` 端口，即可开始使用！


注：为了安全，默认关闭了注册功能，你可以在 `docker-compose.yml` 内修改 `SIGNUPS_ALLOWED` 的值。

### Migration

#### 容灾

容灾时，请备份 `/opt/bitwarden` 文件夹到 oss / 网盘 等。

#### 迁移

迁移时，只需将上次备份的数据存放于 `/opt/bitwarden` ，其他按照以上流程配置启动即可。

### Monitor

以下是 `nginx` 容器内的日志监控位置：

path|description
:-|:-
`/var/log/nginx/error.log`| nginx 全局错误日志
`/var/log/nginx/{{SITE_DOMAIN}}.log`|网站 nginx access 日志
`/var/log/nginx/{{SITE_DOMAIN}}.error.log`|网站 nginx error 日志

其他 docker 操作手法此处不予多述。
