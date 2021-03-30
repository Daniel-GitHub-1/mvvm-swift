//
//  PopOverLoadingViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/18.
//

protocol PopOverLoadingViewDelegate: NSObjectProtocol {
    
    /**
     * 로딩 델리게이트
     *
     * @param controller // 컨트롤러
     * @param loadingType // 로딩 타입
     */
    func PopOverLoadingViewDelegate(controller: PopOverLoadingViewController,
                                    loadingType: Enum.LoadingType)
}

class PopOverLoadingViewController: BaseViewController {
    
    @IBOutlet var ivLoading: UIImageView! // 로딩 이미지
    
    var delegate: PopOverLoadingViewDelegate? // 델리게이트
    var loadingType: Enum.LoadingType = .NONE // 로딩 타입
    
    override func viewDidLoad() {
        d("viewDidLoad() >> Start !!!")
        super.viewDidLoad()
        
        // 뷰 컨트롤러 초기화
        self.initViewController(self,
                                navTitle: "",
                                tag: "[PopOverLoadingView]")
        
        ivLoading.animationImages = self.getImages()
        ivLoading.animationDuration = 3.0
        ivLoading.animationRepeatCount = 0
        ivLoading.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        
        self.delegate?.PopOverLoadingViewDelegate(controller: self,
                                      loadingType: self.loadingType)
        super.viewWillAppear(animated)
    }
    
    /**
     * 로딩 이미지
     *
     * @returns [UIImage] // 이미지 배열
     */
    func getImages() -> [UIImage] {
        var array: [UIImage] = []
        array.append(UIImage(named: "Loading_1")!)
        array.append(UIImage(named: "Loading_2")!)
        array.append(UIImage(named: "Loading_3")!)
        array.append(UIImage(named: "Loading_4")!)
        return array
    }

    override func finish(_ animated: Bool) {
        d("finish() >> Start !!!")
        
        self.dismiss(animated: false, completion: nil)
    }
}

