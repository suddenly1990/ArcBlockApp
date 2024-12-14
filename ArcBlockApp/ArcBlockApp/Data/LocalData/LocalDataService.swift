// MARK: - Implementation

import Foundation

final class DefaultLocalService: BlogRepository {
    
    let localConfig: DataConfig
    private var blogs: [Blog] = [] // 假设这是您的本地数据源
    
    init(config: DataConfig) {
        self.localConfig = config
        loadLocalData() // 加载本地 JSON 数据
    }
    
    func fetchBlogList(query: BlogQuery, page: Int, completion: @escaping (Result<BlogPage, any Error>) -> Void) -> (any Cancellable)? {
        let pageSize = query.size
        let startIndex = page * pageSize
        let endIndex = min(startIndex + pageSize, blogs.count)
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self = self else { return }
            
            if startIndex >= self.blogs.count {
                // 页码超出范围，返回空数据
                let emptyPage = BlogPage(page: page, totalPages: (self.blogs.count + pageSize - 1) / pageSize, blogs: [])
                completion(.success(emptyPage))
                return
            }
            // 计算当前页的数据
            let pageBlogs = Array(self.blogs[startIndex..<endIndex]).map { blog in
                var modifiedBlog = blog
                modifiedBlog.cover = "\(self.localConfig.imageUrl)\(blog.cover)"
                modifiedBlog.slug = "\(self.localConfig.detailUrl)\(blog.slug)"
                return modifiedBlog
            }
            let totalPages = (self.blogs.count + pageSize - 1) / pageSize
             let blogPage = BlogPage(page: page, totalPages: totalPages, blogs: pageBlogs)
          completion(.success(blogPage))
        }
        
        return nil // 如果需要返回一个可取消的任务，可以在这里实现
    }
    
    private func loadLocalData() {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("Failed to find local data file")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            
            // 自定义日期解码策略
            jsonDecoder.dateDecodingStrategy = .custom { decoder -> Date in
                let container = try decoder.singleValueContainer()
                let dateString = try container.decode(String.self)
                
                let iso8601Formatter = ISO8601DateFormatter()
                iso8601Formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                
                if let date = iso8601Formatter.date(from: dateString) {
                    return date
                } else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
                }
            }
            
            // 解码 JSON 数据
            let blogResponse = try jsonDecoder.decode(BlogsResponse.self, from: data)
            self.blogs = blogResponse.data
        } catch let error as DecodingError {
            print("Decoding error: \(error)")
        } catch {
            print("Failed to load or decode JSON: \(error)")
        }
    }
}
