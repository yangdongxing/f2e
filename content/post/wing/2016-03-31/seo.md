+++
title = "SEO学习笔记"
date = "2016-04-05"
tags = ["SEO"]
draft = false
author = "阿wing"
avatar = "awing.jpg"
+++

------
####  描述

关于 SEO，百度百科给出的定义是：指在了解搜索引擎自然排名机制的基础上，对网站进行内部及外部的调整优化，改进网站在搜索引擎中关键词的自然排名，获得更多的展现量，吸引更多目标客户点击访问网站，从而达到网络营销及品牌建设的目标。

百度通过一个叫做 Baiduspider 的程序抓取互联网上的网页，经过处理后建入索引中。目前 Baiduspider 只能读懂文本内容，flash、图片等非文本内容暂时不能处理，放置在 flash、图片中的文字，百度无法识别。

SEO 的策略主要包括关键词优化、对网站结构和 SEO 整站优化及 SEO 整站优化吧内容的优化、注重内链和外链的优化等。
<!--more-->

------
#### 页面结构优化

SEO 本身涉及的范围非常广，就前端而言最先应该考虑的就是网页的结构化，《百度搜索引擎优化指南2.0》指出理想的网站结构应该是更扁平一些，从首页到内容页的层次尽量少，这样搜索引擎处理起来，会更简单。

正确使用 HTML 标签，搜索引擎在搜索内容时，根据 tag 就可以清楚知道每个部分的内容是什么，可以搜索到准确的资料和资讯。

1. header 标签。header tag 能够明确地告诉搜索引擎，这里面的内容是重要的。

2. 唯一的 h1 标题。h1 在 SEO 中权重时非常重要的， 除了 h1 标签,其他的标签可以用多个,但不能泛滥。h2 标签一般用于栏目,h3 以后的标签优化效果比较低,但在组织内容结构上,可以用得上。H1>h2>h3… 在 SEO 权重中是逐渐递减的

3. article 标签，article tag 是 HTML5 新增加的这些 tag 中，对 SEO 影响最大的一个。

4. section 标签，对SEO比较合适的方案是将你所呈现的内容的每个标题用 section 将其分割出来。

5. 图片的优化，可以在img的alt标签，适当增加关键字


#### 单页面应用如何做SEO优化

越来越多的网站采用 SPA 应用，给用户更好的体验，让用户在 web 感受 natvie 的速度和流畅。
但是由于这种方式数据都需要通过 AJAX 同步、提交，而搜索搜索引擎抓取的内容，需要有完整的HTML和内容，所以并不能很好的支持搜索。

1. 为了解决这个问题，Google 提出了"井号+感叹号"的结构。
Google发现URL里有#!符号，例如 example.com/#!/detail/1，于是 Google 开始抓取 example.com/?_escaped_fragment_=/detail/1；
这种方式除了丑，还要生成一份 html 静态页面；除了兼容性好一些，并没有什么可推荐的。

2. 使用 HTML5 History API。window.history.pushState(null null, url):使用这个方法在浏览器的 History 对象中，添加一条记录。

3. 像Angular/React 这样前端框架可以使用 [Prerender](https://prerender.io/)。


#### 参考资料

* [http://www.uml.org.cn/html/201212264.asp](http://www.uml.org.cn/html/201212264.asp)

* [http://www.astralweb.com.tw/the-best-seo-practices-for-front-end-coding/](http://www.astralweb.com.tw/the-best-seo-practices-for-front-end-coding/)

* [https://isux.tencent.com/seo-for-single-page-applications.html](https://isux.tencent.com/seo-for-single-page-applications.html)

* [http://www.ruanyifeng.com/blog/2013/07/how_to_make_search_engines_find_ajax_content.html](http://www.ruanyifeng.com/blog/2013/07/how_to_make_search_engines_find_ajax_content.html)