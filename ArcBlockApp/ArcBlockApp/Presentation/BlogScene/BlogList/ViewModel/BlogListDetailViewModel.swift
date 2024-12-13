//
//  BlogListDetailViewModel.swift
//  ArcBlockApp
//
//  Created by 代百生 on 2024/12/13.
//

import Foundation

struct BlogListDetailViewModel: Equatable {
    let detailUrl: String!
}




extension BlogListDetailViewModel {
    init(url: String) {
        self.detailUrl = url
    }
}


