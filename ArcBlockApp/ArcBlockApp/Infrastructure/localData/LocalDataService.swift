//
//  LocalDataService.swift
//  ArcBlockApp
//
//  Created by 代百生 on 2024/12/12.
//

import Foundation

enum LocalDataError: Error {
    case error(statusCode: Int, data: Data?)
    case cancelled
}

protocol LocalCancellable {
    func cancel()
}

enum DataType: Int {
    case JsonDdata
}

protocol localDataRequestable {
    var path: String { get }
    var dataType: DataType { get }
}

protocol LocalService {
    typealias CompletionHandler = (Result<Data?, LocalDataError>) -> Void
    
    func request(localData: localDataRequestable, completion: @escaping CompletionHandler) -> LocalCancellable?
}


// MARK: - Implementation

final class DefaultLocalService {
    
    private let config: LocalConfigurable
    
    init(
        config: LocalConfigurable
    ) {
        self.config = config
    }
    // TODO
//    private func request(
//        localData: localDataRequestable,
//        completion: CompletionHandler
//    ) -> LocalCancellable {
//        
// 
//    }
    
}

