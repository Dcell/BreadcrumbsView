# BreadcrumbsView

一个基于collection view 的面包屑视图

## 功能

- [x] 自定义面包屑视图
- [x] 自定义间隔视图
- [x] 自定义大小

## 集成方式

SPM

```
dependencies: [
    .package(url: "https://github.com/Dcell/BreadcrumbsView.git", .upToNextMajor(from: "1.0"))
]
```



## 使用方式

初始化**BreadcrumbsView**

```swift
let breadcrumbsView = BreadcrumbsView(frame: CGRect)
```

添加代理

```swift
//BreadcrumbsViewDelegate
breadcrumbsView.breadcrumbsViewDelegate = self
```

注册面包屑视图和间隔视图（其中间隔视图可选）

```swift
breadcrumbsView.register(CrumbViewCell.self, forCellWithReuseIdentifier: .crumb)
breadcrumbsView.register(IntervalViewCell.self, forCellWithReuseIdentifier: .interval)
```

添加/删除 等方式和**CollectionView**使用一致，请参考Demo

⚠️ 因为**BreadcrumbsView** 是基于 **CollectionVIew** 实现的，并且只复写了关键的几个函数，如果使用未复写的函数特别是和**IndexPath**相关的，可能会导致程序异常

<img src="https://i.loli.net/2021/01/09/Vq9eimoL1uyp6zf.png" alt="Simulator Screen Shot - iPhone 8 - 2021-01-09 at 17.08.21.png" style="zoom:50%;" />

