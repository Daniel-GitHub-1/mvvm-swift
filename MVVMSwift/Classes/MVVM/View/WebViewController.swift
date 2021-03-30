//
//  WebViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/02.
//

import UIKit
import WebKit
import SwiftUI

// RxSwift
import RxCocoa
import RxSwift
import RxViewController

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
class WebViewController: BaseViewController {

    @IBOutlet var webView: WKWebView! // 웹 뷰
    @IBOutlet var activityIndicator: UIActivityIndicatorView! // 인디게이터 뷰
    
    var delegate: WebViewDelegate? // 델리게이트
    let webViewModel = WebViewModel() // 뷰 모델
    
    @ObservedObject var locationUtil = LocationUtil()
    
    // MARK: - UIViewController Life Cycle
    
    override func loadView() {
        d("loadView() >> Start !!!")
        super.loadView()
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "getUser")
        contentController.add(self, name: "getCompany")
        contentController.add(self, name: "getLocation")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        
        self.webView = WKWebView(frame: self.view.bounds, configuration: configuration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.configuration.preferences.javaScriptEnabled = true
        
        self.view.addSubview(webView)
    }

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        d("viewDidLoad() >> Start !!!")
        super.viewDidLoad()
        
        // 뷰 초기화
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        setUpNavigationBar("#3766F2")
    }

    // MARK: - Function
    
    /**
     *  뷰 초기화
     *
     */
    func initView() {
        // 뷰 컨트롤러 초기화
        self.initViewController(self,
                                navTitle: getString("Web"),
                                tag:"[\(getString("Web"))]")
        
        // 뒤로가기 버튼
        self.addBackButton()

        HTTPCookieStorage.shared.cookieAcceptPolicy = HTTPCookie.AcceptPolicy.always
        
        self.webView.addSubview(self.activityIndicator)
        self.activityIndicator.center = view.center
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
        
        // TODO 테스트
//        let url = "http://59.29.245.72:8992/sample/pay"
//        let request = URLRequest(url: URL(string: url)!)
//        self.webView.load(request as URLRequest)
      
        // todo 테스트
//        guard let localFilePath = Bundle.main.path(forResource: "sample", ofType: "html") else {
//            d("initView() >> path is nil !!!")
//            return
//        }
//        d("initView() >> localFilePath: \(localFilePath)")
//
//        let url = URL(fileURLWithPath: localFilePath)
//        let request = URLRequest(url: url)
//        self.webView.load(request as URLRequest)
        

        // TODO URL 테스트
        let url = Url.getWebViewUrl("")
        d("viewDidLoad Start !!!")
        
        let request = URLRequest(url: URL(string: url)!)
        self.webView.load(request as URLRequest)
        
//        webViewModel.getVersion(view: self) { (result, version, msg) in
//            d("getVersion() >> result: \(result)")
//            d("getVersion() >> version: \(version)")
//            d("getVersion() >> msg: \(msg)")
//        }
    }
    
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
        
        let vc = UIActivityViewController(activityItems: objectsToShare as [Any], applicationActivities: nil)
        vc.popoverPresentationController?.sourceView = self.view
        
        self.present(vc, animated: true, completion: nil)
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

// MARK: - WKNavigation Delegate

extension WebViewController: WKNavigationDelegate {
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
}

// MARK: - WKUI Delegate

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView,
                 runJavaScriptAlertPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping () -> Void) {
        var contents = [String]()
        contents.append("Confirm")
        
        DialogUtil
            .sharedInstance
            .show(controller: self,
                  title: "Alert",
                  message: message,
                  contents: contents) { (content) in
                completionHandler()
            }
    }
    
    func webView(_ webView: WKWebView,
                 runJavaScriptConfirmPanelWithMessage message: String,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping (Bool) -> Void) {
        
        var contents = [String]()
        contents.append("Cancel")
        contents.append("Confirm")
        
        DialogUtil
            .sharedInstance
            .show(controller: self,
                  title: "Alert",
                  message: message,
                  contents: contents) { (content) in
                if (content == "Confirm") {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
    }
}

// MARK: - WKScriptMessageHandler Delegate

extension WebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        d("userContentController() >> name: \(message.name)")
        
        if message.name == "getUser" {
            if let dictionary: [String: String] = message.body as? Dictionary {
                if let action = dictionary["action"] {
                    if action == "user",
                       let name = dictionary["name"],
                       let email = dictionary["email"],
                       let hp = dictionary["hp"] {
                        d("userContentController() >> name: \(name)")
                        d("userContentController() >> email: \(email)")
                        d("userContentController() >> hp: \(hp)")

                        let dateString = Date().description
                        d("userContentController() >> dateString: \(dateString)")
                        let message = "\(dateString)\n\(name)\n\(email)\n\(hp)"

                        let escaped = message.replacingOccurrences(of: "\n", with: "\\n", options: .literal, range: nil)
                        webView.evaluateJavaScript("showPopup('\(escaped)');", completionHandler: nil)
                    
//                        self.gotoViewController(identifier: Define.VC_NAME_SETTINGSVIEW,
//                                                animated: true,
//                                                completion: { (viewController) in
//                            self.d("userContentController() >> viewController: \(viewController)")
//                      
//                        })
                    }
                }
            }
        } else if message.name == "getCompany" {
            if let dictionary: [String: String] = message.body as? Dictionary {
                if let action = dictionary["action"] {
                    if action == "company",
                       let name = dictionary["name"],
                       let ceo = dictionary["ceo"],
                       let website = dictionary["website"] {
                        
                        d("userContentController() >> name: \(name)")
                        d("userContentController() >> ceo: \(ceo)")
                        d("userContentController() >> website: \(website)")
                        
                        let dateString = Date().description
                        d("userContentController() >> dateString: \(dateString)")
                        let message = "\(dateString)\n\(name)\n\(ceo)\n\(website)"
                        let escaped = message.replacingOccurrences(of: "\n", with: "\\n", options: .literal, range: nil)
                        webView.evaluateJavaScript("showPopup('\(escaped)');", completionHandler: nil)
                    }
                }
            }
        } else if message.name == "getLocation" {
            let statusString = locationUtil.statusString
            d("userContentController() >> statusString: \(String(describing: statusString))")
            if statusString == "authorizedWhenInUse"
                || statusString == "authorizedAlways" {
                
                let location = locationUtil.lastLocation
                let latitude = "\(location?.coordinate.latitude ?? 0)"
                let longitude = "\(location?.coordinate.longitude ?? 0)"
          
                d("userContentController() >> latitude: \(latitude)")
                d("userContentController() >> longitude: \(longitude)")
                
                let message = "\(latitude)\n\(longitude)"
                let escaped = message.replacingOccurrences(of: "\n", with: "\\n", options: .literal, range: nil)
                
                webView.evaluateJavaScript("showPopup('\(escaped)');", completionHandler: nil)
            }
        }
    }
}
