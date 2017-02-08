+++
title = "rem 的使用"
tags = ["css"]
date = "2016-04-05T15:50:37+08:00"
draft = false
author = "libr"
avatar = "libr.png"
+++

------
###  背景：

<p>最近因为调查问卷的需求，需要在移动端整体缩放页面，故考虑使用 rem 。</p>

###  简介：

> <p>px 相对于显示器屏幕分辨率而言的。</p>
> <p>em 相对于当前对象内文本的字体尺寸。如当前对行内文本的字体尺寸未被人为设置，则相对于浏览器的默认字体尺寸。</p>
> <p>rem 相对于根元素的字体大小的单位。</p>

<!--more-->

------
###  原因：
####  为什么选择 rem ,我的理由如下：
1. 精准缩放，等比例适应所有屏幕
<p>不少页面采用流体布局或者百分比来设置宽度间距，高度被定死。当设备宽度较大时，页面会被横向拉长，变形。同时过多的百分比，对设计造成阻碍，兼容也比较难调。当页面采用响应式设计的时候，虽然能够很好的兼容不同手机，但是维护成本相继增大，大量的媒体查询样式难以管理，并且只有在固定的几个分辨率下才能有最好的体验。</p>
<p>还有种粗暴的方式就是直接 viewport 缩放，不过实测有的时候感觉画面某部分会糊，并且页面部分高度不足的情况下强行缩放，会造成手机上页面只占很小的高度，甚至不超过手机屏幕的高度，很难控制外观样式。</p>
<p>最后，rem 就是很好的选择了。移动端兼容良好，所有的长度都根据根元素的字体大小值来改变，根元素的字体大小只要跟随屏幕大小动态变化，就可以精准缩放页面且画面保真。</p>

2. 移动端兼容性良好，使用简单
3. 易于维护修改

### 使用：
#### 动态赋值页面根元素(html)的字体大小

	(function (doc, win) {
		var docEl = doc.documentElement,
 		resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize';
	
		var recalc = function () {
			var width = docEl.clientWidth;

			if (width > 640) {
				width = 640 ;
			}
			if (width < 320) {
				width = 320 ;
			}

			docEl.style.fontSize = 100 * (width / 1080) + 'px';		//1080 是设计图的宽度	
		  };
		recalc();


		if (!doc.addEventListener) return;
		win.addEventListener(resizeEvt, recalc, false);
	})(document, window);

页面引入这段脚本，再根据实际设计图取值，给相应的部位设置 css。

例如根元素(html)字体大小为 100 像素时，宽为 100 像素的 div，其样式设置为 width:1rem; 。

### 心得：
1080 是设计图宽度，这样可以直接在图上量取数值，写在样式中。例如间距 40px ，赋值 0.4rem 。

chrome 支持的最小字体为 12px，所以设置为 100px，方便取值。

### 兼容：
![rem 兼容性](../rem.jpg)

### 坑：
<p>随着越来越多的项目使用，后面在此补上具体坑。</p>