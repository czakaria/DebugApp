//
//  InnerCell.swift
//  DebugApp
//

//

import UIKit

class InnerCell: UICollectionViewCell {
    
    var text : UITextView = {
        let tv = UITextView()
        tv.text = ""
        tv.font = UIFont(name: "HelveticaNeue", size: 16)
        tv.textColor = .black
        tv.allowsEditingTextAttributes = false
        tv.isUserInteractionEnabled = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // backgroundColor = .red
        addSubview(text)
        setupTextLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextLayout(){
        
        text.leftAnchor.constraint(equalTo: self.leftAnchor ,constant: 20).isActive  = true
        text.rightAnchor.constraint(equalTo: self.rightAnchor ,constant: -20).isActive  = true
        text.topAnchor.constraint(equalTo: self.topAnchor,constant: 20).isActive  = true
        text.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -20).isActive = true
        
    }
    
    
}
