import UIKit
import SnapKit
import Kingfisher

final class BlogListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: BlogListItemCell.self)
    static let height = CGFloat(130)

    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var titleImageView: UIImageView!
    private var tagsView: TagsView! // 添加 TagsView
    private var line: UILabel!

    private var viewModel: BlogListItemViewModel!
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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)

        // 初始化 TagsView
        tagsView = TagsView()
        tagsView.heightDidChange = { [weak self] _ in
            self?.setNeedsLayout()
            self?.layoutIfNeeded()
        }
        contentView.addSubview(tagsView)

        dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textAlignment = .left
        dateLabel.textColor = UIColor(hex: "#ACACAC")
        contentView.addSubview(dateLabel)

        line = UILabel()
        line.backgroundColor = UIColor(hex: "#D5D5D5")
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
            make.right.equalTo(titleImageView.snp.right)
        }

        // TagsView 约束
        tagsView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(titleImageView.snp.left)
            make.right.equalTo(titleImageView.snp.right)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(tagsView.snp.bottom).offset(16)
            make.left.equalTo(titleImageView.snp.left)
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

    func fill(with viewModel: BlogListItemViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.dateString
        tagsView.tags = viewModel.labels // 动态更新标签内容
        configureImageContent(with: viewModel.coverImagePath)
    }

    func configureImageContent(with url: String) {
        let placeholderImage = UIImage(named: "placeholder")
        let imageUrl = URL(string: url)

        titleImageView.kf.indicatorType = .activity
        titleImageView.kf.setImage(
            with: imageUrl,
            placeholder: placeholderImage,
            options: [
                .transition(.fade(0.2)),
                .cacheOriginalImage,
                .scaleFactor(UIScreen.main.scale),
                .processor(DownsamplingImageProcessor(size: titleImageView.bounds.size))
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
        titleImageView.kf.cancelDownloadTask()
        titleImageView.image = nil
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
