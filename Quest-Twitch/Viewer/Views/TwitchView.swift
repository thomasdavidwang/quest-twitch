//
//  TwitchView.swift
//  Quest-Twitch
//
//  Created by Thomas Wang on 12/27/23.
//

import SwiftUI
import WebKit

struct TwitchView: UIViewRepresentable {
    let url: URL
    let frame: CGRect
    
    func makeUIView(context: Context) -> WKWebView  {
        // Initialize a WKWebViewConfiguration object.
        let webViewConfiguration = WKWebViewConfiguration()
        // Let HTML videos with a "playsinline" attribute play inline.
        webViewConfiguration.allowsInlineMediaPlayback = true
        // Let HTML videos with an "autoplay" attribute play automatically.
        webViewConfiguration.mediaTypesRequiringUserActionForPlayback = []
        
        let wkwebView = WKWebView(frame: frame, configuration: webViewConfiguration)
        let request = URLRequest(url: url)
        wkwebView.load(request)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            wkwebView.evaluateJavaScript("""
                                         {
                                         const hideElements = (...el) => {
                                           el.forEach((el) => {
                                             el?.style.setProperty("display", "none", "important");
                                           })
                                         }
                                         const hide = () => {
                                           const topBar = document.querySelector(".top-bar");
                                           const playerControls = document.querySelector(".player-controls");
                                           const channelDisclosures = document.querySelector("#channel-player-disclosures");
                                           hideElements(topBar, playerControls, channelDisclosures);
                                         }
                                         const observer = new MutationObserver(() => {
                                           const videoOverlay = document.querySelector('.video-player__overlay');
                                           if(!videoOverlay) return;
                                           hide();
                                           const videoOverlayObserver = new MutationObserver(hide);
                                           videoOverlayObserver.observe(videoOverlay, { childList: true, subtree: true });
                                           observer.disconnect();
                                         });
                                         observer.observe(document.body, { childList: true, subtree: true });
                                         }
                                         """) { (result, error) in
                if error == nil {
                    print(result)
                } else {
                    print(error)
                }
            }
        }
        return wkwebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

}
