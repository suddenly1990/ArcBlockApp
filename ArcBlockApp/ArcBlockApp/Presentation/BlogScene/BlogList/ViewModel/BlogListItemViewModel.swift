
import Foundation

struct BlogListItemViewModel: Equatable {
    let title: String
    let overview: String
    let releaseDate: String
    let posterImagePath: String?
}

extension BlogListItemViewModel {

    init(blog: Blog) {
        self.title = blog.title ?? ""
        self.posterImagePath = blog.posterPath
        self.overview = blog.overview ?? ""
        if let releaseDate = blog.releaseDate {
            self.releaseDate = "\(NSLocalizedString("Release Date", comment: "")): \(dateFormatter.string(from: releaseDate))"
        } else {
            self.releaseDate = NSLocalizedString("To be announced", comment: "")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
