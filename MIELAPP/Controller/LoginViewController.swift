import UIKit
import OpenAPIClient
import AnyCodable

final class LoginViewController: UIViewController {
    var completion: (() -> Void)?
    
    // --- UI ---
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "logo1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро пожаловать!"
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Логин"
        field.autocapitalizationType = .none
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Пароль"
        field.isSecureTextEntry = true
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1).cgColor
        return button
    }()
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    private let agreementLabel: UILabel = {
        let label = UILabel()
        label.text = "Выполняя вход, вы соглашаетесь с Условиями и Политикой конфиденциальности"
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
#if DEBUG
        usernameField.text = "supervisor"
        passwordField.text = "supervisor"
#endif
        setupLayout()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(containerView)
        view.addSubview(agreementLabel)
        containerView.addSubview(usernameField)
        containerView.addSubview(passwordField)
        containerView.addSubview(loginButton)
        containerView.addSubview(errorLabel)
        containerView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 138),
            logoImageView.heightAnchor.constraint(equalToConstant: 138),
            
            welcomeLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            containerView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 32),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 328),
            containerView.heightAnchor.constraint(equalToConstant: 236),
            
            usernameField.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            usernameField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            usernameField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            usernameField.heightAnchor.constraint(equalToConstant: 44),
            
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: usernameField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: usernameField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 44),
            
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8),
            errorLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            errorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 10),
            
            agreementLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 24),
            agreementLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            agreementLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func loginButtonTapped() {
        view.endEditing(true)
        errorLabel.isHidden = true
        activityIndicator.startAnimating()
        loginButton.isEnabled = false

        let body: [String: String] = [
            "username": usernameField.text ?? "",
            "password": passwordField.text ?? ""
        ]

        let anyBody = AnyCodable(body)
        ApiAPI.apiLoginCreate(body: anyBody) { [weak self] data, error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.loginButton.isEnabled = true

                if let error = error {
                    self?.errorLabel.text = "Ошибка входа: \(error.localizedDescription)"
                    self?.errorLabel.isHidden = false
                    return
                }
                
                guard
                    let dict = data?.value as? [String: Any],
                    let token = dict["token"] as? String
                else {
                    self?.errorLabel.text = "Не удалось получить токен"
                    self?.errorLabel.isHidden = false
                    return
                }

                // Сохраняем токен
                UserDefaults.standard.set(token, forKey: "authToken")
                OpenAPIClientAPI.customHeaders["Authorization"] = "Token \(token)"
                print("Токен сохранён: \(token)")

                // Переход на Greeting
                if let window = UIApplication.shared.connectedScenes
                    .compactMap({ $0 as? UIWindowScene })
                    .flatMap({ $0.windows })
                    .first(where: { $0.isKeyWindow }) {

                    let greetingVC = GreetingViewController()
                    greetingVC.completion = {
                        print("SceneDelegate: Показываю MainTabBarController")
                        let mainTabBar = MainTabBarController()
                        window.setRootViewController(mainTabBar)
                    }
                    window.setRootViewController(greetingVC)
                }
            }
        }
    }
}
