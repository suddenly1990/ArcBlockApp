import Foundation

// This is another option to create Use Case using more generic way
final class FetchBlogQueriesUseCase: UseCase {

    private let blogsQueriesRepository: BlogRepository
    private let completion: (ResultValue) -> Void

    typealias ResultValue = (Result<BlogPage, Error>)
    
    init(blogsQueriesRepository: BlogRepository,
         completion: @escaping (ResultValue) -> Void) {
        self.blogsQueriesRepository = blogsQueriesRepository
        self.completion = completion
    }
    
    func start() -> Cancellable? {
        return blogsQueriesRepository.fetchBlogList(
            query: BlogQuery(),
            page: 0,
            completion:self.completion
        )
    }
}
