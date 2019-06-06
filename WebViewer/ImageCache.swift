//
//  ImageCache.swift
//  FA Viewer
//
//  Created by Eunmo Yang on 5/30/18.
//  Copyright © 2018 Eunmo Yang. All rights reserved.
//

import Foundation
import WebKit

class ImageCache: NSObject, WKURLSchemeHandler {
    
    static let serverAddress = "https://drugon-seller.firebaseapp.com/"
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func saveFile(data: Data, url: URL) {
        try? data.write(to: url, options: [.atomic])
    }
    
    func webView(_ webView: WKWebView, start urlSchemeTask: WKURLSchemeTask) {
        if let url = urlSchemeTask.request.url {
            let imageFile = url.absoluteString.replacingOccurrences(of: "drugon-scheme://", with: "")
            let localFile = ImageCache.DocumentsDirectory.appendingPathComponent(imageFile)
            let imageUrl = "\(ImageCache.serverAddress)/\(imageFile)"
            let url = URL(string: imageUrl)!
            let urlResponse = URLResponse(url: url, mimeType: "image/png", expectedContentLength: -1, textEncodingName: nil)
            var isLocal = false
            
            if FileManager.default.fileExists(atPath: localFile.path) {
                if let data = try? Data(contentsOf: localFile) {
                    urlSchemeTask.didReceive(urlResponse)
                    urlSchemeTask.didReceive(data)
                    urlSchemeTask.didFinish()
                    isLocal = true
                }
            }
            
            if isLocal == false {
                let urlSession = URLSession.shared
                
                let query = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
                    if let d = data {
                        self.saveFile(data: d, url: localFile)
                        urlSchemeTask.didReceive(urlResponse)
                        urlSchemeTask.didReceive(d)
                        urlSchemeTask.didFinish()
                    }
                })
                
                query.resume()
            }
        }
    }
    
    func webView(_ webView: WKWebView, stop urlSchemeTask: WKURLSchemeTask) {
        //
    }
}
