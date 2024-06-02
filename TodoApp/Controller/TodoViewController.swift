//
//  TodoViewController.swift
//  TodoApp
//
//  Created by 한현승 on 5/25/24.
//

import UIKit
import SnapKit

final class TodoViewController: UIViewController {
    
    var categories: [Category] = []
    var todos: [Todo] = []
    var currentMonth: Int = Calendar.current.component(.month, from: Date())
    var currentDay: Int = Calendar.current.component(.day, from: Date())
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "TodoLogo")
        return image
    }()
    
    private let menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "profile-circle"), for: .normal)
        return button
    }()
    
    private let monthContainer = UIView()
    
    private let priviousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("<", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(">", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    private let categoryView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let categorys = UICollectionView(frame: .zero, collectionViewLayout: layout)
        categorys.backgroundColor = UIColor.white
        categorys.showsHorizontalScrollIndicator = false
        return categorys
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let todoView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let todos = UICollectionView(frame: .zero, collectionViewLayout: layout)
        todos.backgroundColor = UIColor.white
        todos.showsHorizontalScrollIndicator = false
        return todos
    }()
    
    private let addTodoButton: UIButton = {
       let button = UIButton()
        button.setTitle("TodoList 추가", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.backgroundColor = UIColor(hexCode: "F5F5F5")
        button.setTitleColor(UIColor(hexCode: "A2A2A2"), for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
 
    override func viewDidLoad(){
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        priviousButton.addTarget(self, action: #selector(priviousMonth), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        
        let tapDayLabel = UITapGestureRecognizer(target: self, action: #selector(dayLabelTapped))
        dayLabel.addGestureRecognizer(tapDayLabel)
        
        addTodoButton.addTarget(self, action: #selector(addTodo), for: .touchUpInside)
        
        setUpViews()
        updateMonthLabel()
        updateDayLabel()
        getCategoryTodo()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCategoryTodo()
    }
    
    
    func setUpViews() {
        
//        [].forEach {
//            self.view.addSubview($0)
//        }
        
        self.view.addSubview(logoImage)
        logoImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        self.view.addSubview(menuButton)
        menuButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(80)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(13)
        }
        
        let monthView = monthContainer
        self.view.addSubview(monthView)
        monthView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        //    make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        monthView.addSubview(priviousButton)
        priviousButton.snp.makeConstraints{ make in
            make.leading.equalTo(monthView.snp.leading).offset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
        }
        
        monthView.addSubview(monthLabel)
        monthLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.leading.equalTo(priviousButton.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
        
        monthView.addSubview(nextButton)
        nextButton.snp.makeConstraints{ make in
            make.leading.equalTo(monthLabel.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
            make.width.equalTo(50)
        }
        
        
        self.view.addSubview(categoryView)
        self.categoryView.register(CategoryViewCell.self, forCellWithReuseIdentifier: CategoryViewCell.identifier)
        self.categoryView.register(AddCategoryCell.self, forCellWithReuseIdentifier: AddCategoryCell.identifier)
        self.categoryView.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
        //   make.top.equalTo(monthView.snp.bottom).offset(1)
            make.leading.equalTo(monthView.snp.trailing).offset(20)
            make.trailing.equalTo(view).offset(-5)
            make.height.equalTo(40)
        }
        self.categoryView.delegate = self
        self.categoryView.dataSource = self
        
        self.view.addSubview(dayLabel)
        self.dayLabel.snp.makeConstraints{ make in
            make.top.equalTo(categoryView.snp.bottom).offset(60)
            make.leading.equalTo(view).offset(20)
        }
        
        self.view.addSubview(todoView)
        self.todoView.register(TodoViewCell.self, forCellWithReuseIdentifier: TodoViewCell.identifier)
        self.todoView.snp.makeConstraints{ make in
            make.top.equalTo(dayLabel.snp.bottom).offset(10)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-20)
            make.height.equalTo(230)
        }
        self.todoView.delegate = self
        self.todoView.dataSource = self
        
        self.view.addSubview(addTodoButton)
        self.addTodoButton.snp.makeConstraints{ make in
            make.top.equalTo(todoView.snp.bottom).offset(20)
            make.leading.equalTo(view).offset(10)
            make.trailing.equalTo(view).offset(-10)
            make.height.equalTo(40)
        }
    }
    
    func updateMonthLabel(){
        monthLabel.text = "\(currentMonth)월"
    }
    
    func updateDayLabel() {
        dayLabel.text = "\(currentDay)일"
    }
    
    @objc func priviousMonth() {
        currentMonth -= 1
        if currentMonth < 1 {
            currentMonth = 12
        }
        updateMonthLabel()
        getCategoryTodo()
    }
    
    @objc func nextMonth() {
        currentMonth += 1
        if currentMonth > 12 {
            currentMonth = 1
        }
        updateMonthLabel()
        getCategoryTodo()
    }
    
    @objc func dayLabelTapped() {
        let datePicker = UIPickerView()
        datePicker.delegate = self
        datePicker.dataSource = self
        
        let alert = UIAlertController(title: "날짜 선택", message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
            alert.view.addSubview(datePicker)
            
        datePicker.snp.makeConstraints { make in
            make.centerX.equalTo(alert.view)
            make.top.equalTo(alert.view).offset(20)
        }
            
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
            let selectedDay = datePicker.selectedRow(inComponent: 0) + 1
            self.currentDay = selectedDay
            self.updateDayLabel()
            self.getCategoryTodo()
        }))
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func dateChanged(_ datePicker: UIDatePicker){
        let selectedDate = datePicker.date
        let calendar = Calendar.current
        currentDay = calendar.component(.day, from: selectedDate)
        updateDayLabel()
    }
    
    @objc func addTodo() {
        let TodoDetailVC = TodoDetailViewController()
        navigationController?.pushViewController(TodoDetailVC, animated: true)
    }
    
    
    func getCategoryTodo() {
        Task {
            do {
                let memberId = 1
                self.categories = try await FetchAPI.shared.getCategory(memberId: memberId)
                self.todos = try await FetchAPI.shared.getTodo(memberId: memberId)
                self.categoryView.reloadData()
                self.todoView.reloadData()
//                print(categories)
//                print(todos)
            }catch {
                print("Failed to Fetch API data: \(error)")
            }
        }
    }
}

extension TodoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 31
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)일 "
    }
}

extension TodoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryView {
            return categories.count + 1
        }
        else {
            return todos.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryView {
            if indexPath.item == categories.count {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCategoryCell.identifier, for: indexPath) as? AddCategoryCell else {
                    return UICollectionViewCell()
                }
                cell.addButton.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
                return cell
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryViewCell.identifier, for: indexPath) as? CategoryViewCell else {
                    return UICollectionViewCell()
                }
                cell.layer.cornerRadius = 10
                let category = categories[indexPath.item]
                cell.configure(with: category)
                return cell
            }
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodoViewCell.identifier, for: indexPath) as? TodoViewCell else {
                return UICollectionViewCell()
            }
            cell.layer.cornerRadius = 10
            let todo = todos[indexPath.item]
            cell.configure(with: todo)
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          if collectionView == categoryView {
              if indexPath.item == categories.count {
                  return CGSize(width: 40, height: 40)
              }
              else {
                  let category = categories[indexPath.item]
                  let width = category.content.size(withAttributes:[NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]).width
                  return CGSize(width: width + 20, height : 40 )
              }
          } else {
              return CGSize(width: collectionView.frame.width, height: 40) 
          }
      }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryView && indexPath.item < categories.count {
            let selectedCategory = categories[indexPath.item]
            let categoryVC = CategoryDetailViewController()
            categoryVC.selectedCategory = selectedCategory
            navigationController?.pushViewController(categoryVC, animated: true)
        }
        else {
            let selectedTodo = todos[indexPath.item]
            let todoDetailVC = TodoDetailViewController()
            todoDetailVC.selectedTodo = selectedTodo
            navigationController?.pushViewController(todoDetailVC, animated: true)
        }
    }
    
    @objc func addCategory(){
        let addCateVC = CategoryDetailViewController()
        navigationController?.pushViewController(addCateVC, animated: true)
    }
    
  
}
