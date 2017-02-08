+++
title = "HTML 桌面消息通知"
date = "2016-07-06"
tags = ["HTML5"]
draft = false
author = "yaoyj"
avatar = "yaoyj.jpg"
+++

HTML 桌面消息通知，指的是通过浏览器的 Notification 对象为用户在系统桌面设置和显示通知提醒。这样，用户就可以做自己的事情，而不用担心会错过一些消息。
<!--more-->

### 如何使用？


##### 首先向用户获取在当前网站展示系统通知的权限
获取这个权限一般在网站在初始化的时候完成，使用 ` Notification.requestPermission()`方法
```
    Notification.requestPermission().then(function(status) {
        // 根据 status 的值做一些事情 
        if (Notification.permission !== status) {
            Notification.permission = status;
        }
    });
```
返回的 status 为字符串，有三个值

- denied (用户拒绝了通知的显示)
- granted (用户允许了通知的显示)
- default (默认为 default，也就是需要询问用户是否授权，浏览器的表现和 denied 一样)

##### 之后，就可以用`Notification()`构造函数建一条新的通知
```
    var notification = new Notification(title, options);    
```
- 这里的 title 是必传的
- options 是可选的一个对象，它规定了文本的方向、通知的内容、通知的图标等等

### 属性
##### 静态属性：`Notification.permission`
表明当前通知显示的授权状态，值可能为：denied、granted、default
##### 只读属性：
- dir (文字方向，经测试都不支持)
- lang (语言)
- body (消息体)
- tag (标签)
- icon (图标地址)

这些属性，可以在创建消息的时候，作为 options 的属性传入 Notificaiton 函数。

重点提一下tag属性，它用于给相同类别的消息做标记，如果在短时间内有很多消息，系统会只显示tag标记的消息中最新的一条
### 事件处理
Notification.onclick()/onshow()/onerror()/onclose()

通常情况下，onclick事件用的比较多，比如点击消息后跳转到特定页面
### 方法
##### 静态方法：
- Notification.requestPermission() ——只能被用户行为调用，比如页面加载或用户点击

##### 实例方法（仅在Notification实例或其prototype中有效）：
- Notification.close()
- 继承自EventTarget接口：addEventListener()/removeEventListener()/dispatchEvnet()

### 举个🌰
```
    // 页面加载时，获取权限
    if (window.Notification && Notification.permission !== "granted") {
        Notification.requestPermission(function (status) {
            if (Notification.permission !== status) {
                Notification.permission = status;
            }
        });
    }
    function notifyMe() {
        // 判断浏览器是否支持Nitifocaiton
        if (!("Notification" in window)) {
            alert("This browser does not support desktop notification");
        // 判断用户是否已经准许了发送桌面通知
        } else if (window.Notification && Notification.permission === 'granted') {
        // 如果准许了，我们就发送一条消息
            var n = new Notification('Hi!', {
                body: 'hi, this is body'
            });
        // 如果用户没有准许，我们需要向用户获取权限
        } else if (window.Notification && Notification.permission !== 'denied') {
            Notification.requestPermission(function(status) {
                if (Notification.permission !== status) {
                    Notification.permission = status;
                }
                if (status === 'granted') {
                    var n = new Notification('Hi!', {
                    body: 'hi, this is body'
                    });
                } else {
                    alert('Hi!');
                }
            });
        } else {
            alert('Hi!');
        }
    }
```

（在我的 Mac 下 Chrome 中测试时，不能弹出通知，Firefox 和 Safari 都可以，但是别的电脑的 Chrome 中可以。原因我没有查到，希望查到的小伙伴告诉我一下～）
### 浏览器兼容性
现代浏览器都支持基本的属性和方法，除了 IE。具体属性和方法的支持情况，可见参考资料

下面是 Nick Desaulniers 编写的一个可以向前向后兼容各种版本的实现
```
	function sendNotification (title, options) {
	  // Memoize based on feature detection.
	  if ("Notification" in window) {
	    sendNotification = function (title, options) {
	      return new Notification(title, options);
	    };
	  } else if ("mozNotification" in navigator) {
	    sendNotification = function (title, options) {
	      // Gecko < 22
	      return navigator.mozNotification
	               .createNotification(title, options.body, options.icon)
	               .show();
	    };
	  } else {
	    sendNotification = function (title, options) {
	      alert(title + ": " + options.body);
	    };
	  }
	  return sendNotification(title, options);
	};
```

##### Chrome 备忘

在 Chrome 22 版本之前，如果要使用通知需要旧的带前缀版本的规范 ，并且使用navigator.webkitNotifications 对象创建一个新的通知实例。

在 Chrome 32 版本之前，不支持 Notification.permission 属性。

在Chrome 42 版本之前，不支持 service worker。

从chrome 49版本开始，匿名模式下的notifications不能运行。
##### Safari 备忘

Safari 在 Safari 6 版本开始支持通知，但是只能在 Mac OSX 10.8+ (Mountain Lion) 中使用。

### 参考资料
* [Notification - Web Api 接口](https://developer.mozilla.org/zh-CN/docs/Web/API/notification)
* [使用 Web Notification](https://developer.mozilla.org/zh-CN/docs/Web/API/notification/Using_Web_Notifications)

