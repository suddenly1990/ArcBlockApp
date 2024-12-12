import Foundation

protocol BlogRepository {
    @discardableResult
    func fetchBlogList(
        query: BlogQuery,
        page: Int,
        completion: @escaping (Result<BlogPage, Error>) -> Void
    ) -> Cancellable?
}
