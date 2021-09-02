//
//  NetworkService.swift
//  Avito
//
//  Created by Marcus on 01.09.2021.
//

import Foundation
import SystemConfiguration


class NetworkService {
    private var cache = URLCache.shared
    private var request: URLRequest?
    private var timeOut : TimeInterval = 3600
    init() {
        let stringURl = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        if let url = URL(string: stringURl) {
            request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: timeOut)
        }
    }
    
    func startEmployeesLoading(handler: @escaping (Company)-> Void) {
        guard let request = request else { return }
        if let cashedRequest = cache.cachedResponse(for: request),
           let time = cashedRequest.userInfo?.first(where: { $0.key as? String == "date" })?.value as? Date,
           time.addingTimeInterval(3600) < Date() {
            cache.removeAllCachedResponses()
        }
        let task = URLSession.shared.downloadTask(with: request) {[weak self] url, responce, error in
            
            guard let url = url, let data = try? Data(contentsOf: url),
                  let responce = responce else {return}
            do {
                guard let self = self else {
                    return
                }
                let dataString = String(data: data, encoding: .utf8) ?? ""
                let jsonResult = try
                    JSONDecoder().decode(Company.self, from: dataString.data(using: .utf8) ?? data)
                if let cachedResponse = self.cache.cachedResponse(for: request) {
                    self.cache.storeCachedResponse(cachedResponse, for: request)
                } else {
                    self.cache.storeCachedResponse(CachedURLResponse(response: responce, data: data, userInfo: ["date": Date()], storagePolicy: .allowed), for: request)
                }
                handler(jsonResult)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    static func isConnectedToNetwork() -> Bool {
        var address = sockaddr_in()
        address.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        address.sin_family = sa_family_t(AF_INET)
        
        guard let defaultReach = withUnsafePointer(to: &address, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultReach, &flags) {
            return false
        }
        if flags.isEmpty {
            return false
        }
        
        let isReach = flags.contains(.reachable)
        let connect = flags.contains(.connectionRequired)
        
        return (isReach && !connect)
    }
}
