//
//  ListViewModel.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/05.
//

class ListViewModel: BaseViewModel {

    private let listDataService = ListDataService() // 리스트 데이터 서비스
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initViewModel("[ListViewModel]")
    }
    
    /**
     * 리스트 데이터 요청
     *
     * @param viewController UIViewController
     * @param parameters 파라미터
     * @return completion(true|false, ListData, GetFailureReason)
     *
     */
    func getListData(_ viewController: UIViewController,
                     parameters: Parameters,
                     onResult: @escaping (Bool, ListData, GetFailureReason) -> ()) {
        d("getListData() >> parameters: \(parameters)")
        
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
