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

struct DataConfig: LocalConfigurable {
    let fileName: String
    var localData: Bool = true     
     init(
        fileName: String,
        localData: Bool = true
     ) {
        self.fileName = fileName
        self.localData = localData
    }
}


