//
//  BreadcrumbsView.swift
//  BreadcrumbsView
//
//  Created by ding_qili on 2021/1/6.
//

import UIKit


/// 可注册的面包屑视图
/// .interval 间隔视图
/// .crumb 面包屑视图
public enum BreadcrumbsViewReuseIdentifier:String{
    case interval = "_intervalReuseIdentifier_"
    case crumb = "_crumbReuseIdentifier_"
}


/// 面包屑视图数据代理类
@objc public protocol BreadcrumbsViewDelegate:AnyObject{
    
    /// 面包屑个数
    /// - Parameter breadcrumbsView: 面包屑视图
    func numberOfRows(in breadcrumbsView: BreadcrumbsView) -> Int
    
    
    /// 面包屑单元视图大小
    /// - Parameters:
    ///   - breadcrumbsView: 面包屑视图
    ///   - indexPath: 索引
    @objc optional func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, sizeForItemAt indexPath: IndexPath) -> CGSize

    
    /// 面包屑单元视图边距
    /// - Parameters:
    ///   - breadcrumbsView: 面包屑视图
    ///   - indexPath: 索引
    @objc optional func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, insetForItemAt indexPath: IndexPath) -> UIEdgeInsets
    
    
    
    /// 面包屑单元即将展示
    /// - Parameters:
    ///   - breadcrumbsView: 面包屑视图
    ///   - cell: 面包屑单元
    ///   - indexPath: 索引
    @objc optional func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, willDisplay cell: AnyObject, forItemAt indexPath: IndexPath)
    /// 面包屑单元即将展示
    /// - Parameters:
    ///   - breadcrumbsView: 面包屑视图
    ///   - cell: 面包屑单元
    ///   - indexPath: 索引
    @objc optional func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, willDisplayInterval cell: AnyObject, forItemAt indexPath: IndexPath)
    
    
    /// 面包屑单元被选中
    /// - Parameters:
    ///   - breadcrumbsView: 面包屑视图
    ///   - indexPath: 索引
    @objc optional func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, didSelectItemAt indexPath: IndexPath)
    
    
    /// 面包屑未被选中
    /// - Parameters:
    ///   - collectionView: 面包屑视图
    ///   - indexPath: 索引
    @objc optional func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, didDeselectItemAt indexPath: IndexPath)
}


public class BreadcrumbsView: UICollectionView {
//    面包屑视图的大小
    public var itemSize: CGSize = CGSize.zero
//    面包屑视图的边距
    public var itemEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
//    间隔视图的大小
    public var intervalItemSize: CGSize = CGSize.zero
//    间隔视图的边距
    public var intervalEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
//    面包屑数据代理协议
    public weak var breadcrumbsViewDelegate:BreadcrumbsViewDelegate?
    
    private var hasInterval = false //是否设置了间隔试图
    
    public override var indexPathsForSelectedItems: [IndexPath]?{
        let indexPaths =  super.indexPathsForSelectedItems
        if self.hasInterval {
            return indexPaths?.reduce([], { (result, indexPath) -> [IndexPath] in
                var result = result
                if(indexPath.row%2 == 0){
                    result.append(IndexPath(row: indexPath.row/2, section: 0))
                }
                return result
            })
        }
        return indexPaths
    }
    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame,collectionViewLayout:layout)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize(){
        self.dataSource = self
        self.delegate = self
        let layoutManager = BreadcrumbsViewLayout()
        self.collectionViewLayout = layoutManager
        layoutManager.delegate = self
        self.allowsSelection = true
        self.allowsMultipleSelection = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.bounces = false
    }
    
    public func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: BreadcrumbsViewReuseIdentifier){
        self.register(cellClass, forCellWithReuseIdentifier: identifier.rawValue)
        if identifier == BreadcrumbsViewReuseIdentifier.interval {
            self.hasInterval = true
        }
    }

    public func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: BreadcrumbsViewReuseIdentifier){
        self.register(nib, forCellWithReuseIdentifier: identifier.rawValue)
        if identifier == BreadcrumbsViewReuseIdentifier.interval {
            self.hasInterval = true
        }
    }
    
    public override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        if self.hasInterval {
            return super.cellForItem(at: IndexPath(row: indexPath.row * 2, section: 0))
        }
        return super.cellForItem(at: indexPath)
    }
    public func intervalcellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        if self.hasInterval {
            return super.cellForItem(at: IndexPath(row: indexPath.row * 2 + 1, section: 0))
        }
        return nil
    }
    
    public override func insertItems(at indexPaths: [IndexPath]) {
        if self.hasInterval {
            super.insertItems(at: indexPaths.reduce([]) { (result, indexPath) -> [IndexPath] in
                var result = result
                let row = indexPath.row
                if row == 0{
                    result.append(indexPath)
                }else{
                    result.append(IndexPath(row: row*2 - 1, section: 0))
                    result.append(IndexPath(row: row * 2, section: 0))
                }
                return result
            })
        }else{
            super.insertItems(at: indexPaths)
        }
            
    }
    
    public override func deleteItems(at indexPaths: [IndexPath]) {
        if self.hasInterval {
            super.deleteItems(at: indexPaths.reduce([]) { (result, indexPath) -> [IndexPath] in
                var result = result
                let row = indexPath.row
                if row == 0{
                    result.append(indexPath)
                }else{
                    result.append(IndexPath(row: row*2 - 1, section: 0))
                    result.append(IndexPath(row: row * 2, section: 0))
                }
                return result
            })
        }else{
            super.deleteItems(at: indexPaths)
        }
    }
    
    public override func reloadItems(at indexPaths: [IndexPath]) {
        if self.hasInterval {
            super.reloadItems(at: indexPaths.reduce([]) { (result, indexPath) -> [IndexPath] in
                var result = result
                let row = indexPath.row
                if row == 0{
                    result.append(indexPath)
                }else{
                    result.append(IndexPath(row: row*2 - 1, section: 0))
                    result.append(IndexPath(row: row * 2, section: 0))
                }
                return result
            })
        }else{
            super.reloadItems(at: indexPaths)
        }
    }
    
    public override func moveItem(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        if self.hasInterval {
            super.moveItem(at: IndexPath(row: indexPath.row * 2, section: 0), to: IndexPath(row: newIndexPath.row * 2, section: 0))
        }else{
            super.moveItem(at: indexPath, to: newIndexPath)
        }
    }
}



extension BreadcrumbsView:UICollectionViewDelegate,UICollectionViewDataSource{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = self.breadcrumbsViewDelegate else {
            return 0
        }
        if self.hasInterval {
            let number = dataSource.numberOfRows(in: self)
            return max(number*2 - 1, 0)
        }
        return dataSource.numberOfRows(in: self)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.breadcrumbsView(isIntervalAt: indexPath){
            return collectionView.dequeueReusableCell(withReuseIdentifier: BreadcrumbsViewReuseIdentifier.interval.rawValue, for: indexPath)
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: BreadcrumbsViewReuseIdentifier.crumb.rawValue, for: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell.reuseIdentifier ==  BreadcrumbsViewReuseIdentifier.crumb.rawValue{
            var indexPath = indexPath
            if self.hasInterval {
                indexPath = IndexPath(row: indexPath.row/2, section: 0)
            }
            self.breadcrumbsViewDelegate?.breadcrumbsView?( self, willDisplay: cell, forItemAt: indexPath)
        }else{
            let indexPath = IndexPath(row: indexPath.row/2, section: 0)
            self.breadcrumbsViewDelegate?.breadcrumbsView?(self, willDisplayInterval: cell, forItemAt: indexPath)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if !hasInterval {
            return self.allowsSelection
        }
        if let reuseIdentifier = collectionView.cellForItem(at: indexPath)?.reuseIdentifier , reuseIdentifier == BreadcrumbsViewReuseIdentifier.interval.rawValue  {
            return false
        }
        return indexPath.row%2 == 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        var indexPath = indexPath
        if self.hasInterval {
            indexPath = IndexPath(row: indexPath.row/2, section: 0)
        }
        self.breadcrumbsViewDelegate?.breadcrumbsView?(self, didSelectItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        var indexPath = indexPath
        if self.hasInterval {
            indexPath = IndexPath(row: indexPath.row/2, section: 0)
        }
        self.breadcrumbsViewDelegate?.breadcrumbsView?(self, didDeselectItemAt: indexPath)
    }
    
}

extension BreadcrumbsView:BreadcrumbsViewLayoutDelegate{
    private func breadcrumbsView( isIntervalAt indexPath:IndexPath ) -> Bool{
        if !self.hasInterval{
            return false
        }
        let row = indexPath.row + 1
        return row%2 != 1
    }
    
    
    func numberOfRows() -> Int {
        return self.numberOfItems(inSection: 0)
    }
    
    func breadcrumbsView(sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.breadcrumbsView(isIntervalAt: indexPath) {
            return self.intervalItemSize
        }
        return self.breadcrumbsViewDelegate?.breadcrumbsView?(self, sizeForItemAt: indexPath) ?? self.itemSize
    }
    
    func breadcrumbsView(insetForItemAt indexPath: IndexPath) -> UIEdgeInsets {
        if self.breadcrumbsView(isIntervalAt: indexPath) {
            return self.intervalEdgeInsets
        }
        return self.breadcrumbsViewDelegate?.breadcrumbsView?(self, insetForItemAt: indexPath) ?? self.itemEdgeInsets
    }
}

private protocol BreadcrumbsViewLayoutDelegate:AnyObject{
    func numberOfRows() -> Int
    func breadcrumbsView( sizeForItemAt indexPath: IndexPath) -> CGSize
    func breadcrumbsView( insetForItemAt indexPath: IndexPath) -> UIEdgeInsets
}
 
private class BreadcrumbsViewLayout:UICollectionViewLayout{
    weak var delegate:BreadcrumbsViewLayoutDelegate?
    var cache:[UICollectionViewLayoutAttributes] = []
    var width:CGFloat = 0
    var height:CGFloat = 0
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
    }
    
    override func prepare() {
        super.prepare()
        guard let _ = self.collectionView else {
            return
        }
        guard let breadcrumbsViewLayoutDelegate = self.delegate else {
            return
        }
        cache.removeAll()
        var x:CGFloat = 0
        let y:CGFloat = 0
        width = x
        for i in 0 ..< breadcrumbsViewLayoutDelegate.numberOfRows() {
            let indexPath = IndexPath(row: i, section: 0)
            let indexPathSize = breadcrumbsViewLayoutDelegate.breadcrumbsView(sizeForItemAt: indexPath)
            let indexInsets = breadcrumbsViewLayoutDelegate.breadcrumbsView(insetForItemAt: indexPath)
            let layoutattr =  UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let indexRect = CGRect(origin: CGPoint(x: x, y: y), size: indexPathSize).inset(by: indexInsets)
            layoutattr.frame = indexRect
            x = x + indexPathSize.width
            width = width + indexPathSize.width
            height = max(height, indexPathSize.height)
            cache.append(layoutattr)
        }
    }
    override var collectionViewContentSize: CGSize{
        guard let collectionview = self.collectionView else {
            return CGSize.zero
        }
        let height = max(self.height, collectionview.frame.height)
        let width = max(self.width, collectionview.frame.width)
        return CGSize(width: width, height: height)
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.cache.filter { (layoutattr) -> Bool in
            return layoutattr.frame.intersects(rect)
        }
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath.row]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else {
           return false
       }
       guard newBounds.size != collectionView.frame.size else {
           return false
       }
       return true
    }
}
