import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "로그인"
        
        setUpviews()
        updateLoginButtonState()
    }
    
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("아이디", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pwLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("비밀번호", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(hexCode: "#F5F5F5")
        textField.placeholder =  " 아이디를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .none
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
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
    
    lazy var pwTextField: UITextField = {
        let textField = UITextField() //정의
        textField.backgroundColor = UIColor.grayBackgroud
        textField.placeholder =  " 비밀번호를 입력해주세요"
        textField.font = UIFont.systemFont(ofSize: 14) // 글자 크기
        textField.borderStyle = .none // 테두리 없음
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
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
    
    @objc func togglePasswordVisibility(_ sender: UITapGestureRecognizer) {
        pwTextField.isSecureTextEntry.toggle()
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor(hexCode: "#F2F4FF")
        textField.layer.borderColor = UIColor.MainBackground.cgColor
        textField.layer.borderWidth = 1.0
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.grayBackgroud
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0.0
    }
    
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle( "로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.MainBackground
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    func setUpviews() {
        
        self.view.addSubview(idLabel)
        self.view.addSubview(idTextField)
        self.view.addSubview(pwLabel)
        self.view.addSubview(pwTextField)
        self.view.addSubview(loginButton)
        
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.leading.equalTo(view).offset(30)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idLabel.snp.bottom).offset(8)
            make.leading.equalTo(idLabel)
            make.trailing.equalTo(view).offset(-30)
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
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            make.height.equalTo(50)
        }
    }
    
    
    @objc private func loginButtonTapped() {
        guard let setUserId = idTextField.text,
                let setUserPw = pwTextField.text
        else {
            let alert = UIAlertController(title: "Error", message: "양식을 채워주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return}
        
        
        Task {
            do {
                let newLogin = SignIn(userId: setUserId, userPw: setUserPw)
                
                let permitLogin = try await FetchAPI.shared.signIn(data: newLogin)
                print("Permit Login: \(permitLogin)")
                
                let todoVC = TodoViewController(memberId: permitLogin.memberId)
                navigationController?.pushViewController(todoVC, animated: true)
                
            } catch {
                let alert = UIAlertController(title: "Error", message: "로그인에 실패하였습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                print("Failed to SignIn: \(error)")
            }
        }
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
        func areFieldsFilled() -> Bool {
            return !(idTextField.text?.isEmpty ?? true) && !(pwTextField.text?.isEmpty ?? true)
        }
        
        // 로그인 버튼의 상태를 업데이트하는 함수
        func updateLoginButtonState() {
            if areFieldsFilled() {
                loginButton.backgroundColor = UIColor.MainBackground
                loginButton.isEnabled = true
            } else {
                loginButton.backgroundColor = UIColor(hexCode: "#C1C1C1")
                loginButton.isEnabled = false
            }
        }
        
        // 텍스트 필드의 편집이 변경될 때마다 로그인 버튼 상태를 업데이트
        func textFieldDidChangeSelection(_ textField: UITextField) {
            updateLoginButtonState()
        }
    }

