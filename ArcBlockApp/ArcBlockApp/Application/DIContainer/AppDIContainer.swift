import Foundation

final class AppDIContainer {
    
    lazy var appConfiguration = AppConfiguration()
    // MARK: -  localData
    lazy var dataTransferService: DefaultLocalDataTransferService = {
        let config = LocalDataNetworkConfig(
            type: 0, fileName: "data.json"
        )
        let localDataNetwork = DefaultLocalService(config: config)
        return DefaultLocalDataTransferService(with: localDataNetwork)
    }()

//    // MARK: - DIContainers of scenes
    func makeBlogSceneDIContainer() -> BlogSceneDIContainer {
        let dependencies = BlogSceneDIContainer.Dependencies(
            dataService: dataTransferService
        )
        return BlogSceneDIContainer(dependencies: dependencies)
    }
}
