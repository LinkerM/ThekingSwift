//
//  MingViewController.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/31.
//  Copyright © 2019年 Joint. All rights reserved.
//

import UIKit

class MingViewController: UIViewController {

    var showButton : UIButton!
    var choiceScrollView : UIScrollView!
    var choiceButtons = [UIButton]()
    var currentUpChoice = 0
    var currentDownChoice = 0
    var collection : UICollectionView!
    var mings = [MingModel]()
    var storeMings = [MingModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        edgesForExtendedLayout = .init(rawValue: 0)
        
        showButton = UIButton()
        showButton.setTitle("点击这里进行筛选", for: .normal)
        showButton.setTitle("点击这里回收", for: .selected)
        showButton.backgroundColor = CustomColor.mainColor
        showButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.view.addSubview(showButton)
        showButton.snp.makeConstraints { (mark) in
            mark.left.top.right.equalTo(view)
            mark.height.equalTo(30)
        }
        showButton.addTarget(self, action: #selector(showBtn(btn:)), for: .touchUpInside)
        
        choiceScrollView = UIScrollView()
        choiceScrollView.alpha = 0
        view.addSubview(choiceScrollView)
        choiceScrollView.snp.makeConstraints { (mark) in
            mark.left.right.equalTo(view)
            mark.top.equalTo(showButton.snp.bottom)
            mark.height.equalTo(60)
        }
        choiceScrollView.contentSize = CGSize(width: max(UIScreen.main.bounds.width, 55 * 7), height: 30)
        view.layoutIfNeeded()
        
        let t1 = UILabel()
        t1.text = "颜色"
        t1.textColor = CustomColor.mainColor
        t1.font = UIFont.systemFont(ofSize: 12)
        t1.textAlignment = .center
        choiceScrollView.addSubview(t1)
        t1.snp.makeConstraints { (mark) in
            mark.left.top.equalToSuperview()
            mark.height.equalTo(choiceScrollView.frame.height / 2)
            mark.width.equalTo(50)
        }
        
        let b0 = addChoiceBtn(title: "全部")
        choiceScrollView.addSubview(b0)
        b0.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(t1.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height / 2 - 10))
        }
        
        let b1 = addChoiceBtn(title: "红色")
        choiceScrollView.addSubview(b1)
        b1.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b0.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height / 2 - 10))
        }
        
        let b2 = addChoiceBtn(title: "绿色")
        choiceScrollView.addSubview(b2)
        b2.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b1.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height / 2 - 10))
        }
        
        let b3 = addChoiceBtn(title: "蓝色")
        choiceScrollView.addSubview(b3)
        b3.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b2.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height / 2 - 10))
        }
        
        let t2 = UILabel()
        t2.text = "等级"
        t2.textColor = CustomColor.mainColor
        t2.font = UIFont.systemFont(ofSize: 12)
        t2.textAlignment = .center
        choiceScrollView.addSubview(t2)
        t2.snp.makeConstraints { (mark) in
            mark.top.equalTo(t1.snp.bottom).offset(0)
            mark.left.equalToSuperview()
            mark.height.equalTo(choiceScrollView.frame.height / 2)
            mark.width.equalTo(50)
        }
        
        let b4 = addChoiceBtn(title: "全部")
        choiceScrollView.addSubview(b4)
        b4.snp.makeConstraints { (mark) in
            mark.top.equalTo(t1.snp.bottom).offset(0)
            mark.left.equalTo(t2.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height / 2 - 10))
        }
        
        let b5 = addChoiceBtn(title: "五级")
        choiceScrollView.addSubview(b5)
        b5.snp.makeConstraints { (mark) in
            mark.top.equalTo(t1.snp.bottom).offset(0)
            mark.left.equalTo(b4.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height / 2 - 10))
        }
        
        let b6 = addChoiceBtn(title: "四级")
        choiceScrollView.addSubview(b6)
        b6.snp.makeConstraints { (mark) in
            mark.top.equalTo(t1.snp.bottom).offset(0)
            mark.left.equalTo(b5.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height / 2 - 10))
        }
        
        let b7 = addChoiceBtn(title: "三级")
        choiceScrollView.addSubview(b7)
        b7.snp.makeConstraints { (mark) in
            mark.top.equalTo(t1.snp.bottom).offset(0)
            mark.left.equalTo(b6.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height / 2 - 10))
        }
        
        let b8 = addChoiceBtn(title: "二级")
        choiceScrollView.addSubview(b8)
        b8.snp.makeConstraints { (mark) in
            mark.top.equalTo(t1.snp.bottom).offset(0)
            mark.left.equalTo(b7.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height / 2 - 10))
        }
        
        let b9 = addChoiceBtn(title: "一级")
        choiceScrollView.addSubview(b9)
        b9.snp.makeConstraints { (mark) in
            mark.top.equalTo(t1.snp.bottom).offset(0)
            mark.left.equalTo(b8.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height / 2 - 10))
        }
        
        let width = (UIScreen.main.bounds.width - 70) / 5
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: width, height: width + 20)
        collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collection.delegate = self
        collection.dataSource = self
        collection.register(HeroCellCollectionViewCell.self, forCellWithReuseIdentifier: "MingCell")
        collection.backgroundColor = .white
        view.addSubview(collection)
        collection.snp.makeConstraints { (mark) in
            mark.top.equalTo(showButton.snp.bottom).offset(5)
            mark.left.equalTo(view).offset(5)
            mark.bottom.right.equalTo(view).offset(-5)
        }
        
        updateData()
        
    }
    
    func updateData() {
        if mings.isEmpty {
            let request = Net.GetMing(fail: {
                DispatchQueue.main.async {
                    BWHUD.infoHUD(msg: "无法获取！")
                }
            }) { value in
                self.storeMings = value
                self.mings = value
                DispatchQueue.main.async {
                    self.collection.reloadData()
                }
            }
            
            if let req = request {
                BWHUD.showHUD(msg: "获取铭文列表失败") {
                    print("获取超时")
                    req.cancel()
                }
            }
        }
    }
    
    func addChoiceBtn(title: String) -> UIButton {
        let b = UIButton()
        b.setTitle(title, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        b.setTitleColor(CustomColor.mainColor, for: .normal)
        b.setTitleColor(CustomColor.textColorWhite, for: .selected)
        b.backgroundColor = CustomColor.backgroundColor
        b.layer.cornerRadius = 2
        b.layer.borderColor = CustomColor.mainColor.cgColor
        b.layer.borderWidth = 1
        choiceButtons.append(b)
        b.addTarget(self, action: #selector(choiceBtnSelected(btn:)), for: .touchUpInside)
        return b
    }
    
    @objc func choiceBtnSelected(btn: UIButton) {
        if btn.isSelected {
            return
        }
        let index = choiceButtons.firstIndex(of: btn)!
        if index <= 3 {
            currentUpChoice = index
        } else {
            currentUpChoice = index - 4
        }
    }
    
    @objc func showBtn(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            UIView.animate(withDuration: 0.5) {
                self.collection.snp.updateConstraints({ (mark) in
                    mark.top.equalTo(self.showButton.snp.bottom).offset(self.choiceScrollView.frame.height + 5)
                })
                self.view.layoutIfNeeded()
                self.choiceScrollView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.collection.snp.updateConstraints {
                    $0.top.equalTo(self.showButton.snp.bottom).offset(5)
                }
            }
            self.view.layoutIfNeeded()
            self.choiceScrollView.alpha = 0
        }
    }
}

extension MingViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MingCell", for: indexPath) as! HeroCellCollectionViewCell
        let ming = mings[indexPath.row]
        cell.heroImageView.image = nil
        cell.heroImageView.kf.setImage(with: URL(string: ming.imageUrl), placeholder:CustomCreate.createActivity())
        cell.heroName.text = "\(ming.name)(\(ming.grade))"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let ming = mings[indexPath.row]
        CustomCreate.showMingTips(ming: ming)
    }
}
