//
//  AddCategoryViewController.swift
//  TodoApp
//
//  Created by 한현승 on 5/28/24.
//

import UIKit
import SnapKit


final class CategoryDetailViewController: UIViewController {
    
    var categoryId: Int?
    var selectedCategory: Category?
    
    private let categoryName: UITextField = {
        
        let field = UITextField()
        field.placeholder = "추가할 카테고리를 입력해주세요!"
        field.font = UIFont.systemFont(ofSize: 18)
        field.borderStyle = .roundedRect
        return field
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Color"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    private let colorSelectionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.backgroundColor = UIColor(hexCode: "EEEEEE").cgColor
        return view
    }()
    
    let colors: [String] = ["FFFDEE", "F0FFFE","FFF5F9","FE867E", "FCEA4A"]
    private var selectedColor: String?
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexCode: "4260FF")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveCategory), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpViews()
        setupColorButtons()
        didSelectCategory()
    }
    
    private func setUpViews() {
        view.addSubview(categoryName)
        self.categoryName.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.height.equalTo(50)
        }
        self.categoryName.becomeFirstResponder()
        self.categoryName.delegate = self
        
        
        view.addSubview(colorLabel)
        colorLabel.snp.makeConstraints{make in
            make.top.equalTo(categoryName.snp.bottom).offset(50)
            make.centerX.equalTo(view)
        }
        
        
        view.addSubview(colorSelectionView)
        self.colorSelectionView.snp.makeConstraints{ make in
            make.top.equalTo(colorLabel.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.height.equalTo(120)
        }
        
        view.addSubview(addButton)
        self.addButton.snp.makeConstraints{ make in
            make.bottom.equalTo(view).offset(-80)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.height.equalTo(60)
            make.centerX.equalTo(view)
        }
    }
    
    private func setupColorButtons() {
        let buttonWidth = (view.frame.width - 100) / CGFloat(colors.count)
        for (index, colorHex) in colors.enumerated() {
            let button = UIButton()
            
            button.backgroundColor = UIColor(hexCode: colorHex)
            button.layer.cornerRadius = buttonWidth / 2
            button.tag = index
            button.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
            
            colorSelectionView.addSubview(button)
            button.snp.makeConstraints { make in
                make.width.height.equalTo(buttonWidth)
                make.leading.equalToSuperview().offset(20 + CGFloat(index) * (buttonWidth + 10))
                make.centerY.equalToSuperview()
            }
        }
    }
    
    private func didSelectCategory() {
        if let selected = selectedCategory {
            categoryId = selected.categoryId
            categoryName.text = selected.content
            selectedColor = selected.color
            
            for subview in colorSelectionView.subviews {
                if let button = subview as? UIButton, button.backgroundColor == UIColor(hexCode: selected.color) {
                    button.layer.borderWidth = 2
                    button.layer.borderColor = UIColor.white.cgColor
                }
            }
        }
    }
    
    @objc func colorButtonTapped(_ sender: UIButton ) {
        for subview in colorSelectionView.subviews {
            subview.layer.borderWidth = 0
        }
        sender.layer.borderWidth = 2
        sender.layer.borderColor = UIColor.white.cgColor
        selectedColor = colors[sender.tag]
    }
    
    @objc func saveCategory() {
        guard let content = categoryName.text, !content.isEmpty,
              let color = selectedColor  else {
            let alert = UIAlertController(title: "Error", message: "양식을 채워주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return}
        
        Task {
            do {
                let memberId = 1
                if selectedCategory != nil {
                    let newCategory = Category(categoryId: categoryId!, content: content, color: color)
                    let updatedCategory = try await FetchAPI.shared.updateCategory(categoryId: categoryId!, category: newCategory)
                    print("Category update :\(updatedCategory)")
                }
                else {
                    let newCategory = AddCategory(content: content, color: color)
                    let addedCategory = try await FetchAPI.shared.addCategory(memberId: memberId, category: newCategory)
                    print("Category added: \(addedCategory)")
                }
                
                navigationController?.popViewController(animated: true)
                
            }catch {
                let alert = UIAlertController(title: "Error", message: "Failed to add category", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                print("Failed to add category: \(error)")
            }
        }
    }
}

extension CategoryDetailViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.tintColor = UIColor.clear
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        categoryName.tintColor = .gray
        return true
    }
}
