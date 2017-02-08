# 环境搭建

[`Installing Hugo`](https://gohugo.io/overview/installing)

# 项目构建

    # 预览
    npm start

    # 构建
    npm run build

    # 发布到 Github
    npm run publish

# 新增文章

### 主要目录

    ./content       # 源文件
    ./static/media  # 头像
    ./config.toml   # 请在[params.authors]下自行添加昵称与头像的映射

### 文章头

     title = "Markdown Demo"              # 标题
      date = "2016-02-22T17:18:13+08:00"  # 日期
      tags = ["dmeo"]                     # 标签列表
     draft = true                         # 是否为草稿
    author = "f2e"                        # 作者
    avatar = "huot.jpg"                   # 头像

### tips
- 新建文章：`hugo new [path]/[name].md`，例如，`hugo new post/huot/test.md`
- 自定义截断：md 中加 <!--more--> 可自定义文章列表中的详情长度（默认 70）
- 路由说明：`http://site.com/blog/:year/:month/:day/:slug`，图片链接：content 同目录下为 ../xx.jpg

# 其他
- 线上地址：`http://dxy-developer.github.io/f2e`
- 问题反馈：`huot@dxyer.com`