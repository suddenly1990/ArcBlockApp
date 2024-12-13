//
//  BlogDetailsViewController.swift
//  ArcBlockApp
//
//  Created by 代百生 on 2024/12/13.
//

import UIKit
import WebKit
import SnapKit


class BlogDetailsViewController: UIViewController {

    // 创建一个 WKWebView
    private var webView: WKWebView!

    private var url: String!

    static func create(
        with url:String
    ) -> BlogDetailsViewController {
        let vc = BlogDetailsViewController.init()
        vc.url = url
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 初始化 WebView
        setupWebView()
        
        // 加载网页
        loadWebPage()
        
       

    }

    private func setupWebView() {
        // 初始化 WebView
        webView = WKWebView()
        webView.navigationDelegate = self // 设置代理（可选，用于处理导航事件）
        view.addSubview(webView)
        
        // 设置 Auto Layout 约束
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func loadWebPage() {
        // 示例 URL，可以替换为实际需要加载的链接
        if let url = URL(string: self.url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

// MARK: - WKNavigationDelegate
extension BlogDetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载网页")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("网页加载完成")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("网页加载失败: \(error.localizedDescription)")
    }
}

