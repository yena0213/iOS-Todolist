//
//  SignupViewController.swift
//  Todo_list
//
//  Created by 이예나 on 5/28/24.
//ㄴ
import UIKit
import SnapKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    
   private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        return label
    }()
    
    private lazy var pwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        return label
    }()
    
    private lazy var checkPwLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.grayBackgroud
        textField.placeholder = " 아이디를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        let imageView = UIImageView(image: UIImage(named: "user"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        paddingView.addSubview(imageView)
                    
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    
    private lazy var pwTextField: UITextField = {
        let textField = UITextField() //정의
        textField.backgroundColor = UIColor.grayBackgroud
        textField.placeholder =  " 비밀번호를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 14) // 글자 크기
        textField.borderStyle = .none // 테두리 없음
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true // 초기에는 암호화 처리

        textField.delegate = self
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
    
        // 따로
        let leftpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        let lockImage = UIImageView(image: UIImage(named: "Lock"))
        lockImage.contentMode = .scaleAspectFit
        lockImage.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        leftpaddingView.addSubview(lockImage)
                    
        textField.leftView = leftpaddingView
        textField.leftViewMode = .always
        
        let rightpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        let eyeImage = UIImageView(image: UIImage(named: "Eye"))
        eyeImage.contentMode = .scaleAspectFit
        eyeImage.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        eyeImage.isUserInteractionEnabled = true // 이미지에 터치 이벤트 허용
        eyeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility(_:))))

        rightpaddingView.addSubview(eyeImage)
                    
        textField.rightView = rightpaddingView
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private lazy var checkpwTextField: UITextField = {
        let textField = UITextField() //정의
        textField.backgroundColor = UIColor.grayBackgroud
        textField.placeholder = " 비밀번호를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 14) // 글자 크기
        textField.borderStyle = .none // 테두리 없음
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true // 초기에는 암호화 처리

        textField.delegate = self
        
        textField.addTarget(self, action: #selector(textFieldDidBeginEditing(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldDidEndEditing(_:)), for: .editingDidEnd)
        
        let leftpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        let lockImage = UIImageView(image: UIImage(named: "Lock"))
        lockImage.contentMode = .scaleAspectFit
        lockImage.frame = CGRect(x: 10, y: 0, width: 20, height: 20)
        leftpaddingView.addSubview(lockImage)
                    
        textField.leftView = leftpaddingView
        textField.leftViewMode = .always
        
        let rightpaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        let eyeImage = UIImageView(image: UIImage(named: "Eye"))
        eyeImage.contentMode = .scaleAspectFit
        eyeImage.frame = CGRect(x: -10, y: 0, width: 20, height: 20)
        eyeImage.isUserInteractionEnabled = true // 이미지에 터치 이벤트 허용
        eyeImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(togglePasswordVisibility(_:))))

        rightpaddingView.addSubview(eyeImage)
                    
        textField.rightView = rightpaddingView
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle(NSLocalizedString("회원가입", comment: ""), for: .normal) //로그인 버튼 이름
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.MainBackground
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "회원가입"
     
        self.view.backgroundColor = .white
        
        setupViews()
        updateLoginButtonState()
    }
    
    
    @objc func togglePasswordVisibility(_ sender: UITapGestureRecognizer) {
        pwTextField.isSecureTextEntry.toggle()
    }
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor(hexCode: "F2F4FF")
        textField.layer.borderColor = UIColor.MainBackground.cgColor
        textField.layer.borderWidth = 1.0
    }

    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor(hexCode: "F5F5F5")
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0.0
    }

    private func setupViews() {
        self.view.addSubview(idLabel)
        self.view.addSubview(idTextField)
        self.view.addSubview(pwLabel)
        self.view.addSubview(pwTextField)
        self.view.addSubview(loginButton)
        
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalToSuperview().offset(30)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(8)
            make.leading.equalTo(idLabel)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(40)
        }
        
        pwLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(20)
            make.leading.equalTo(idLabel)
        }
        
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(pwLabel.snp.bottom).offset(8)
            make.leading.equalTo(pwLabel)
            make.trailing.equalTo(idTextField)
            make.height.equalTo(40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(pwTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
    }
    
    @objc private func loginButtonTapped() {
        // Implement your login logic here
        print("로그인 버튼 탭됨")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idTextField {
            pwTextField.becomeFirstResponder()
        } else if textField == pwTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    // 모든 필드가 채워져 있는지 확인하는 함수
        private func areFieldsFilled() -> Bool {
            return !(idTextField.text?.isEmpty ?? true) && !(pwTextField.text?.isEmpty ?? true)
        }
        
        // 로그인 버튼의 상태를 업데이트하는 함수
        private func updateLoginButtonState() {
            if areFieldsFilled() {
                loginButton.backgroundColor = UIColor(hexCode: "4260FF")
                loginButton.isEnabled = true
            } else {
                loginButton.backgroundColor = UIColor(hexCode: "C1C1C1")
                loginButton.isEnabled = false
            }
        }
        
    // 텍스트 필드의 편집이 변경될 때마다 로그인 버튼 상태를 업데이트
        func textFieldDidChangeSelection(_ textField: UITextField) {
            updateLoginButtonState()
        }
}
