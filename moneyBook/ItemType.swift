//
//  ItemType.swift
//  moneyBook
//
//  Created by p14822 on 2017/12/29.
//  Copyright © 2017年 p14822. All rights reserved.
//

import Foundation
import UIKit

let ImageWidth = 40
let ImageHeight = 40

enum ItemTypeSelect:Int{
    case FOOD
    case DRINK
    case TRAFFIC
    case CHRISTMAS
    
    static var count: Int { return ItemTypeSelect.CHRISTMAS.hashValue + 1}
    
    func setPickerView() -> UIImageView {
        var imageView:UIImageView
        switch self {
        case .FOOD:
            imageView = UIImageView(image: UIImage(named: "food.png"))
            imageView.frame = CGRect(x:0,y:0,width:ImageWidth,height:ImageHeight)
        case .DRINK:
            imageView = UIImageView(image: UIImage(named: "cup.png"))
            imageView.frame = CGRect(x:0,y:0,width:ImageWidth,height:ImageHeight)
        case .TRAFFIC:
            imageView = UIImageView(image: UIImage(named: "bus.png"))
            imageView.frame = CGRect(x:0,y:0,width:ImageWidth,height:ImageHeight)
        case .CHRISTMAS:
            imageView = UIImageView(image: UIImage(named: "christmas.png"))
            imageView.frame = CGRect(x:0,y:0,width:ImageWidth,height:ImageHeight)
        }
        return imageView
    }
    

}

