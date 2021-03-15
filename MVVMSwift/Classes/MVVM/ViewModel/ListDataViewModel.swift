//
//  ListDataViewModel.swift
//  MVVMSwift
//
//  Created by crecolto on 2021/02/24.
//  Copyright © 2021 ZwooSoft. All rights reserved.
//

class ListDataViewModel: BaseViewModel {
 
    private let listDataService = ListDataService() // 리스트 데이터 서비스
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initViewModel("[ListDataViewModel]")
    }
    
    /**
     * 리스트 데이터 요청
     *
     * @param view UIViewController
     * @param parameters 파라미터
     * @return onResult(true|false, ListData, GetFailureReason)
     *
     */
    func getListData(_ viewController: UIViewController,
                     parameters: Parameters,
                     onResult: @escaping (Bool, ListData, GetFailureReason) -> ()) {
        self.d("getListData() >> parameters: \(parameters)")
        listDataService
            .getListData(parameters)
            .subscribe(
                onNext: { result in
                    onResult(true, result, GetFailureReason.NONE)
                    self.d("getListData() >> result: \(result)")
                },
                onError: { error in
                    onResult(false, ListData.init(),
                             error as? GetFailureReason ?? GetFailureReason.NONE)
                    self.d("getListData() >> error: \(error)")
                }
            )
            .disposed(by: self.disposeBag)
    }
}
