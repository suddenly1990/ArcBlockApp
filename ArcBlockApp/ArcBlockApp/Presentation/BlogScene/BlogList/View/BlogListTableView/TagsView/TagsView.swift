import UIKit
import SnapKit

final class TagsView: UIView {

    var tags: [String] = [] {
        didSet {
            collectionView.reloadData()
            DispatchQueue.main.async { [weak self] in
                self?.updateHeightConstraint()
            }
        }
    }
    var onTagSelected: ((String) -> Void)? // 添加标签点击回调
    private let collectionView: UICollectionView
    private var heightConstraint: Constraint? // 高度约束引用
    var heightDidChange: ((CGFloat) -> Void)? // 高度更新回调

    override init(frame: CGRect) {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8 // 标签之间的行间距
        layout.minimumInteritemSpacing = 8 // 标签之间的列间距

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)

        setupCollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.reuseIdentifier)
        collectionView.isScrollEnabled = false // 禁止滚动，支持自适应高度
        collectionView.isUserInteractionEnabled = true

        addSubview(collectionView)

        // 使用 SnapKit 设置约束
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            heightConstraint = make.height.equalTo(1).constraint // 初始化高度约束
        }
    }

    private func updateHeightConstraint() {
        collectionView.layoutIfNeeded()
        let contentHeight = collectionView.contentSize.height
        heightConstraint?.update(offset: contentHeight)

        // 通知父视图高度已更新
        heightDidChange?(contentHeight)
    }
}

extension TagsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseIdentifier, for: indexPath) as! TagCell
        cell.configure(with: tags[indexPath.item])
        return cell
    }
    
   
}

final class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin: CGFloat = sectionInset.left // 左边距
        var maxY: CGFloat = -1.0 // 记录当前行的最大 Y 值

        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                // 换行
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }

        return attributes
    }
}

extension TagsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = tags[indexPath.item]
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()

        return CGSize(width: label.frame.width + 16, height: label.frame.height + 8) // 增加内边距
    }
    
    // 添加点击事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTag = tags[indexPath.item]
        onTagSelected?(selectedTag) // 调用回调
    }
}


final class TagCell: UICollectionViewCell {
    static let reuseIdentifier = "TagCell"

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        contentView.layer.cornerRadius = 4
        contentView.clipsToBounds = true

        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center

        contentView.addSubview(label)

        // 使用 SnapKit 设置约束
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        }
    }

    func configure(with text: String) {
        label.text = text
    }
}
