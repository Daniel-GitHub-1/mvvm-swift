//
//  BottomSheetSelectViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/22.
//

import UIKit
import Alamofire
import MessageUI

protocol BottomSheetSelectDelegate: NSObjectProtocol {
    
    /**
     * 삭제하기 델리게이트
     *
     * @param controller // 컨트롤러
     * @param index // 선택 인덱스
     */
    func BottomSheetSelectDelegate(controller: BottomSheetSelectViewController,
                                   index: Int)
}

/**
 * BottomSheetSelectViewController.swift
 *
 * @description 더보기 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/22/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class BottomSheetSelectViewController: BaseViewController {
    
    var delegate: BottomSheetSelectDelegate? // 델리게이트

    @IBOutlet weak var vwMain: UIView? // 메인 뷰
    
    @IBOutlet weak var lbTitle: UILabel? // 라벨 타이틀
    
    @IBOutlet weak var btnCloseTop: UIButton? // 닫기 버튼 (Top)
    @IBOutlet weak var btnCamera: UIButton? // 카메라 촬영 버튼
    @IBOutlet weak var btnGallery: UIButton? // 갤러리 이동 버튼
    
    override func viewDidLoad() {
        d("viewDidLoad() >> Start !!!")
        d("viewDidLoad() >> width: \(self.view.frame.width)")
        d("viewDidLoad() >> height: \(self.view.frame.height)")
        super.viewDidLoad()
        
        // 메인
        self.vwMain?.addRoundCorners(50, corners: [.layerMaxXMinYCorner])

        // 닫기 버튼 (Top)
        self.btnCloseTop?.addTarget(self, action: #selector(self.actionCloseTop(_:)), for: .touchUpInside)
        
        // 카메라 촬영 버튼
        self.btnCamera?.addTarget(self, action: #selector(self.actionCamera(_:)), for: .touchUpInside)
        
        // 갤러리 이동 버튼
        self.btnGallery?.addTarget(self, action: #selector(self.actionGallery(_:)), for: .touchUpInside)
        
        // 버튼 태그 설정
        self.btnCamera?.tag = 1
        self.btnGallery?.tag = 2
    }
    
    /**
     * 닫기 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionCloseTop(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    /**
     * 카메라 촬영 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionCamera(_ sender: UIButton) {
        self.delegate?.BottomSheetSelectDelegate(controller: self,
                                                 index: sender.tag)
        self.dismiss(animated: true)
    }
    
    /**
     * 갤러리 이동 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionGallery(_ sender: UIButton) {
        self.delegate?.BottomSheetSelectDelegate(controller: self,
                                                 index: sender.tag)
        self.dismiss(animated: true)
    }
}

