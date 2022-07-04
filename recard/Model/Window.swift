//
//  Window.swift
//  recard
//
//  Created by Musa Yazuju on 2022/07/04.
//

import SwiftUI
//iOS15以降でも警告が出ないwindow
struct Window {
    static var first: UIWindow? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        return windowScene?.windows.first
    }
}
