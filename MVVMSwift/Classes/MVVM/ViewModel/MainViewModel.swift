//
//  MainViewModel.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/01/28.
//

class MainViewModel: BaseViewModel {
    
    /**
     * 초기화
     *
     */
    override init() {
        super.init()
        self.initViewModel("[MainViewModel]")
    }
    
    /**
     * 단축 URL
     *
     * @param url 입력 URL
     * @returns completion(Bool, String)
     */
    func getUrl(_ url: String!,
                completion: @escaping (Bool, String) -> ()) {
        URLShortener.sharedInstance.getUrl(url: url) { (result, shortUrl) in
            self.d("getUrl() >> shortUrl: \(shortUrl)")
            completion(result, shortUrl)
        }
    }
}
