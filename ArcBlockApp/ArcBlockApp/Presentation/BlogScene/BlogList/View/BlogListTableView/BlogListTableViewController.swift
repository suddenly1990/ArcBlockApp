import UIKit
import SnapKit

final class BlogListTableViewController: UIViewController {

    var viewModel: DefaultBlogListViewModel!
    var tableView:UITableView?
    var nextPageLoadingSpinner: UIActivityIndicatorView?

    // MARK: - Lifecycle
    static func create(
        with viewModel:DefaultBlogListViewModel
    ) -> BlogListTableViewController {
        let vc = BlogListTableViewController.init()
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "最新文章"
        setupTableView()
        setupBehaviours()
        bind(to: viewModel)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.viewWillAppear()
    }

    // UI
    private func setupTableView() {
        // 初始化 UITableView
        self.tableView = UITableView()
        guard let tableView = self.tableView else { return }
        
        // 配置 UITableView 的属性
        tableView.estimatedRowHeight = BlogListItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(BlogListItemCell.self, forCellReuseIdentifier: BlogListItemCell.reuseIdentifier)
        tableView.separatorStyle = .none 
        // 添加到视图
        view.addSubview(tableView)

        // 使用 SnapKit 进行布局
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 设置 UITableView 的数据源和代理
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupBehaviours() {
        addBehaviors([BackButtonEmptyTitleNavigationBarBehavior(),
                      BlackStyleNavigationBarBehavior()])
    }
    
    private func bind(to viewModel: DefaultBlogListViewModel) {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems()
        }
    }
    private func updateItems() {
        self.reload()
    }

    func reload() {
        self.tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension BlogListTableViewController:UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BlogListItemCell.reuseIdentifier,
            for: indexPath
        ) as? BlogListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(BlogListItemCell.self) with reuseIdentifier: \(BlogListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        if indexPath.row == viewModel.items.value.count - 1 {
            viewModel.didLoadNextPage()
        }
        cell.fill(with:viewModel.items.value[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}


extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
