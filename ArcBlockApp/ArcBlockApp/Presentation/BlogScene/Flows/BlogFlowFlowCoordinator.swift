import UIKit

// TODO
protocol BlogFlowCoordinatorDependencies  {
    func makeBlogsListTableViewController(actions:BlogListViewModelActions) -> BlogListTableViewController
    
    func makeBlogDetailsViewController(url: String) -> BlogWebViewController
    
    func makeTagListViewController(tag: String) -> BlogWebViewController

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
        let actions = BlogListViewModelActions(showBlogDetails: showBlogDetails,showtagList: showtagList)
        let vc = dependencies.makeBlogsListTableViewController(actions:actions)
        navigationController?.pushViewController(vc, animated: false)
        blogListVC = vc
    }
    
    
    private func showBlogDetails(url: String) {
        let vc = dependencies.makeBlogDetailsViewController(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showtagList(tag: String) {
        let vc = dependencies.makeTagListViewController(tag: tag)
        navigationController?.pushViewController(vc, animated: true)
    }
}
