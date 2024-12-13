import Foundation

struct Blog: Codable, Identifiable {
 
    typealias Identifier = String
    
    struct Meta: Codable {
        let explicitSlug: Bool?
        let unpublishedChanges: Int
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.explicitSlug = try container.decodeIfPresent(Bool.self, forKey: .explicitSlug)
            self.unpublishedChanges = try container.decode(Int.self, forKey: .unpublishedChanges)
        }
    }
    
    let id: Identifier
    let latestCommenters: [String]
    let meta: Meta
    var slug: String
    let title: String
    let author: String
    var cover: String
    let excerpt: String
    let boardId: String
    let createdAt: String 
    let updatedAt: String
    let commentCount: Int
    let type: String
    let status: String
    let publishTime: String
    let labels: [String]
    let locale: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Identifier.self, forKey: .id)
        self.latestCommenters = try container.decodeIfPresent([String].self, forKey: .latestCommenters) ?? []
        self.meta = try container.decode(Meta.self, forKey: .meta)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.title = try container.decode(String.self, forKey: .title)
        self.author = try container.decode(String.self, forKey: .author)
        self.cover = try container.decode(String.self, forKey: .cover)
        self.excerpt = try container.decode(String.self, forKey: .excerpt)
        self.boardId = try container.decode(String.self, forKey: .boardId)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
        self.commentCount = try container.decode(Int.self, forKey: .commentCount)
        self.type = try container.decode(String.self, forKey: .type)
        self.status = try container.decode(String.self, forKey: .status)
        self.publishTime = try container.decode(String.self, forKey: .publishTime)
        self.labels = try container.decode([String].self, forKey: .labels)
        self.locale = try container.decode(String.self, forKey: .locale)
    }
}

struct BlogPage: Codable {
    let page: Int
    let totalPages: Int
    let blogs: [Blog]
}


struct BlogsResponse: Codable {
    let data: [Blog]
    let total: Int
    let countAll: Int
}
