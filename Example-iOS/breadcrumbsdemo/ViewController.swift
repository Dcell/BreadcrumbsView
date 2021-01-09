//
//  ViewController.swift
//  breadlineview
//
//  Created by ding_qili on 2021/1/6.
//

import UIKit
import BreadcrumbsView
import SnapKit

typealias breadcrumbsViewItem = (String,Bool)

class ViewController: UIViewController {
    var nums:[breadcrumbsViewItem] = [("0",false),("1",false),("2",false)]
    var breadcrumbsView1:BreadcrumbsView!
    var breadcrumbsView2:BreadcrumbsView!
    var breadcrumbsView3:BreadcrumbsView!
    var breadcrumbsView4:BreadcrumbsView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let addbutton = UIButton(type: .system)
        addbutton.setTitle("add", for: UIControl.State.normal)
        self.view.addSubview(addbutton)
        addbutton.snp.makeConstraints { (maker) in
            maker.bottom.equalToSuperview().offset(-20)
            maker.left.equalToSuperview().offset(20)
        }
        addbutton.addTarget(self, action: #selector(addItem), for: UIControl.Event.touchUpInside)
        
        let delbutton = UIButton(type: .system)
        delbutton.setTitle("del", for: UIControl.State.normal)
        self.view.addSubview(delbutton)
        delbutton.snp.makeConstraints { (maker) in
            maker.bottom.equalToSuperview().offset(-20)
            maker.right.equalToSuperview().offset(-20)
        }
        delbutton.addTarget(self, action: #selector(delItem), for: UIControl.Event.touchUpInside)
        
        demo1()
        demo2()
        demo3()
        demo4()
        // Do any additional setup after loading the view.
    }
    
    @objc func delItem(){
        self.nums.removeLast()
        self.view.subviews.forEach { (view) in
            if let breadcrumbsView = view as? BreadcrumbsView{
                breadcrumbsView.deleteItems(at: [IndexPath(row: self.nums.count, section: 0)])
            }
        }
    }
    
    @objc func addItem(){
        self.nums.append(("",false))
        self.view.subviews.forEach { (view) in
            if let breadcrumbsView = view as? BreadcrumbsView{
                breadcrumbsView.insertItems(at: [IndexPath(row: self.nums.count - 1, section: 0)])
            }
        }
    }
    
    func reloadAll(){
        self.view.subviews.forEach { (view) in
            if let breadcrumbsView = view as? BreadcrumbsView{
                breadcrumbsView.reloadData()
            }
        }
    }
    
    func demo1(){
        let breadcrumbsView = BreadcrumbsView(frame: CGRect(x: 100, y: 100, width: self.view.frame.width, height: 50), collectionViewLayout: UICollectionViewLayout())
        self.breadcrumbsView1 = breadcrumbsView
        breadcrumbsView.itemSize = CGSize(width: 50 , height: 50)
//        breadcrumbsView.itemEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        breadcrumbsView.intervalItemSize = CGSize(width: 20, height: 50)
        breadcrumbsView.breadcrumbsViewDelegate = self
        breadcrumbsView.register(CrumbViewCell.self, forCellWithReuseIdentifier: .crumb)
//        breadcrumbsView.register(IntervalViewCell.self, forCellWithReuseIdentifier: .interval)
        breadcrumbsView.backgroundColor = UIColor.white
        self.view.addSubview(breadcrumbsView)
        breadcrumbsView.snp.makeConstraints { (maker) in
            maker.height.equalTo(50)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.top.equalToSuperview().offset(40)
        }
        
        let label = UILabel()
        label.text = "没有间隔"
        self.view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.height.equalTo(20)
            maker.left.equalToSuperview()
            maker.top.equalToSuperview().offset(20)
        }
    }
    
    func demo2(){
        let breadcrumbsView = BreadcrumbsView(frame: CGRect(x: 100, y: 100, width: self.view.frame.width, height: 50), collectionViewLayout: UICollectionViewLayout())
        self.breadcrumbsView2 = breadcrumbsView
        breadcrumbsView.itemSize = CGSize(width: 50 , height: 50)
//        breadcrumbsView.itemEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        breadcrumbsView.intervalItemSize = CGSize(width: 10, height: 50)
        breadcrumbsView.breadcrumbsViewDelegate = self
        breadcrumbsView.register(CrumbViewCell2.self, forCellWithReuseIdentifier: .crumb)
        breadcrumbsView.register(IntervalViewCell2.self, forCellWithReuseIdentifier: .interval)
        breadcrumbsView.backgroundColor = UIColor.white
        self.view.addSubview(breadcrumbsView)
        breadcrumbsView.snp.makeConstraints { (maker) in
            maker.height.equalTo(50)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.top.equalToSuperview().offset(120)
        }
        let label = UILabel()
        label.text = "有间隔"
        self.view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.height.equalTo(20)
            maker.left.equalToSuperview()
            maker.top.equalToSuperview().offset(100)
        }
    }
    
    func demo3(){
        let breadcrumbsView = BreadcrumbsView(frame: CGRect(x: 100, y: 100, width: self.view.frame.width, height: 50), collectionViewLayout: UICollectionViewLayout())
        self.breadcrumbsView3 = breadcrumbsView
        breadcrumbsView.itemSize = CGSize(width: 50 , height: 40)
//        breadcrumbsView.itemEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        breadcrumbsView.intervalItemSize = CGSize(width: 14, height: 40)
        breadcrumbsView.breadcrumbsViewDelegate = self
        breadcrumbsView.register(CrumbViewCell3.self, forCellWithReuseIdentifier: .crumb)
        breadcrumbsView.register(IntervalViewCell3.self, forCellWithReuseIdentifier: .interval)
        breadcrumbsView.backgroundColor = UIColor.white
        self.view.addSubview(breadcrumbsView)
        breadcrumbsView.snp.makeConstraints { (maker) in
            maker.height.equalTo(40)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.top.equalToSuperview().offset(220)
        }
        
        let label = UILabel()
        label.text = "自定义间隔"
        self.view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.height.equalTo(20)
            maker.left.equalToSuperview()
            maker.top.equalToSuperview().offset(200)
        }
    }
    
    func demo4(){
        let breadcrumbsView = BreadcrumbsView(frame: CGRect(x: 100, y: 100, width: self.view.frame.width, height: 50), collectionViewLayout: UICollectionViewLayout())
        self.breadcrumbsView4 = breadcrumbsView
        breadcrumbsView.itemSize = CGSize(width: 50 , height: 40)
//        breadcrumbsView.itemEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        breadcrumbsView.intervalItemSize = CGSize(width: 14, height: 40)
        breadcrumbsView.breadcrumbsViewDelegate = self
        breadcrumbsView.register(CrumbViewCell4.self, forCellWithReuseIdentifier: .crumb)
        breadcrumbsView.register(IntervalViewCell4.self, forCellWithReuseIdentifier: .interval)
        breadcrumbsView.backgroundColor = UIColor.white
        self.view.addSubview(breadcrumbsView)
        breadcrumbsView.snp.makeConstraints { (maker) in
            maker.height.equalTo(40)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.top.equalToSuperview().offset(320)
        }
        let label = UILabel()
        label.text = "自定义面包屑size"
        self.view.addSubview(label)
        label.snp.makeConstraints { (maker) in
            maker.height.equalTo(20)
            maker.left.equalToSuperview()
            maker.top.equalToSuperview().offset(300)
        }
    }
}


extension ViewController:BreadcrumbsViewDelegate{
    func numberOfRows(in breadcrumbsView: BreadcrumbsView) -> Int {
        return nums.count
    }
    
    func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, willDisplay cell: AnyObject, forItemAt indexPath: IndexPath) {
        if let crumbViewCell = cell as? CrumbViewCell{
            crumbViewCell.title.text = "\(indexPath.row)"
        }else if let crumbViewCell = cell as? CrumbViewCell2{
            crumbViewCell.title.text = "\(indexPath.row) File"
            crumbViewCell.title.textColor = crumbViewCell.isSelected ? UIColor.green : UIColor.black
        }else if let crumbViewCell = cell as? CrumbViewCell3{
            let selectedIndex = breadcrumbsView.indexPathsForSelectedItems?.first?.row ?? -1
            crumbViewCell.title.text = "\(indexPath.row)"
            crumbViewCell.title.textColor = selectedIndex == indexPath.row ? UIColor.white : UIColor.white
            crumbViewCell.backgroundColor = selectedIndex == indexPath.row ? UIColor(red: 28/255, green: 117/225, blue: 170/255, alpha: 1) : UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
        }else if let crumbViewCell = cell as? CrumbViewCell4{
            let selectedIndex = breadcrumbsView.indexPathsForSelectedItems?.first?.row ?? -1
            crumbViewCell.title.text = "\(indexPath.row)"
            crumbViewCell.title.textColor = selectedIndex == indexPath.row ? UIColor.white : UIColor.white
            crumbViewCell.backgroundColor = selectedIndex == indexPath.row ? UIColor(red: 28/255, green: 117/225, blue: 170/255, alpha: 1) : UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
        }
    }
    
    func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, willDisplayInterval cell: AnyObject, forItemAt indexPath: IndexPath) {
        if breadcrumbsView == self.breadcrumbsView3 {
            if let intervalViewCell3 = cell as? IntervalViewCell3{
                let selectedIndex = breadcrumbsView.indexPathsForSelectedItems?.first?.row ?? -1
                if indexPath.row == selectedIndex {
                    intervalViewCell3.setShapefillColer(UIColor(red: 28/255, green: 117/225, blue: 170/255, alpha: 1))
                    intervalViewCell3.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
                }else{
                    intervalViewCell3.setShapefillColer(UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1))
                    intervalViewCell3.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
                }
            }
        }else if breadcrumbsView == self.breadcrumbsView4 {
            if let intervalViewCell3 = cell as? IntervalViewCell4{
                let selectedIndex = breadcrumbsView.indexPathsForSelectedItems?.first?.row ?? -1
                if indexPath.row == selectedIndex {
                    intervalViewCell3.setShapefillColer(UIColor(red: 28/255, green: 117/225, blue: 170/255, alpha: 1))
                    intervalViewCell3.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
                }else{
                    intervalViewCell3.setShapefillColer(UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1))
                    intervalViewCell3.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
                }
            }
        }
    }
    
    func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, didSelectItemAt indexPath: IndexPath) {
        nums[indexPath.row].1 = true
        if breadcrumbsView == self.breadcrumbsView2 {
            if let cell = breadcrumbsView.cellForItem(at: indexPath) as? CrumbViewCell2{
                cell.title.textColor = UIColor.green
            }
        }else if breadcrumbsView == self.breadcrumbsView3{
            nums[indexPath.row].1 = true
            if let cell = breadcrumbsView.cellForItem(at: indexPath) as? CrumbViewCell3{
                cell.backgroundColor = UIColor(red: 28/255, green: 117/225, blue: 170/255, alpha: 1)
            }
            if let afterIntervalCell =  breadcrumbsView.intervalcellForItem(at: indexPath) as? IntervalViewCell3{
                afterIntervalCell.setShapefillColer(UIColor(red: 28/255, green: 117/225, blue: 170/255, alpha: 1))
                afterIntervalCell.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
            }
            if let beforeIntervalCell =  breadcrumbsView.intervalcellForItem(at: IndexPath(row: indexPath.row - 1, section: 0)) as? IntervalViewCell3{
                beforeIntervalCell.backgroundColor = UIColor(red: 28/255, green: 117/225, blue: 170/255, alpha: 1)
                beforeIntervalCell.setShapefillColer(UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1))
            }
        }else if breadcrumbsView == self.breadcrumbsView4{
            nums[indexPath.row].1 = true
            if let cell = breadcrumbsView.cellForItem(at: indexPath) as? CrumbViewCell4{
                cell.backgroundColor = UIColor(red: 28/255, green: 117/225, blue: 170/255, alpha: 1)
            }
            if let afterIntervalCell =  breadcrumbsView.intervalcellForItem(at: indexPath) as? IntervalViewCell4{
                afterIntervalCell.setShapefillColer(UIColor(red: 28/255, green: 117/225, blue: 170/255, alpha: 1))
                afterIntervalCell.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
            }
            if let beforeIntervalCell =  breadcrumbsView.intervalcellForItem(at: IndexPath(row: indexPath.row - 1, section: 0)) as? IntervalViewCell4{
                beforeIntervalCell.backgroundColor = UIColor(red: 28/255, green: 117/225, blue: 170/255, alpha: 1)
                beforeIntervalCell.setShapefillColer(UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1))
            }
        }
    }
    func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, didDeselectItemAt indexPath: IndexPath) {
        nums[indexPath.row].1 = false
        let selectedIndex = breadcrumbsView.indexPathsForSelectedItems?.first?.row ?? -1
        if breadcrumbsView == self.breadcrumbsView2 {
            if let cell = breadcrumbsView.cellForItem(at: indexPath) as? CrumbViewCell2{
                cell.title.textColor = UIColor.black
            }
        }else if breadcrumbsView == self.breadcrumbsView3{
            nums[indexPath.row].1 = false
            if let cell = breadcrumbsView.cellForItem(at: indexPath) as? CrumbViewCell3{
                cell.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
            }
            if let afterIntervalCell =  breadcrumbsView.intervalcellForItem(at: indexPath) as? IntervalViewCell3{
                afterIntervalCell.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
                afterIntervalCell.setShapefillColer(UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1))
            }
            if let beforeIntervalCell =  breadcrumbsView.intervalcellForItem(at: IndexPath(row: indexPath.row - 1, section: 0)) as? IntervalViewCell3{
                beforeIntervalCell.setShapefillColer(UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1))
                beforeIntervalCell.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
            }
        }else if breadcrumbsView == self.breadcrumbsView4{
            nums[indexPath.row].1 = false
            if let cell = breadcrumbsView.cellForItem(at: indexPath) as? CrumbViewCell4{
                cell.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
            }
            if let afterIntervalCell =  breadcrumbsView.intervalcellForItem(at: indexPath) as? IntervalViewCell4{
                afterIntervalCell.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
                afterIntervalCell.setShapefillColer(UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1))
            }
            if let beforeIntervalCell =  breadcrumbsView.intervalcellForItem(at: IndexPath(row: indexPath.row - 1, section: 0)) as? IntervalViewCell4{
                beforeIntervalCell.setShapefillColer(UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1))
                beforeIntervalCell.backgroundColor = UIColor(red: 39/255, green: 129/225, blue: 210/255, alpha: 1)
            }
        }
    }
    
    func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if breadcrumbsView == self.breadcrumbsView4 {
            var minwidth = 50
            minwidth = max(minwidth, 80 - 10 * indexPath.row)
            return CGSize(width: minwidth, height: 40)
        }
        return breadcrumbsView.itemSize
    }
    
}


class CrumbViewCell: UICollectionViewCell {
    let title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.contentView.addSubview(title)
        title.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        self.backgroundColor = UIColor.init(red: (((CGFloat)((arc4random() % 256)) / 255.0)), green: (((CGFloat)((arc4random() % 256)) / 255.0)), blue: (((CGFloat)((arc4random() % 256)) / 255.0)), alpha: 1.0);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class IntervalViewCell: UICollectionViewCell {
    let title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        title.text = ">"
        self.contentView.addSubview(title)
        title.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
        title.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//--------demo2
class CrumbViewCell2: UICollectionViewCell {
    let title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.contentView.addSubview(title)
        title.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IntervalViewCell2: UICollectionViewCell {
    let title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        title.text = "/"
        self.contentView.addSubview(title)
        title.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
        title.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//-------demo3
class CrumbViewCell3: UICollectionViewCell {
    let title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.contentView.addSubview(title)
        title.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IntervalViewCell3: UICollectionViewCell {
    private let shapeLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let trianglePath = UIBezierPath()
        var point = CGPoint(x: 0, y: 0)
        trianglePath.move(to: point)
        point = CGPoint(x: 12, y: 20)
        trianglePath.addLine(to: point)
        point = CGPoint(x: 0, y: 40)
        trianglePath.addLine(to: point)
        
        
        shapeLayer.path = trianglePath.cgPath
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.black.cgColor
        self.contentView.layer.addSublayer(shapeLayer)
        
    }
    
    func setShapefillColer(_ color:UIColor){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.shapeLayer.fillColor = color.cgColor
        CATransaction.commit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//-------demo3
class CrumbViewCell4: UICollectionViewCell {
    let title = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        self.contentView.addSubview(title)
        title.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class IntervalViewCell4: UICollectionViewCell {
    private let shapeLayer = CAShapeLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let trianglePath = UIBezierPath()
        var point = CGPoint(x: 0, y: 0)
        trianglePath.move(to: point)
        point = CGPoint(x: 12, y: 20)
        trianglePath.addLine(to: point)
        point = CGPoint(x: 0, y: 40)
        trianglePath.addLine(to: point)
        
        
        shapeLayer.path = trianglePath.cgPath
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor.black.cgColor
        self.contentView.layer.addSublayer(shapeLayer)
        
    }
    
    func setShapefillColer(_ color:UIColor){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        self.shapeLayer.fillColor = color.cgColor
        CATransaction.commit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
