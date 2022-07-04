//
//  FormRowView.swift
//  recard
//
//  Created by Musa Yazuju on 2022/07/04.
//

import SwiftUI

struct FormRowView: View {
    @ObservedObject private var viewModel = ViewModel()
    var icon: String
    var firstText: String
    var isHidden: Bool
    //SettingViewの項目
    var body: some View {
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(viewModel.getThemeColor())
                Image(systemName: icon)
                    .foregroundColor(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            Text(firstText).foregroundColor(Color(R.color.fontColor()!))
            Spacer()
        }.opacity(isHidden ? 0.5 : 1)
    }
}
