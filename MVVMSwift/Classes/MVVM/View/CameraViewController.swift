//
//  CameraViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/22.
//

import UIKit
import MobileCoreServices

// RxSwift
import RxCocoa
import RxSwift
import RxViewController

// BottomSheet
import MaterialComponents.MaterialBottomSheet

protocol CameraViewDelegate: NSObjectProtocol {
    
    /**
     * 카메라 뷰 델리게이트
     *
     * @param controller // 컨트롤러
     */
    func CameraViewDelegate(controller: CameraViewController)
}

/**
 * CameraViewController.swift
 *
 * @description 카메라 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/22/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class CameraViewController: BaseViewController {
    
    @IBOutlet weak var btnSelect: UIButton? // 카메라 촬영, 갤러리에서 선택 버튼
    
    @IBOutlet weak var ivImage: UIImageView? // 이미지 뷰
    
//    let imagePicker: UIImagePickerController! = UIImagePickerController() // 이미지 피커 컨트롤러
    var imagePicker: ImagePicker?
    
    var viewModel = IntroViewModel() // 뷰 모델

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        // 디버그 태그
        setTag("[\(NSLocalizedString("Camera", comment: ""))]")
        
        // 네비게이션 타이틀
        setTitle(NSLocalizedString("Camera", comment: ""))
        
        // 뒤로가기 버튼
        self.addBackButton()
        
        // 버튼 라운드 설정
        if let color = "#3766F2".hexString2UIColor() {
            btnSelect?.addRound(8, color: color, width: 0.1)
        }
        
//        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
    }
    
    /**
     * 선택 팝업 뷰 컨트롤러 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionSelect(sender: UIButton) {
        d("actionSelect() >> Start !!!")

        self.imagePicker?.present(from: sender)
    }
    
    
    /**
     * Botom Sheet 선택 컨틀롤러 이동
     *
     */
    func gotoBottomSheetSelectViewController() {
        if let bottomSheetSelectViewController
            = UIStoryboard(name: "BottomSheet",
                           bundle: nil).instantiateViewController(withIdentifier: "BottomSheetSelectView") as? BottomSheetSelectViewController {
            self.d("gotoBottomSheetSelectViewController() >> bottomSheetSelectViewController: \(bottomSheetSelectViewController)")

            let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: bottomSheetSelectViewController)
            bottomSheet.preferredContentSize = CGSize(width: self.view.frame.size.width, height: 150.0)
            
            bottomSheet.dismissOnDraggingDownSheet = false
            present(bottomSheet, animated: true, completion: nil)
            
        }
    }
}

// MARK: - BottomSheetMoreView Delegate

extension CameraViewController: BottomSheetSelectDelegate {
    
    func BottomSheetSelectDelegate(controller: BottomSheetSelectViewController,
                                   index: Int) {
        
        switch(index) {
        case 1: do {
            self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        }
            break
        case 2: do {
            
        }
            break
        default:
            break;
        }
    }
}

extension CameraViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.ivImage?.image = image
    }
}
