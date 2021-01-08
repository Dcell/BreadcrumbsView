//
//  ViewController.swift
//  breadlineview
//
//  Created by ding_qili on 2021/1/6.
//

import UIKit
import BreadcrumbsView
import SnapKit
class ViewController: UIViewController {
    var nums:[String] = ["1","2","3"]
    var breadcrumbsView1:BreadcrumbsView!
    var breadcrumbsView2:BreadcrumbsView!
    var breadcrumbsView3:BreadcrumbsView!

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
        self.nums.append("")
        self.view.subviews.forEach { (view) in
            if let breadcrumbsView = view as? BreadcrumbsView{
                breadcrumbsView.insertItems(at: [IndexPath(row: self.nums.count - 1, section: 0)])
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
        breadcrumbsView.register(IntervalViewCell.self, forCellWithReuseIdentifier: .interval)
        breadcrumbsView.backgroundColor = UIColor.white
        self.view.addSubview(breadcrumbsView)
        breadcrumbsView.snp.makeConstraints { (maker) in
            maker.height.equalTo(50)
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
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
    }
    
    func demo3(){
        let breadcrumbsView = BreadcrumbsView(frame: CGRect(x: 100, y: 100, width: self.view.frame.width, height: 50), collectionViewLayout: UICollectionViewLayout())
        self.breadcrumbsView3 = breadcrumbsView
        breadcrumbsView.itemSize = CGSize(width: 50 , height: 40)
//        breadcrumbsView.itemEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        breadcrumbsView.intervalItemSize = CGSize(width: 20, height: 40)
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
            crumbViewCell.title.text = "\(indexPath.row)"
            crumbViewCell.title.textColor = crumbViewCell.isSelected ? UIColor.green : UIColor.black
        }
    }
    
    func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, didSelectItemAt indexPath: IndexPath) {
        if breadcrumbsView == self.breadcrumbsView2 {
            if let cell = breadcrumbsView.cellForItem(at: indexPath) as? CrumbViewCell2{
                cell.title.textColor = UIColor.green
            }
        }
    }
    func breadcrumbsView(_ breadcrumbsView: BreadcrumbsView, didDeselectItemAt indexPath: IndexPath) {
        if breadcrumbsView == self.breadcrumbsView2 {
            if let cell = breadcrumbsView.cellForItem(at: indexPath) as? CrumbViewCell2{
                cell.title.textColor = UIColor.black
            }
        }
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
    let uiview = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(uiview)
        uiview.backgroundColor = UIColor.gray
        uiview.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
            maker.left.equalToSuperview()
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
        
        let trianglePath = UIBezierPath()
        trianglePath.lineWidth = 5
        var point = CGPoint(x: 0, y: 0)
        trianglePath.move(to: point)
        point = CGPoint(x: 20, y: 20)
        trianglePath.addLine(to: point)
        point = CGPoint(x: 0, y: 40)
        trianglePath.addLine(to: point)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = trianglePath.cgPath
        uiview.layer.addSublayer(shapeLayer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
