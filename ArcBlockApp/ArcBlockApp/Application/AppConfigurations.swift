import Foundation

final class AppConfiguration {
    lazy var dataPath: String = {
        guard let pathKey = Bundle.main.object(forInfoDictionaryKey: "pathKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        return pathKey
    }()
}
