//
//  LoginView.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 07/01/23.
//

import UIKit

/////////////////////// LOGIN VIEW PROTOCOL
protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
    
    func loginDataError(error: Error?)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// LOGIN  VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////

class LoginView: UIViewController {
    
    private lazy var imgLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = ImageCatalog.logo
        return image
    }()
    
    private lazy var lblHiMessage: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = ColorCatalog.dark
        lbl.text = Content.hiMessage
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        return lbl
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 15
        return stack
    }()
    private lazy var txtEmail: CustomTextField = {
        let txt = CustomTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholderText = Content.email
        txt.delegate = self
        return txt
    }()
    
    private lazy var txtPassword: CustomTextField = {
        let txt = CustomTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholderText = Content.password
        txt.isSecureTextEntry = true
        txt.delegate = self
        return txt
    }()
    
    private lazy var lblEmailError: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .red
        lbl.text = Content.required
        lbl.isHidden = true
        return lbl
    }()
    
    private lazy var lblPasswordError: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .red
        lbl.text = Content.required
        lbl.isHidden = true
        return lbl
    }()
    
    private lazy var btnLogin: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Content.logIn, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.backgroundColor = ColorCatalog.principal.cgColor
        btn.layer.cornerRadius = 2
        btn.addTarget(self, action: #selector(tappedAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var lblNew: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = ColorCatalog.dark
        lbl.numberOfLines = 1
        lbl.text = Content.new
        return lbl
    }()
    
    private lazy var btnSignUp: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Content.signUp, for: .normal)
        btn.setTitleColor(ColorCatalog.principal, for: .normal)
        btn.addTarget(self, action: #selector(tappedSignUp), for: .touchUpInside)
        return btn
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    
    var presenter: LoginPresenterProtocol?

    private var emailValue: String?
    private var passwordValue: String?
    private var constraintsArray: [NSLayoutConstraint] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ColorCatalog.background
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLayoutSubviews() {
        txtEmail.addLineLayer()
        txtPassword.addLineLayer()
    }
}

private extension LoginView {
    
    func setupView() {
        
        stackView.addArrangedSubview(lblEmailError)
        stackView.addArrangedSubview(txtEmail)
        stackView.addArrangedSubview(lblPasswordError)
        stackView.addArrangedSubview(txtPassword)
        
        bottomStackView.addArrangedSubview(lblNew)
        bottomStackView.addArrangedSubview(btnSignUp)
        
        view.addSubview(imgLogo)
        view.addSubview(lblHiMessage)
        view.addSubview(stackView)
        view.addSubview(btnLogin)
        view.addSubview(bottomStackView)
        
        setConstraints()
        
    }
    
    func setConstraints() {
        
        constraintsArray = [
            imgLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            imgLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgLogo.widthAnchor.constraint(equalToConstant: 100),
            imgLogo.heightAnchor.constraint(equalToConstant: 100),
            
            lblHiMessage.topAnchor.constraint(equalTo: imgLogo.bottomAnchor, constant: 20),
            lblHiMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            lblHiMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            stackView.topAnchor.constraint(equalTo: lblHiMessage.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            btnLogin.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            btnLogin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            btnLogin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            btnLogin.heightAnchor.constraint(equalToConstant: 55),
            
            bottomStackView.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 25),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraintsArray)
    }
    
    @objc func tappedAction() {
        if let input = isInputValid(),
            input.0 {
            DispatchQueue.main.async {
                self.btnLogin.isEnabled = false
                self.txtPassword.resignFirstResponder()
            }
            showIndicator()
            presenter?.tapToLogin(input: (input.1, input.2))
        }
    }
    
    @objc func tappedSignUp() {
        presenter?.tapToRegister()
    }
    
    func isInputValid() -> (Bool, String, String)? {
        guard let emailValue = emailValue,
              !emailValue.isEmpty else {
            lblEmailError.isHidden = false
            return nil
        }
        
        guard let passwordValue = passwordValue,
              !passwordValue.isEmpty else {
            lblPasswordError.isHidden = false
            return nil
        }
        
        return (true, emailValue, passwordValue)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func presentAlert(_ title: String, message: String) {
        self.openAlert(title: title,
                       message: message,
                       alertStyle: .alert,
                       actionTitles: [Content.alert.okMessage],
                       actionStyles: [.default],
                       actions: [ {_ in
            print(Content.alert.okMessage)
        },])
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtEmail:
            txtPassword.becomeFirstResponder()
        default:
            txtPassword.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        switch textField {
        case txtEmail:
            lblEmailError.isHidden = !text.isEmpty
            emailValue = text
        case txtPassword:
            lblPasswordError.isHidden = !text.isEmpty
            passwordValue = text
        default:
            break
        }
    }
}

extension LoginView: LoginViewProtocol {
    
    func loginDataError(error: Error?) {
        hideIndicator()
        guard let error = error else {
            return
        }
        DispatchQueue.main.async {
            self.btnLogin.isEnabled = true
            self.presentAlert(Content.errorMessage, message: error.localizedDescription)
        }
        
    }
}
