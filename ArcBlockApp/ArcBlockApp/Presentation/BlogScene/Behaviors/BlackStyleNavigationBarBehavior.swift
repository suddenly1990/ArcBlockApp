import UIKit

struct BlackStyleNavigationBarBehavior: ViewControllerLifecycleBehavior {

    func viewDidLoad(viewController: UIViewController) {

        viewController.navigationController?.navigationBar.backgroundColor = .white
        viewController.navigationController?.navigationBar.barTintColor = .white
        // 自定义标题样式
        viewController.navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.black, // 标题颜色
                .font: UIFont.boldSystemFont(ofSize: 24) // 标题字体和大小
            ]
    }
}
