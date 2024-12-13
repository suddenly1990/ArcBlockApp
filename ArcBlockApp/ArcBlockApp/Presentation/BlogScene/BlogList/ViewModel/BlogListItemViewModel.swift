import Foundation

struct BlogListItemViewModel: Equatable {
    let coverImagePath: String?
    let title:String
    let labels:[String]
    var dateString: String?
}

extension BlogListItemViewModel {

    init(blog: Blog) {
        self.title = blog.title
        self.coverImagePath = blog.cover
        self.labels = blog.labels
        self.dateString = blog.updatedAt
        if let date = ISO8601DateFormatter().date(from: blog.updatedAt) {
            self.dateString = dateFormatter.string(from: date)
        } else {
            self.dateString = ""
        }
    
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
