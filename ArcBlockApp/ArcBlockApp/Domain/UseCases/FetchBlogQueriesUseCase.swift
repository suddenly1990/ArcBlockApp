import Foundation

// This is another option to create Use Case using more generic way
final class FetchBlogQueriesUseCase: UseCase {

   private let blogsQueriesRepository: BlogRepository

    init(blogsQueriesRepository: BlogRepository) {
        self.blogsQueriesRepository = blogsQueriesRepository
    }
    
    func start() -> Cancellable? {
        return blogsQueriesRepository.fetchBlogList(
            query: BlogQuery(),
            page: 0,
            completion: { result in
                switch result {
                case .success(let blogPage):
                    print("Fetched blogs: \(blogPage.totalPages)")
                    // 在这里处理成功的结果，例如更新 UI
                case .failure(let error):
                    print("Error fetching blogs: \(error)")
                    // 在这里处理错误，例如显示错误消息
                }
            }
        )
    }
}
