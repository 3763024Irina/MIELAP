import UIKit
import OpenAPIClient
import AnyCodable
    struct RawCandidate: Decodable {
    let id: Int
    let name: String
    let surname: String
    let patronymic: String?
    let birth: String?        // <-- Исправлено!
    let age: Int
    let education: String?
    let photo: String?
    let country: String?
    let city: String?
    let resume: String?
    let courses: [Course]
    let updated_at: String?
    let is_favorite: Bool?
    let favorite_id: Int?      // <-- опционально!
    let is_invited: Bool?
    let achivment_objects: Int?
    let achivment_clients: Int?
    let achivment_leads: Int?
    let achivment_exclusives: Int?
    let achivment_deals: Int?
}
final class CandidatesViewController: UIViewController {
   
    private let headerView = SupervisorHeaderView()
    private let tableView = UITableView()
    private var candidates: [CandidateInfo] = []
    private let chatButton = UIButton(type: .system)
    private var isSortedAlphabetically = false
    private let filterButton = UIButton(type: .system)
    private var quotasCount: Int = 0
    private var invitationsCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CandidatesViewController открыт")
        
        view.backgroundColor = .white
        
        // 1. Проверяем токен ДО вызова сетевых методов
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            print("Нет токена. Нужно авторизоваться.")
            // Возвращаем пользователя к логину
            if let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene }).first?.windows.first {
                let loginVC = LoginViewController()
                loginVC.completion = {
                    let greetingVC = GreetingViewController()
                    greetingVC.completion = {
                        // Исправлено:
                        window.rootViewController = MainTabBarController()
                    }
                    window.rootViewController = greetingVC
                }
                window.rootViewController = loginVC
            }
            return
        }

        print("Token найден:", token)
        OpenAPIClientAPI.customHeaders["Authorization"] = "Token \(token)"
        
        // 2. Подключаем UI
        setupChatButton()
        setupUI()
        setupHeaderCallbacks()
        
        // 3. Сетевые запросы и обновления UI
        fetchCandidates()
      
        SupervisorHelper.fetch(headerView: headerView)
    }

    @objc private func sortCandidatesBySurname() {
        isSortedAlphabetically.toggle()
        if isSortedAlphabetically {
            candidates.sort { ($0.surname ) < ($1.surname ) }
            filterButton.setTitle("А-Я", for: .normal) // Меняешь текст или иконку — по желанию
        } else {
            fetchCandidates() // Сбросить сортировку, вернуть исходный список с сервера
            filterButton.setTitle("Фильтр", for: .normal)
        }
        tableView.reloadData()
    }
    private func setupChatButton() {
        chatButton.setTitle("Чат с админом", for: .normal)
        chatButton.addTarget(self, action: #selector(openChatLink), for: .touchUpInside)
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(chatButton)
        // пример расположения (подстраивай под свой layout)
        NSLayoutConstraint.activate([
            chatButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            chatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    // --- 2. Вызов API для получения ссылки ---
    private func fetchChatLink(completion: @escaping (String?) -> Void) {
        ApiAPI.apiLinkRetrieve { response, error in
            if let error = error {
                print("Ошибка получения ссылки на чат: \(error)")
                DispatchQueue.main.async { completion(nil) }
                return
            }
            if let value = response?.value as? String {
                // Если сервер вернул строку-ссылку напрямую
                DispatchQueue.main.async { completion(value) }
            } else if let dict = response?.value as? [String: Any], let link = dict["link"] as? String {
                // Если сервер возвращает { "link": "https://..." }
                DispatchQueue.main.async { completion(link) }
            } else {
                DispatchQueue.main.async { completion(nil) }
            }
        }
    }
    // --- 3. Обработка кнопки и показ алерта ---
    @objc private func openChatLink() {
        fetchChatLink { [weak self] link in
            guard let self = self else { return }
            guard let urlString = link else {
                self.showAlert(title: "Ошибка", message: "Не удалось получить ссылку на чат")
                return
            }
            
            let alert = UIAlertController(title: "Ссылка на чат", message: urlString, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Открыть", style: .default, handler: { _ in
                if let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
            }))
            alert.addAction(UIAlertAction(title: "Скопировать", style: .default, handler: { _ in
                UIPasteboard.general.string = urlString
            }))
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    // --- 4. Функция для показа простого алерта ---
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        let sectionHeaderContainer = UIView()
        sectionHeaderContainer.translatesAutoresizingMaskIntoConstraints = false
        sectionHeaderContainer.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CandidateCell.self, forCellReuseIdentifier: CandidateCell.reuseId)
        tableView.separatorStyle = .none

        view.addSubview(headerView)
        view.addSubview(sectionHeaderContainer)
        view.addSubview(tableView)

        // --- Заголовок "Витрина кандидатов" + "Запросить квоты" ---
        let titleLabel = UILabel()
        titleLabel.text = "Витрина кандидатов"
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
        // requestQuotaButton.addTarget(self, action: #selector(showQuotasScreen), for: .touchUpInside)

        let rowStack = UIStackView(arrangedSubviews: [titleLabel, UIView(), requestQuotaButton])
        rowStack.axis = .horizontal
        rowStack.alignment = .center
        rowStack.spacing = 8
        rowStack.translatesAutoresizingMaskIntoConstraints = false

        sectionHeaderContainer.addSubview(rowStack)
        NSLayoutConstraint.activate([
            rowStack.topAnchor.constraint(equalTo: sectionHeaderContainer.topAnchor, constant: 8),
            rowStack.leadingAnchor.constraint(equalTo: sectionHeaderContainer.leadingAnchor, constant: 16),
            rowStack.trailingAnchor.constraint(equalTo: sectionHeaderContainer.trailingAnchor, constant: -16)
        ])

        // --- Кнопка "Фильтр" справа ---
        filterButton.setTitle("Фильтр", for: .normal)
        let filterIcon = UIImage(systemName: "line.3.horizontal.decrease.circle")
        filterButton.setImage(filterIcon, for: .normal)
        filterButton.tintColor = .black
        filterButton.setTitleColor(.black, for: .normal)
        filterButton.backgroundColor = UIColor.white
        filterButton.layer.cornerRadius = 8
        filterButton.contentEdgeInsets = UIEdgeInsets(top: 3, left: 18, bottom: 3, right: 18)
        filterButton.layer.borderWidth = 1
        filterButton.layer.borderColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1).cgColor
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)

        let filterStack = UIStackView(arrangedSubviews: [UIView(), filterButton])
        filterStack.axis = .horizontal
        filterStack.backgroundColor = .white
        filterStack.alignment = .center
        filterStack.translatesAutoresizingMaskIntoConstraints = false

        sectionHeaderContainer.addSubview(filterStack)
        NSLayoutConstraint.activate([
            filterStack.topAnchor.constraint(equalTo: rowStack.bottomAnchor, constant: 6),
            filterStack.leadingAnchor.constraint(equalTo: sectionHeaderContainer.leadingAnchor, constant: 16),
            filterStack.trailingAnchor.constraint(equalTo: sectionHeaderContainer.trailingAnchor, constant: -16),
            filterStack.bottomAnchor.constraint(equalTo: sectionHeaderContainer.bottomAnchor, constant: -8),
            filterButton.heightAnchor.constraint(equalToConstant: 32)
        ])

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            sectionHeaderContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            sectionHeaderContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sectionHeaderContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sectionHeaderContainer.heightAnchor.constraint(equalToConstant: 72), // под фильтр

            tableView.topAnchor.constraint(equalTo: sectionHeaderContainer.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }




    private func setupHeaderCallbacks() {
        headerView.onNotifications = { [weak self] in
            self?.showInfoAlert(title: "Уведомления", message: "Нет новых уведомлений")
        }
        headerView.onLogout = {
            // Сброс токена и заголовков
            UserDefaults.standard.removeObject(forKey: "authToken")
            OpenAPIClientAPI.customHeaders["Authorization"] = nil

            // Смена rootViewController на LoginViewController
            if let window = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows.first {
                let loginVC = LoginViewController()
                loginVC.completion = {
                    let greetingVC = GreetingViewController()
                    greetingVC.completion = {
                        // Исправлено:
                        window.rootViewController = MainTabBarController()
                    }
                    window.rootViewController = greetingVC
                }
                window.rootViewController = loginVC
            }
        }
    }


    
    // Универсальный инфо-алерт:
    private func showInfoAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // В контроллере хранишь значения (заполняются при загрузке):
    private var supervisorQuotasCount: Int = 0
    private var supervisorInvitationsCount: Int = 0
    
    private func showGreetingScreen() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            let greetingVC = GreetingViewController()
            greetingVC.completion = {
                // Исправлено:
                window.rootViewController = MainTabBarController()
            }
            window.rootViewController = greetingVC
            window.makeKeyAndVisible()
        }
    }

    private func fetchCandidates() {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else { return }
        let url = URL(string: OpenAPIClientAPI.basePath + "/api/supervisor/candidates/")!
        var req = URLRequest(url: url)
        req.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: req) { [weak self] data, res, err in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let err = err { print(err); return }
                guard let data = data else { print("no data"); return }
                do {
                    let raws = try JSONDecoder().decode([RawCandidate].self, from: data)
                    let isoFormatter = ISO8601DateFormatter()
                    let infos: [CandidateInfo] = raws.map { r in
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd" // если строка типа "1990-04-15"
                        let birthDate = r.birth.flatMap { dateFormatter.date(from: $0) } // String? -> Date?
                        
                        let updatedDate = isoFormatter.date(from: r.updated_at ?? "") ?? Date()
                        
                        return CandidateInfo(
                            id: r.id,
                            name: r.name,
                            surname: r.surname,
                            patronymic: r.patronymic,
                            birth: birthDate, // теперь Date?
                            age: r.age,
                            education: r.education,
                            photo: r.photo,
                            country: r.country,
                            city: r.city,
                            resume: r.resume,
                            courses: r.courses,
                            updatedAt: updatedDate, // тут ДОЛЖЕН быть Date!
                            isFavorite: r.is_favorite ?? false,
                            favoriteId: r.favorite_id ?? 0,
                            isInvited: r.is_invited ?? false,
                            achivmentObjects: r.achivment_objects,
                            achivmentClients: r.achivment_clients,
                            achivmentLeads: r.achivment_leads,
                            achivmentExclusives: r.achivment_exclusives,
                            achivmentDeals: r.achivment_deals
                        )
                    }
                    self.candidates = infos
                    self.tableView.reloadData()
                } catch {
                    print("Decode raw error:", error)
                    print("Raw data:", String(data: data, encoding: .utf8) ?? "nil")
                }
            }
        }.resume()
    }
    func openContactLink(for candidateId: Int) {
        getCandidateLink(candidateId: candidateId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let link):
                    if let url = URL(string: link) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        self?.showAlert(title: "Ошибка", message: "Ссылка некорректна")
                    }
                case .failure(let error):
                    self?.showAlert(title: "Ошибка", message: "Не удалось получить ссылку: \(error.localizedDescription)")
                }
            }
        }
    }
    func sendAddToFavorites(candidateId: Int, token: String, completion: @escaping (Bool, Int?, String?) -> Void) {
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
                    completion(false, nil, "Ошибка: \(error.localizedDescription)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(false, nil, "Нет ответа от сервера")
                    return
                }
                if httpResponse.statusCode == 201, let data = data {
                    // Сервер возвращает объект избранного, можно достать id
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let id = json["id"] as? Int {
                        completion(true, id, nil)
                    } else {
                        completion(true, nil, nil)
                    }
                } else {
                    let msg = data.flatMap { String(data: $0, encoding: .utf8) } ?? "Ошибка добавления в избранное"
                    completion(false, nil, msg)
                }
            }
        }
        task.resume()
    }
    private func removeFromFavorites(candidate: CandidateInfo, at index: Int) {
        guard candidate.favoriteId != 0 else { return }
        ApiAPI.apiSupervisorFavoritesDestroy(id: String(candidate.favoriteId)) { [weak self] _, error in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if error == nil {
                    var updatedCandidate = candidate
                    updatedCandidate.isFavorite = false
                    updatedCandidate.favoriteId = 0
                    self.candidates[index] = updatedCandidate
                    self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                } else {
                    self.showAlert(title: "Ошибка", message: error?.localizedDescription ?? "Не удалось удалить из избранного")
                }
            }
        }
    }
    
    func sendInvitation(for candidate: CandidateInfo, completion: @escaping (Result<Void, Error>) -> Void) {
        let invitation = Invitation(
            id: 0,
            candidate: candidate.id,
            name: candidate.name,
            surname: candidate.surname,
            patronymic: candidate.patronymic ?? "",
            city: candidate.city ?? "",
            age: candidate.age,
            photo: candidate.photo ?? "",
            status: "pending",
            updatedAt: ""
        )
        ApiAPI.apiSupervisorInvitationsCreate(invitation: invitation) { response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    @objc func inviteButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        let candidate = candidates[index]
        sendInvitation(for: candidate) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.showAlert(title: "Успех", message: "Приглашение отправлено!")
                    self?.fetchCandidates()
                case .failure(let error):
                    self?.showAlert(title: "Ошибка", message: error.localizedDescription)
                }
            }
        }
    }
    func getCandidateLink(candidateId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            completion(.failure(NSError(domain: "NoAuth", code: 401, userInfo: [NSLocalizedDescriptionKey: "Нет токена авторизации"])))
            return
        }
        let url = URL(string: "https://miel.sayrrx.cfd/api/link/\(candidateId)/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error { completion(.failure(error)); return }
            guard let data = data else {
                completion(.failure(NSError(domain: "NoData", code: 0)))
                return
            }
            // Ожидаем что в ответе будет JSON {"link": "https://..."}
            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let link = json["link"] as? String {
                completion(.success(link))
            } else {
                let msg = String(data: data, encoding: .utf8) ?? "Некорректный ответ"
                completion(.failure(NSError(domain: "Link", code: 0, userInfo: [NSLocalizedDescriptionKey: msg])))
            }
        }
        task.resume()
    }
}
    // MARK: - UITableViewDataSource, UITableViewDelegate
    extension CandidatesViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            candidates.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CandidateCell.reuseId,
                for: indexPath
            ) as! CandidateCell
            
            let candidate = candidates[indexPath.row]
            cell.inviteButton.tag = indexPath.row
            cell.inviteButton.addTarget(self, action: #selector(inviteButtonTapped(_:)), for: .touchUpInside)
            
            cell.configure(with: candidate)
            cell.favoriteDelegate = self
            cell.inviteDelegate = self
            cell.inviteButton.isEnabled = !candidate.isInvited
            cell.inviteButton.alpha = candidate.isInvited ? 0.4 : 1.0
            return cell
        }
    }
    // MARK: - CandidateCellDelegate (Invite)
    extension CandidatesViewController: CandidateCellDelegate {
        // Например, в методе делегата ячейки или при нажатии на "Пригласить"
        // В вашем делегате или ViewController:
        func candidateCellDidTapInvite(_ cell: CandidateCell) {
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let candidate = candidates[indexPath.row]
            
            sendInvitation(for: candidate) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success():
                        self?.showAlert(title: "Успех", message: "Приглашение отправлено!")
                        // Обновить список, чтобы кнопка стала неактивной:
                        self?.fetchCandidates()
                    case .failure(let error):
                        self?.showAlert(title: "Ошибка", message: error.localizedDescription)
                    }
                }
            }
        }
        
    }
    // MARK: - FavoriteCellDelegate (Like/Unlike)
    extension CandidatesViewController: FavoriteCellDelegate {
        func candidateCell(_ cell: CandidateCell, didToggleFavorite isFavorite: Bool) {
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            var candidate = candidates[indexPath.row]
            guard let token = UserDefaults.standard.string(forKey: "authToken") else {
                showAlert(title: "Ошибка", message: "Необходима авторизация")
                return
            }
            if isFavorite {
                // Добавить в избранное через URLSession
                sendAddToFavorites(candidateId: candidate.id, token: token) { [weak self] success, favoriteId, errorMsg in
                    guard let self = self else { return }
                    if success {
                        candidate.isFavorite = true
                        if let id = favoriteId {
                            candidate.favoriteId = id
                        }
                        self.candidates[indexPath.row] = candidate
                        self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    } else {
                        self.showAlert(title: "Ошибка", message: errorMsg ?? "Не удалось добавить в избранное")
                    }
                }
            } else {
                // Удалить из избранного (через OpenAPIClient)
                let favoriteIdStr = String(candidate.favoriteId)
                ApiAPI.apiSupervisorFavoritesDestroy(id: favoriteIdStr) { [weak self] _, error in
                    DispatchQueue.main.async {
                        guard let self = self else { return }
                        if let error = error {
                            self.showAlert(title: "Ошибка", message: "Не удалось удалить из избранного: \(error.localizedDescription)")
                        } else {
                            candidate.isFavorite = false
                            candidate.favoriteId = 0
                            self.candidates[indexPath.row] = candidate
                            self.tableView.reloadRows(at: [indexPath], with: .automatic)
                        }
                    }
                }
            }
        }
    }
    // Для Invitation
    extension Invitation {
        init(candidate: Int) {
            self.init(
                id: 0,                 // или просто self.init(...) без id, если твой конструктор это позволяет
                candidate: candidate,
                name: "string",
                surname: "string",
                patronymic: "string",
                city: "string",
                age: 0,
                photo: "string",
                status: "string",
                updatedAt: "string"
            )
        }
    }
    
    // Для Favorite
    extension Favorite {
        init(candidate: Int) {
            self.init(
                id: 0,
                candidate: candidate,
                candidateInfo: CandidateInfo(
                    id: 0,
                    name: "",
                    surname: "",
                    patronymic: nil,
                    birth: nil,             // <-- просто nil если даты нет
                    age: 0,
                    education: nil,
                    photo: nil,
                    country: nil,
                    city: nil,
                    resume: nil,
                    courses: [],
                    updatedAt: Date(),      // <-- всегда Date!
                    isFavorite: false,
                    favoriteId: 0,
                    isInvited: false,
                    achivmentObjects: nil,
                    achivmentClients: nil,
                    achivmentLeads: nil,
                    achivmentExclusives: nil,
                    achivmentDeals: nil
                ),
                createdAt: Date() // если Favorite.createdAt — это Date
            )
        }
    }


