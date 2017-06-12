//
//  URLSession.swift
//  LiveStream
//
//  Created by Lamine Ndiaye on 10/06/2017.
//
//

import Foundation

extension URLSession {

    private static let swizzlingDataTask:() = {
        URLSession.shared.swizzleDataTask()
    }()
    
    func swizzleDataTask () {
        
        let dataTaskSelector =  #selector((URLSession.dataTask(with:)) as (URLSession) -> (URLRequest) -> URLSessionDataTask)
        let originalSelector = dataTaskSelector
        let swizzledSelector = #selector(URLSession.customDataTask(with:))
        
        let originalMethod = class_getInstanceMethod(URLSession.self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(URLSession.self, swizzledSelector)
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    @objc func customDataTask(with request: URLRequest) -> URLSessionDataTask {
        if let urlString = request.url?.absoluteString {
            if urlString.contains(Constants.liveStreamBaseUrl) {
                debugLog("PLAYER HTTP REQUEST: \(urlString))") //DEbug Log
            }
        }
        return customDataTask(with: request)
    }
    
    open override class func initialize() {
        if self !== URLSession.self {
            return
        }
        
        swizzlingDataTask
    }
}
