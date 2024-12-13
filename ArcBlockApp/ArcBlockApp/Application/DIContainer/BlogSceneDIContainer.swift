//
//  File.swift
//  ArcBlockApp
//
//  Created by 代百生 on 2024/12/12.
//
import UIKit

// TODO 需要改变依赖
final class BlogSceneDIContainer: BlogFlowCoordinatorDependencies {
    
    struct Dependencies {
        let dataService: DefaultLocalService
    }

    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

//    // MARK: - blogs List
    func makeBlogsListTableViewController(actions:BlogListViewModelActions) -> BlogListTableViewController {
        BlogListTableViewController.create(
            with: makeMoviesListViewModel(actions: actions)
        )
    }
    
    func makeMoviesListViewModel(actions: BlogListViewModelActions) -> DefaultBlogListViewModel {
        DefaultBlogListViewModel(
            blogsUseCase: makeSearchMoviesUseCase(),
            actions: actions
        )
    }
    // MARK: - Use Cases
    func makeSearchMoviesUseCase() -> FetchBlogQueriesUseCase {
        FetchBlogQueriesUseCase(blogsQueriesRepository: self.dependencies.dataService)
    }
//    // MARK: - Flow Coordinators
    func makeBlogFlowCoordinator(navigationController: UINavigationController) -> BlogFlowFlowCoordinator {
        BlogFlowFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
    
     // TODO
    func makeBlogDetailsViewController(blog: Blog) -> BlogDetailsViewController {
        BlogDetailsViewController()
    }
}
