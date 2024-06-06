import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()  // 코드로 작성한 UI 실행
    }
    
    // main화면 중앙 사진 랜덤 구현 - 배열과 랜덤한 인덱스 사용
    private var mainImage: UIImageView = {
        let image = UIImageView()
        let imageNames = ["Main1", "Main2", "Main3"]
        let randomIndex = Int.random(in: 0..<imageNames.count) //index count range
        let selectedImageName = imageNames[randomIndex] //select image
        image.image = UIImage(named: selectedImageName)
        image.contentMode = .scaleAspectFit  // 이미지가 올바르게 스케일링 되도록 설정
        return image
    }()
    
    // todoList 로고 구현 - 배열과 랜덤한 인덱스 사용
    private let logoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        button.isEnabled = true // 버튼의 동작 설정 (처음에 동작 on)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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
        button.isEnabled = true // 버튼의 동작 설정 (처음에 동작 on)
        return button
    }()
    
    // 사진&로그인버튼 & 회원가입 버튼을 스택뷰로 묶기
    lazy var stackView: UIStackView = {
        // 배열을 사용하여 각각의 객체를 하나로 묶는 코드
        let stView = UIStackView(arrangedSubviews: [mainImage, logoImage, loginButton, signupButton])
        
        stView.spacing = 20    // 객체의 내부 간격 설정
        stView.axis = .vertical  // 세로 묶음으로 정렬 (가로 묶음은 horizontal)
        stView.distribution = .fillProportionally  // 각 객체의 크기(간격) 분배 설정 (fillEqually: 여기서는 동일하게 분배)
        stView.alignment = .fill  // 정렬 설정 (fill: 전부 채우는 설정)
        return stView
    }()
    
    // + 각 텍스트필드 및 로그인 버튼의 높이 설정
    private let textViewHeight: CGFloat = 27
    
    func makeUI() {
        view.backgroundColor = .white  // 메인 뷰 객체의 배경색을 변경
        
        // 스택 뷰 객체를 메인 뷰 객체(ViewController)에 추가
        view.addSubview(stackView)
        
        // 스택 뷰의 Auto Layout 활성화
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // 스택 뷰의 위치 및 크기 설정
        // snapkit 라이브러리 다운받아서 하면 더 편해!!
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        ])
        
        // mainImage의 높이와 너비 제약 조건 설정 (스택 뷰 내부에서 관리됨)
        mainImage.heightAnchor.constraint(equalToConstant: 230).isActive = true
        mainImage.widthAnchor.constraint(equalToConstant: 230).isActive = true
        
        // logoImage의 높이와 너비 제약 조건 설정 (스택 뷰 내부에서 관리됨)
        logoImage.heightAnchor.constraint(equalToConstant: 64).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 261).isActive = true
        
        // 로그인 버튼과 회원가입 버튼의 높이 및 너비 설정
        loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        // 로그인 버튼과 회원가입 버튼의 너비 제약 조건은 스택 뷰에 추가하는 대신, 버튼 자체에 직접 추가합니다.
        loginButton.widthAnchor.constraint(equalToConstant: 326).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: 326).isActive = true
    }
    
    @objc private func loginButtonTapped() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
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
