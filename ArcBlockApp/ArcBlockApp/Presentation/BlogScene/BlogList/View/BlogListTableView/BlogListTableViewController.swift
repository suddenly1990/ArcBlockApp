import UIKit
import SnapKit

final class BlogListTableViewController: UIViewController {

    var viewModel: DefaultBlogListViewModel!
    var tableView:UITableView?
    var nextPageLoadingSpinner: UIActivityIndicatorView?
    var refreshControl:UIRefreshControl?
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
        
        handleRefresh()
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
        
        
        // 创建 UIRefreshControl
      let refreshControl = UIRefreshControl()
      
      // 设置刷新时的文字
      refreshControl.attributedTitle = NSAttributedString(string: "刷新中")
      
      // 添加目标和动作
      refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
      
      // 将 refreshControl 赋值给 tableView
      self.refreshControl = refreshControl
      tableView.refreshControl = refreshControl
    }
    
// 下拉触发的回调方法
   @objc private func handleRefresh() {
       print("开始刷新数据...")
       DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
           // 停止刷新动画
           self.refreshControl?.endRefreshing()
           
           self.viewModel.fetchData()
           print("数据加载完成！")
       }
   }
    
    private func setupBehaviours() {
        addBehaviors([BackButtonEmptyTitleNavigationBarBehavior(),
                      BlackStyleNavigationBarBehavior()])
        // 自定义返回按钮标题为空
       let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       navigationItem.backBarButtonItem = backButton
        // 改变返回按钮或导航栏按钮的颜色
       navigationController?.navigationBar.tintColor = UIColor(hex: "#D5D5D5")
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
        cell.onTagSelected = { [weak self] selectedTag in
            print("Selected tag: \(selectedTag)")
            self?.viewModel.didselctLabels(tag: selectedTag)
        }
        if indexPath.row == viewModel.items.value.count - 1 {
            viewModel.didLoadNextPage()
        }
        cell.fill(with:viewModel.items.value[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.items.value[indexPath.row]
        viewModel.didSelectItem(url: item.detailURL ?? "")
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
