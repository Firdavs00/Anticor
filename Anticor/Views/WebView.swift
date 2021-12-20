//
//  WebView.swift
//  iDine
//
//  Created by Apple Bro on 05/12/21.
//

import Foundation
import SwiftUI
import Combine
import WebKit
import UIKit

struct WebView: UIViewRepresentable {
    
    var type: URLType
    var url: String?
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        return webView
    
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let urlValue = url  {
            if let requestUrl = URL(string: urlValue) {
                webView.load(URLRequest(url: requestUrl))
            }
        }
    }
    
}


struct WebViewOpen: UIViewRepresentable {
    var url: URL
    var isComplate: (Bool)->Void

    func makeCoordinator() -> WebViewOpen.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // you can access environment via context.environment here
        // Note that this method will be called A LOT
    }


    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebViewOpen
        var codeDataServise = CodeData()
        
        init(_ parent: WebViewOpen) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation : WKNavigation!) {
            
            guard let url = webView.url else {
                return
            }
            
            guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code"})?.value else {
                return
            }
            
            guard let state = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "state"})?.value else {
                return
            }
            
            webView.isHidden = true
            print("Code: \(code)")
            print("staet: \(state)")
            codeDataServise.codeToken(code: code, state: state, complation: { model in
                guard let model = model else {
                    self.parent.isComplate(false)
                    return
                }
                self.parent.isComplate(true)
            })
            
        }
}
}

