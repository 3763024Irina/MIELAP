import UIKit
import OpenAPIClient

protocol CandidateCellDelegate: AnyObject {
    func candidateCellDidTapInvite(_ cell: CandidateCell)
}
protocol FavoriteCellDelegate: AnyObject {
    func candidateCell(_ cell: CandidateCell, didToggleFavorite isFavorite: Bool)
}

final class CandidateCell: UITableViewCell {
    static let reuseId = "CandidateCell"
    weak var favoriteDelegate: FavoriteCellDelegate?
    weak var inviteDelegate: CandidateCellDelegate?
    
    private let avatar = UIImageView()
    private let nameAgeCity = UILabel()
    private let resumeButton = UIButton(type: .system)
    private(set) var heartButton = UIButton(type: .system)
    private let officeLabel = UILabel()
    private let coursesStack = UIStackView()
    private let achievementsTitle = UILabel()
    private let achLeftStack = UIStackView()
    private let achRightStack = UIStackView()
    private let achievementsWrapper = UIStackView()
    let inviteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Пригласить", for: .normal)
        btn.backgroundColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1) // #960047
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private var resumeURL: URL?
    private var avatarTask: URLSessionDataTask?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupActions()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupActions()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarTask?.cancel()
        avatar.image = UIImage(named: "avatar_placeholder") // если нет фото
        heartButton.isSelected = false
        achLeftStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        achRightStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        coursesStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    private func setupActions() {
        heartButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        resumeButton.addTarget(self, action: #selector(openResume), for: .touchUpInside)
        inviteButton.addTarget(self, action: #selector(inviteTapped), for: .touchUpInside)
    }
    private func setupSubviews() {
        // СТИЛЬ КАРТОЧКИ
        contentView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 247/255, alpha: 1) // #F6F6F7
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.792, green: 0.796, blue: 0.808, alpha: 1).cgColor // #CACBCE
        contentView.layer.masksToBounds = true
        
        // АВАТАР
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 24
        avatar.clipsToBounds = true
        avatar.backgroundColor = .systemGray5
        NSLayoutConstraint.activate([
            avatar.widthAnchor.constraint(equalToConstant: 48),
            avatar.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        // СЕРДЕЧКО
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        heartButton.tintColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1)
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heartButton.widthAnchor.constraint(equalToConstant: 24),
            heartButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // ИМЯ + ВОЗРАСТ + ГОРОД
        nameAgeCity.font = .systemFont(ofSize: 15, weight: .semibold)
        nameAgeCity.numberOfLines = 2
        nameAgeCity.textColor = .black
        
        // Резюме (если есть)
        resumeButton.setTitle("Ссылка на резюме", for: .normal)
        resumeButton.setTitleColor(UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1), for: .normal)
        resumeButton.titleLabel?.font = .systemFont(ofSize: 15)
        resumeButton.isHidden = true
        
        // ОБРАЗОВАНИЕ
        officeLabel.font = .systemFont(ofSize: 15, weight: .medium)
        officeLabel.textColor = .black
        
        // КУРСЫ
        coursesStack.axis = .vertical
        coursesStack.spacing = 2
        
        // ДОСТИЖЕНИЯ
        achievementsTitle.text = "Достижения"
        achievementsTitle.font = .systemFont(ofSize: 16, weight: .bold)
        achLeftStack.axis = .vertical
        achLeftStack.spacing = 2
        achRightStack.axis = .vertical
        achRightStack.spacing = 2
        achievementsWrapper.axis = .horizontal
        achievementsWrapper.spacing = 30
        achievementsWrapper.addArrangedSubview(achLeftStack)
        achievementsWrapper.addArrangedSubview(achRightStack)
        
        // КНОПКА "ПРИГЛАСИТЬ"
        let buttonContainer = UIView()
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.addSubview(inviteButton)
        NSLayoutConstraint.activate([
            inviteButton.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
            inviteButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
            inviteButton.bottomAnchor.constraint(equalTo: buttonContainer.bottomAnchor),
            inviteButton.widthAnchor.constraint(equalToConstant: 160),
            inviteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        // ВЕРХНЯЯ СТРОКА: аватар - ФИО - сердечко
        let headerRow = UIStackView(arrangedSubviews: [avatar, nameAgeCity, UIView(), heartButton])
        headerRow.axis = .horizontal
        headerRow.alignment = .center
        headerRow.spacing = 12
        
        // Вторая строка: образование и резюме
        let infoRow = UIStackView(arrangedSubviews: [officeLabel, UIView(), resumeButton])
        infoRow.axis = .horizontal
        infoRow.alignment = .center
        infoRow.spacing = 8
        
        // Основной стек для всей ячейки
        let mainStack = UIStackView(arrangedSubviews: [
            headerRow,
            infoRow,
            coursesStack,
            achievementsTitle,
            achievementsWrapper,
            buttonContainer
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 8
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
        func configure(with c: CandidateInfo) {
        avatarTask?.cancel()
        if let s = c.photo, !s.isEmpty, let url = URL(string: s) {
            avatarTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let d = data, let img = UIImage(data: d) else { return }
                DispatchQueue.main.async { self?.avatar.image = img }
            }
            avatarTask?.resume()
        } else {
            avatar.image = UIImage(named: "avatar_placeholder") // <- твоя маска в assets
        }
        
        heartButton.isSelected = c.isFavorite
        
        let fio = [c.surname, c.name, c.patronymic].compactMap { $0 }.joined(separator: " ")
        var details = ["\(c.age) года"]
        if let city = c.city, !city.isEmpty { details.append(city) }
        nameAgeCity.text = fio + "\n" + details.joined(separator: ", ")
        
        if let link = c.resume, !link.isEmpty, let url = URL(string: link) {
            resumeURL = url
            resumeButton.isHidden = false
        } else {
            resumeURL = nil
            resumeButton.isHidden = true
        }
        
        officeLabel.text = c.education ?? ""
        
        // --- Курсы ---
        coursesStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let square = "\u{25A0}"
        c.courses.forEach {
            let lbl = UILabel()
            lbl.font = .systemFont(ofSize: 14)
            lbl.text = "\(square) \($0.name)"
            lbl.textColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1)
            lbl.numberOfLines = 0
            coursesStack.addArrangedSubview(lbl)
        }
        
        // --- Достижения ---
        achLeftStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        achRightStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let achTuples: [(String, Int?)] = [
            ("Объекты",    c.achivmentObjects),
            ("Лиды",       c.achivmentLeads),
            ("Сделки",     c.achivmentDeals),
            ("Покупатели", c.achivmentClients),
            ("Эксклюзивы", c.achivmentExclusives)
        ]
        let bulletColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1)
        for (i, item) in achTuples.enumerated() {
            let value = item.1 ?? 0
            let lbl = UILabel()
            lbl.font = .systemFont(ofSize: 15, weight: .semibold)
            let bullet = NSAttributedString(
                string: square + " ",
                attributes: [.foregroundColor: bulletColor]
            )
            let text = NSMutableAttributedString(attributedString: bullet)
            text.append(NSAttributedString(
                string: "\(item.0) \(value)",
                attributes: [.foregroundColor: UIColor.label]
            ))
            lbl.attributedText = text
            if i < 3 {
                achLeftStack.addArrangedSubview(lbl)
            } else {
                achRightStack.addArrangedSubview(lbl)
            }
        }
        achievementsTitle.isHidden = false
        
        // --- Кнопка "Пригласить"/"Отправлено" ---
        if c.isInvited {
            inviteButton.setTitle("Отправлено", for: .normal)
            inviteButton.isEnabled = false
            inviteButton.alpha = 0.5
        } else {
            inviteButton.setTitle("Пригласить", for: .normal)
            inviteButton.isEnabled = true
            inviteButton.alpha = 1.0
        }
    }

    
    @objc private func inviteTapped() {
        inviteDelegate?.candidateCellDidTapInvite(self)
    }
    @objc private func toggleFavorite() {
        heartButton.isSelected.toggle()
        favoriteDelegate?.candidateCell(self, didToggleFavorite: heartButton.isSelected)
    }
    @objc private func openResume() {
        guard let u = resumeURL else { return }
        UIApplication.shared.open(u)
    }
}
