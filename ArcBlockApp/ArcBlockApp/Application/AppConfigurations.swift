import Foundation

final class AppConfiguration {
    lazy var dataPath: String = {
        guard let pathKey = Bundle.main.object(forInfoDictionaryKey: "pathKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        print(pathKey)
        return pathKey
    }()

     lazy var imageURL: String = {
        guard let imageURL = Bundle.main.object(forInfoDictionaryKey: "ImageURlKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
        print(imageURL)
        return imageURL
    }()
    
    
    lazy var requestURL: String = {
       guard let requestURL = Bundle.main.object(forInfoDictionaryKey: "requestURLKey") as? String else {
           fatalError("ApiKey must not be empty in plist")
       }
       print(requestURL)
       return requestURL
   }()


}
