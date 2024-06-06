//
//  CategoryCell.swift
//  TodoApp
//
//  Created by 한현승 on 5/26/24.
//

import Foundation
import UIKit


class CategoryViewCell: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
   //     label.layer.masksToBounds = true
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
        
    func configure(with text: Category) {
        label.text = text.content
        label.backgroundColor = UIColor(hexCode: text.color)
    }
}
