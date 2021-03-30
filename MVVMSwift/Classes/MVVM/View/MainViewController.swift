//
//  ViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/01/28.
//

protocol MainViewDelegate: NSObjectProtocol {
    
    /**
     * 메인 뷰 델리게이트
     *
     * @param controller // 컨트롤러
     */
    func MainViewDelegate(controller: MainViewController)
}

class MainViewController: BaseViewController {
    
    var delegate: MainViewDelegate? // 델리게이트
    var mainViewModel = MainViewModel() // 메인 뷰 모델

    @IBOutlet weak var btnWebView: UIButton! // 웹 뷰 이동 버튼
    @IBOutlet weak var btnTableView: UIButton! // 테이블 뷰 이동 버튼
    @IBOutlet weak var btnDataCore: UIButton! // 데이터 코어 뷰 이동 버튼
    @IBOutlet weak var btnRealm: UIButton! // 렐름 뷰 이동 버튼
    @IBOutlet weak var btnSendMessage: UIButton! // 메시지 전송 뷰 이동 버튼
    @IBOutlet weak var btnCameraGallery: UIButton! // 카메라, 갤러리 뷰 이동 버튼
    @IBOutlet weak var btnSettings: UIButton! // 설정 뷰 버튼
    @IBOutlet weak var btnShortUrl: UIButton! // 단축 URL 버튼
    @IBOutlet weak var btnChart: UIButton! // 챠트 버튼

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        // 뷰 초기화
        initView()

        // Version
//        var parameters: Parameters = Parameters.init()
//        parameters[Key.MOBILE_TYPE] = "A"
//        parameters[Key.PUSH_TOKEN] = "dEWiunazakvqqNsmQgadHI:APA91bE2YNFTTM8Yh_qmK3RQ5l8zzzzk_fP6FCM5LIQC_TY7a1sVfNwuDDZnqizVvZn5ieagARvt3LBraf_-F2UY3kcqgjum0vsbbQM28pfy_ny_kwNOaEi4yCfnYIQ0MF27KHkwIsBD"
//        d("getListData() >> parameters: \(parameters)")
//
//        viewModel.getVersion(view: self, parameters: parameters) { (result, version, msg) in
//            self.d("getVersion() >> result: \(result)")
//            self.d("getVersion() >> version: \(version)")
//            self.d("getVersion() >> msg: \(msg)")
//        }
        
        // Check Duplicate id
//        parameters = Parameters.init()
//        parameters[Key.APP_TYPE] = Define.APP_TYPE
//        parameters[Key.TN] = Define.TN_ID
//        parameters[Key.MEM_ID] = "test01"
//        d("getDuplicateCheckId() >> parameters: \(parameters)")
//        viewModel.getDuplicateCheckId(view: self,
//                                      parameters: parameters) { (result, version, msg) in
//            self.d("getDuplicateCheckId() >> result: \(result)")
//            self.d("getDuplicateCheckId() >> version: \(version)")
//            self.d("getDuplicateCheckId() >> msg: \(msg)")
//        }
        
        // Request List
//        parameters = Parameters.init()
//        parameters[Key.TN] = Define.TN_LIST
//        parameters[Key.MEM_IDX] = 65
//        parameters[Key.CATE_MAIN] = "001"
//        parameters[Key.CATE_SUB] = "001002"
//        parameters[Key.PAGE] = 1
//        parameters[Key.LIMIT] = 20
//        d("getListData() >> parameters: \(parameters)")
//
//        viewModel.getListData(view: self, parameters: parameters) { (result, datas, msg) in
//            self.d("getListData() >> result: \(result)")
//            self.d("getListData() >> datass: \(datas)")
//            self.d("getListData() >> msg: \(msg)")
//
//            for data in datas {
//                self.d("getListData() >> idx: \(data.idx)")
//                self.d("getListData() >> intro_img: \(data.intro_img)")
//                self.d("getListData() >> store_name: \(data.store_name)")
//                self.d("getListData() >> store_name: \(data.store_name)")
//                self.d("getListData() >> store_addr: \(data.store_addr)")
//                self.d("getListData() >> map_x: \(data.map_x)")
//                self.d("getListData() >> map_y: \(data.map_y)")
//            }
//        }
        
        delegate?.MainViewDelegate(controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        // 네비게이션바 설정
        self.setUpNavigationBar("#FFFFFF")
    }
    
    // MARK: - Action
    
    override func actionRightButton(_ sender: UIButton) {
        d("actionRightButton() >> Start !!!")
        
        // 설정 뷰 컨트롤러 이동
        self.gotoViewController(name: Define.SB_NAME_MAIN,
                                withIdentifier: Define.VC_NAME_SETTINGSVIEW,
                                of: SettingsViewController(),
                                animated: true) { (controller) in
            self.d("actionRightButton() >> controller: \(controller)")
            controller.delegate = self
        }
    }
    
    /**
     * 웹 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionWebView(sender: UIButton) {
        d("actionWebView() >> Start !!!")
        
        // 웹 뷰 컨트롤러 이동
        gotoViewController(identifier: Define.VC_NAME_WEBVIEW, animated: true) { (viewController) in
            self.d("actionWebView() >> viewController: \(viewController)")
        }
        
//        gotoPopOverAniLoadingViewController()
    }
    
    /**
     * 테이블 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionTableView(sender: UIButton) {
        d("actionTableView() >> Start !!!")
        
        // 테이블 뷰 컨드롤러 이동
        gotoViewController(identifier: Define.VC_NAME_TABLEVIEW, animated: true) { (viewController) in
            self.d("actionTableView() >> viewController: \(viewController)")
        }
    }
    
    /**
     * 설정 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionSettingsView(sender: UIButton) {
        d("actionSettingsView() >> Start !!!")
       
        // 설정 뷰 컨트롤러 이동
        gotoViewController(identifier: Define.VC_NAME_SETTINGSVIEW, animated: true) { (viewController) in
            self.d("actionSettingsView() >> viewController: \(viewController)")
        }
    }
    
    /**
     * 코어 데이터 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionCoreDataView(sender: UIButton) {
        d("actionCoreDataView() >> Start !!!")
        
        // 코어 데이터 뷰 컨트롤러 이동
        gotoViewController(identifier: Define.VC_NAME_COREDATAVIEW, animated: true) { (viewController) in
            self.d("gotoViewController() >> viewController: \(viewController)")
        }
    }
    
    /**
     * 렐름 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionRealmView(sender: UIButton) {
        d("actionRealmView() >> Start !!!")
        
        // 렐름 뷰 컨드롤러 이동
        gotoViewController(identifier: Define.VC_NAME_REALMVIEW, animated: true) { (viewController) in
            self.d("gotoViewController() >> viewController: \(viewController)")
        }
    }
    
    /**
     * 메시지 보내기 팝업 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionPopupSendMessage(sender: UIButton) {
        d("actionPopupSendMessage() >> Start !!!")

        // 메시지 보내기 뷰 컨틀롤러 이동
        gotoViewController(identifier: Define.VC_NAME_MESSAGEVIEW, animated: true) { (viewController) in
            self.d("gotoViewController() >> viewController: \(viewController)")
        }
    }
    
    /**
     * 선택 팝업 뷰 컨트롤러 이동 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionPopupSelect(sender: UIButton) {
        d("actionPopupSelect() >> Start !!!")
        
        // 카메라 뷰 컨드롤러 이동
        gotoViewController(identifier: Define.VC_NAME_CAMERAVIEW, animated: true) { (viewController) in
            self.d("gotoViewController() >> viewController: \(viewController)")
        }
    }
    
    /**
     *  단축 URL 생성 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionShortenUrl(sender: UIButton) {
        d("actionShortenUrl() >> Start !!!")

        mainViewModel.getUrl("http://crecolto.com/") { (result, shortUrl) in
            self.d("actionShortenUrl() >> shortUrl: \(shortUrl)")
        }
    }
    
    /**
     *  챠트 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionChart(sender: UIButton) {
        d("actionChart() >> Start !!!")

        // 챠트 뷰 컨드롤러 이동
        gotoViewController(identifier: Define.VC_NAME_CHARTVIEW, animated: true) { (viewController) in
            self.d("gotoViewController() >> viewController: \(viewController)")
        }
    }
    
    
    // MARK: - Function
    
    /**
     * 뷰 초기화
     */
    private func initView() {
        // 뷰 컨트롤러 초기화
        self.initViewController(self,
                                navTitle: "",
                                tag:"[\(getString("Main"))]")
        
        // 뒤로가기 버튼
        self.addBackButton()
        
        // 닫기 버튼
        let image = UIImage(named: "SettingsBlack") ?? UIImage()
        self.addRightButton(image)
        
        // 버튼 라운드 설정
        if let color = "#3766F2".hexString2UIColor() {
            d("initView() >> color: \(color)")
            
            btnWebView.addRound(8, color: color, width: 0.1)
            btnTableView.addRound(8, color: color, width: 0.1)
            btnDataCore.addRound(8, color: color, width: 0.1)
            btnRealm.addRound(8, color: color, width: 0.1)
            btnSendMessage.addRound(8, color: color, width: 0.1)
            btnCameraGallery.addRound(8, color: color, width: 0.1)
            btnSettings.addRound(8, color: color, width: 0.1)
            btnShortUrl.addRound(8, color: color, width: 0.1)
            btnChart.addRound(8, color: color, width: 0.1)
        }
    }
}

// MARK: - SettingsView Delegate

extension MainViewController: SettingsViewDelegate {
    func SettingsViewDelegate(controller: SettingsViewController) {
        d("SettingsViewDelegate() >> Start !!!")
    }
}
