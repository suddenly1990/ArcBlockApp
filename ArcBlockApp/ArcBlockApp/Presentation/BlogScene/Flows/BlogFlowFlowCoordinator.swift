import UIKit

// TODO
protocol BlogFlowCoordinatorDependencies  {
    func makeBlogsListTableViewController(actions:BlogListViewModelActions) -> BlogListTableViewController
    
    func makeBlogDetailsViewController(blog: Blog) -> BlogDetailsViewController
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
        let actions = BlogListViewModelActions(showBlogDetails: showBlogDetails)
        let vc = dependencies.makeBlogsListTableViewController(actions:actions)
        navigationController?.pushViewController(vc, animated: false)
        blogListVC = vc
    }
    
    
    private func showBlogDetails(blog: Blog) {
        let vc = dependencies.makeBlogDetailsViewController(blog: blog)
        navigationController?.pushViewController(vc, animated: true)
    }
}
