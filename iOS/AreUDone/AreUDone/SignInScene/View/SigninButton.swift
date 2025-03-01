//
//  SigninButton.swift
//  AreUDone
//
//  Created by a1111 on 2020/11/19.
//

import UIKit

class SigninButton: UIButton {
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    configure()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configure()
  }
  
  private func configure() {
    layer.cornerRadius = 5
    adjustsImageWhenHighlighted = false
  }
}
