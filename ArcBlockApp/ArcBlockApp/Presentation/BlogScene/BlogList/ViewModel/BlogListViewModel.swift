import Foundation

struct BlogListViewModelActions {
    let showBlogDetails: (Blog) -> Void
}

enum BlogListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol BlogListViewModelInput {
    func viewWillAppear()
    func didLoadNextPage()
    func didSelectItem(at index: Int)
}

protocol BlogListViewModelOutput {
    var items: Observable<[BlogListItemViewModel]> { get } /// Also we can
    var loading: Observable<BlogListViewModelLoading?> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
}

typealias BlogListViewModel = BlogListViewModelInput & BlogListViewModelOutput

final class DefaultBlogListViewModel: BlogListViewModel {
    
    private let blogsUseCase: FetchBlogQueriesUseCase
    private let actions: BlogListViewModelActions?
    private let mainQueue: DispatchQueueType
    private var pages: BlogPage?
    
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

   
    private var BlogLoadTask: Cancellable? { willSet { BlogLoadTask?.cancel() } }
   

    // MARK: - OUTPUT
    let items: Observable<[BlogListItemViewModel]> = Observable([])
    let loading: Observable<BlogListViewModelLoading?> = Observable(.none)
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Blog", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")

    // MARK: - Init
    
    init(
        blogsUseCase: FetchBlogQueriesUseCase,
        actions: BlogListViewModelActions? = nil,
        mainQueue: DispatchQueueType = DispatchQueue.main
    ) {
        self.blogsUseCase = blogsUseCase
        self.actions = actions
        self.mainQueue = mainQueue
    }

    // MARK: - Private

    private func appendPage(_ blogPage: BlogPage) {
//        currentPage = blogPage.page
//        totalPageCount = blogPage.totalPages

//        pages = pages
//            .filter { $0.page != blogPage.page }
//            + [blogPage]

        // TODO
//        items.value = pages.blogs.map(BlogListItemViewModel.init)
    }

    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
//        pages.removeAll()
        items.value.removeAll()
    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading Blog", comment: "")
    }
    
    private func updateBlogsQueries() {
        self.blogsUseCase.start()
    }
}
// MARK: - INPUT. View event methods
extension DefaultBlogListViewModel {
    
    func viewWillAppear() {
        updateBlogsQueries()
    }

    func didLoadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
//        load(BlogQuery: .init(query: query.value),
//             loading: .nextPage)
    }
    func didSelectItem(at index: Int) {
//         actions?.showBlogDetails(pages[index])
    }
}
