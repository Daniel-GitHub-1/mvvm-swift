//
//  URLShortener.swift
//  MVVMSwift
//
//  Created by Daniel on 2021/02/19.
//

import Foundation
import Alamofire

class URLShortener {
    let TAG: String = "[ShortenUtil]"
    
    let CLIEND_ID = "irUlO8cgzUrAxkhWA2Dt" // X-Naver-Client-Id
    let CLIEND_SECRET = "IfwsNJij9R" // X-Naver-Client-Secret
    
    static let sharedInstance = URLShortener() // 인스턴스
    
    init() {
        print("\(TAG) init() >> Start !!!")
    }
    
    /**
     * 사용자 정보 아이템
     *
     * @returns CardBookItem
     */
    func getUrl(url: String,
                completion: @escaping (Bool, String) -> Void) {
        
        let apiUrl = "https://openapi.naver.com/v1/util/shorturl"
        
        let parameters = ["url": url]
        
        let encodedUrl = apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        AF.request (
            encodedUrl!,
            method: .post,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: ["Content-Typ":"application/json",
                      "X-Naver-Client-Id":CLIEND_ID,
                      "X-Naver-Client-Secret":CLIEND_SECRET])
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                print("\(self.TAG) getUrl() >> response: \(response)")
                
                switch response.result {
                case .success(let data):
                    print("\(self.TAG) getUrl() >> data: \(data)")
                    
                    // 데이터 파싱
                    let shortUrl = self.parseUrl(data: response.data!)
                    print("\(self.TAG) getUrl() >> shortUrl: \(shortUrl)")
                    completion(true, shortUrl)
                    
                    break
                case .failure(let error):
                    print("\(self.TAG) getUrl() >> error: \(error)")
                    completion(false, "")
                    break
                }
        }
    }
    
    /**
     * 데이터 파싱
     *
     * @param data Data
     * @returns short URL
     */
    func parseUrl(data: Data) -> String {
        var shortUrl = ""
        do {
            let json = try JSONSerialization.jsonObject(with: data, options:[]) as! [String: Any]
            let result = json[Key.RESULT] as? NSDictionary ?? NSDictionary.init()
            print("\(self.TAG) parseUrl() >> result: \(String(describing: result))")
            
            shortUrl = result[Key.URL] as? String ?? ""
            print("\(self.TAG) parseUrl() >> shortUrl: \(shortUrl)")
        } catch {
            print("\(self.TAG) parseUrl() >> error: \(error)")
        }
        return shortUrl
    }
}

