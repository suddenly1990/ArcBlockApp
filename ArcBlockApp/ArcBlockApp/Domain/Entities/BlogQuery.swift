//
//  BlogQuery.swift
//  ArcBlockApp
//
//  Created by 代百生 on 2024/12/12.
//
import Foundation

struct BlogQuery: Equatable {
    let size = 20
    let local = "en"
    let tagMatchStrategy = "all"
    let sort = "-publishTime"
}

