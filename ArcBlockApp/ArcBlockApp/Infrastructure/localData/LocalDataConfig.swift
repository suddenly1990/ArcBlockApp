//
//  LocalDataConfig.swift
//  ArcBlockApp
//
//  Created by 代百生 on 2024/12/12.
//

import Foundation


protocol LocalConfigurable {
    var type: Int { get }
    var fileName: String { get }
}

// TODO
struct LocalDataNetworkConfig: LocalConfigurable {
    let type: Int
    let fileName: String
     init(
        type:Int,  // 类型
        fileName: String
     ) {
        self.type = type
        self.fileName = fileName
    }
}
