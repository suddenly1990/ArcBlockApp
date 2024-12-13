import Foundation

struct Blog: Codable, Identifiable {
 
    typealias Identifier = String
    
    struct Meta: Codable {
        let explicitSlug: Bool
        let unpublishedChanges: Int
    }
    
    let id: Identifier
    let latestCommenters: [String]
    let meta: Meta
    let slug: String
    let title: String
    let author: String
    let cover: String
    let excerpt: String
    let boardId: String
    let createdAt: String
    let updatedAt: String
    let commentCount: Int
    let type: String
    let status: String
    let publishTime: Date
    let labels: [String]
    let locale: String
}

struct BlogPage {
    let page: Int
    let totalPages: Int
    let blogs: [Blog]
}
