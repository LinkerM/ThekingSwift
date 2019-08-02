//
//  ViewController.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/22.
//  Copyright © 2019年 Joint. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    var showButton : UIButton!
    var choiceScroll : UIScrollView!
    var collection : UICollectionView!
    var choiceButtons = [UIButton]()
    var heros = [HeroModel]()
    var storeHeros = [HeroModel]()
    var reloadButton = UIButton()
    var currentChoice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        edgesForExtendedLayout = .init(rawValue: 0)
        
        showButton = UIButton()
        showButton.backgroundColor = CustomColor.mainColor
        showButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        showButton.setTitle("点击这里进行筛选", for: .normal)
        showButton.setTitle("点击这里收回", for: .selected)
        showButton.setTitleColor(CustomColor.textColorWhite, for: .normal)
        showButton.setTitleColor(CustomColor.textColorWhite, for: .selected)
        view.addSubview(showButton)
        showButton.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.right.equalTo(view)
            make.height.equalTo(30)
        }
        showButton.addTarget(self,
                             action: #selector(showButton(btn:)),
                             for: .touchUpInside)
        
        choiceScroll = UIScrollView()
        view.addSubview(choiceScroll)
        choiceScroll.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(showButton.snp.bottom)
            make.height.equalTo(60)
        }
        choiceScroll.contentSize = CGSize(width: max(UIScreen.main.bounds.width, 55 * 7), height: 60)
        view.layoutIfNeeded()
        
        let lab1 = UILabel()
        lab1.textColor = CustomColor.textColorBlack
        lab1.font = UIFont.systemFont(ofSize: 15)
        lab1.text = "综合"
        lab1.textAlignment = .center
        choiceScroll.addSubview(lab1)
        lab1.snp.makeConstraints { (mark) in
            mark.left.top.equalToSuperview()
            mark.height.equalTo(choiceScroll.frame.height / 2)
            mark.width.equalTo(50)
        }
        
        let b0 = addChioseBtn(title: "全部")
        choiceScroll.addSubview(b0)
        b0.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(lab1.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScroll.frame.height / 2 - 10))
        }
        
        let b1 = addChioseBtn(title: "周免")
        choiceScroll.addSubview(b1)
        b1.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b0.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScroll.frame.height / 2 - 10))
        }
        
        let b2 = addChioseBtn(title: "新手")
        choiceScroll.addSubview(b2)
        b2.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.left.equalTo(b1.snp.right).offset(5)
            mark.size.equalTo(CGSize(width: 50, height: choiceScroll.frame.height / 2 - 10))
        }
        
        let lab2 = UILabel()
        lab2.textColor = CustomColor.textColorBlack
        lab2.font = UIFont.systemFont(ofSize: 15)
        lab2.text = "定位"
        lab2.textAlignment = .center
        choiceScroll.addSubview(lab2)
        lab2.snp.makeConstraints { (mark) in
            mark.left.equalToSuperview()
            mark.top.equalTo(lab1.snp.bottom).offset(0)
            mark.height.equalTo(choiceScroll.frame.height / 2)
            mark.width.equalTo(50)
        }
        
        let b3 = addChioseBtn(title: "坦克")
        choiceScroll.addSubview(b3)
        b3.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.left.equalTo(lab2.snp.right).offset(5)
            $0.size.equalTo(CGSize(width: 50, height: choiceScroll.frame.height/2-10))
        }
        let b4 = addChioseBtn(title: "战士")
        choiceScroll.addSubview(b4)
        b4.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.left.equalTo(b3.snp.right).offset(5)
            $0.size.equalTo(CGSize(width: 50, height: choiceScroll.frame.height/2-10))
        }
        let b5 = addChioseBtn(title: "刺客")
        choiceScroll.addSubview(b5)
        b5.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.left.equalTo(b4.snp.right).offset(5)
            $0.size.equalTo(CGSize(width: 50, height: choiceScroll.frame.height/2-10))
        }
        let b6 = addChioseBtn(title: "法师")
        choiceScroll.addSubview(b6)
        b6.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.left.equalTo(b5.snp.right).offset(5)
            $0.size.equalTo(CGSize(width: 50, height: choiceScroll.frame.height/2-10))
        }
        let b7 = addChioseBtn(title: "射手")
        choiceScroll.addSubview(b7)
        b7.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.left.equalTo(b6.snp.right).offset(5)
            $0.size.equalTo(CGSize(width: 50, height: choiceScroll.frame.height/2-10))
        }
        let b8 = addChioseBtn(title: "辅助")
        choiceScroll.addSubview(b8)
        b8.snp.makeConstraints {
            $0.top.equalToSuperview().offset(35)
            $0.left.equalTo(b7.snp.right).offset(5)
            $0.size.equalTo(CGSize(width: 50, height: choiceScroll.frame.height/2-10))
        }
        
        //collection
        let width = (UIScreen.main.bounds.width-60)/4
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: width, height: width + 20)
        collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self

        collection.register(HeroCellCollectionViewCell.self, forCellWithReuseIdentifier: "HeroCell")
        view.addSubview(collection)
        collection.snp.makeConstraints { (mark) in
            mark.left.equalTo(view).offset(5)
            mark.top.equalTo(showButton.snp.bottom).offset(5)
            mark.right.bottom.equalTo(view).offset(-5)
        }
        
        //重新获取button
        reloadButton.setTitle("点击这里重新获取", for: .normal)
        reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 14);
        reloadButton.layer.borderColor = CustomColor.mainColor.cgColor
        reloadButton.layer.borderWidth = 1
        reloadButton.layer.cornerRadius = 2
        view.addSubview(reloadButton)
        reloadButton.snp.makeConstraints { (mark) in
            mark.center.equalTo(view)
            mark.size.equalTo(CGSize(width: 200, height: 40))
        }
        reloadButton.addTarget(self, action: #selector(upData), for: .touchUpInside)
        
        upData()
        
        clearUpChoice()
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
            //周免
            heros = storeHeros.filter { $0.payType==10 }
        case 2:
            //新手
            heros = storeHeros.filter { $0.payType==11 }
        case 3:
            //坦克
            heros = storeHeros.filter { $0.heroType==3 }
        case 4:
            //战士
            heros = storeHeros.filter { $0.heroType==1 }
        case 5:
            //刺客
            heros = storeHeros.filter { $0.heroType==4 }
        case 6:
            //法师
            heros = storeHeros.filter { $0.heroType==2 }
        case 7:
            //射手
            heros = storeHeros.filter { $0.heroType==5 }
        case 8:
            //辅助
            heros = storeHeros.filter { $0.heroType==6 }
        default:
            heros = storeHeros
        }
        collection.reloadData()
        
    }
    
    @objc func showButton(btn: UIButton){
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            UIView.animate(withDuration: 0.5) {
                self.collection.snp.updateConstraints {
                    $0.top.equalTo(self.showButton.snp.bottom).offset(self.choiceScroll.frame.height+5)
                }
                self.view.layoutIfNeeded()
                self.choiceScroll.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.collection.snp.updateConstraints {
                    $0.top.equalTo(self.showButton.snp.bottom).offset(5)
                }
                self.view.layoutIfNeeded()
                self.choiceScroll.alpha = 0
            }
        }
    }
    
    //button
    func addChioseBtn(title: String) -> UIButton {
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
        b.addTarget(self, action: #selector(choiceBtnSelected(btn:)), for: .touchUpInside)
        return b
    }
    
    @objc func choiceBtnSelected(btn: UIButton){
        if btn.isSelected{
            return
        }
        currentChoice = choiceButtons.firstIndex(of: btn)!
        clearUpChoice()
    }
    
    @objc func upData(){
        if heros.isEmpty{
            let request = Net.GetHero(fail: {
                DispatchQueue.main.async {
                    BWHUD.infoHUD(msg: "无法获取！")
                }
            }){ value in
                self.storeHeros = value
                self.heros = value
                DispatchQueue.main.async {
                    if self.heros.isEmpty {
                        self.reloadButton.isHidden = false
                    }else{
                        self.reloadButton.isHidden = true
                    }
                    self.collection.reloadData()
                    BWHUD.dismissHUD()
                }
            }
            if let req = request {
                BWHUD.showHUD(msg: "获取英雄列表") {
                    print("获取超时，取消获取")
                    req.cancel()
                }
            }
        }
        
        if CommonData.mings == nil {
            _ = Net.GetMing()
        }
        if CommonData.items == nil {
            _ = Net.GetEquip()
        }
        if CommonData.summons == nil {
            _ = Net.GetSummon()
        }
        
        do {
            let total = try Video.db?.scalar(Video.video.count) ?? 0
            print("数据库已存在数据视频:\(total)")
            if total == 0 {
                _ = Net.GetVideo()
            }
        } catch {
            _ = Net.GetVideo()
            print("数据库查询视频出现错误")
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heros.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as! HeroCellCollectionViewCell
        let hero = heros[indexPath.row]
        cell.heroImageView.image = nil
        cell.heroImageView.kf.setImage(with: URL(string: hero.imageUrl), placeholder: CustomCreate.createActivity())
        cell.heroName.text = hero.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        var hero = heros[indexPath.row]
        if hero.heroInfo != nil{
            self.jumpHeroInfo(hero: hero)
        } else {
            let request = Net.GetHeroInfo(hero: hero, fail: {
                DispatchQueue.main.async {
                    BWHUD.infoHUD(msg: "无法获取！")
                }
            }) { heroInfo in
                hero.heroInfo = heroInfo
                DispatchQueue.main.async {
                    self.jumpHeroInfo(hero: hero)
                    BWHUD.dismissHUD()
                }
            }
            BWHUD.showHUD(msg: "获取英雄信息") {
                print("获取超时，取消请求")
                request?.cancel()
            }
        }
    }
    
    func jumpHeroInfo(hero: HeroModel) {
        let vc = HeroInfoVC()
        vc.heroModel = hero
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

