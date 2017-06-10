//
//  Constants.swift
//  LiveStream
//
//  Created by Lamine Ndiaye on 10/06/2017.
//
//

import Foundation

enum Constants {
    
    static let liveStreamScheme = "https://"
    static let liveStreamBaseUrl = "wowza-cloudfront.streamroot.io/"
    static let liveStreamPath = "liveorigin/stream4/playlist.m3u8"
    
    static func liveStreamUrlString() -> String {
        return liveStreamScheme + liveStreamBaseUrl + liveStreamPath
    }
}
