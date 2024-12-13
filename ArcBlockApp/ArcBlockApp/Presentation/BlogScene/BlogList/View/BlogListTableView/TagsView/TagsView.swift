//
//  TagsView.swift
//  ArcBlockApp
//
//  Created by 代百生 on 2024/12/13.
//

import UIKit
import SnapKit

class TagsView: UIView {

    // 数据源，存储标签内容
    var tags: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    private let collectionView: UICollectionView

    override init(frame: CGRect) {
        // 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8 // 标签之间的行间距
        layout.minimumInteritemSpacing = 8 // 标签之间的列间距

        // 初始化 UICollectionView
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

        addSubview(collectionView)

        // 使用 SnapKit 设置约束
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource
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

// MARK: - UICollectionViewDelegateFlowLayout
extension TagsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 动态计算标签的大小
        let label = UILabel()
        label.text = tags[indexPath.item]
        label.font = UIFont.systemFont(ofSize: 14)
        label.sizeToFit()

        return CGSize(width: label.frame.width + 16, height: label.frame.height + 8) // 增加内边距
    }
}

// MARK: - 自定义 Cell
class TagCell: UICollectionViewCell {
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
