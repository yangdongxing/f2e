+++
title = "CSS 自定义滚动条"
date = "2016-04-04"
tags = ["CSS"]
draft = false
author = "霍腾"
avatar = "huoteng.png" 
+++

最近遇到的一个需求，由于移动端空间有限，表格不能完整显示，为了让用户知道可以通过左右滑动来查看表格的完整信息，PM 希望能模拟一个水平滚动条来提醒用户。具体需求如下（或者您也可以查看线上实例，[丁香诊所](http://hz.dxy.com) → 医疗团队 → 排班信息）：

> PC 端效果

![排版信息 - PC](https://raw.githubusercontent.com/huoteng/blog/master/media/custom-scrollbar/duty-info-pc.png)

> 移动端效果

![排版信息 - Mobile](https://raw.githubusercontent.com/huoteng/blog/master/media/custom-scrollbar/duty-info-mobile.png)

> 移动端效果（期望）

![排版信息 - Mobile Expect](https://raw.githubusercontent.com/huoteng/blog/master/media/custom-scrollbar/duty-info-mobile-scroll.png)

要解决这个问题，我们可以去使用一些开源的滚动条插件，或者自己模拟。但是为了这么一个小功能就额外引用插件，而且为了保证设计上没有违和感，或许连同`HTML`和`CSS`也得跟着一起调整，未免小题大做了。

目前主要有两种通过`CSS`来自定义滚动条的样式，但也还是做不到兼容所有的浏览器。

### 1. 在`WebKit`中自定义滚动条

通过伪元素和 [Shadow DOM](http://www.toobug.net/article/what_is_shadow_dom.html) 来实现，David Hyatt 2009 年就在 [WebKit 官网](https://webkit.org/blog/363/styling-scrollbars/)介绍过这种方法，并列出了[所有可能的组合](http://trac.webkit.org/export/41842/trunk/LayoutTests/scrollbars/overflow-scrollbar-combinations.html)。

#### 1.1 伪元素所代表的不同部分

	::-webkit-scrollbar              { /* 1 */ }
	::-webkit-scrollbar-button       { /* 2 */ }
	::-webkit-scrollbar-track        { /* 3 */ }
	::-webkit-scrollbar-track-piece  { /* 4 */ }
	::-webkit-scrollbar-thumb        { /* 5 */ }
	::-webkit-scrollbar-corner       { /* 6 */ }
	::-webkit-resizer                { /* 7 */ }

![Scrollbar Parts](https://raw.githubusercontent.com/huoteng/blog/master/media/custom-scrollbar/scrollbar-parts.png)

#### 1.2 伪类所代表的不同状态

	:horizontal			//应用于水平滚动条
	:vertical			//应用于垂直滚动条
	:decrement			//应用于按钮和内层轨道，用来指示按钮或内层轨道是否会减小视窗的位置(如，垂直滚动条的上面，水平滚动条的左边)
	:increment			//应用于按钮和内层轨道，用来指示按钮或内层轨道是否会增大视窗的位置(如，垂直滚动条的下面，水平滚动条的右边)
	:start				//应用于按钮和滑块，用来定义对象是否放到滑块的前面
	:end 				//应用于按钮和滑块，用来定义对象是否放到滑块的后面
	:double-button		//应用于按钮和内层轨道，用来判断一个按钮是不是放在滚动条同一端一对按钮中的一个，对于内层轨道来说，它表示内层轨道是否紧靠一对按钮
	:single-button		//应用于判断一个按钮是否自己独立的在滚动条的一端，对内层轨道来说，它表示内层轨道是否紧靠一个`single-button`
	:no-button			//应用于内层轨道，表示内层轨道是否要滚动到滚动条的终端，如，滚动条两端没有按钮
	:corner-present		//应用于所有滚动条轨道，指示滚动条圆角是否显示
	:window-inactive	//应用于所有滚动条轨道，指示应用滚动条的某个页面容器(元素)是否当前被激活(在webkit最近的版本中，该伪类也可以用于`::selection`伪元素，Webkit团队有计划扩展它并推动成为一个标准的伪类)

#### 1.3 伪元素和伪类的组合使用

	::-webkit-scrollbar-track-piece:start {
	   /* Select the top half (or left half) or scrollbar track individually */
	}

	::-webkit-scrollbar-thumb:window-inactive {
	   /* Select the thumb when the browser window isn't in focus */
	}

	::-webkit-scrollbar-button:horizontal:decrement:hover {
	   /* Select the down or left scroll button when it's being hovered by the mouse */
	}

#### 1.4 简单示例

> 配合`WebKit`的伪类和伪元素，我们可以同时使用`:enabled`，`:disabled`，`:hover`等伪类，也可以去应用一些`CSS`属性，如渐变、圆角、gbba 等。具体可以看看官网给出的 [demo](http://trac.webkit.org/export/41842/trunk/LayoutTests/scrollbars/overflow-scrollbar-combinations.html)。

	::-webkit-scrollbar {
	    width: 12px;
	}
	 
	::-webkit-scrollbar-track {
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3); 
	    border-radius: 10px;
	}
	 
	::-webkit-scrollbar-thumb {
	    border-radius: 10px;
	    -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.5); 
	}

### 2. 在`IE`中自定义滚动条

> [在线的可视化工具](http://www.dengjie.com/temp/scroller.swf)，简单好用。

	scrollbar-arrow-color: color;		//三角箭头的颜色
	scrollbar-face-color: color;		//立体滚动条的颜色，包括箭头部分的背景色
	scrollbar-3dlight-color: color;		//立体滚动条亮边的颜色
	scrollbar-highlight-color: color;	//滚动条的高亮颜色
	scrollbar-shadow-color: color;		//立体滚动条阴影的颜色
	scrollbar-darkshadow-color: color;	//立体滚动条外阴影的颜色
	scrollbar-track-color: color;		//立体滚动条背景颜色
	scrollbar-base-color:color;			//滚动条的基色

### 参考资料

- [Custom Scrollbars in WebKit](https://css-tricks.com/custom-scrollbars-in-webkit)
- [[译] 什么是Shadow DOM？](http://www.toobug.net/article/what_is_shadow_dom.html)