import UIKit

// TODO
protocol BlogFlowCoordinatorDependencies  {
    func makeBlogsListTableViewController(actions:BlogListViewModelActions) -> BlogListTableViewController
}

final class BlogFlowFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: BlogFlowCoordinatorDependencies

    private weak var blogListVC: BlogListTableViewController?

    init(navigationController: UINavigationController,
         dependencies: BlogFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with actions, this way this flow do not need to be strong referenced
        let actions = BlogListViewModelActions(showBlogDetails: showBlogDetails,
                                                 showBlogQueriesSuggestions: showBlogQueriesSuggestions,
                                               closeBlogQueriesSuggestions: closeBlogQueriesSuggestions)
        let vc = dependencies.makeBlogsListTableViewController(actions:actions)
        
        
        vc.view.backgroundColor = .red
        navigationController?.pushViewController(vc, animated: false)
        blogListVC = vc
    }
    
    
    private func showBlogDetails(movie: Blog) {
//        let vc = dependencies.makeMoviesDetailsViewController(movie: movie)
//        navigationController?.pushViewController(vc, animated: true)
    }

    private func showBlogQueriesSuggestions(didSelect: @escaping (BlogQuery) -> Void) {
//        guard let moviesListViewController = moviesListVC, moviesQueriesSuggestionsVC == nil,
//            let container = moviesListViewController.suggestionsListContainer else { return }
//
//        let vc = dependencies.makeMoviesQueriesSuggestionsListViewController(didSelect: didSelect)
//
//        moviesListViewController.add(child: vc, container: container)
//        moviesQueriesSuggestionsVC = vc
//        container.isHidden = false
    }

    private func closeBlogQueriesSuggestions() {
//        moviesQueriesSuggestionsVC?.remove()
//        moviesQueriesSuggestionsVC = nil
//        moviesListVC?.suggestionsListContainer.isHidden = true
    }
}
