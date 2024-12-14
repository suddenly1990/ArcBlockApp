import Foundation

final class AppConfiguration {
    lazy var dataPath: String = {
        guard let pathKey = Bundle.main.object(forInfoDictionaryKey: "pathKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
//        print(pathKey)
        return pathKey
    }()

     lazy var imageURL: String = {
        guard let imageURL = Bundle.main.object(forInfoDictionaryKey: "ImageURlKey") as? String else {
            fatalError("ApiKey must not be empty in plist")
        }
//        print(imageURL)
        return imageURL
    }()
    
    
    lazy var detailURL: String = {
       guard let detailURL = Bundle.main.object(forInfoDictionaryKey: "detailURLKey") as? String else {
           fatalError("ApiKey must not be empty in plist")
       }
//       print(detailURL)
       return detailURL
   }()
    
    lazy var labelBaseURL: String = {
       guard let labelBaseURL = Bundle.main.object(forInfoDictionaryKey: "labelBaseURLKey") as? String else {
           fatalError("ApiKey must not be empty in plist")
       }
//       print(labelBaseURL)
       return labelBaseURL
   }()
    
    
    lazy var requestURL: String = {
       guard let requestURL = Bundle.main.object(forInfoDictionaryKey: "requestURLKey") as? String else {
           fatalError("ApiKey must not be empty in plist")
       }
//       print(requestURL)
       return requestURL
   }()


}
