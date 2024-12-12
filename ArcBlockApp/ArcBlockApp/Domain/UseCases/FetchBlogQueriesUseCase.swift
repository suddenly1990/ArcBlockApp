import Foundation

// This is another option to create Use Case using more generic way
final class FetchBlogQueriesUseCase: UseCase {

//    private let blogsQueriesRepository: BlogRepository

//    init(blogsQueriesRepository: BlogRepository) {
//        self.blogsQueriesRepository = blogsQueriesRepository
//    }
    
    func start() -> Cancellable? {
        
//        return blogsQueriesRepository.fetchBlogList(
//            query: BlogQuery.init(query: "11111"),
//            page: 1,
//            completion: { result in
//                // TODO
////                怎么回事
//        })
//
        return nil
    }
}
