import Foundation

// This is another option to create Use Case using more generic way
final class FetchBlogQueriesUseCase: UseCase {

    struct BlogUseCaseRequestValue {
        let query: BlogQuery
        let page: Int
    }
    private let requestValue: BlogUseCaseRequestValue
    private let blogsQueriesRepository: BlogRepository

    init(
        requestValue: BlogUseCaseRequestValue,
        blogsQueriesRepository: BlogRepository
    ) {

        self.requestValue = requestValue
        self.blogsQueriesRepository = blogsQueriesRepository
    }
    
    func start() -> Cancellable? {

        return blogsQueriesRepository.fetchBlogList(
            query: requestValue.query,
            page: requestValue.page,
            completion: { result in
                // TODO
//                怎么回事
        })

        return nil
    }
}
