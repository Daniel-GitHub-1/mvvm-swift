//
//  BottomSheetMoreViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/19.
//

import UIKit
import Alamofire
import MessageUI

protocol BottomSheetMoreDelegate: NSObjectProtocol {
    
    /**
     * 더보기 델리게이트
     *
     * @param controller // 컨트롤러
     * @param index // 선택 인덱스
     */
    func BottomSheetMoreDelegate(controller: BottomSheetMoreViewController,
                                 index: Int)
}

class BottomSheetMoreViewController: BaseViewController {
    
    var delegate: BottomSheetMoreDelegate? // 델리게이트

    @IBOutlet weak var vwMain: UIView? // 메인 뷰
    
    @IBOutlet weak var lbSms: UILabel? // 문자 라벨
    @IBOutlet weak var lbKakao: UILabel? // 카카오 라벨
    @IBOutlet weak var lbBand: UILabel? // 밴드 라벨
    
    @IBOutlet weak var btnCloseTop: UIButton? // 닫기 버튼 (Top)
    @IBOutlet weak var btnCloseBottom: UIButton? // 닫기 버튼 (Bottom)
    @IBOutlet weak var btnSms: UIButton? // 문자 전송 버튼
    @IBOutlet weak var btnKakao: UIButton? // 카카오 전송 버튼
    @IBOutlet weak var btnBand: UIButton? // 밴드 전송 버튼
    
    override func viewDidLoad() {
        d("viewDidLoad() >> Start !!!")
        super.viewDidLoad()
        
        // 뷰 컨트롤러 초기화
        self.initViewController(self,
                                navTitle: "",
                                tag: "[BottomSheetMoreView]")
        
        // 메인
        self.vwMain?.addRoundCorners(50, corners: [.layerMaxXMinYCorner])

        // 닫기 버튼 (Top)
        self.btnCloseTop?.addTarget(self, action: #selector(self.actionCloseTop(_:)), for: .touchUpInside)
        
        // 닫기 버튼 (Bottom)
        self.btnCloseBottom?.addTarget(self, action: #selector(self.actionCloseBottom(_:)), for: .touchUpInside)
        
    
        // 버튼 태그 설정
        self.btnSms?.tag = 1
        self.btnKakao?.tag = 2
        self.btnBand?.tag = 3
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
     * 닫기 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionCloseBottom(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    /**
     * Sms 메시지 전송 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionSms(_ sender: UIButton) {
        
        self.delegate?.BottomSheetMoreDelegate(controller: self,
                                               index: sender.tag)
        self.dismiss(animated: true)
    }
    
    /**
     * 카카오 메시지 전송 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionKakao(_ sender: UIButton) {
        
        self.delegate?.BottomSheetMoreDelegate(controller: self,
                                               index: sender.tag)
        self.dismiss(animated: true)
    }
    
    /**
     * 밴드 메시지 전송 액션
     *
     * @param sender UIButton
     */
    @IBAction func actionBand(_ sender: UIButton) {
        
        self.delegate?.BottomSheetMoreDelegate(controller: self,
                                               index: sender.tag)
        self.dismiss(animated: true)
    }
}
