import UIKit
//import Snapkit
import SnapKit

final class BlogListItemCell: UITableViewCell {

    static let reuseIdentifier = String(describing: BlogListItemCell.self)
    static let height = CGFloat(130)

    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var titleImageView: UIImageView!

    private var viewModel: BlogListItemViewModel!
//    private var posterImagesRepository: PosterImagesRepository?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
    private let mainQueue: DispatchQueueType = DispatchQueue.main

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        titleLabel = UILabel()
        dateLabel = UILabel()
        titleImageView = UIImageView()

        // 添加圆角
        titleImageView.layer.cornerRadius = 10
        titleImageView.clipsToBounds = true

        // 添加阴影
        titleImageView.layer.shadowColor = UIColor.black.cgColor
        titleImageView.layer.shadowOpacity = 0.5
        titleImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        titleImageView.layer.shadowRadius = 4

        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleImageView)
    }

    private func setupConstraints() {
        titleImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(200)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(titleImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        }

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
        }
    }

    func fill(
        with viewModel: BlogListItemViewModel
//        posterImagesRepository: PosterImagesRepository?
    ) {
        self.viewModel = viewModel
//        self.posterImagesRepository = posterImagesRepository

        titleLabel.text = viewModel.title
//        dateLabel.text = viewModel.releaseDate
//        overviewLabel.text = viewModel.overview
        updatePosterImage(width: Int(titleImageView.imageSizeAfterAspectFit.scaledSize.width))
    }

    
    private func updateUI() {
        
        
        
    }
    
    
    
    
    
    
    private func updatePosterImage(width: Int) {
        titleImageView.image = nil
//        guard let posterImagePath = viewModel.posterImagePath else { return }

//        imageLoadTask = posterImagesRepository?.fetchImage(
//            with: posterImagePath,
//            width: width
//        ) { [weak self] result in
//            self?.mainQueue.async {
//                guard self?.viewModel.posterImagePath == posterImagePath else { return }
//                if case let .success(data) = result {
//                    self?.posterImageView.image = UIImage(data: data)
//                }
//                self?.imageLoadTask = nil
//            }
//        }
    }
}
