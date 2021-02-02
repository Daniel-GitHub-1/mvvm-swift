//
//  ViewController.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/01/28.
//

import RxCocoa
import RxSwift
import RxViewController
import UIKit


class MainViewController: UIViewController {
    
    var TAG = "MainViewController" // 디버그 태그
    
    @IBOutlet weak var tableView: UITableView!
    
//    let searchController = UISearchController(searchResultsController: nil)
//    var searchBar: UISearchBar { return searchController.searchBar }
//
//    var viewModel: ViewModelType
    var viewModel = MainViewModel()
//    let disposeBag = DisposeBag()
//
    var navigationTitle: String {
        return "ViewController"
    }
//
//    init(viewModel: ViewModelType) {
//       self.viewModel = viewModel
//     }
//

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad() >> Start !!!")
        
//        configureSearchController()
        
//        viewModel.getVersion()
        
        viewModel.getDuplicateCheckId(id: "zzz@gmail.com")
        
//        DispatchQueue
//            .main
//            .asyncAfter(deadline: .now() + 1.0) {
//                self.requestGetPartner(parameters: parameters)
//        }
    }
}
