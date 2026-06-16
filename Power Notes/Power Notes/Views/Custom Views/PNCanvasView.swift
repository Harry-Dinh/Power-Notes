//
//  PNCanvasView.swift
//  Power Notes
//
//  Created by Harry Dinh on 2026-06-06.
//

import UIKit

final class PNCanvasView: UIView {
    private let editingLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.orange.cgColor
        layer.lineWidth = 3
        layer.fillColor = nil
        return layer
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        editingLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
