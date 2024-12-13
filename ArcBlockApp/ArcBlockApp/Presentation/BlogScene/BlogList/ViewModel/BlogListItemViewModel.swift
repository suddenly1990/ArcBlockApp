import Foundation

struct BlogListItemViewModel: Equatable {
    let coverImagePath: String!
    let title:String
    let labels:[String]
    var dateString: String?
    var detailURL:String?
    var labelURL:String?
}




extension BlogListItemViewModel {

    init(blog: Blog) {
        self.title = blog.title
        self.coverImagePath = blog.cover
        self.labels = blog.labels
        self.detailURL = blog.slug
        self.dateString = formatDate(from: blog.publishTime)
    }
    
    func formatDate(from isoDateString: String) -> String? {
        // 创建一个 ISO8601 的日期格式解析器
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        // 将字符串解析为 Date 对象
        guard let date = isoDateFormatter.date(from: isoDateString) else {
            print("Invalid date format")
            return nil
        }
        
        // 创建一个目标格式的 DateFormatter
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy年MM月dd日" // 自定义格式
        outputDateFormatter.locale = Locale(identifier: "zh_CN") // 确保中文格式
        
        // 将 Date 格式化为目标字符串
        return outputDateFormatter.string(from: date)
    }

}


