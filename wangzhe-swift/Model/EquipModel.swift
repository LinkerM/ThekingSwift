//
//  EquipModel.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/22.
//  Copyright © 2019年 Joint. All rights reserved.
//

import Foundation

struct EquipModel {
    var id: Int
    var name: String
    var type: Int
    var price: Int
    var buy: Int
    var des: String
    var imageUrl: String
    var des2: String?
    
    init(id: Int, name: String, type: Int, price: Int, buy: Int, des: String, des2: String?) {
        self.id = id
        self.name = name
        self.type = type
        self.price = price
        self.buy = buy
        self.des = des
        self.des2 = des2
        imageUrl = "https://game.gtimg.cn/images/yxzj/img201606/itemimg/\(id).jpg"
    }
}
