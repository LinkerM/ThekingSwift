//
//  SummonModel.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/22.
//  Copyright © 2019年 Joint. All rights reserved.
//

import Foundation

struct SummonModel {
    var id: Int
    var name: String
    var rank: String
    var des: String
    var imageUrl: String
    var bigUrl: String
    
    init(id: Int, name: String, rank: String, des: String) {
        self.id = id
        self.name = name
        self.rank = rank
        self.des = des
        imageUrl = "https://game.gtimg.cn/images/yxzj/img201606/summoner/\(id).jpg"
        bigUrl = "https://game.gtimg.cn/images/yxzj/img201606/summoner/\(id)-big.jpg"
    }
}
