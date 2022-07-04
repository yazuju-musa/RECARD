//
//  ContentView.swift
//  recard
//
//  Created by Musa Yazuju on 2022/07/02.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var firebaseViewModel = FirebaseViewModel()
    @ObservedObject private var purchaseViewModel = PurchaseViewModel()
    @ObservedObject private var viewModel = ViewModel()
    @State private var isShowingAlert = false
    @State private var isShowingPro = false
    @State private var isPro = false
    @State var isShowingTutorial = false

    init(){
        //ナビゲーションバーのUI調整
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = UIColor(viewModel.getThemeColor())
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        //グラフの表示幅選択ボタンのUI調整
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(viewModel.getThemeColor())
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(viewModel.getThemeColor())], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white,], for: .selected)
        //チュートリアルのPageControlのUI調整
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(viewModel.getThemeColor())
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        //20回起動毎にレビューアラートを表示
        viewModel.showReviewForEvery20Launchs()
    }
    
    var body: some View {
        NavigationView {
            Text("HomeView")
            .background(Color(R.color.backgroundColor()!))
            .navigationBarTitle(R.string.localizable.homeViewTitle(), displayMode: .inline)
            .toolbar {
                //設定ボタン
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    NavigationLink(destination: SettingView()){
                        Image(systemName: R.string.localizable.settingIcon()).foregroundColor(.white)
                    }
                }
            }
            //ログインしていない場合チュートリアルを表示
            .onAppear {
                if !firebaseViewModel.isLoggedIn() {
                    isShowingTutorial = true
                }
            }
            //チュートリアル
            .fullScreenCover(isPresented: $isShowingTutorial) {
                TutorialView(isShowingTutorial: $isShowingTutorial)
            }
            //非課金状態で6個以上種目を登録する場合アラートを表示
            .alert(isPresented: $isShowingAlert) {
                return Alert(title: Text(R.string.localizable.onlyFiveEventsAvailableInFree()), message: Text(R.string.localizable.eventsWillBeUnlimitedIfJoinPro()), primaryButton: .default(Text(R.string.localizable.close())), secondaryButton: .default(Text(R.string.localizable.seePro()), action: {
                    isShowingPro = true
                }))
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
