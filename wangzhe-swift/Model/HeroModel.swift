//
//  HeroModel.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/19.
//  Copyright © 2019年 Joint. All rights reserved.
//

import UIKit


struct HeroModel {
    var name: String
    var id: Int
    var newType: Int
    var payType: Int
    var heroType: Int
    var imageUrl: String
    var heroUrl: String
    var heroInfo: HeroInfo?
    
   
    
    init(name: String, id: Int, newType: Int, heroType: Int, payType: Int) {
        self.name = name
        self.id = id
        self.newType = newType
        self.heroType = heroType
        self.payType = payType
        imageUrl = "https://game.gtimg.cn/images/yxzj/img201606/heroimg/\(id)/\(id).jpg"
        heroUrl = "https://pvp.qq.com/web201605/herodetail/\(id).shtml"
    }
}

struct HeroInfo {
    var skin: [String]?
    var skins: [[String]]?
    var skills: [[String]]?
    var ming: [String]?
    var mingTips: String?
    var items: [[String]]?
    var itemsTips: [String]?
    var story: String?
}
