# 前端博客项目

### 初始化项目
clone 本项目 git@gitlab.dxy.net:f2e/blog-hugo.git。

备注，有个偷懒未改动的地方是， `bin` 的自动脚本目录中对应的 `remote name` 未改回来， `origin` 对应线上 `github` 项目，`gitlab` 对应线下 `gitlab`

### 新增文章说明
目前文章为 `markdown` 格式，在 `content` 目录下。

* 方式一： 如果本地安装了有 `hugo` 服务器，执行 `hugo new [relative new content path]` 可自动生成新文章。
* 方式二： 复制 `archetypes/default.md` 到 `content` 目录下。

具体格式可参考 `content/post/demo/tech-stack.md`。建议采用目录的形式。

### 效果预览
这个貌似得依赖服务器了。

执行 `hugo server --watch --buildDrafts`，访问 `127.0.0.1：1313`

如果没有，直接进入下一步，在测试线中预览（建议开 draft 参数，目前测试线直接做了跳板机，自动发布上线）

### 发布
执行 `git push`。

备注：跳板机上未做冲突处理，不建议直接提交到 `github` 目录

### 链接地址
线上博客地址： [http://dxy-developer.github.io/f2e/](http://dxy-developer.github.io/f2e/)

测试线地址(内网可访问)： [http://f2e.dxy.net/blog/](http://f2e.dxy.net/blog/)

### markdown 文件头说明
采用 `toml` 格式。[详细说明](https://gohugo.io/content/front-matter/)

* title = "标题，必须"
* date = "2012-01-12 必须"
* tags = ["标签类别"]
* draft = true  // 是否为草稿
* author = "f2e"  // 作者

### 关于作者图片说明
在根目录 'config.toml' 中配置与作者名对应的图片地址，存放于 `static/media` 中。

### 路由说明
`http://site.com/blog/:year/:month/:day/:slug/`

年月日取文章 `date`， `slug` 取文章 `slug`，如无为 `title`

### FAQ
* 图片链接：`content` 同目录下为 `../xx.jpg`
* `markdown` 中加 `<!--more-->` 可自定义文章列表中的详情长度（默认 70）

## 开发文档
### 目录说明
* archetypes: 模板目录（可忽略）
* content: 文章目录（主战场）
    - post: 大类别目录，比如 `css`, `js` ...
* public: 线上今天目录（程序自动生成）
* static: 静态资源文件
* data: hugo 数据目录
* layouts: hugo 页面样式模板
* themes: hugo 主题
* bin/hook: 一些相关自定义 `shell` 及服务
* 其它

### 发布 github(暂时废弃)
~~执行 `sh bin/deploy.sh MSG`。 `MSG` 为提交的 Log~~

### 本地调试
#### 预览
这个. 需要有本地服务咧。

执行 `hugo server --watch --buildDrafts`，访问 `127.0.0.1：1313`

#### 编译
执行 `hugo`。会自动生成 `public`

#### 206 启动
`sh bin/start.sh`
