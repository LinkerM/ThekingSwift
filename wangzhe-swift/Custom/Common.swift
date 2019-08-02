//
//  Common.swift
//  wangzhe-swift
//
//  Created by Joint on 2019/7/26.
//  Copyright © 2019年 Joint. All rights reserved.
//

import Foundation


func getTextViewHeight(textView: UITextView, width: CGFloat) -> CGFloat {
    let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    return textView.sizeThatFits(size).height
}

extension String {
    
    func substring(from: Int, to: Int) -> String? {
        if to >= self.count || to < 0 || from >= self.count || from < 0 || from >= to {
            return nil
        }
        let start = self.index(self.startIndex, offsetBy: from)
        let end = self.index(self.startIndex, offsetBy: to)
        return String(self[start ..< end])
    }
    
    public func substring(from: Int, length: Int) -> String? {
        if from >= self.count || from < 0 || length > self.count || length < 0 || from + length > self.count {
            return nil
        }
        let start = self.index(self.startIndex, offsetBy: from)
        let end = self.index(start, offsetBy: length)
        return String(self[start ..< end])
    }
    
}
