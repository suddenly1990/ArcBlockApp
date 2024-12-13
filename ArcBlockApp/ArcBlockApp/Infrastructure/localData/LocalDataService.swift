//
//  LocalDataService.swift
//  ArcBlockApp
//
//  Created by 代百生 on 2024/12/12.
//

import Foundation

// MARK: - Implementation

final class DefaultLocalService: BlogRepository {
    
    let localConfig:LocalDataNetworkConfig
    
    init(config:LocalDataNetworkConfig) {
        self.localConfig = config
    }
    
    func fetchBlogList(query: BlogQuery, page: Int, completion: @escaping (Result<BlogPage, any Error>) -> Void) -> (any Cancellable)? {
        
        
        
        return nil
    }
    
}

