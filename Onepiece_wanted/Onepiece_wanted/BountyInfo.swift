//
//  BountyInfo.swift
//  Onepiece_wanted
//
//  Created by 서보경 on 2020/10/30.
//

import UIKit

// MARK: - Model

struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: name)
    }
    
    init(name: String, bounty: Int) {
        self.name = name
        self.bounty = bounty
    }
}
