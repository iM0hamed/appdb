//
//  TagButton.swift
//  appdb
//
//  Created by ned on 12/10/2018.
//  Copyright © 2018 ned. All rights reserved.
//

import UIKit

class TagButton: UIButton {
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    var paddingY: CGFloat = 2 {
        didSet {
            titleEdgeInsets.top = paddingY
            titleEdgeInsets.bottom = paddingY
        }
    }
    
    var paddingX: CGFloat = 5 {
        didSet {
            titleEdgeInsets.left = paddingX
            titleEdgeInsets.right = paddingX
        }
    }
    
    var textFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            titleLabel?.font = textFont
            titleLabel?.makeDynamicFont()
        }
    }
    
    // MARK: - init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(title: String) {
        super.init(frame: CGRect.zero)
        
        setTitle(title, for: .normal)
        
        frame.size = intrinsicContentSize
        
        addTarget(self, action: #selector(self.pressed), for: .touchDown)
        addTarget(self, action: #selector(self.pressed), for: .touchDragEnter)
        addTarget(self, action: #selector(self.released), for: .touchDragExit)
        
    }
    
    // MARK: - Layout
    
    override open var intrinsicContentSize: CGSize {
        guard let font = titleLabel?.scalableFont else { return .zero }
        var size = titleLabel?.text?.size(withAttributes: [NSAttributedString.Key.font: font]) ?? .zero
        size.height = font.pointSize + paddingY * 2
        size.width += paddingX * 2
        if size.width < size.height {
            size.width = size.height
        }
        return size
    }
    
    // MARK: - Animations
    
    @objc private func pressed() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseIn], animations: {
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }, completion: nil)
    }
    
    @objc private func released() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseOut], animations: {
            self.transform = .identity
        }, completion: nil)
    }
}
