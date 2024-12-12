// **Note**: DTOs structs are mapped into Domains here, and Repository protocols does not contain DTOs

import Foundation

final class DefaultBlogsRepository {

    private let dataTransferService: DataTransferService
//    private let cache: blogsResponseStorage
    private let backgroundQueue: DataTransferDispatchQueue

    init(
        dataTransferService: DataTransferService,
//        cache: blogsResponseStorage,
        backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.dataTransferService = dataTransferService
//        self.cache = cache
        self.backgroundQueue = backgroundQueue
    }
}

//extension DefaultblogsRepository: blogsRepository {
//    
//    func fetchblogsList(
//        query: MovieQuery,
//        page: Int,
//        cached: @escaping (blogsPage) -> Void,
//        completion: @escaping (Result<blogsPage, Error>) -> Void
//    ) -> Cancellable? {
//
//        let requestDTO = blogsRequestDTO(query: query.query, page: page)
//        let task = RepositoryTask()
//
//        cache.getResponse(for: requestDTO) { [weak self, backgroundQueue] result in
//
//            if case let .success(responseDTO?) = result {
//                cached(responseDTO.toDomain())
//            }
//            guard !task.isCancelled else { return }
//
//            let endpoint = APIEndpoints.getblogs(with: requestDTO)
//            task.networkTask = self?.dataTransferService.request(
//                with: endpoint,
//                on: backgroundQueue
//            ) { result in
//                switch result {
//                case .success(let responseDTO):
//                    self?.cache.save(response: responseDTO, for: requestDTO)
//                    completion(.success(responseDTO.toDomain()))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
//        return task
//    }
//}
