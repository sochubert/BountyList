//
//  BountyInfo.swift
//  BountyList
//
//  Created by Minjae Lee on 2021/07/24.
//

import UIKit

struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    init(name:String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
