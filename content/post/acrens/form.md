+++
title = "经验杂谈 - 魔性表单"
date = "2016-04-05"
tags = ["form","自动提交","required","novalidate"]
draft=false
author = "acrens"
avatar = "acrens.jpeg"
+++

----

#### 表单
这里先解释表单，相信大家看到这里已经知道是什么了；没错，这里说的表单就是 html 中的 form 表单。

HTML5 中 form 做了一些优化，比如增加 novalidate 属性，可以控制 form 无需校验提交；给 form 内部 input 增加 required 属性，结合 validate 既可以控制表单必填字段校验，又无需写 js 代码校验。

HTML5 自动校验截图：
![Alt text](/images/share1.png)


在这里在特别说明下 form 的 enctype 属性；用于设置表单提交数据的编码，默认编码格式：application/x-www-form-urlencoded，在发送前会对所有字符进行编码；当为值 multipart/form-data 时，并不对字符进行编码，一般在文件上传时一定要使用该类型；另外还有一个不经常使用的值：text/plain，提交数据会以存文本形式编码，且不包含格式字符。
<!--more-->

----

#### 魔性
魔性给我们带来的感觉就是很神奇，为什么会这样；这里所说的魔性跟 form 提交相关联。

在一次项目开发中，曾经碰到这样的问题，在一个页面上有一个 input 输入框，同时有一个提交按钮，input 需要支持 enter 按键提交，并且提交之前需要 JS 校验。
![Alt text](./images/share2.png)

此时，我正在调试 enter keyup input 输入框，死活都不进入我的 keyup 事件监听函数里，后面就开始进行了扫盲行动，在某搜索引擎输入关键字 "form 自动提交"关键词，难题迎刃而解。

在没有 JS 处理的情况下，form 有以下一些表单提交方式：

> * 如果 form 表单里有 type 为 submit 的按钮存在，不管 form 内部有一个文本框还是多个文本框都会触发按钮提交生效。

> * 如果按钮不是 input，而是用 button，并且没有加 type，IE 下默认为   
 type = button 触发不提交，Chrome 默认为 type = submit 触发提交。

> * 对于其它表单元素，如 textarea、select、radio、checkbox 不影响触发规则。

> * 最奇怪的是如果有 type="image" 的 input 效果等同于 type="submit"。

> * 如果 form 表单里面只有一个 type="text" 的 input 文本框，不管按钮是什么type，回车键都会自动提交 form（我遇到的问题）。

-----
#### 解决方案
在 form 里面再添加一个 input 输入框，type 不可以为 hidden，否则无效：
![Alt text](./屏幕快照 2016-03-31 下午10.59.42.png)


在最底部我添加了一个 input 输入框 type="text"。 

