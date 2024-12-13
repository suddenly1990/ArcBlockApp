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
    let imageUrl: String
    let detailUrl: String
    var localData: Bool = true
    
     init(
        fileName: String,
        imageUrl:String,
        detailUrl: String,
        localData: Bool = true
     ) {
        self.fileName = fileName
        self.localData = localData
        self.imageUrl = imageUrl
        self.detailUrl = detailUrl
    }
}


