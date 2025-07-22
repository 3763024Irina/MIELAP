import UIKit
import OpenAPIClient
import AnyCodable
final class FavoritesViewController: UIViewController, UITableViewDelegate {
    private let headerView = SupervisorHeaderView()
    private let tableView = UITableView()
    private var favorites: [Favorite] = []
    private let sectionHeaderContainer = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
     //   title = "Избранное"
        setupUI()
        setupHeaderCallbacks()
        SupervisorHelper.fetch(headerView: headerView) // <-- загрузка данных супервайзера из API
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavorites()
    }

    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        sectionHeaderContainer.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CandidateCell.self, forCellReuseIdentifier: CandidateCell.reuseId)
        tableView.separatorStyle = .none

        view.addSubview(headerView)
        view.addSubview(sectionHeaderContainer)
        view.addSubview(tableView)

        // --- Заголовок "Избранные" + "Запросить квоты" ---
        sectionHeaderContainer.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.text = "Избранные"
        if let ptSansBold = UIFont(name: "PTSans-Bold", size: 20) {
            titleLabel.font = ptSansBold
        } else {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        }
        titleLabel.textColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1)
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .left
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let requestQuotaButton = UIButton(type: .system)
        requestQuotaButton.setTitle("Запросить квоты", for: .normal)
        if let ptSansFont = UIFont(name: "PTSans-Regular", size: 12) {
            requestQuotaButton.titleLabel?.font = ptSansFont
        }
        requestQuotaButton.setTitleColor(.black, for: .normal)
        requestQuotaButton.backgroundColor = UIColor.white
        requestQuotaButton.layer.cornerRadius = 8
        requestQuotaButton.contentEdgeInsets = UIEdgeInsets(top: 3, left: 18, bottom: 3, right: 18)
        requestQuotaButton.layer.borderWidth = 1
        requestQuotaButton.layer.borderColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1).cgColor
        requestQuotaButton.translatesAutoresizingMaskIntoConstraints = false
        requestQuotaButton.addTarget(self, action: #selector(showQuotasScreen), for: .touchUpInside)

        let rowStack = UIStackView(arrangedSubviews: [titleLabel, UIView(), requestQuotaButton])
        rowStack.axis = .horizontal
        rowStack.alignment = .center
        rowStack.spacing = 8
        rowStack.translatesAutoresizingMaskIntoConstraints = false

        sectionHeaderContainer.addSubview(rowStack)
        NSLayoutConstraint.activate([
            rowStack.topAnchor.constraint(equalTo: sectionHeaderContainer.topAnchor, constant: 8),
            rowStack.bottomAnchor.constraint(equalTo: sectionHeaderContainer.bottomAnchor, constant: -8),
            rowStack.leadingAnchor.constraint(equalTo: sectionHeaderContainer.leadingAnchor, constant: 16),
            rowStack.trailingAnchor.constraint(equalTo: sectionHeaderContainer.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            sectionHeaderContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            sectionHeaderContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sectionHeaderContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sectionHeaderContainer.heightAnchor.constraint(equalToConstant: 48),

            tableView.topAnchor.constraint(equalTo: sectionHeaderContainer.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func setupHeaderCallbacks() {
        headerView.onNotifications = { [weak self] in
            print("Уведомления нажаты")
        }
        headerView.onLogout = { [weak self] in
            UserDefaults.standard.removeObject(forKey: "authToken")
            OpenAPIClientAPI.customHeaders["Authorization"] = nil
            self?.showLoginScreen()
        }
    }

    private func showLoginScreen() {
        guard let window = UIApplication.shared.windows.first else { return }
        let loginVC = LoginViewController()
        window.rootViewController = UINavigationController(rootViewController: loginVC)
        window.makeKeyAndVisible()
    }

    private func fetchFavorites() {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }
        let url = URL(string: OpenAPIClientAPI.basePath + "/api/supervisor/favorites/")!
        var req = URLRequest(url: url)
        req.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: req) { data, res, err in
            DispatchQueue.main.async {
                if let err = err { print("Ошибка загрузки избранного:", err); return }
                guard let data = data else { print("Нет данных"); return }
                do {
                    let decoder = JSONDecoder.mielDecoder()
                    let favs = try decoder.decode([Favorite].self, from: data)
                    self.favorites = favs
                    self.tableView.reloadData()
                } catch {
                    print("Ошибка декодирования избранного:", error)
                }
            }
        }.resume()
    }
    func addCandidateToFavorites(candidateId: Int, completion: @escaping (Bool, String?) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            completion(false, "Нет токена авторизации")
            return
        }
        let url = URL(string: "https://miel.sayrrx.cfd/api/supervisor/favorites/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        let body: [String: Any] = ["candidate": candidateId]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(false, "Ошибка сети: \(error.localizedDescription)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(false, "Нет ответа сервера")
                    return
                }
                if httpResponse.statusCode == 201 {
                    completion(true, nil) // успех
                } else if let data = data, let respStr = String(data: data, encoding: .utf8) {
                    completion(false, "Ошибка \(httpResponse.statusCode): \(respStr)")
                } else {
                    completion(false, "Неизвестная ошибка сервера (\(httpResponse.statusCode))")
                }
            }
        }
        task.resume()
    }

    private func removeFromFavorites(favoriteId: Int, at index: Int) {
        ApiAPI.apiSupervisorFavoritesDestroy(id: String(favoriteId)) { [weak self] _, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if error == nil {
                    self.favorites.remove(at: index)
                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                } else {
                    print("Ошибка удаления из избранного:", error?.localizedDescription ?? "Unknown error")
                }
            }
        }
    }

    @objc private func showQuotasScreen() {
        // Ваш код перехода на экран "Квоты"
        print("Открыть экран квот")
    }


    private func showInvitationsScreen() {
        // TODO: здесь сделать переход на экран "Приглашения" или вызвать нужный API
        print("Открыть экран приглашений")
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fav = favorites[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CandidateCell.reuseId, for: indexPath) as! CandidateCell

        let info = fav.candidateInfo
        cell.configure(with: info)
        cell.heartButton.isSelected = true
        cell.heartButton.isUserInteractionEnabled = true
        cell.favoriteDelegate = self

        return cell
    }
}

// MARK: - FavoriteCellDelegate
extension FavoritesViewController: FavoriteCellDelegate {
    func candidateCell(_ cell: CandidateCell, didToggleFavorite isFavorite: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let fav = favorites[indexPath.row]
        let favoriteId = fav.id

        if !isFavorite {
            removeFromFavorites(favoriteId: favoriteId, at: indexPath.row)
        }
    }
}

extension JSONDecoder {
    static func mielDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            let formats = [
                "dd.MM.yyyy",
                "yyyy-MM-dd",
                "yyyy-MM-dd'T'HH:mm:ssZ",
                "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                "yyyy-MM-dd'T'HH:mm:ss.SSSSSS",
                "yyyy-MM-dd'T'HH:mm:ss.SSS",
                "yyyy-MM-dd'T'HH:mm:ss"
            ]
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            for format in formats {
                formatter.dateFormat = format
                if let date = formatter.date(from: dateStr) {
                    return date
                }
            }
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Неверный формат даты: \(dateStr)"
            )
        }
        return decoder
    }
}

