//
//  PopOverAniLoadingViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/18.
//

protocol PopOverAniLoadingViewDelegate: NSObjectProtocol {
    
    /**
     * 로딩 델리게이트
     *
     * @param controller // 컨트롤러
     * @param loadingType // 로딩 타입
     */
    func PopOverAniLoadingViewDelegate(controller: PopOverAniLoadingViewController,
                                       loadingType: Enum.LoadingType)
}

class PopOverAniLoadingViewController: BaseViewController {
    @IBOutlet var viewLoading: UIView! // 로딩 뷰
    
    var delegate: PopOverAniLoadingViewDelegate? // 델리게이트
    var loadingType: Enum.LoadingType = .NONE // 로딩 타입
    
    override func viewDidLoad() {
        d("viewDidLoad() >> Start !!!")
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")

        let gif = UIImage.gifImageWithName("ani_loading")
        let imageView = UIImageView(image: gif)
        
        imageView.frame = CGRect(x: 0.0,
                                 y: 0.0,
                                 width: view.frame.width,
                                 height: view.frame.height)
        
        imageView.contentMode = .scaleAspectFill
        self.view.addSubview(imageView)

        delegate?.PopOverAniLoadingViewDelegate(controller: self,
                                                loadingType: self.loadingType)
        
        super.viewWillAppear(animated)
    }
}

