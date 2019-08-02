//
//  HeroCellCollectionViewCell.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/19.
//  Copyright © 2019年 Joint. All rights reserved.
//

import UIKit
import SnapKit

class HeroCellCollectionViewCell: UICollectionViewCell {
    
    var heroName = UILabel()
    var heroImageView  = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        heroName = UILabel()
        heroName.textColor = CustomColor.mainColor
        heroName.font = UIFont.systemFont(ofSize: 15)
        heroName.textAlignment = .center
        heroName.adjustsFontSizeToFitWidth = true
        contentView.addSubview(heroName)
        
        heroImageView = UIImageView()
        heroImageView.contentMode = .scaleAspectFit
        contentView.addSubview(heroImageView)
        
        heroName.snp.makeConstraints { (mark) in
            mark.left.bottom.right.equalTo(contentView)
            mark.height.equalTo(20)
        }
        
        heroImageView.snp.makeConstraints { (mark) in
            mark.top.left.right.equalTo(contentView)
            mark.bottom.equalTo(heroName.snp.top)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
