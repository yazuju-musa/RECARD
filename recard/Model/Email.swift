//
//  Email.swift
//  recard
//
//  Created by Musa Yazuju on 2022/07/04.
//

import Foundation
//問い合わせメールの内容
struct Email {
  let subject: String
  let recipients: [String]?
  let message: String
}
