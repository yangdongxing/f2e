## Coming soon

### 目录说明
* archetypes: 模板目录（可忽略）
* content: 文章目录（主战场）
* public: 线上今天目录（程序生成）
* static: 静态资源文件
* data: hugo 数据目录
* layouts: hugo 页面样式模板
* themes: hugo 主题
* 其它

### 路由说明
`http://site.com//blog/:year/:month/:day/:slug/`

年月日取文章 `date`， `slug` 取文章 `slug`，如无为 `title`

### 新建文章
* 如果本地有 `hugo` 环境的话，执行 `hugo new [relative new content path]` 自动生成文章。
* 如果没有，可以手动复制 `archetypes/default.md` 文件到 `article` 目录下

文章为 `markdown` 格式。开头 `+++` 为 `toml` 格式申明（照抄即可）。
PS: 个人建议图片放在文章同级目录下，便于迁移，当然也可以单独放在 `static` 下

### 预览
这个. 需要有本地服务咧。

执行 `hugo server --watch --buildDrafts`，访问 127.0.0.1：1313

### 发布
执行 `hugo`。会自动生成 `public`


### 206 启动
'''
hugo server -b http://f2e.dxy.net/blog --appendPort=false --buildDrafts --watch
'''
