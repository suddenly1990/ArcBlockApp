import UIKit

final class BlogListTableViewController: UITableViewController {

    var viewModel: DefaultBlogListViewModel!

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
        setupViews()
    }

    func reload() {
        tableView.reloadData()
    }

    func updateLoading(_ loading: BlogListViewModelLoading?) {
        switch loading {
        case .nextPage:
            nextPageLoadingSpinner?.removeFromSuperview()
            nextPageLoadingSpinner = makeActivityIndicator(size: .init(width: tableView.frame.width, height: 44))
            tableView.tableFooterView = nextPageLoadingSpinner
        case .fullScreen, .none:
            tableView.tableFooterView = nil
        }
    }

    // MARK: - Private

    private func setupViews() {
        tableView.estimatedRowHeight = BlogListItemCell.height
        tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension BlogListTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: BlogListItemCell.reuseIdentifier,
            for: indexPath
        ) as? BlogListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(BlogListItemCell.self) with reuseIdentifier: \(BlogListItemCell.reuseIdentifier)")
            return UITableViewCell()
        }

//        cell.fill(with: viewModel.items.value[indexPath.row],
//                  posterImagesRepository: posterImagesRepository)

        if indexPath.row == viewModel.items.value.count - 1 {
            viewModel.didLoadNextPage()
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.isEmpty ? tableView.frame.height : super.tableView(tableView, heightForRowAt: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath.row)
    }
}
