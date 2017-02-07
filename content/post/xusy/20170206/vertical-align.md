+++
title = "关于 vertical-align的一些试验"
date = "2017-02-06T17:45:00+08:00"
tags = ["css"]
author = "徐溯阳"
avatar = "xusy.jpg"
+++

# 前言 
关于 vertical-align，我们很容易想到，这不就是告诉我们元素在纵向上和什么对齐的属性吗？看似很简单的定义，在实战使用时却总是不按套路出牌，带来了很多误解和困惑。事实上，正是这种宽泛的说法导致了我们对其的理解存在许多不确定性。问题就在于，“对齐”这两个字其实牵涉到4个对象：即**哪个对象的哪条线，与哪个对象的哪条线对齐？**只有将这4者搞清楚，我们才能说是理解了这个属性。

我们知道，vertical-align 有以下几类可选值：

 1. 文字：baseline、top、bottom、text-top、text-bottom、middle、sub、super
 2. 百分比
 3. 数字

其中，文字是出现的最多的，现在我就以这些值为例，来探讨一下vertical-align究竟是怎么对齐的。在阅读之前，有一些预备知识应该是必不可少的，它们是：

 1. 关于行内元素的4种box模型：containing boxes、inline boxes、line box 以及 content area。
    
 2. 关于 font-size 的 4 条参考线:topline、bottomline、baseline以及middleline。
   
 3. 关于 font-size 和 line-height 之间的关系。

以上知识可以在以下文章中看到
[深入了解css的行高Line Height属性](http://www.cnblogs.com/fengzheng126/archive/2012/05/18/2507632.html)

下面是这次我使用的例子。
**html：**

    <div class="box">
        0.Eng<sub>2</sub>lish<sup>3</sup>
        <span class="span">Englishx</span>
    </div>

**css：**

    .box{
        border: 1px solid #555;
        font-size: 28px;
        height:150px;
        line-height: 100px;
    }
    .span{
        display: inline-block;
        background-color: #ddd;
        font-size: 50px;
        margin-right: 35px;
        line-height: 80px;
    }

### vertical-align:top ###
![图片描述](../1.png)

目标元素的 inline-box 的顶端边缘，与父元素的 line-box 的顶端边缘对齐。这很好理解。

### vertical-align:bottom ###
![图片描述](../2.png)

目标元素的 inline box 的底端边缘，与父元素的 line-box 的底端边缘对齐。同样很好理解。

不过，这里有同学说了：不对啊，图片里目标元素的底端没有和父元素的底端对齐啊！注意，上面写的是与父元素的 line-box 的底端边缘对齐。那么父元素的底端边缘在哪里呢？并不是在下边框这里。这是因为，下边框是被父元素的 height 属性撑开的，父元素的 line box 的高度，是由 line-height 属性决定的。注意看上面的 css。这里的 line-height 比 height 要小，所以目标元素的底部达不到父元素的下边框。

还有一部分眼尖的同学说，还是不对呀，我目测了一下，你 css 里设置的 line-height 是 100px。但是这里目标元素的底部，离父元素的顶部似乎要大于 100px 呀？是的，你说的没错。实际上这个数字是118px，原因是，内部匿名inline box 的上标(3)和下标(2)把这个匿名 inline box 的line-height 撑大了，导致其实际 line-height 达到了 118px。如果把上标下标去掉，那就完美符合啦。


### vertical-align:middle ###
![图片描述](../5.png)

目标元素的 inline-box 的垂直平分线，与父元素内匿名inline boxes的 middleline 对齐。这个属性恐怕是实战中使用最频繁的属性了。

这里出现了几个新东西，需要多说几句。垂直平分线，这个容易理解。那什么是“父元素内匿名inline boxes，什么又是“父元素内匿名 inline boxes 的 middleline”？

首先，父元素内匿名inline boxes，你可以假设成直接写在父元素内的纯文字。由于它被父元素直接包裹，所以各种属性，包括line-height 和 font-size 等等，都是直接继承自父元素。当然，父元素内未必真的存在文字，它内部可能没有任何匿名inline boxes，但是，当 vertical-align 参与计算的时候，所参照的就是这个**可能并不存在的**匿名inline boxes。

好了，轮到 middleline。middleline 之前被我放在了预备知识里，这里再多引申一点。按照规范，middleline 是文字的 baseline 往上方挪 1/2 个 x字母高度 的位置，所在的那条线。这条线并不是content area的严格中线，但和真正几何位置的中线很接近。

为了更清楚地表示 middleline 的位置，我这里多加了3个 x 字母，很明显，middleline 穿过字母 x 的中央。

好了，理解了 `vertical-align:middle` ，我们再理解下面几个属性就简单多了。

### vertical-align:text-top ###
![图片描述](../4.png)

目标元素的 inline-box 的顶部边缘，与父元素内匿名 inline boxes 的顶线，topline对齐。这里要注意，topline 在视觉上并不和l、h这些高字母的顶端对齐，这是因为这些字母的高度都没有达到topline。topline 要比这些字母的顶端再高一些。

### vertical-align:text-bottom ###
![图片描述](../3.png)

目标元素的 inline-box 的底部边缘，与父元素内匿名 inline boxes 的底线，bottomline对齐。和 topline 不同，像 g 这样的下沉字母的底端一般都会达到 bottomline 的位置。

### vertical-align:baseline ###
![图片描述](../8.png)

这个默认属性反而放到后面来说？为什么？因为这里和上面有一点不同。在上面的情况下，目标元素参与对齐的参考线，都是 inline-box 的上下边缘，而这里是 baseline!

### vertical-align:sub ###
![图片描述](../6.png)

目标元素的 inline-box 的 baseline，与父元素内下标（sub 标签）的 inline boxes 的 baseline 对齐。

### vertical-align:super ###
![图片描述](../7.png)

目标元素的 inline-box 的 baseline，与父元素内上标（sup 标签）的 inline boxes 的 baseline 对齐。