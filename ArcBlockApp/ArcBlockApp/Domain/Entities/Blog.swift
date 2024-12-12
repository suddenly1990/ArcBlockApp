import Foundation

struct Blog: Equatable, Identifiable {
    typealias Identifier = String
    enum Genre {
        case adventure
        case scienceFiction
    }
    let id: Identifier
    let title: String?
    let genre: Genre?
    let posterPath: String?
    let overview: String?
    let releaseDate: Date?
}

struct BlogPage: Equatable {
    let page: Int
    let totalPages: Int
    let blogs: [Blog]
}
