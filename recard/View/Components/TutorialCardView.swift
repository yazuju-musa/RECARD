//
//  TutorialCardView.swift
//  recard
//
//  Created by Musa Yazuju on 2022/07/04.
//

import SwiftUI

struct TutorialCardView<Content: View>: View {
    @ObservedObject private var viewModel = ViewModel()
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    //チュートリアルのカード
    var body: some View {
        VStack {
            Spacer()
            content
            Spacer()
        }
        .background(Color(R.color.clearColor()!))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}
