//
//  LocalDataConfig.swift
//  ArcBlockApp
//
//  Created by 代百生 on 2024/12/12.
//

import Foundation


protocol LocalConfigurable {
    var fileName: String { get }
}

struct LocalDataNetworkConfig: LocalConfigurable {
    let fileName: String
     init(
        fileName: String
     ) {
        self.fileName = fileName
    }
}
