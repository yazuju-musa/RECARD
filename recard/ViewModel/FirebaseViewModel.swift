//
//  FirebaseViewModel.swift
//  recard
//
//  Created by Musa Yazuju on 2022/07/04.
//

import Foundation
import Firebase

class FirebaseViewModel: ObservableObject {
    //ログイン状態
    func isLoggedIn() -> Bool {
        if Auth.auth().currentUser == nil {
            return false
        } else {
            return true
        }
    }
    //サインイン
    func signIn(email: String, password: String) -> String? {
        var errorMessage = ""
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            }
        }
        return errorMessage
    }
    //アカウント作成
    func signUp(email: String, password: String) -> String? {
        var errorMessage = ""
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                guard let _ = authResult?.user else { return }
                Auth.auth().signIn(withEmail: email, password: password)
                let db = Firestore.firestore()
                let userID = Auth.auth().currentUser!.uid
                db.collection(R.string.localizable.users()).document(userID).setData([R.string.localizable.email(): email])
            }
        }
        return errorMessage
    }
    //メールアドレス変更
    func changeEmail(into: String) -> String? {
        var errorMessage = ""
        Auth.auth().currentUser?.updateEmail(to: into) { error in
            if let error = error as NSError? {
                errorMessage = error.localizedDescription
            }
        }
        return errorMessage
    }
    //パスワード変更
    func changePassword(into: String) -> String? {
        var errorMessage = ""
        Auth.auth().currentUser?.updatePassword(to: into) { error in
            if let error = error as NSError? {
                errorMessage = error.localizedDescription
            }
        }
        return errorMessage
    }
    //パスワードリセット
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                print("パスワードリセット時のエラー\(error!)")
                return
            }
        }
    }
    //サインアウト
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("サインアウトエラー\(signOutError)")
        }
    }
}
