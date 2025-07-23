import UIKit
import OpenAPIClient
import AnyCodable

final class GreetingViewController: UIViewController {
    var completion: (() -> Void)?
    
    private let logoImageView = UIImageView()
    private let greetingLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print("GreetingViewController открыт")
        
        logoImageView.image = UIImage(named: "logo1")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        greetingLabel.font = .systemFont(ofSize: 24, weight: .bold)
        greetingLabel.textAlignment = .center
        greetingLabel.numberOfLines = 0
        greetingLabel.text = ""
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(greetingLabel)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 170),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            greetingLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            greetingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            greetingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 32)
        ])
        
        activityIndicator.startAnimating()
        fetchUserName()
    }

    private func fetchUserName() {
        // Проверяем, есть ли сохранённый токен
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            print("Нет сохранённого токена — нужно авторизоваться")
            greetingLabel.text = "Не авторизован"
            fireCompletionWithDelay()
            return
        }

        // Устанавливаем заголовок авторизации
        OpenAPIClientAPI.customHeaders["Authorization"] = "Token \(token)"

        // Запрашиваем информацию о пользователе
        ApiAPI.apiInfoRetrieve { [weak self] data, error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                
                // Обработка ошибки
                if let error = error {
                    print("API ERROR:", error)
                    self?.greetingLabel.text = "Ошибка авторизации"
                    self?.fireCompletionWithDelay()
                    return
                }
                
                // Парсим данные
                guard
                    let data = data,
                    let array = data.value as? [[String: Any]],
                    let dict = array.first
                else {
                    print("API: data is nil или не массив словарей, data =", data?.value ?? "nil")
                    self?.greetingLabel.text = "Не удалось получить имя"
                    self?.fireCompletionWithDelay()
                    return
                }

                // Показываем имя
                let name = dict["full_name"] as? String
                self?.greetingLabel.text = name != nil ? "Добро пожаловать, \(name!)!" : "Не удалось получить имя"
                self?.fireCompletionWithDelay()
            }
        }
    }

    private func fireCompletionWithDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            print("GreetingViewController: вызываю completion")
            self?.completion?()
        }
    }
}
