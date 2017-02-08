# 环境搭建

[`Installing Hugo`](https://gohugo.io/overview/installing)

# 项目构建

    # 预览
    npm start

    # 发布到 github 需要配置 ssh-key
    npm run publish [commit message]

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
- 自定义截断：`md`文件中插入`<!--more-->`可自定义文章截断位置，默认截断长度为`70`

# 其他
- 线上地址：`http://dxy-developer.github.io/f2e`
- 问题反馈：`huot@dxyer.com`