//
//  RegisterView.swift
//  UpaxTest
//
//  Created by Aldair Carrillo on 08/01/23.
//

import UIKit

/////////////////////// REGISTER VIEW PROTOCOL
protocol RegisterViewProtocol: AnyObject {
    var presenter: RegisterPresenterProtocol? { get set }
    
    func registerDataError(error: Error?)
}

////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////// REGISTER  VIEW
///////////////////////////////////////////////////////////////////////////////////////////////////

class RegisterView: UIViewController {
    
    private lazy var imgLogo: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = ImageCatalog.placeholderUser
        image.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedTakePicture))
        image.addGestureRecognizer(tapGestureRecognizer)
        return image
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
    
    private lazy var txtUser: CustomTextField = {
        let txt = CustomTextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholderText = Content.user
        txt.delegate = self
        return txt
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
    
    private lazy var lblUserError: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .red
        lbl.text = Content.required
        lbl.isHidden = true
        return lbl
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
    
    private lazy var btnRegister: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Content.signUp, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.backgroundColor = ColorCatalog.principal.cgColor
        btn.layer.cornerRadius = 2
        btn.addTarget(self, action: #selector(tappedAction), for: .touchUpInside)
        return btn
    }()
    
    private lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    var presenter: RegisterPresenterProtocol?

    private var userValue: String?
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
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = nil
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }

    override func viewDidLayoutSubviews() {
        txtUser.addLineLayer()
        txtEmail.addLineLayer()
        txtPassword.addLineLayer()
        imgLogo.layer.cornerRadius = imgLogo.frame.size.width / 2
    }
}

private extension RegisterView {
    
    func setupView() {
        
        stackView.addArrangedSubview(lblUserError)
        stackView.addArrangedSubview(txtUser)
        stackView.addArrangedSubview(lblEmailError)
        stackView.addArrangedSubview(txtEmail)
        stackView.addArrangedSubview(lblPasswordError)
        stackView.addArrangedSubview(txtPassword)
        
        view.addSubview(imgLogo)
        view.addSubview(stackView)
        view.addSubview(btnRegister)
        
        setConstraints()
        
    }
    
    func setConstraints() {
        
        constraintsArray = [
            imgLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            imgLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgLogo.widthAnchor.constraint(equalToConstant: 100),
            imgLogo.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: imgLogo.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            btnRegister.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            btnRegister.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            btnRegister.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            btnRegister.heightAnchor.constraint(equalToConstant: 55)
            
        ]
        
        NSLayoutConstraint.activate(constraintsArray)
    }
    
    @objc func tappedAction() {
        if let input = isInputValid(),
            input.0 {
            DispatchQueue.main.async {
                self.btnRegister.isEnabled = false
                self.txtPassword.resignFirstResponder()
            }
            presenter?.tapToRegister(input: (input.1, input.2, input.3, imgLogo.image?.pngData()))
        }
    }
    
    @objc func tappedTakePicture() {
        imagePicker.cameraAsscessRequest()
    }
    
    func isInputValid() -> (Bool, String, String, String)? {
        
        guard let userValue = userValue,
              !userValue.isEmpty else {
            lblUserError.isHidden = false
            return nil
        }
        
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
        
        return (true, userValue, emailValue, passwordValue)
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

extension RegisterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtUser:
            txtEmail.becomeFirstResponder()
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
        case txtUser:
            lblUserError.isHidden = !text.isEmpty
            userValue = text
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

extension RegisterView: RegisterViewProtocol {
    
    func registerDataError(error: Error?) {
        guard let error = error else {
            return
        }
        DispatchQueue.main.async {
            self.btnRegister.isEnabled = true
            self.presentAlert(Content.errorMessage, message: error.localizedDescription)
        }
    }
    
}

// MARK: ImagePickerDelegate

extension RegisterView: ImagePickerDelegate {

    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        imgLogo.image = image
        imagePicker.dismiss()
    }

    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}
