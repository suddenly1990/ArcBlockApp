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
            with: makeBlogsListViewModel(actions: actions)
        )
    }
//    actions: actions
    func makeBlogsListViewModel(actions: BlogListViewModelActions) -> DefaultBlogListViewModel {
        DefaultBlogListViewModel(fetchBlogsUseCaseFactory: makeBlogUseCase,actions: actions)
            
    }
    // MARK: - Use Cases
    func makeBlogUseCase(completion: @escaping (FetchBlogQueriesUseCase.ResultValue) -> Void
    ) -> UseCase {
        FetchBlogQueriesUseCase(blogsQueriesRepository: self.dependencies.dataService,completion:completion)
    }
    
//    // MARK: - Flow Coordinators
    func makeBlogFlowCoordinator(navigationController: UINavigationController) -> BlogFlowFlowCoordinator {
        BlogFlowFlowCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
    
    func makeBlogDetailsViewController(url: String) -> BlogWebViewController {
        BlogWebViewController.create(with: url)
    }
    
    func makeTagListViewController(tag: String) -> BlogWebViewController {
        let labelBaseURL = self.dependencies.dataService.localConfig.labelUrl
        let url = "\(labelBaseURL)\(tag)"
        return BlogWebViewController.create(with: url)
    }
    
}
