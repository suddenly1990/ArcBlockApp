import UIKit
import SnapKit
import Kingfisher

final class BlogListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: BlogListItemCell.self)
    static let height = CGFloat(130)

    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var titleImageView: UIImageView!
    private var line: UILabel!

    private var viewModel: BlogListItemViewModel!
//    private var posterImagesRepository: PosterImagesRepository?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType = DispatchQueue.main

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       self.selectionStyle = .none
       

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        titleImageView = UIImageView()
        titleImageView.layer.cornerRadius = 10
        titleImageView.clipsToBounds = true
        titleImageView.layer.shadowColor = UIColor.black.cgColor
        titleImageView.layer.shadowOpacity = 0.5
        titleImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        titleImageView.layer.shadowRadius = 4
        contentView.addSubview(titleImageView)
        titleImageView.backgroundColor = .blue
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18) // 设置粗体 18 号字体
        titleLabel.textColor = .black // 设置字体颜色
        titleLabel.textAlignment = .left // 设置文字居中
        contentView.addSubview(titleLabel)

        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 12) // 设置粗体 18
        dateLabel.textAlignment = .left // 设置文字居中
        dateLabel.textColor = UIColor(hex: "#ACACAC") // 设置字体颜色
        
        contentView.addSubview(dateLabel)


        line = UILabel() 
        line.backgroundColor =  UIColor(hex: "#D5D5D5")
        contentView.addSubview(line)

    }

    private func setupConstraints() {
        titleImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(200)
           
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleImageView.snp.bottom).offset(16)
            make.left.equalTo(titleImageView.snp.left)
            make.height.greaterThanOrEqualTo(30)
            make.right.equalTo(titleImageView.snp.right)
//            make.bottom.equalToSuperview().offset(-10)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.left.equalTo(titleImageView.snp.left)
            make.height.greaterThanOrEqualTo(1)
            make.right.equalTo(titleImageView.snp.right)
            make.bottom.equalToSuperview().offset(-10)
        }

        line.snp.makeConstraints { make in
            make.left.equalTo(titleImageView.snp.left)
            make.right.equalTo(titleImageView.snp.right)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func fill(
        with viewModel: BlogListItemViewModel
    ) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.dateString
        configureImageContent(with:viewModel.coverImagePath)
    }
    
    func configureImageContent(with url: String) {
        let placeholderImage = UIImage(named: "placeholder") // 占位图
        let imageUrl = URL(string: url)
        
        titleImageView.kf.indicatorType = .activity // 显示加载指示器
        
        titleImageView.kf.setImage(
            with: imageUrl,
            placeholder: placeholderImage,
            options: [
                .transition(.fade(0.2)), // 图片加载动画
                .cacheOriginalImage, // 缓存原始图片
                .scaleFactor(UIScreen.main.scale), // 根据屏幕缩放
                .processor(DownsamplingImageProcessor(size: titleImageView.bounds.size)) // 图片下采样
            ],
            completionHandler: { result in
                switch result {
                case .success(let value):
                    print("Image loaded: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Error loading image: \(error.localizedDescription)")
                }
            }
        )
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleImageView.kf.cancelDownloadTask() // 取消未完成的下载任务
        titleImageView.image = nil // 清除旧图片
    } 
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
