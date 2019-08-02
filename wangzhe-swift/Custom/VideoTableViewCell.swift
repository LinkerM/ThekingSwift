//
//  VideoTableViewCell.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/29.
//  Copyright © 2019年 Joint. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    var videImage : UIImageView!
    var videTitle : UILabel!
    var videoDesc : UILabel!
    var videoDetail : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        videImage = UIImageView()
        videImage.contentMode = .scaleAspectFill
        videImage.layer.masksToBounds = true
        contentView.addSubview(videImage)
        
        videTitle = UILabel()
        videTitle.textColor = CustomColor.mainColor
        videTitle.font = UIFont.systemFont(ofSize: 18)
        videTitle.numberOfLines = 2
        videTitle.textAlignment = .left
        videTitle.adjustsFontSizeToFitWidth = true
        contentView.addSubview(videTitle)
        
        videoDesc = UILabel()
        videoDesc.textColor = CustomColor.mainColor
        videoDesc.font = UIFont.systemFont(ofSize: 12)
        videoDesc.textAlignment = .left
        videoDesc.adjustsFontSizeToFitWidth = true
        videoDesc.numberOfLines = 3
        contentView.addSubview(videoDesc)
        
        videoDetail = UILabel()
        videoDetail.textColor = .gray
        videoDetail.font = UIFont.systemFont(ofSize: 10)
        videoDetail.textAlignment = .left
        videoDetail.adjustsFontSizeToFitWidth = true
        contentView.addSubview(videoDetail)
        
        videImage.snp.makeConstraints { (mark) in
            mark.top.left.equalToSuperview().offset(5)
            mark.bottom.equalToSuperview().offset(-5)
            mark.width.equalTo(100 / 0.618)
        }
        
        videTitle.snp.makeConstraints { (mark) in
            mark.top.equalToSuperview().offset(5)
            mark.right.equalToSuperview().offset(-5)
            mark.left.equalTo(videImage.snp.right).offset(5)
            mark.height.equalTo(40)
        }
        
        videoDesc.snp.makeConstraints { (mark) in
            mark.top.equalTo(videTitle.snp.bottom)
            mark.right.equalToSuperview().offset(-5)
            mark.left.equalTo(videTitle)
            mark.height.equalTo(40)
        }
        
        videoDetail.snp.makeConstraints { (mark) in
            mark.right.bottom.equalTo(-5)
            mark.left.equalTo(videTitle)
            mark.height.equalTo(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
