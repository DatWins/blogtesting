---
title: "Dark and Light mode images on Hugo"
date: "2024-05-20"
summary: "Auto-switch images based on theme."
toc: true
readTime: true
autonumber: true
showTags: false
---

## The Problem

During the writing of my first blog post, I found a problem with images. The drawings I made are png with a transparent background, and, since the lines are black, they look horrible on dark mode, as you can see below.

![img](img.webp)

I wanted a quick way to define light and dark mode images for Hugo.

## Solution

GitHub lets users specify in which theme they want readme images with two tags:

```
![img](./dark.png#gh-dark-mode-only)
![img](./light.png#gh-light-mode-only)
```

I decided to do something similar, definining two tags, `#dark`, and `#light`. 

```
![img](./dark.png#dark)
![img](./light.png#light)
```

What’s left is to tweak the hugo image render function to accomplish this.

## Code

Hugo renders images with the logic defined in: 

```
/layouts/_default/_markup/render-image.html
```

We can override it and decide which class to apply to an image based on the final tag:

```html
{{ $url := .Destination | safeURL }}

{{ $class := "" }}
{{ $file_name_array :=split $url "#" }}
{{ $file_name_len :=len $file_name_array }}

{{ if eq (index $file_name_array (sub $file_name_len 1)) "dark" }}
    {{ $class = "img-dark" }}
{{ else if eq (index $file_name_array (sub $file_name_len 1)) "light" }}
    {{ $class = "img-light" }}
{{end }}

<figure class="{{ $class }}">
    <img loading="lazy" alt="{{ .Text }}" src=" {{ $url }}">
</figure>
```

Finally, we need to define two image classes in our CSS as follows:

```css
.dark .img-light {
  display: none !important;
}

.light .img-dark {
  display: none !important;
}
```

Where dark and light classes define color schemes.

This solution is currently implemented in the [Typo theme](https://github.com/tomfran/typo), which is in use on this website, go have a look!

I hope this was useful, thank you for reading! 