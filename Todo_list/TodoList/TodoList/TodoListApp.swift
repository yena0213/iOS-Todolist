//
//  TodoListApp.swift
//  TodoList
//
//  Created by 이예나 on 5/28/24.
//

import UIKit

class TodoListApp: UIViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
            makeUI()  // 코드로 작성한 UI 실행
        }
    
    // main화면 중앙 사진 랜덤 구현 - 배열과 랜덤한 인덱스 사용
    private var mainImage: UIImageView = {
        let image = UIImageView()
        let imageNames = ["Main1", "Main2", "Main3"]
        let randomIndex = Int.random(in: 0..<imageNames.count)
        let selectedImageName = imageNames[randomIndex]
        image.image = UIImage(named: selectedImageName)
        return image
    }()
    
    // 하단에 로그인 버튼 구현
    lazy var loginButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)
        button.backgroundColor = UIColor(hex:"#4260FF")
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.isEnabled = false       // 버튼의 동작 설정 (처음에는 동작 off)
        return button
    }()
    
    // 하단에 회원가입 버튼 구현
    lazy var signupButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(UIColor(hex: "#4260FF"), for: .normal)
        button.backgroundColor = .clear // 버튼 배경색: 투명
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1   // 버튼의 테두리 두께
        button.layer.borderColor = UIColor(hex: "#4260FF").cgColor
 // 버튼의 테두리 색 설정
        button.isEnabled = false // 버튼의 동작 설정 (처음에는 동작 off)
        return button
    }()
    
    
    // 사진&로그인버튼 & 회원가입 버튼을 스택뷰로 묶기
    lazy var stackView: UIStackView = {
            // 배열을 사용하여 각각의 객체를 하나로 묶는 코드
            let stView = UIStackView(arrangedSubviews: [mainImage, loginButton, signupButton])
           
            stView.spacing = 18      // 객체의 내부 간격 설정
            stView.axis = .vertical  // 세로 묶음으로 정렬 (가로 묶음은 horizontal)
            stView.distribution = .fillEqually  // 각 객체의 크기(간격) 분배 설정 (fillEqually: 여기서는 동일하게 분배)
            stView.alignment = .fill  // 정렬 설정 (fill: 전부 채우는 설정)
            return stView
        }()
       

    // + 각 텍스트필드 및 로그인 버튼의 높이 설정
    private let textViewHeight: CGFloat = 27
    
    func makeUI(){
            view.backgroundColor = .white  // 메인 뷰 객체의 배경색을 변경
           
            // 메인 뷰 객체(ViewController)에 stackView, passWordResetButton, mainLoginImage 객체 올리기
            view.addSubview(stackView)
            view.addSubview(passWordResetButton)
            view.addSubview(mainLoginImage)
           
            // 사용자가 코드로 정의한 Auto Layout 기능 활성화
            mainLoginImage.translatesAutoresizingMaskIntoConstraints = false
            emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
            emailTextField.translatesAutoresizingMaskIntoConstraints = false
            passWordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
            passWordTextField.translatesAutoresizingMaskIntoConstraints = false
            passWordSecureButton.translatesAutoresizingMaskIntoConstraints = false
            stackView.translatesAutoresizingMaskIntoConstraints = false
            passWordResetButton.translatesAutoresizingMaskIntoConstraints = false
           
            // NSLayoutConstraint.activate([뷰 객체의 위치 및 크기])배열 안에 뷰 객체의 위치와 크기를 설정
            NSLayoutConstraint.activate([
            // 로그인 화면 상단 이미지 위치 및 크기 설정
                mainLoginImage.heightAnchor.constraint(equalToConstant: 200),
                mainLoginImage.widthAnchor.constraint(equalToConstant: 200),
                mainLoginImage.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -30),
                mainLoginImage.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
               
            // 이메일 안내 문구 위치 설정
                emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
                emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
                emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor),
               
            // 이메일 텍스트 필드 위치 설정
                emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
                emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: 8),
                emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
                emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: 2),

            // 비밀번호 안내 문구 위치 설정
                passWordInfoLabel.leadingAnchor.constraint(equalTo: passWordTextFieldView.leadingAnchor, constant: 8),
                passWordInfoLabel.trailingAnchor.constraint(equalTo: passWordTextFieldView.trailingAnchor, constant: 8),
                passWordInfoLabel.centerYAnchor.constraint(equalTo: passWordTextFieldView.centerYAnchor),
               
            // 비밀번호 텍스트 필드 위치 설정
                passWordTextField.leadingAnchor.constraint(equalTo: passWordTextFieldView.leadingAnchor, constant: 8),
                passWordTextField.trailingAnchor.constraint(equalTo: passWordTextFieldView.trailingAnchor, constant: 8),
                passWordTextField.topAnchor.constraint(equalTo: passWordTextFieldView.topAnchor, constant: 15),
                passWordTextField.bottomAnchor.constraint(equalTo: passWordTextFieldView.bottomAnchor, constant: 2),
               
            // 비밀번호 재설정 위치 설정
                passWordSecureButton.topAnchor.constraint(equalTo: passWordTextFieldView.topAnchor, constant: 15),
                passWordSecureButton.bottomAnchor.constraint(equalTo: passWordTextFieldView.bottomAnchor, constant: -15),
                passWordSecureButton.trailingAnchor.constraint(equalTo: passWordTextFieldView.trailingAnchor, constant: -8),
               
            // 하나로 묶은 스택 뷰 위치 및 높이 설정
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36),  //stackView의 높이 설정
               
            // 비밀번호 재설정 위치 및 높이 설정
                passWordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
                passWordResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                passWordResetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                passWordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight)  //비밀번호 재설정 버튼 높이 설정
            ])
        }
}


extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1)
     }
}

