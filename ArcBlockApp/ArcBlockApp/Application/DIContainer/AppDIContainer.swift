import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    // MARK: -  localData
    lazy var dataService: DefaultLocalService = {
        let config = LocalDataNetworkConfig(
           fileName: appConfiguration.dataPath
        )
        return DefaultLocalService(config: config)
    }()

//    // MARK: - DIContainers of scenes
    func makeBlogSceneDIContainer() -> BlogSceneDIContainer {
        let dependencies = BlogSceneDIContainer.Dependencies(
            dataService: dataService
        )
        return BlogSceneDIContainer(dependencies: dependencies)
    }
}
