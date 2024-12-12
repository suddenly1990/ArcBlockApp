import Foundation

struct BlogListViewModelActions {
    
    let showBlogDetails: (Blog) -> Void
    let showBlogQueriesSuggestions: (@escaping (_ didSelect: BlogQuery) -> Void) -> Void
    let closeBlogQueriesSuggestions: () -> Void
}

enum BlogListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol BlogListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func showQueriesSuggestions()
    func closeQueriesSuggestions()
    func didSelectItem(at index: Int)
}

protocol BlogListViewModelOutput {
    var items: Observable<[BlogListItemViewModel]> { get } /// Also we can calculate view model items on demand:  https://github.com/kudoleh/iOS-Clean-Architecture-MVVM/pull/10/files
    var loading: Observable<BlogListViewModelLoading?> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

typealias BlogListViewModel = BlogListViewModelInput & BlogListViewModelOutput

final class DefaultBlogListViewModel: BlogListViewModel {
    
    private let blogsUseCase: FetchBlogQueriesUseCase
    private let actions: BlogListViewModelActions?

    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }

    private var pages: [BlogPage] = []
    private var BlogLoadTask: Cancellable? { willSet { BlogLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType

    // MARK: - OUTPUT

    let items: Observable<[BlogListItemViewModel]> = Observable([])
    let loading: Observable<BlogListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Blog", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Blog", comment: "")

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
        currentPage = blogPage.page
        totalPageCount = blogPage.totalPages

        pages = pages
            .filter { $0.page != blogPage.page }
            + [blogPage]

        // TODO
//        items.value = pages.blogs.map(BlogListItemViewModel.init)
    }

    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
        pages.removeAll()
        items.value.removeAll()
    }

    private func load(BlogQuery: BlogQuery, loading: BlogListViewModelLoading) {
        self.loading.value = loading
        query.value = BlogQuery.query

//        BlogLoadTask = searchBlogUseCase.execute(
//            requestValue: .init(query: BlogQuery, page: nextPage),
//            cached: { [weak self] page in
//                self?.mainQueue.async {
//                    self?.appendPage(page)
//                }
//            },
//            completion: { [weak self] result in
//                self?.mainQueue.async {
//                    switch result {
//                    case .success(let page):
//                        self?.appendPage(page)
//                    case .failure(let error):
//                        self?.handle(error: error)
//                    }
//                    self?.loading.value = .none
//                }
//        })
    }

    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading Blog", comment: "")
    }

    private func update(BlogQuery: BlogQuery) {
        resetPages()
        load(BlogQuery: BlogQuery, loading: .fullScreen)
    }
}

// MARK: - INPUT. View event methods

extension DefaultBlogListViewModel {

    func viewDidLoad() { }

    func didLoadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
        load(BlogQuery: .init(query: query.value),
             loading: .nextPage)
    }

    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(BlogQuery: BlogQuery(query: query))
    }

    func didCancelSearch() {
        BlogLoadTask?.cancel()
    }

    func showQueriesSuggestions() {
        actions?.showBlogQueriesSuggestions(update(BlogQuery:))
    }

    func closeQueriesSuggestions() {
        actions?.closeBlogQueriesSuggestions()
    }

    func didSelectItem(at index: Int) {
//        actions?.showBlogDetails(pages.Blog[index])
    }
}

// MARK: - Private

//private extension Array where Element == BlogPage {
//    var Blog: [Blog] { flatMap { $0.Blog } }
//}
