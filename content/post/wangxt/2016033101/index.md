+++
title = "处理移动端文章两端对齐的一点微小经验"
date = "2016-03-31T17:23:13+08:00"
tags = ["CSS"]
draft = false
slug = "mobile-article-align-justify-minor-experience"
author = "wangxt"
avatar = "wangxt.jpg"
+++

最近处理了一个移动端的文章详情页面，产品的需求是要做到正文区块内的内容能够两端对齐。

在这里分享实现过程中一点微小的经验。

<!--more-->

注：以下演示均未添加浏览器 prefix，请各位自行添加。推荐使用 [autoprefixer](https://github.com/postcss/autoprefixer)。

以下代码均在 webkit/blink 引擎浏览器下测试，未考虑 Gecko。

先来构造一个最小 demo：

```html
<article class="content">
   <p>
      政黨或了底乎實運外球便易華公你物實。人病說？容不排。  中有那童節完放回什這，麼題容。問酒後但感臺？人機資良他主金同樣合車後們義質境不經對都專天林息密了和去中我聲……間言分的門同、三行方之友一濟才？？面球發一一看消示個以麼期造，我金民家不心直能，理方斯生那不近理製室示每連態生和片得人會美……是山求寫南工，沒元身山統熱現研後我心出筆息不。件談是條國求重：  也為活國到後得常命經求？
   </p>
</article>
```

```css
.content {
    width: 50%;
    background: #fff;
    margin: 50px auto;
}

.content p {
    padding: 5px;
}
```

大概是这么一个效果：

![1.png](../images/812DE944B087ABDAE674280AA7019BA8.png)

看着还好嘛，不过仔细看会发现右边确实不太整齐。为了善待强迫症，让我们加上两端对齐的 css。

```css
p {
    text-align: justify;
}
```


![2.png](../images/A60CA2C1C3A39C6D9FB24E0C5743F6C6.png)

搞定。不过这个属性在 Firefox 下对中文标点的支持有点问题，由于我们是处理移动端，就暂且按下不表。

但是等等，如果有很长的英文溢出怎么办？

比如说这样：

```html
...
<p>    
    WTFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
</p>
...
```

![3.png](../images/35EAC982FD1C45BB53549A686EABC90F.png)

立马就破功了。这个时候我们一般会加什么属性？

* `overflow: hidden` : 隐藏超出部分
* `word-break: break-all` : 强制超过容器的部分换行

好，那我们都加上：

```css
p {
    text-align: justify;
    overflow: hidden;
    word-break: break-all;
}
```

![4.png](../images/BD66B650252DA552276571522723D63E.png)

好，溢出问题也解决了。这下总可以交差了吧？等等，让我们看下如果是一篇真正的英文文章会出现什么情况：

```html
...
<p>
The first thing you'll want to do is to draw boxes around every component (and subcomponent) in the mock and give them all names. If you're working with a designer, they may have already done this, so go talk to them! Their Photoshop layer names may end up being the names of your React components!
</p>
...
```

![5.png](../images/DBA8F9BDE0818B335A20A021EB2D18E6.png)

我们会发现不该换行的地方全被截断了。这可怎么办？看来问题是出在 `word-break: break-all` 上了。我们来看下这个属性的详细解释：

> # word-break
> The word-break CSS property is used to specify whether to break lines within words.
> * normal : Use the default line break rule.
> * break-all : Word breaks may be inserted between any character for non-CJK (Chinese/Japanese/Korean) text.
> * keep-all : Don't allow word breaks for CJK text.  Non-CJK text behavior is the same as for normal.

[word-break - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/word-break)

`break-all` 表示所有的非中日韩字符间都可能被换行，这就有点麻烦了。任意换行的英文非常难读，因此要想个办法处理才行。

但其实 `word-break` 有个只有 webkit/blink 引擎支持的属性，`break-wrod`。通过这个属性，我们可以让英文句子在正确的位置换行，但如果实在没有地方可以打断，会进行强制打断。但它是个非标准属性，通过 Google 可知，它的效果基本等同于 `word-wrap: break-word`。

> # word-wrap
> The word-wrap property is used to specify whether or not the browser may break lines within words in order to prevent overflow when an otherwise unbreakable string is too long to fit in its containing box.
> * normal : Indicates that lines may only break at normal word break points.
> * break-wrod : Indicates that normally unbreakable words may be broken at arbitrary points if there are no otherwise acceptable break points in the line.

[word-wrap - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/word-wrap)

我们使用这个属性来替代 `word-break` 来看看效果。

```css
p {
    text-align: justify;
    overflow: hidden;
    word-wrap: break-word;
}
```

![6.png](../images/F94AFBC735957DD932C300CBE758D922.png)

进行到这里我们基本上已经达成了目的。但如果你还想对英文做进一步的优化的话，可以考虑添加 `hyphens: auto` 这个属性。这样英文单词会在必要的时候添加连字符换行，可以避免有时为了在空格处换行造成的每行词间距疏密差距过大的问题。

由于这个属性对中文没有作用，而且兼容性不佳（移动端暂时只在 Safari 中有作用）因此以用得比较少，这里也不多做介绍，各位可以看看效果。

```css
p {
    text-align: justify;
    overflow: hidden;
    word-wrap: break-word;
    hyphens: auto;
}
```

![7.png](../images/C71770943A12A21B8FAE28C8150FF99E.png)

要注意的是，`hyphens: auto` 是会根据 `lang` 属性中的语言来调整添加连字符的策略的，因此如果我们的网页 `html` 元素中写的是 `lang="zh-CN"` ，那么这个属性完全不会有效果，因此需要换成 `lang="en"`。如果不想更换整个页面的语言申明的话，也可以在需要使用这个属性的元素上单独添加 `lang` 属性。

```html
<p lang="en">xxx</p>
```
[hyphens - CSS | MDN](https://developer.mozilla.org/en-US/docs/Web/CSS/hyphens)

[最终 demo](http://codepen.io/wxt2005/pen/pywoqR?editors=1100)（请在 webkit/blink 引擎浏览器下打开）
