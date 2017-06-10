//
//  URLSession.swift
//  LiveStream
//
//  Created by Lamine Ndiaye on 10/06/2017.
//
//

import Foundation

extension URLSession {
    private func  swizzlingDataTask () {
        
        let dataTaskSelector =  #selector((URLSession.dataTask(with:)) as (URLSession) -> (URLRequest) -> URLSessionDataTask)
        let originalSelector = dataTaskSelector
        let swizzledSelector = #selector(URLSession.bisdataTask(with:))
        
        let originalMethod = class_getInstanceMethod(URLSession.self, originalSelector)
        let swizzledMethod = class_getInstanceMethod(URLSession.self, swizzledSelector)
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    @objc func bisdataTask(with request: URLRequest) -> URLSessionDataTask {
        if let urlString = request.url?.absoluteString {
            if urlString.contains(Constants.liveStreamBaseUrl) {
                debugLog("PLAYER HTTP REQUEST: \(urlString))") //DEbug Log
            }
        }
        return bisdataTask(with: request)
    }
    
    open override class func initialize() {
        if self !== URLSession.self {
            return
        }
        
        let swizzlingDataTask:() = {
            URLSession.shared.swizzlingDataTask()
        }()
        swizzlingDataTask
    }
}
