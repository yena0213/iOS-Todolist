//
//  AddCategoryCell.swift
//  TodoApp
//
//  Created by 한현승 on 5/28/24.
//

import UIKit

class AddCategoryCell: UICollectionViewCell {
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = UIColor(hexCode:"F5F5F5")
        button.setTitleColor(UIColor(hexCode: "A2A2A2"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setUpViews() {
        addSubview(addButton)
        self.addButton.snp.makeConstraints{make in
            make.edges.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
}

class TodoView: UIView {
    
}
