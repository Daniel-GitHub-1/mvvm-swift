//
//  MessageViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/22.
//

import UIKit

import MaterialComponents.MaterialBottomSheet
import MessageUI

// RxSwift
import RxCocoa
import RxSwift
import RxViewController

import KakaoSDKAuth
import RxKakaoSDKAuth

import KakaoSDKUser
import RxKakaoSDKUser

import KakaoSDKLink
import RxKakaoSDKLink
import KakaoSDKAuth
import RxKakaoSDKAuth

import KakaoSDKTalk
import RxKakaoSDKTalk

protocol MessageViewDelegate: NSObjectProtocol {
    
    /**
     * 메시지 뷰 델리게이트
     *
     * @param controller // 컨트롤러
     */
    func MessageViewDelegate(controller: MessageViewController)
}

/**
 * MessageViewController.swift
 *
 * @description 메시지 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/22/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class MessageViewController: BaseViewController {
    
    @IBOutlet weak var btnSendMessage: UIButton? // 메시지 전송 버튼

    var viewModel = IntroViewModel() // 뷰 모델

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        // 디버그 태그
        setTag("[\(NSLocalizedString("Message", comment: ""))]")
        
        // 네비게이션 타이틀
        setTitle(NSLocalizedString("Message", comment: ""))
        
        // 뒤로가기 버튼
        self.addBackButton()
        
        // 버튼 라운드 설정
        if let color = "#3766F2".hexString2UIColor() {
            btnSendMessage?.addRound(8, color: color, width: 0.1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
    }
    
    /**
     * 메시지 팝업 뷰 컨트롤러 버튼
     *
     * @param sender UIButton
     */
    @IBAction func actionMessage(sender: UIButton) {
        d("actionMessage() >> Start !!!")
        
        // Botom Sheet 더보기 컨틀롤러 이동
        gotoBottomSheetMoreViewController()
    }
    
    /**
     * Botom Sheet 더보기 컨틀롤러 이동
     *
     */
    func gotoBottomSheetMoreViewController() {
        d("gotoBottomSheetMoreViewController() >> Start !!!")
        
        if let bottomSheetMoreViewController
            = UIStoryboard(name: "BottomSheet",
                           bundle: nil).instantiateViewController(withIdentifier: "BottomSheetMoreView") as? BottomSheetMoreViewController {
           
            bottomSheetMoreViewController.delegate = self
            
            let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: bottomSheetMoreViewController)
            
            bottomSheet.preferredContentSize = CGSize(width: self.view.frame.size.width, height: 220.0)
            
            bottomSheet.dismissOnDraggingDownSheet = false
            present(bottomSheet, animated: true, completion: nil)
            
        }
    }
    
    /**
     * 문자 메시지 전송 액션
     *
     * @param recipients 수신 연락처
     * @param content 내용
     */
    func actionSms(recipients: [String],
                   content: String) {
        d("actionSms() >> Start !!!")
        
        let messageCompose = MFMessageComposeViewController()
        messageCompose.messageComposeDelegate = self
        if MFMessageComposeViewController.canSendText(){
            messageCompose.recipients = recipients
            messageCompose.body = content
            self.present(messageCompose, animated: true, completion: nil)
        }
    }
    
    /**
     * 밴드 메시지 전송 액션
     *
     * @param content 내용
     * @param url URL
     */
    func actionBand(content: String, url: String) {
        d("actionBand() >> Start !!!")
        
        let isInstalled = UIApplication.shared.canOpenURL(URL(string: Naver.SCHEME_BAND)!)
        d("actionBand() >> isInstalled: \(isInstalled)")
        
        if (!isInstalled) {
            UIApplication.shared.open(URL(string: Naver.APPSTORE_URL_BAND)!,
                                      options: [:],
                                      completionHandler: nil)
        } else {
            let contentUrl = content.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let str = String(format: Naver.CONTENT_URL_BAND,
                             arguments: [contentUrl!, url])
            
            UIApplication.shared.open(URL(string: str)!, options: [:], completionHandler: nil)
        }
    }
}

// MARK: - BottomSheetMoreView Delegate

extension MessageViewController: BottomSheetMoreDelegate,
                                 MFMessageComposeViewControllerDelegate {
    /**
     * 더보기 팝업 델리게이트
     *
     * @param controller 컨트롤러
     * @param index 선택 인덱스
     */
    func BottomSheetMoreDelegate(controller: BottomSheetMoreViewController,
                                 index: Int) {
       d("BottomSheetMoreDelegate() >> index: \(index)")
        
        switch(index) {
        case 1: do {
            actionSms(recipients: ["0123456789"], content: "test")
        }
        default:
            break
        }
    }

    /**
     * SMS 전송 델리게이트
     *
     * @param controller 컨트롤러
     * @param result 선택 인덱스
     */
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        switch result {
        case MessageComposeResult.sent:
            d("didFinishWith() >> sent !!!")
            break
        case MessageComposeResult.cancelled:
            d("didFinishWith >> cancelled !!!")
            break
        case MessageComposeResult.failed:
            d("didFinishWith >> failed !!!")
            break
        @unknown default:
            fatalError("")
            
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
