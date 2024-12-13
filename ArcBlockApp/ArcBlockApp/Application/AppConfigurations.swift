import Foundation

final class AppConfiguration {
    lazy var dataPath: String = {
        guard let pathKey = Bundle.main.object(forInfoDictionaryKey: "pathKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        print(pathKey)
        return pathKey
    }()

     lazy var baseURl: String = {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "baseURlKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        print(baseURL)
        return baseURl
    }()

}
