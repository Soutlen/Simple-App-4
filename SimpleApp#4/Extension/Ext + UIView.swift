//
//  Ext + UIView.swift
//  SimpleApp#4
//
//  Created by Евгений Глоба on 6/22/25.
//

import UIKit

extension UIView {
    
    /// Применяет градиент к View.
    /// - Parameters:
    ///   - colors: Массив цветов (UIColor) для градиента.
    ///   - startPoint: Начальная точка градиента (например, верхний центр - CGPoint(x: 0.5, y: 0)).
    ///   - endPoint: Конечная точка градиента (например, нижний центр - CGPoint(x: 0.5, y: 1)).
    func applyGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor } // Преобразуем UIColor в CGColor
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = self.bounds
        
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
