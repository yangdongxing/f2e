+++
title = "HTML5 drag and drop"
date = "2016-04-05"
tags = ["HTML5"]
draft = false
author = "yaoyj"
avatar = "yaoyj.jpg"
+++

## HTML5 drag and drop 

*****
### 拖放简介：
拖放操作的过程是怎样的？ 
>允许用户在一个元素上点击并按住鼠标按钮，拖动它到别的位置，然后松开鼠标，元素停留在该位置。在拖动的过程中，被拖动元素以半透明的形式展现，并跟随鼠标指针移动。

在早期的 IE4 中的网页上，只有文本和图片可以拖动，并且唯一有效的放置目标就是文本框。随着浏览器的发展，拖放功能也得到扩展，现在几乎网页中的任何元素都可以拖放，并且任何元素都可以作为放置目标。HTML5 就以 IE 的实例为基础制定了拖放规范。现对其主要内容做了整理。


### 拖放步骤：
>1. 定义可拖放目标
2. 定义被拖动的数据
3. 定义拖动过程中鼠标指针旁边出现的反馈图片
4. 允许设置拖拽效果
5. 定义放置区域
6. 拖放结束时，完成数据交互等工作


### 帮助实现拖放的一些特性：

- **属性**：`draggable`
    - 设为 true，则该元素可拖放
    - 在 html 中，图片、超链接、被选中文本，这些元素默认就是可拖拽，可以不用设置该属性

``` html
<div draggable="true" ondragstart="event.dataTransfer.setData('text/plain', '这里是想要拖动的元素')">
  这里是想要拖动的元素
</div>

```
___
- **事件**：
    - 事件的目标是被拖动的元素
        - `dragstart`
        - `drag`
        - `dragend`
    - 事件的目标是作为放置目标（droptarget）的元素
        - `dragenter`
        - `dragover`
        - `dragleave`／`drop`
___
- **对象**：`event.dataTransfer`
    - 用于实现数据交换，可在拖放事件的事件处理程序中访问
    - 方法：`setData()`，设置拖放要传递的数据
        - 参数1: text/URL，表示保存的数据类型（HTML5 允许各种 MIME 类型，但 IE 只支持着两种）
        - 参数2: 要保存的数据
    - 方法：`getData()`，获取拖放传递的数据，只能在 `drop` 事件处理程序中使用
    - 属性：`dropEffect`
        - 值：none/move/copy/link，
        - 表示元素拖动到 droptarget 上时鼠标的效果
        - 必须在 ondragenter 事件中使用
    - 属性：`effectAllowed`
        - 值：none/move/copt/link/all/...
        - 跟 dropeffect 搭配使用，表示允许拖动元素的哪种 dropeffect


### 代码示例：

``` javascript
	$(被拖动元素).on("dragstart", function (e) {
	    /*开始拖拽源文本*/			
	    e.preventDefault();
	    e.dataTransfer.effectAllowed = "move";
	    e.originalEvent.dataTransfer.setData("text", '要传递的数据');
	    return true;
    });
    
    $(被拖动元素).on("dragend",  function(ev) {
        /*拖拽结束*/
        ev.dataTransfer.clearData("text");
        eleDrag = null;
        return false
    };

	$(放置目标元素).on("dragover", function (e) {
	    /*拖拽元素在目标元素头上移动的时候*/
		e.preventDefault();
		return true;
	});
	
	$(放置目标元素).on("dragenter",  function(ev) {
        /*拖拽元素进入目标元素头上的时候*/
        return true;
    };

	$(放置目标元素).on("drop", function (e) {               
	    /*拖拽元素进入目标元素头上，同时鼠标松开的时候*/
		var	data = e.originalEvent.dataTransfer.getData("text");
		/*阻止在Firefox中拖拽打开新标签*/
		return false;
		}
    	
	});

```

---
### 注意点：

- 在 dragstart 事件中必须使用 `event.preventDefault()`，否则 drag 事件不能触发，也就不能实现拖拽；
- 在 dragover 事件中也必须使用 `event.preventDefault()`，否则 drop 事件不会触发；
- 需在 drop 事件中使用 ` return false; `， 解决 Firefox 中拖拽元素会直接打开新标签的问题；
- 为了减少事件，可以在 dragenter 的时候绑定方法 ，而 dragleave 的时候删除方法；
- 在 dragover 上不要做数据处理，它类似mouseover，在拖动的过程中会不断触发，可能会导致浏览器崩溃
- drag 事件和 mouse 事件不能同时触发



---
### 兼容性：
浏览器支持：IE10+、Firefox 4+、Safari 5+和Chrome。

---

### 参考文档：
https://developer.mozilla.org/zh-CN/docs/DragDrop/Drag_and_Drop

http://www.zhangxinxu.com/wordpress/2011/02/html5-drag-drop-%E6%8B%96%E6%8B%BD%E4%B8%8E%E6%8B%96%E6%94%BE%E7%AE%80%E4%BB%8B/