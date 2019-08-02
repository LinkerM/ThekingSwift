//
//  SummonViewController.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/8/1.
//  Copyright © 2019年 Joint. All rights reserved.
//

import UIKit

class SummonViewController: UIViewController {

    var imageBig : UIImageView!
    var contextTextField : UITextView!
    var collection : UICollectionView!
    var summons = [SummonModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        edgesForExtendedLayout = .init(rawValue: 0)
        
        imageBig = UIImageView()
        imageBig.contentMode = .scaleToFill
        view.addSubview(imageBig)
        imageBig.snp.makeConstraints { (mark) in
            mark.left.top.right.equalTo(view)
            mark.height.equalTo(UIScreen.main.bounds.width * 0.618)
        }
        
        contextTextField = UITextView()
        contextTextField.isEditable = false
        contextTextField.isSelectable = false
        contextTextField.textColor = CustomColor.textColorWhite
        contextTextField.backgroundColor = CustomColor.mainColor
        contextTextField.layer.cornerRadius = 2
        contextTextField.font = UIFont.systemFont(ofSize: 14)
        contextTextField.textContainerInset = .init()
        view.addSubview(contextTextField)
        contextTextField.snp.makeConstraints { (mark) in
            mark.left.equalTo(view).offset(5)
            mark.right.equalTo(view).offset(-5)
            mark.height.equalTo(40)
            mark.top.equalTo(imageBig.snp.bottom).offset(10)
        }

        
        let width = (UIScreen.main.bounds.width - 70) / 5
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: width, height: width + 20)
        collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collection.backgroundColor = .white
        collection.delegate = self
        collection.dataSource = self
        collection.register(HeroCellCollectionViewCell.self, forCellWithReuseIdentifier: "heroCell")
        view.addSubview(collection)
        collection.snp.makeConstraints { (mark) in
            mark.top.equalTo(contextTextField.snp.bottom).offset(5)
            mark.left.equalTo(view).offset(5)
            mark.right.bottom.equalTo(view).offset(-5)
        }
        
        updateData()
    }
    
    func updateData() {
        if summons.isEmpty {
            let request = Net.GetSummon(fail: {
                DispatchQueue.main.async {
                    BWHUD.showHUD(msg:"无法获取！")
                }
            }) { (value) in
                self.summons = value
                DispatchQueue.main.async {
                    self.contextTextField.text = "\n\(value.first?.rank ?? "")\n\n\(value.first?.des ?? "")\n"
                    self.imageBig.kf.setImage(with: URL(string: value.first?.bigUrl ?? ""), placeholder: CustomCreate.createActivity())
                    self.layout()
                    self.collection.reloadData()
                }
            }
            
            if let req = request {
                BWHUD.showHUD(msg: "获取召唤师技能失败") {
                    req.cancel()
                }
            }
        }
    }
    
    func layout() {
        UIView.animate(withDuration: 0.5) {
            self.contextTextField.snp.updateConstraints({ (mark) in
                mark.height.equalTo(getTextViewHeight(textView: self.contextTextField, width: self.contextTextField.frame.width))
            })
        }
        self.view.layoutIfNeeded()
    }
}


extension SummonViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return summons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: indexPath) as! HeroCellCollectionViewCell
        let item = summons[indexPath.row]
        contextTextField.text = "\n\(item.rank)\n\n\(item.des)\n"
        cell.heroImageView.image = nil
        cell.heroImageView.contentMode = .scaleAspectFill
        cell.heroImageView.kf.setImage(with: URL(string: item.imageUrl), placeholder:CustomCreate.createActivity())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = summons[indexPath.row]
        contextTextField.text = "\n\(item.rank)\n\n\(item.des)\n"
        imageBig.image = nil
        imageBig.kf.setImage(with: URL(string: item.bigUrl), placeholder: CustomCreate.createActivity())
        layout()
    }
}
