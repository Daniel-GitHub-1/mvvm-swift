//
//  SettingsViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/02.
//

import UIKit

/**
 * 계정 셀
 *
 */
class SettingsCell: UITableViewCell {
    @IBOutlet var lbTitle: UILabel! // 타이틀 라벨
    @IBOutlet var lbSubTitle: UILabel! // 보조 타이틀 라벨
    @IBOutlet var btnSwitch: UIButton! // 스위치 버튼
    @IBOutlet var ivRight: UIImageView! // 다음 아이콘
}

protocol SettingsViewDelegate: NSObjectProtocol {
    
    /**
     * 설정 뷰 델리게이트
     *
     * @param controller // 컨트롤러
     */
    func SettingsViewDelegate(controller: SettingsViewController)
}

class SettingsViewController: BaseViewController {
    
    @IBOutlet var tbSettings: UITableView! // 설정 테이블 뷰
    
    let settingsCellIdentifier = "SettingsCellIdentifier" // Cell Identifier
    let rowHeight: CGFloat = 60.0 // Cell 높이
    
    var delegate: SettingsViewDelegate? // 델리게이트
    var arraySettings: [String] = [] // 설정 리스트
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        d("viewDidLoad() >> Start !!!")
        
        // 뷰 컨트롤러 초기화
        self.initViewController(self,
                                navTitle: getString("Settings"),
                                tag:"[\(getString("Settings"))]")
        
        // 설정 리스트
        for i in 0..<3 {
            switch(i) {
            case 0:
                self.arraySettings.append("계정")
                break
            case 1:
                self.arraySettings.append("알림설정")
                break
            case 2:
                self.arraySettings.append("이용약관 및 개인정보 취급방침")
                break
            default:
                break
            }
        }
        
        // 뒤로가기 버튼
        self.addBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        // 네비게이션바 설정
        self.setUpNavigationBar("#3766F2")
    }
}

// MARK: - UITableView DataSource

extension SettingsViewController: UITableViewDataSource {
    
    /**
     * 테이블 뷰 아이템 개수
     *
     * @param tableView UITableView
     * @param section Row 개수
     * @return Int 아이템 개수
     */
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        d("numberOfRowsInSection() >> Start !!!")
        return self.arraySettings.count
        
    }
    /**
     * 테이블 뷰 Cell 높이
     *
     * @param tableView UITableView
     * @returns indexPath IndexPath
     */
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.rowHeight
    }
    
    /**
     * 테이블 뷰 구성
     *
     * @param tableView UITableView
     * @param indexPath Cell Index
     * @return cell     UITableViewCell
     */
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        d("cellForRowAt() >> Start !!!")
        
        let cell
            = tableView
            .dequeueReusableCell(withIdentifier: settingsCellIdentifier,
                                 for: indexPath) as! SettingsCell
        d("cellForItemAt() >> cell: \(cell)")
        
        cell.lbTitle.text = ""
        cell.lbSubTitle.text = ""
        cell.lbSubTitle.isHidden = true
        cell.btnSwitch.isHidden = true
        
        let index = indexPath.row
        d("cellForItemAt() >> index: \(String(describing: index))")
        let item = self.arraySettings[index]
        d("cellForItemAt() >> item: \(String(describing: item))")
        
        // 타이틀
        cell.lbTitle.text = item
        
        cell.selectionStyle = .none
        
        return cell
    }
    
}

// MARK: - UITableView Delegate

extension SettingsViewController:  UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    /**
     * 테이블 뷰 아이템 선택
     *
     * @param tableView UITableView
     * @param indexPath Cell Index
     */
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        d("didSelectRowAt() >> Start !!!")
        let index = indexPath.row
        d("didSelectRowAt() >> index: \(index)")
        
        let item = self.arraySettings[index]
        d("didSelectRowAt() >> item: \(item)")
    }
    
    /**
     * 테이블 뷰 아이템 선택 해제
     *
     * @param tableView UITableView
     * @param indexPath Cell Index
     */
    func tableView(_ tableView: UITableView,
                   didDeselectRowAt indexPath: IndexPath) {
        d("didDeselectRowAt() >> Start !!!")
        let index = indexPath.row
        d("didDeselectRowAt() >> index: \(index)")
        
        let item = self.arraySettings[index]
        d("didDeselectRowAt() >> item: \(item)")
    }
    
    /**
     * 테이블 뷰 편집
     *
     * @param tableView UITableView
     * @param indexPath Cell IndexPath
     * @returns UISwipeActionsConfiguration
     */
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title:  "삭제", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
        })
        
        let shareAction = UIContextualAction(style: .normal, title:  "공유", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            
        })
        
        return UISwipeActionsConfiguration(actions:[deleteAction,shareAction])
    }
    
    
    /**
     * 테이블 뷰 편집
     *
     * @param tableView UITableView
     * @param indexPath Cell IndexPath
     * @returns UISwipeActionsConfiguration
     */
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive,
                                              title:  "",
                                              handler: { (ac: UIContextualAction,
                                                          view: UIView, success: (Bool) -> Void) in
            success(true)
            
            let item = self.arraySettings[indexPath.row]
            var contents = [String]()
            contents.append("닫기")
            contents.append("삭제")

            self.popupDialog(title: "",
                             msg: "\(item)를 삭제합니다.",
                             contents: contents) { (content) in
                if content == "삭제" {
                    self.arraySettings.remove(at: indexPath.row)
                    self.tbSettings.deleteRows(at: [indexPath], with: .fade)
                }
            }
        })
        deleteAction.image = UIImage(named: "Gallery")

        let shareAction = UIContextualAction(style: .normal,
                                             title:  "",
                                             handler: { (ac: UIContextualAction,
                                                         view: UIView, success: (Bool) -> Void) in
                                                success(true)
                                                
                                 
        })
        shareAction.image = UIImage(named:"Camera")

        
        return UISwipeActionsConfiguration(actions:[deleteAction,shareAction])
    }

    
    /**
     * 테이블 뷰 스크롤
     *
     * @param tableView UITableView
     * @param willDisplay Cell
     * @param forRowAt Cell Index
     */
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        d("willDisplay() >> Start !!!")
        d("willDisplay() >> indexPath.section: \(indexPath.section)")
        d("willDisplay() >> indexPath.row: \(indexPath.row)")
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
        }
    }
}

