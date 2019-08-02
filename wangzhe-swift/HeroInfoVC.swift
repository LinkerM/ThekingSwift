//
//  HeroInfoVC.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/23.
//  Copyright © 2019年 Joint. All rights reserved.
//

import UIKit
import Kingfisher
import Photos

class HeroInfoVC: UIViewController {

    var heroModel : HeroModel!
    var scrollView : UIScrollView!
    var skinBigImageView : UIImageView!
    var skillSelected = 0
    var skinSelected = 0
    var heroNameLabel : UILabel!
    var skillNameLabel : UILabel!
    var attributeNameLabel : UILabel!
    var skillDesTextView : UITextView!
    var skillTipsTextView : UITextView!
    var itemTipsTextView : UITextView!
    var mingTextView : UITextView!
    var segmentViewControl: UISegmentedControl!
    var itemsImageView = [UIImageView]()
    var videoButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        edgesForExtendedLayout = .init(rawValue: 0)
        title = heroModel.name
     
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (mark) in
            mark.left.top.right.bottom.equalTo(0)
        }
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2)
        
        //皮肤大图
        skinBigImageView = UIImageView()
        skinBigImageView.contentMode = .scaleAspectFill
        skinBigImageView.isUserInteractionEnabled = true
        scrollView.addSubview(skinBigImageView)
        skinBigImageView.snp.makeConstraints { (mark) in
            mark.top.left.equalTo(scrollView)
            mark.height.equalTo(UIScreen.main.bounds.width / 1.618)
            mark.width.equalTo(UIScreen.main.bounds.width)
        }
        skinBigImageView.kf.setImage(with: URL(string: (heroModel.heroInfo?.skins?.first?.last)!), placeholder: CustomCreate.createActivity())
        
        //皮肤列表
        let skinsTableView = UITableView()
        skinsTableView.backgroundColor = .clear
        skinsTableView.tag = 1
        skinsTableView.separatorStyle = .none
        skinsTableView.delegate = self
        skinsTableView.dataSource = self
        skinsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "heroSkinCell")
        skinsTableView.tableFooterView = UIView()
        scrollView.addSubview(skinsTableView)
        skinsTableView.snp.makeConstraints { (mark) in
            mark.left.top.equalTo(skinBigImageView).offset(5)
            mark.bottom.equalTo(skinBigImageView).offset(-5)
            mark.width.equalTo(50)
        }
        
        // 皮肤名称
        heroNameLabel = UILabel()
        heroNameLabel.textColor = CustomColor.mainColor
        heroNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        heroNameLabel.textAlignment = .center
        heroNameLabel.text = heroModel.heroInfo?.skin?.first
        scrollView.addSubview(heroNameLabel)
        heroNameLabel.snp.makeConstraints { (mark) in
            mark.left.top.right.equalTo(skinBigImageView)
            mark.height.equalTo(30)
        }
        
        //保存到相册
        let saveBtn = UIButton()
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.setTitleColor(.red, for: .normal)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        skinBigImageView.addSubview(saveBtn)
        saveBtn.snp.makeConstraints { (mark) in
            mark.right.bottom.equalTo(-10)
            mark.width.height.equalTo(40)
        }
        saveBtn.addTarget(self, action: #selector(saveSkin), for: .touchUpInside)
        
        //技能列表
        let skilssTableView = UITableView()
        skilssTableView.tag = 2
        skilssTableView.separatorStyle = .none
        skilssTableView.delegate = self
        skilssTableView.dataSource = self
        skilssTableView.register(UITableViewCell.self, forCellReuseIdentifier: "heroSkilssCell")
        skilssTableView.tableHeaderView = UIView()
        scrollView.addSubview(skilssTableView)
        skilssTableView.snp.makeConstraints { (mark) in
            mark.top.equalTo(skinBigImageView.snp.bottom).offset(5)
            mark.left.equalTo(5)
            mark.width.equalTo(50)
            mark.height.equalTo(249)
        }
        
        //技能名称
        skillNameLabel = UILabel()
        skillNameLabel.font = UIFont.systemFont(ofSize: 18)
        skillNameLabel.textColor = CustomColor.mainColor
        scrollView.addSubview(skillNameLabel)
        skillNameLabel.snp.makeConstraints { (mark) in
            mark.left.equalTo(skilssTableView.snp.right).offset(10)
            mark.top.equalTo(skinBigImageView.snp.bottom).offset(5);
            mark.right.equalTo(skinBigImageView);
            
        }
        skillNameLabel.text = heroModel.heroInfo?.skills?[0][0]

        //技能消耗
        attributeNameLabel = UILabel()
        attributeNameLabel.font = UIFont.systemFont(ofSize: 14)
        attributeNameLabel.textColor = CustomColor.mainColor
        scrollView.addSubview(attributeNameLabel)
        attributeNameLabel.snp.makeConstraints { (mark) in
            mark.left.equalTo(skilssTableView.snp.right).offset(10)
            mark.top.equalTo(skillNameLabel.snp.bottom).offset(5);
            mark.right.equalTo(skinBigImageView);
        }
        attributeNameLabel.text = heroModel.heroInfo?.skills?[0][2]
        
        //技能介绍
        skillDesTextView = UITextView()
        skillDesTextView.layer.cornerRadius = 2
        skillDesTextView.backgroundColor = .red
        skillDesTextView.backgroundColor = CustomColor.mainColor
        skillDesTextView.textColor = CustomColor.textColorWhite
        skillDesTextView.isEditable = false
        skillDesTextView.isSelectable = false
        skillDesTextView.font = UIFont.systemFont(ofSize: 14)
        skillDesTextView.textContainerInset = .init()
        scrollView.addSubview(skillDesTextView)
        skillDesTextView.text = heroModel.heroInfo?.skills![0][3]
        
        skillTipsTextView = UITextView()
        skillTipsTextView.layer.cornerRadius = 2
        skillTipsTextView.backgroundColor = .red
        skillTipsTextView.backgroundColor = CustomColor.mainColor
        skillTipsTextView.textColor = CustomColor.textColorWhite
        skillTipsTextView.isEditable = false
        skillTipsTextView.isSelectable = false
        skillTipsTextView.font = UIFont.systemFont(ofSize: 14)
        skillTipsTextView.textContainerInset = .init()
        scrollView.addSubview(skillTipsTextView)
        skillTipsTextView.snp.makeConstraints { (mark) in
            mark.bottom.equalTo(skilssTableView.snp.bottom)
            mark.left.equalTo(skilssTableView.snp.right).offset(10)
            mark.height.equalTo(50)
            mark.right.equalTo(skinBigImageView).offset(-5)
        }
        skillTipsTextView.text = heroModel.heroInfo?.skills![0][4]
        
        skillDesTextView.snp.makeConstraints { (mark) in
            mark.left.equalTo(skilssTableView.snp.right).offset(10)
            mark.top.equalTo(attributeNameLabel.snp.bottom).offset(5)
            mark.right.equalTo(skinBigImageView.snp.right).offset(-5)
            mark.bottom.equalTo(skillTipsTextView.snp.top).offset(-5)
        }
        
        segmentViewControl = UISegmentedControl(items: ["推荐出装一", "推荐出装二"])
        segmentViewControl.selectedSegmentIndex = 0
        segmentViewControl.tintColor = CustomColor.mainColor
        scrollView.addSubview(segmentViewControl)
        segmentViewControl.snp.makeConstraints { (mark) in
            mark.left.equalTo(skinBigImageView.snp.left).offset(5);
            mark.right.equalTo(skinBigImageView.snp.right).offset(-5)
            mark.top.equalTo(skilssTableView.snp.bottom).offset(10)
            mark.height.equalTo(30)
        }
        segmentViewControl.addTarget(self, action: #selector(segmentViewControlChenge(segment:)), for: .valueChanged)
        
        //出装图片
        let width = (UIScreen.main.bounds.width - 70) / 6
        for i in 0...5 {
            let image = UIImageView()
            image.tag = i + 10
            image.contentMode = .scaleAspectFit
            let id = heroModel.heroInfo?.items?.first![i] ?? ""
            image.kf.setImage(with:  URL(string: "https://game.gtimg.cn/images/yxzj/img201606/itemimg/\(id).jpg"), placeholder: CustomCreate.createActivity())
            scrollView.addSubview(image)
            image.snp.makeConstraints { (mark) in
                mark.size.equalTo(CGSize(width: width, height: width))
                mark.top.equalTo(segmentViewControl.snp.bottom).offset(5)
                mark.left.equalTo(scrollView).offset(10 + (10 + width) * CGFloat(i))
            }
            itemsImageView.append(image)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTap(tap:)))
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(tap)
        }
        
        //装备介绍
        itemTipsTextView = UITextView()
        itemTipsTextView.layer.cornerRadius = 2
        itemTipsTextView.backgroundColor = .red
        itemTipsTextView.backgroundColor = CustomColor.mainColor
        itemTipsTextView.textColor = CustomColor.textColorWhite
        itemTipsTextView.isEditable = false
        itemTipsTextView.isSelectable = false
        itemTipsTextView.font = UIFont.systemFont(ofSize: 14)
        itemTipsTextView.textContainerInset = .init()
        scrollView.addSubview(itemTipsTextView)
        itemTipsTextView.snp.makeConstraints { (mark) in
            mark.top.equalTo(segmentViewControl.snp.bottom).offset(width + 10)
            mark.left.equalTo(skinBigImageView.snp.left).offset(5)
            mark.height.equalTo(50)
            mark.right.equalTo(skinBigImageView).offset(-5)
        }
        itemTipsTextView.text = heroModel.heroInfo?.itemsTips?.first! ?? ""
        skillDesTextView.snp.makeConstraints { (mark) in
            mark.left.equalTo(skilssTableView.snp.right).offset(10)
            mark.top.equalTo(attributeNameLabel.snp.bottom).offset(5)
            mark.right.equalTo(skinBigImageView.snp.right).offset(-5)
            mark.bottom.equalTo(skillTipsTextView.snp.top).offset(-5)
        }
        
        //铭文介绍
        let mingsLabel = UILabel()
        mingsLabel.text = "铭文推荐"
        mingsLabel.textColor = CustomColor.mainColor
        mingsLabel.font = UIFont.systemFont(ofSize: 18)
        scrollView.addSubview(mingsLabel)
        mingsLabel.snp.makeConstraints { (mark) in
            mark.left.equalTo(skinBigImageView.snp.left).offset(5)
            mark.right.equalTo(skinBigImageView.snp.right).offset(-5)
            mark.top.equalTo(itemTipsTextView.snp.bottom).offset(5)
            mark.height.equalTo(30)
        }
        
        //铭文图片
        for i in 0...2 {
            let image = UIImageView()
            image.tag = i + 20
            image.contentMode = .scaleAspectFit
            let id = heroModel.heroInfo?.ming?[i] ?? ""
            image.kf.setImage(with:  URL(string: "https://game.gtimg.cn/images/yxzj/img201606/mingwen/\(id).png"), placeholder: CustomCreate.createActivity())
            scrollView.addSubview(image)
            image.snp.makeConstraints { (mark) in
                mark.size.equalTo(CGSize(width: width, height: width))
                mark.top.equalTo(mingsLabel.snp.bottom).offset(5)
                mark.left.equalTo(scrollView).offset(10 + (10 + width) * CGFloat(i))
            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTap(tap:)))
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(tap)
        }
        
        //英雄铭文推荐
        mingTextView = UITextView()
        mingTextView.layer.cornerRadius = 2
        mingTextView.backgroundColor = .red
        mingTextView.backgroundColor = CustomColor.mainColor
        mingTextView.textColor = CustomColor.textColorWhite
        mingTextView.isEditable = false
        mingTextView.isSelectable = false
        mingTextView.font = UIFont.systemFont(ofSize: 14)
        mingTextView.textContainerInset = .init()
        scrollView.addSubview(mingTextView)
        mingTextView.snp.makeConstraints { (mark) in
            mark.top.equalTo(mingsLabel.snp.bottom).offset(width + 10)
            mark.left.equalTo(skinBigImageView.snp.left).offset(5)
            mark.height.equalTo(50)
            mark.right.equalTo(skinBigImageView).offset(-5)
        }
        mingTextView.text = heroModel.heroInfo?.mingTips! ?? ""
        
        //英雄故事
        let heroStoryLabel = UILabel()
        heroStoryLabel.text = "英雄故事"
        heroStoryLabel.textColor = CustomColor.mainColor
        heroStoryLabel.font = UIFont.systemFont(ofSize: 18)
        scrollView.addSubview(heroStoryLabel)
        heroStoryLabel.snp.makeConstraints { (mark) in
            mark.left.equalTo(skinBigImageView.snp.left).offset(5)
            mark.right.equalTo(skinBigImageView.snp.right).offset(-5)
            mark.top.equalTo(mingTextView.snp.bottom).offset(5)
            mark.height.equalTo(30)
        }
        
        //英雄故事内容
        let  heroStoryText = UITextView()
        heroStoryText.layer.cornerRadius = 2
        heroStoryText.backgroundColor = CustomColor.mainColor
        heroStoryText.textColor = CustomColor.textColorWhite
        heroStoryText.isEditable = false
        heroStoryText.isSelectable = false
        heroStoryText.font = UIFont.systemFont(ofSize: 14)
        heroStoryText.textContainerInset = .init()
        scrollView.addSubview(heroStoryText)
        var text = heroModel.heroInfo?.story ?? ""
        text = text.replacingOccurrences(of: "<p>", with: "\t")
        text = text.replacingOccurrences(of: "</p>", with: "")
        text = text.replacingOccurrences(of: "<br>", with: "\n\t")
        let spacing = NSMutableParagraphStyle()
        spacing.lineSpacing = 4
        spacing.paragraphSpacing = 8
        let attr = [NSAttributedString.Key.paragraphStyle: spacing, NSAttributedString.Key.foregroundColor: CustomColor.textColorWhite]
        heroStoryText.attributedText = NSAttributedString(string: text, attributes: attr)
//        heroStoryText.text = text
        let max = getTextViewHeight(textView: heroStoryText, width: UIScreen.main.bounds.width - 10)
        var textViewHeight = 400
        if Int(max) < textViewHeight {
            textViewHeight = Int(max)
        }
        heroStoryText.snp.makeConstraints { (mark) in
            mark.top.equalTo(heroStoryLabel.snp.bottom).offset(10)
            mark.left.equalTo(skinBigImageView.snp.left).offset(5)
            mark.height.equalTo(textViewHeight)
            mark.right.equalTo(skinBigImageView).offset(-5)
        }
        
        videoButton = UIButton()
        let videoTitle = NSAttributedString(string: "想学技术，点击这里查看教程！",
                                            attributes :
             [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
             NSAttributedString.Key.foregroundColor: CustomColor.mainColor,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
             NSAttributedString.Key.obliqueness: 0.5])
        videoButton.setAttributedTitle(videoTitle, for: .normal)
        scrollView.addSubview(videoButton)
        videoButton.snp.makeConstraints { (mark) in
            mark.left.right.equalTo(skinBigImageView)
            mark.top.equalTo(heroStoryText.snp.bottom).offset(10)
            mark.height.equalTo(30)
        }
        videoButton.addTarget(self, action: #selector(videoBtn), for: .touchUpInside)
    }

    //保存到相册
    @objc func saveSkin() {
        if let image = skinBigImageView.image {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized || status == .notDetermined {
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveImage(image:error:info:)), nil)
                } else {
                    BWHUD.infoHUD(msg: "没有保存到相册的权限")
                }
            }
        } else {
            BWHUD.infoHUD(msg: "正在下载该皮肤，请稍后再保存！")
        }
    }
    
    @objc func saveImage(image: UIImage, error: Error?, info: AnyObject){
        if error == nil {
            BWHUD.successHUD(msg: "已存储到相册")
        } else {
            BWHUD.infoHUD(msg: "保存失败")
        }
    }
    
    //segment切换显示图片
    @objc func segmentViewControlChenge(segment: UISegmentedControl) {
        for (index, image) in itemsImageView.enumerated() {
            let id = (segment.selectedSegmentIndex == 0) ? (heroModel.heroInfo?.items?.first?[index] ?? "") : (heroModel.heroInfo?.items?.last![index] ?? "")
            image.kf.setImage(with: URL(string: "https://game.gtimg.cn/images/yxzj/img201606/itemimg/\(id).jpg"), placeholder: CustomCreate.createActivity())
            itemTipsTextView.text = (segment.selectedSegmentIndex == 0) ? ( heroModel.heroInfo?.itemsTips?.first ?? "") :
            (heroModel.heroInfo?.itemsTips?.last ?? "")
        }
    }
    
    @objc func imageTap(tap: UITapGestureRecognizer) {
        if (tap.view?.tag)! >= 20, let mings = CommonData.mings {
            //铭文
            let id = heroModel.heroInfo?.ming?[tap.view!.tag-20] ?? ""
            let ming = mings.first(where: { $0.id == id })
            guard let obj = ming else {
                return
            }
            CustomCreate.showMingTips(ming: obj)
        } else {
            //装备
            guard let items = CommonData.items else {
                return
            }
            let id = (segmentViewControl.selectedSegmentIndex == 0) ? (heroModel.heroInfo?.items?.first?[tap.view!.tag-10] ?? "") : (heroModel.heroInfo?.items?.last?[tap.view!.tag-10] ?? "")
            let item = items.first(where: { "\($0.id)" == id })
            CustomCreate.showItemTips(item: item!)
        }
    }
    
    //查看视频
    @objc func videoBtn() {
        let video = VideoListViewController()
        video.hero = heroModel
        navigationController?.pushViewController(video, animated: true)
    }
}

extension HeroInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1{
            return heroModel.heroInfo?.skins?.count ?? 0
        }else if tableView.tag == 2 {
            return heroModel.heroInfo?.skills?.count ?? 0
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView.tag == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "heroSkinCell", for: indexPath)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            
            for sub in cell.contentView.subviews {
                sub.removeFromSuperview()
            }
            
            if skinSelected == indexPath.row {
                let back = UIView()
                back.backgroundColor = CustomColor.mainColor
                cell.contentView.addSubview(back)
                back.snp.makeConstraints { (mark) in
                    mark.left.right.top.bottom.equalTo(cell.contentView)
                }
            }
            
            let image = UIImageView()
            cell.contentView.addSubview(image)
            image.snp.makeConstraints { (mark) in
                mark.left.top.equalTo(cell.contentView).offset(2)
                mark.right.bottom.equalTo(cell.contentView).offset(-2)
            }
            let skin = heroModel.heroInfo?.skins![indexPath.row].first
            image.kf.setImage(with: URL(string: skin!), placeholder: CustomCreate.createActivity())
            
        } else if tableView.tag == 2{
            cell = tableView.dequeueReusableCell(withIdentifier: "heroSkilssCell", for: indexPath)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            
            for sub in cell.contentView.subviews {
                sub.removeFromSuperview()
            }
            
            if skillSelected == indexPath.row {
                let back = UIView()
                back.backgroundColor = CustomColor.mainColor
                cell.contentView.addSubview(back)
                back.snp.makeConstraints { (mark) in
                    mark.left.right.top.bottom.equalTo(cell.contentView)
                }
            }
            
            let image = UIImageView()
            cell.contentView.addSubview(image)
            image.snp.makeConstraints { (mark) in
                mark.left.top.equalTo(cell.contentView).offset(2)
                mark.right.bottom.equalTo(cell.contentView).offset(-2)
            }
            let skin = heroModel.heroInfo?.skills?[indexPath.row][1] ?? ""
            image.kf.setImage(with: URL(string: skin), placeholder: CustomCreate.createActivity())
        }else{
            cell = UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.tag == 1 || tableView.tag == 2{
            return 50
        }else {
            return 0.001
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 1 {
            if skinSelected == indexPath.row{
                return
            }else{
                skinSelected = indexPath.row
                let url = heroModel.heroInfo?.skins![indexPath.row].last ?? ""
                skinBigImageView.image = nil
                skinBigImageView.kf.setImage(with: URL(string: url), placeholder: CustomCreate.createActivity())
                heroNameLabel.text = heroModel.heroInfo?.skin![indexPath.row]
            }
        }else if tableView.tag == 2 {
            if skillSelected == indexPath.row {
                return
            } else {
                skillSelected = indexPath.row
                skillNameLabel.text = heroModel.heroInfo?.skills![indexPath.row][0]
                attributeNameLabel.text = heroModel.heroInfo?.skills![indexPath.row][2]
                skillDesTextView.text = heroModel.heroInfo?.skills![indexPath.row][3]
                skillTipsTextView.text = heroModel.heroInfo?.skills![indexPath.row][4]
            }
        }
        DispatchQueue.main.async {
             tableView.reloadData()
        }
    }
}
