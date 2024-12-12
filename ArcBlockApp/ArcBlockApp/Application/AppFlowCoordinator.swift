import UIKit

final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        let blogSceneDIContainer = appDIContainer.makeBlogSceneDIContainer()
        let flow = blogSceneDIContainer.makeBlogFlowCoordinator(navigationController: self.navigationController)
        flow.start()
    }
}
