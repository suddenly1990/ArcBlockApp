import Foundation

enum DataTransferError: Error {
    case noResponse
}

protocol DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void)
}

extension DispatchQueue: DataTransferDispatchQueue {
    func asyncExecute(work: @escaping () -> Void) {
        async(group: nil, execute: work)
    }
}

protocol DataTransferService {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void
    
//    @discardableResult
//    func request<T: Decodable, E: ResponseRequestable>(
//        with endpoint: E,
//        on queue: DataTransferDispatchQueue,
//        completion: @escaping CompletionHandler<T>
//    ) -> NetworkCancellable? where E.Response == T
//    
//    @discardableResult
//    func request<T: Decodable, E: ResponseRequestable>(
//        with endpoint: E,
//        completion: @escaping CompletionHandler<T>
//    ) -> NetworkCancellable? where E.Response == T
//
//    @discardableResult
//    func request<E: ResponseRequestable>(
//        with endpoint: E,
//        on queue: DataTransferDispatchQueue,
//        completion: @escaping CompletionHandler<Void>
//    ) -> NetworkCancellable? where E.Response == Void
//    
//    @discardableResult
//    func request<E: ResponseRequestable>(
//        with endpoint: E,
//        completion: @escaping CompletionHandler<Void>
//    ) -> NetworkCancellable? where E.Response == Void
}

protocol DataTransferErrorResolver {
    func resolve(error: LocalDataError) -> Error
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

protocol DataTransferErrorLogger {
    func log(error: Error)
}


//////////////////////
final class DefaultLocalDataTransferService {
    
    private let localService: DefaultLocalService
    
    init(
        with localDataService: DefaultLocalService
    ) {
        self.localService = localDataService
    }
}


// MARK: - Logger
final class DefaultDataTransferErrorLogger: DataTransferErrorLogger {
    init() { }
    func log(error: Error) {
    }
}

