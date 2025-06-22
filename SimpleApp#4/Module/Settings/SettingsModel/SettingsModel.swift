//
//  SettingsModel.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/20/25.
//

import UIKit

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

