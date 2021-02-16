//
//  WebViewController.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/02.
//

import Foundation
import UIKit
import WebKit

protocol WebViewDelegate: NSObjectProtocol {
    
    /**
     * 웹 뷰 델리게이트
     *
     * @param controller // 컨트롤러
     */
    func WebViewDelegate(controller: WebViewController)
}

/**
 * WebViewController.swift
 *
 * @description 웹 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class WebViewController: BaseViewController,
                         ControllerType,
                         WKUIDelegate,
                         WKNavigationDelegate,
                         WKScriptMessageHandler {
    
    // MARK: - WKScriptMessageHandler Delegate
    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
//        d("userContentController() >> message: \(message)")
       
        d("userContentController() >> name: \(message.name)")
        
        if message.name == "test" {
            if let dictionary: [String: String] = message.body as? Dictionary {
                if let action = dictionary["action"] {
                    if action == "bind", let name = dictionary["name"] {
                        if name == "message" {
                            let dateString = Date().description
                            webView.evaluateJavaScript("var \(name) = '\(dateString)';", completionHandler: nil)
                        }
                    } else if action == "call", let function = dictionary["function"] {
                        var returnMessage = ""
                        if function == "returnFunction" {
                            returnMessage = "나는 선택받은 function이다."
                        }
                        
                        webView.evaluateJavaScript("\(function)('\(returnMessage)')", completionHandler: nil)
                    }
                }
            } else if let message = message.body as? String {
                if message == "getMessage" {
                    webView.evaluateJavaScript("returnMessage('나는 function에 호출된 녀석입니다.');", completionHandler: nil)
                }
            }
        }
    }
    
    @IBOutlet var webView: WKWebView! // 웹 뷰
    @IBOutlet var activityIndicator: UIActivityIndicatorView! // 인디게이터 뷰
    
    var delegate: WebViewDelegate? // 델리게이트
    let viewModel = WebViewModel() // 뷰 모델
    
    var navigationTitle: String { // 네비게이션 타이틀
        return "[Web]"
    }
    
    // MARK: - UIViewController Life Cycle
    
    override func loadView() {
        d("loadView() >> Start !!!")
        super.loadView()
        self.webView.navigationDelegate = self
        self.webView.uiDelegate = self
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "test")
        
        let userScript = WKUserScript(source: "initNative()", injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        
        self.webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        self.view.addSubview(webView)
    }

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 네비게이션바 설정
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = navigationTitle
        
        HTTPCookieStorage.shared.cookieAcceptPolicy = HTTPCookie.AcceptPolicy.always
        
        self.webView.addSubview(self.activityIndicator)
        self.activityIndicator.center = view.center
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true

        guard let localFilePath = Bundle.main.path(forResource: "sample", ofType: "html") else {
            d("path is nil !!!")
            return
        }
        d("localFilePath: \(localFilePath)")
        
        let url = URL(fileURLWithPath: localFilePath)
        let request = URLRequest(url: url)
        self.webView.load(request as URLRequest)

//        viewModel.getVersion(view: self) { (result, version, msg) in
//            d("getVersion() >> result: \(result)")
//            d("getVersion() >> version: \(version)")
//            d("getVersion() >> msg: \(msg)")
//        }
    }
    
    
    // MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView,
                 didStartProvisionalNavigation navigation: WKNavigation!) {
        d("didStartProvisionalNavigation() >> Start !!!")
        
        self.activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        d("didFinish() >> url: \(String(describing: webView.url?.absoluteString))")
        
        self.activityIndicator.stopAnimating()
    }
    
    internal func webView(_ webView: WKWebView,
                         didFail navigation: WKNavigation!, withError error: Error)  {
        d("didFail() >> url: \(String(describing: error))")
        
        self.activityIndicator.stopAnimating()
    }
    
    /**
     *  중복 리로드 방지
     *
     * @param webView WKWebView
     */
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
        d("webViewWebContentProcessDidTerminate() >> Start !!!")
    }
    
    // MARK: - Function
    
    /**
     *  URL 요청
     *
     * @param url URL
     */
    func request(url: String) {
        self.webView.load(URLRequest(url: URL(string: url)!))
        self.webView.navigationDelegate = self
    }
    
    // MARK: - Action
    
    /**
     * 홈 버튼 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionHome(_ sender: UIBarButtonItem) {
        request(url: "https://kfkorea.com/")
    }
    
    /**
     * 리플래시 버튼 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionReload(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    /**
     * 뒤로가기 버튼 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionGoBack(_ sender: UIBarButtonItem) {
        if (webView.canGoBack) {
            webView.goBack()
        }
    }
    
    /**
     * 앞으로가기 버튼 액션
     *
     * @param sender UIButton
     */
    @IBAction func acrtionGoForward(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    
    /**
     * 공유 버튼 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionShare(_ sender: UIBarButtonItem) {
        var objectsToShare = [Any?]()
        objectsToShare.append(webView.url?.absoluteString)
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    /**
     * 설정 버튼 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionSettings(_ sender: UIBarButtonItem) {
        
        // 설정 뷰 컨틀롤러 이동
        gotoSettingsViewController()
    }
    
    // MARK: - Move ViewController
    
    /**
     *  설정 뷰 컨틀롤러 이동
     *
     */
    func gotoSettingsViewController() {
        d("gotoSettingsViewController() >> Start !!!")
        DispatchQueue
            .main
            .async {
                guard let settingsView = self.storyboard?.instantiateViewController(withIdentifier: "SettingsView") else {
                    return
                }
                self.navigationController?.pushViewController(settingsView,
                                                              animated: true)
            }
    }
}

