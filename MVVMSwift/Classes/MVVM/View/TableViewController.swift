//
//  TableViewController.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/18.
//

import UIKit

// RxSwift
import RxCocoa
import RxSwift
import RxViewController

// Communication
import Alamofire

/**
 * 테이블 셀
 *
 */
class TableCell: UITableViewCell {
    @IBOutlet var ivImage: UIImageView! // 이미지
    @IBOutlet var lbTitle: UILabel! // 타이틀
    @IBOutlet var lbSubTitle: UILabel! // 서브 타이틀
}

protocol TableViewDelegate: NSObjectProtocol {
    
    /**
     * 테이블 뷰 델리게이트
     *
     * @param controller // 컨트롤러
     */
    func TableViewDelegate(controller: TableViewController)
}

/**
 * TableViewController.swift
 *
 * @description 테이블 뷰 컨트롤러
 * @author Daniel
 * @Constructor ZwooSoft
 * @version 1.0.0
 * @since 02/16/21 10:52 AM
 * @copyright Copyright © 2021 ZwooSoft All rights reserved.
 **/
class TableViewController: BaseViewController {

    @IBOutlet weak var tbTable: UITableView! // 테이블 뷰
    
    let tableCellIdentifier = "TableCellIdentifier" // Cell Identifier

    var delegate: TableViewDelegate? // 델리게이트
    var viewModel = ListDataViewModel() // 뷰 모델
    
    var arrayList = [ListDataInfo]() // 리스트
    
    let rowHeight: CGFloat = 60.0 // Cell 높이

    // MARK: - UIViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d("viewDidLoad() >> Start !!!")
        
        // 디버그 태그
        setTag("[\(NSLocalizedString("Table", comment: ""))]")
        
        // 네비게이션 타이틀
        setTitle(NSLocalizedString("Table", comment: ""))
        
        // 뒤로가기 버튼
        self.addBackButton()
        
        // 테이블 뷰 설정
        self.setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        d("viewWillAppear() >> Start !!!")
        super.viewWillAppear(animated)
        
        // 네비게이션바 숨김
        setUpNavigationBar("Table")
        
        DispatchQueue
            .main
            .asyncAfter(deadline: .now() + 0.5) {
                // 로딩 뷰 컨트롤러 시작
                self.startLoading()
                
                // 리스트 데이터 요청
                self.requestList()
            }
    }
    
    /**
     * 리스트 요청 세팅
     *
     */
    func requestList() {
        // Request List
        var parameters = Parameters.init()
//        parameters[Key.TN] = Define.TN_LIST
        parameters[Key.MEM_IDX] = 65
        parameters[Key.CATE_MAIN] = "001"
        parameters[Key.CATE_SUB] = "001002"
        parameters[Key.PAGE] = 1
        parameters[Key.LIMIT] = 20
        d("getListData() >> parameters: \(parameters)")
        
        viewModel.getListData(self, parameters: parameters) { (result, datas, msg) in
            self.d("getListData() >> result: \(result)")
            self.d("getListData() >> datas: \(datas)")
            self.d("getListData() >> msg: \(msg)")
            
            // 로딩 뷰 컨트롤러
            self.stopLoading()
            
            if result {
                self.arrayList = datas.info
                self.d("getListData() >> arrayList: \(self.arrayList.count)")
                
                // TODO 테스트
//                for item in self.arrayList {
//                    self.d("getListData() >> idx: \(item.idx)")
//                    self.d("getListData() >> intro_img: \(item.intro_img)")
//                    self.d("getListData() >> store_name: \(item.store_name)")
//                    self.d("getListData() >> store_name: \(item.store_name)")
//                    self.d("getListData() >> store_addr: \(item.store_addr)")
//                    self.d("getListData() >> map_x: \(item.map_x)")
//                    self.d("getListData() >> map_y: \(item.map_y)")
//                }
                
                // 리스트 뷰 갱신
                self.tbTable.reloadData()
                
            } else {
                var contents = [String]()
                contents.append("확인")
                self.popupDialog(title: "",
                                 msg: "리스트 내용이 없습니다." ,
                                 contents: contents) { (content) in
                    self.d("getListData() >> content: \(content)")
                }
            }
        }
    }
    
    /**
     * 테이블 뷰 세팅
     *
     */
    func setTableView() {
        // 테이블 뷰 델리게이트 설정
        self.tbTable.delegate = self
        self.tbTable.dataSource = self
        
        // 테이블 뷰 높이
        self.tbTable.rowHeight = self.rowHeight
        
        // 테이블 뷰 스크롤 숨김
        self.tbTable.showsHorizontalScrollIndicator = false
        self.tbTable.showsVerticalScrollIndicator = false
        
        // 테이블 뷰 Footer Line
        self.tbTable.tableFooterView = UIView()
        
        // 테이블 뷰 바운스 방지
        self.tbTable.bounces = false
        
        // 구분선 제거
//        self.tbTable.separatorStyle = UITableViewCell.SeparatorStyle.none

//        if #available(iOS 10.0, *) {
//            self.tbTable.refreshControl = refreshControl
//        } else {
//            self.tbTable.addSubview(refreshControl)
//        }
//        self.refreshControl.addTarget(self,
//                                      action: #selector(self.refreshTableView),
//                                      for: .valueChanged)
    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: - UITableView

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
        return self.arrayList.count
    }
    
    /**
     * 테이블 뷰 구성
     *
     * @param tableView UITableView
     * @param indexPath Cell Index
     * @return cell UITableViewCell
     */
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            d("cellForRowAt() >> Start !!!")
        
        let cell
            = tableView
                .dequeueReusableCell(withIdentifier: tableCellIdentifier,
                                     for: indexPath) as! TableCell
//        d("cellForItemAt() >> cell: \(cell)")

        // 셀 뷰 테두리 라운드 처리
//        cell.viewCell.layer.cornerRadius = 3
//        cell.viewCell.layer.borderWidth = 1
//        cell.viewCell.layer.borderColor = UIColor.clear.cgColor

        let index = indexPath.row
        let item = self.arrayList[index]
//        d("cellForItemAt() >> item: \(item)")

        // 타이틀
        var title = item.store_name
        if (title.isEmpty) { title = "이름없음" }
        d("cellForItemAt() >> name: \(String(describing: title))")
        
        // 타이틀 라벨
        cell.lbTitle.text = ""
        cell.lbTitle.text = title
        
        // 서브 타이틀
        let subTitle = item.store_addr
        d("cellForItemAt() >> level: \(String(describing: subTitle))")
        
        // 서브 타이틀 라벨
        cell.lbSubTitle.text = ""
        cell.lbSubTitle.text = subTitle

        let image = item.intro_img
//        d("cellForItemAt() >> image: \(String(describing: image))")
        
        if !image.isEmpty {
            let url = URL(string: image)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.ivImage.image = UIImage(data: data!)
                }
            }
        } else {
            cell.ivImage.image = UIImage(named: "default")!
        }
        
        // 라운드 처리
        cell.ivImage.layer.cornerRadius = cell.ivImage.frame.size.width/2
        cell.ivImage.clipsToBounds = true
        cell.ivImage.layer.borderWidth = 0.1
        cell.ivImage.layer.borderColor = UIColor.clear.cgColor
     
        cell.selectionStyle = .none
        
        return cell
    }
}
//
//
//
//
//
//// MARK: - UITableViewDelegate protocol
//
///**
// * 테이블 뷰 아이템 선택
// *
// * @param tableView UITableView
// * @param indexPath Cell Index
// */
//func tableView(_ tableView: UITableView,
//               didSelectRowAt indexPath: IndexPath) {
//    d("didSelectRowAt() >> Start !!!")
//
//    let index = indexPath.row
//    let cardBookItem = arrayCardBookItem[index]
//    d("didSelectRowAt() >> cardBookItem: \(cardBookItem)")
//
//    let checkBox = self.checkIsCheckBox()
//    if checkBox == CheckBox.none {
//        // index가 0이면,
//        if (index == 0) {
//            // 프로필 뷰 컨트롤러 이동
//            self.gotoProfileViewController()
//            return
//        }
//
//         d("didSelectRowAt() >> card_type: \(cardBookItem.card_type)")
//
//        // 명함타입이 없으면,
//        if cardBookItem.card_type == .none { return }
//
//        if cardBookItem.card_type == .live { // Live 명함 뷰 컨트롤러 이동
//            self.gotoLiveCardDetailViewController(cardBookItem: cardBookItem)
//        } else { // 촬영명함 뷰 컨트롤러 이동
//            self.gotoOcrlogDetailViewController(cardBookItem: cardBookItem,
//                                                index: index,
//                                                startType: .detail)
//        }
//        return
//    }
//
//    if let value = self.dicSelected[indexPath.row] {
//        d("didSelectRowAt() >> value: \(value)")
//        if value {
//            self.dicSelected[indexPath.row] = false
//        } else {
//            self.dicSelected[indexPath.row] = true
//        }
//    } else {
//        self.dicSelected[indexPath.row] = true
//    }
//    self.tbCardbook.reloadData()
//}
//
///**
// * 테이블 뷰 아이템 선택 해제
// *
// * @param tableView UITableView
// * @param indexPath Cell Index
// */
//func tableView(_ tableView: UITableView,
//               didDeselectRowAt indexPath: IndexPath) {
//    d("didDeselectRowAt() >> Start !!!")
//}
//
///**
// * 테이블 뷰 편집
// *
// * @param tableView UITableView
// * @param editActionsForRowAt Cell Index
// */
//func tableView(_ tableView: UITableView,
//               editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//    print("\(self.TAG) editActionsForRowAt() >> Start !!!")
//
//    let index = indexPath.row
//    if index == 0 { return [] }
//
//    let cardBookItem = self.arrayCardBookItem[index]
//
//    // 이름
//    let name = cardBookItem.name
//    print("\(self.TAG) editActionsForRowAt() >> name: \(String(describing: name))")
//
//    let deleteAction = UITableViewRowAction(style: .destructive,
//                                            title: "삭제") { action, index in
//
//                                                // 삭제 팝업
//                                                self.popupDelete(cardBookItem: cardBookItem)
//    }
////        let moreAction = UITableViewRowAction(style: .normal,
////                                              title: "더보기") { action, index in
////
////            // 더보기
////            let title = name
////            let message = "원하는 작업을 선택하세요."
////            var contents = [String]()
////            contents.append("명함 전달")
////            contents.append("회사명함 등록")
////            contents.append("만남이력 작성")
////            contents.append("닫기")
////
////            DispatchQueue
////                .main
////                .async {
////                    DialogUtil
////                        .sharedInstance
////                        .show(controller: self,
////                              title: title,
////                              message: message,
////                              contents: contents,
////                              completion:  {
////                                selected in
////                                print("\(self.TAG) editActionsForRowAt() >> completion: \(selected)")
////                                if (selected == "명함전달") {
////
////                                } else if (selected == "회사명함 등록") {
////
////                                } else if (selected == "만남이력 작성") {
////
////                                }
////                        })
////            }
////        }
////        return [deleteAction, moreAction]
//    return [deleteAction]
//}

