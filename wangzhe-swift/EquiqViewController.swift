//
//  EquiqViewController.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/29.
//  Copyright © 2019年 Joint. All rights reserved.
//

import UIKit

class EquiqViewController: UIViewController {

    var showButton : UIButton!
    var choiceScrollView : UIScrollView!
    var choiceButtons = [UIButton]()
    var collection : UICollectionView!
    var items = [EquipModel]()
    var storeItems = [EquipModel]()
    var currentChoice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        edgesForExtendedLayout = .init(rawValue: 0)
        
        showButton = UIButton()
        showButton.backgroundColor = CustomColor.mainColor
        showButton.setTitle("点击这里进行筛选", for: .normal)
        showButton.setTitle("点击这里收回", for: .selected)
        showButton.setTitleColor(CustomColor.textColorWhite, for: .normal)
        showButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        view.addSubview(showButton)
        showButton.snp.makeConstraints { (mark) in
            mark.left.top.right.equalTo(view)
            mark.height.equalTo(30)
        }
        showButton.addTarget(self, action: #selector(show(btn:)), for: .touchUpInside)
        
        choiceScrollView = UIScrollView()
        choiceScrollView.alpha = 0
        view.addSubview(choiceScrollView)
        choiceScrollView.snp.makeConstraints { (mark) in
            mark.left.right.equalTo(0)
            mark.top.equalTo(showButton.snp.bottom).offset(0)
            mark.height.equalTo(40)
        }
        choiceScrollView.contentSize = CGSize(width: max(UIScreen.main.bounds.width, 55*8), height: 30)
        view.layoutIfNeeded()
        
        let t1 = UILabel()
        t1.text = "综合"
        t1.textColor = CustomColor.textColorBlack
        t1.font = UIFont.systemFont(ofSize: 14)
        t1.textAlignment = .center
        choiceScrollView.addSubview(t1)
        t1.snp.makeConstraints { (mark) in
            mark.left.top.equalToSuperview()
            mark.height.equalTo(choiceScrollView.frame.height)
            mark.width.equalTo(50)
        }
        let b0 = addChoiceBtn(title: "全部")
        choiceScrollView.addSubview(b0)
        b0.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(t1.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height - 10))
        }
        
        let b1 = addChoiceBtn(title: "攻击")
        choiceScrollView.addSubview(b1)
        b1.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b0.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height - 10))
        }
        
        let b2 = addChoiceBtn(title: "法术")
        choiceScrollView.addSubview(b2)
        b2.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b1.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height - 10))
        }
        
        let b3 = addChoiceBtn(title: "防御")
        choiceScrollView.addSubview(b3)
        b3.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b2.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height - 10))
        }
        
        let b4 = addChoiceBtn(title: "移动")
        choiceScrollView.addSubview(b4)
        b4.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b3.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height - 10))
        }
        
        let b5 = addChoiceBtn(title: "打野")
        choiceScrollView.addSubview(b5)
        b5.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b4.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height - 10))
        }
        
        let b6 = addChoiceBtn(title: "辅助")
        choiceScrollView.addSubview(b6)
        b6.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b5.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScrollView.frame.height - 10))
        }
        
        let width = (UIScreen.main.bounds.width - 70) / 5
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: width, height: width + 20)
        collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.register(HeroCellCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCell")
        view.addSubview(collection)
        collection.snp.makeConstraints { (mark) in
            mark.top.equalTo(showButton.snp.bottom).offset(5)
            mark.left.equalTo(view).offset(5)
            mark.right.bottom.equalTo(view).offset(-5)
        }
        
        clearUpChoice()
        
        updateData()
    }

    func updateData() {
        if items.isEmpty {
            let request = Net.GetEquip(fail: {
                DispatchQueue.main.async {
                    BWHUD.showHUD(msg: "无法获取")
                }
            }) { value in
                self.storeItems = value
                self.items = value
                DispatchQueue.main.async {
                    self.collection.reloadData()
                }
            }
            if let req = request {
                BWHUD.showHUD(msg: "获取装备列表失败")
                req.cancel()
            }
        }
    }
    
    func clearUpChoice() {
        var btn = choiceButtons.first(where: {$0.isSelected})
        btn?.isSelected = false
        btn?.backgroundColor = CustomColor.backgroundColor
        btn = choiceButtons[currentChoice]
        btn?.isSelected = true
        btn?.backgroundColor = CustomColor.mainColor
        switch currentChoice {
        case 1:
            items = storeItems.filter{ $0.type == 1}
        case 2:
            items = storeItems.filter{ $0.type == 2}
        case 3:
            items = storeItems.filter{ $0.type == 3}
        case 4:
            items = storeItems.filter{ $0.type == 4}
        case 5:
            items = storeItems.filter{ $0.type == 5}
        case 6:
            items = storeItems.filter{ $0.type == 7}
        default:
            items = storeItems
        }
        collection.reloadData()
    }
    
    @objc func show(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            UIView.animate(withDuration: 0.3) {
                self.collection.snp.updateConstraints({ (mark) in
                    mark.top.equalTo(self.showButton.snp.bottom).offset(self.choiceScrollView.frame.height+5)
                })
                self.view.layoutIfNeeded()
                self.choiceScrollView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.collection.snp.updateConstraints {
                    $0.top.equalTo(self.showButton.snp.bottom).offset(5)
                }
                self.view.layoutIfNeeded()
                self.choiceScrollView.alpha = 0
            }
        }
    }
    
    func addChoiceBtn(title: String) -> UIButton {
        let b = UIButton()
        b.setTitle(title, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        b.setTitleColor(CustomColor.mainColor, for: .normal)
        b.setTitleColor(CustomColor.textColorWhite, for: .selected)
        b.backgroundColor = CustomColor.backgroundColor
        b.layer.cornerRadius = 2
        b.layer.borderColor = CustomColor.mainColor.cgColor
        b.layer.borderWidth = 1
        choiceButtons.append(b)
        b.addTarget(self, action: #selector(choiceBtnSelector(btn:)), for: .touchUpInside)
        return b
    }
    
    @objc func choiceBtnSelector(btn: UIButton){
        if btn.isSelected{
            return
        }
        currentChoice = choiceButtons.firstIndex(of: btn)!
        clearUpChoice()
    }
    
}

extension EquiqViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! HeroCellCollectionViewCell
        let item = items[indexPath.row]
        cell.heroImageView.image = nil
        cell.heroImageView.kf.setImage(with: URL(string: item.imageUrl), placeholder: CustomCreate.createActivity())
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = items[indexPath.row]
        CustomCreate.showItemTips(item: item)
        
    }
}
