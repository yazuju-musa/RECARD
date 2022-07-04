//
//  SimpleNavigationView.swift
//  recard
//
//  Created by Musa Yazuju on 2022/07/04.
//

import SwiftUI

struct SimpleNavigationView<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    let content: Content
    var title: String
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    //アプリ全体で使うNavigationView
    var body: some View {
        content
        .navigationTitle(title)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(
                    action: {
                        dismiss()
                    }, label: {
                        Image(systemName: R.string.localizable.backIcon())
                    }
                ).tint(.white)
            }
        }
    }
}
