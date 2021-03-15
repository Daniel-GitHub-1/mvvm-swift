//
//  PopOverLoadingViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/18.
//

import UIKit



protocol PopOverLoadingViewDelegate: NSObjectProtocol {
    
    /**
     * 로딩 델리게이트
     *
     * @param controller // 컨트롤러
     * @param loadingType // 로딩 타입
     * @param index // 인텍스
     */
    func PopOverLoadingViewDelegate(controller: PopOverLoadingViewController,
                                    loadingType: Enum.LoadingType)
}

/**
 * PopOverLoadingViewController.swift
 *
 * @description 로딩 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/19/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class PopOverLoadingViewController: UIViewController {
    
    let TAG: String = "[PopOverLoadingViewController]" // 디버그 태그
    
    @IBOutlet var ivLoading: UIImageView! // 로딩 이미지
    var delegate: PopOverLoadingViewDelegate? // 델리게이트

    var loadingType: Enum.LoadingType = .NONE // 로딩 타입
    
    override func viewDidLoad() {
        print("\(TAG) viewDidLoad() >> Start !!!")
        print("\(TAG) viewDidLoad() >> width: \(self.view.frame.width)")
        print("\(TAG) viewDidLoad() >> height: \(self.view.frame.height)")
        super.viewDidLoad()
        
        ivLoading.animationImages = self.getImages()
        ivLoading.animationDuration = 3.0
        ivLoading.animationRepeatCount = 0
        ivLoading.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("\(TAG) viewWillAppear() >> Start !!!")
  
        self.delegate?.PopOverLoadingViewDelegate(controller: self,
                                      loadingType: self.loadingType)
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("\(TAG) viewDidAppear() >> Start !!!")
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("\(TAG) viewWillDisappear() >> Start !!!")
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("\(TAG) viewDidDisappear() >> Start !!!")
        super.viewDidDisappear(animated)
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

    public func finish() {
        self.dismiss(animated: false, completion: nil)
    }
}

