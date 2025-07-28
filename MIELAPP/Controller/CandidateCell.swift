import UIKit
import SnapKit
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
        avatar.image = UIImage(named: "avatar_placeholder")
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
        // Стиль карточки
        contentView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 247/255, alpha: 1)
        contentView.layer.cornerRadius = 16
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.792, green: 0.796, blue: 0.808, alpha: 1).cgColor
        contentView.layer.masksToBounds = true
        
        avatar.layer.cornerRadius = 24
        avatar.clipsToBounds = true
        avatar.backgroundColor = .systemGray5
        avatar.snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }
        
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        heartButton.tintColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1)
        heartButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        
        nameAgeCity.font = .systemFont(ofSize: 15, weight: .semibold)
        nameAgeCity.numberOfLines = 2
        nameAgeCity.textColor = .black
        
        resumeButton.setTitle("Ссылка на резюме", for: .normal)
        resumeButton.setTitleColor(UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1), for: .normal)
        resumeButton.titleLabel?.font = .systemFont(ofSize: 15)
        resumeButton.isHidden = true
        
        officeLabel.font = .systemFont(ofSize: 15, weight: .medium)
        officeLabel.textColor = .black
        
        coursesStack.axis = .vertical
        coursesStack.spacing = 2
        
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
        
        let buttonContainer = UIView()
        buttonContainer.addSubview(inviteButton)
        inviteButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(44)
        }
        
        let headerRow = UIStackView(arrangedSubviews: [avatar, nameAgeCity, UIView(), heartButton])
        headerRow.axis = .horizontal
        headerRow.alignment = .center
        headerRow.spacing = 12
        
        let infoRow = UIStackView(arrangedSubviews: [officeLabel, UIView(), resumeButton])
        infoRow.axis = .horizontal
        infoRow.alignment = .center
        infoRow.spacing = 8
        
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
        
        contentView.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
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
            avatar.image = UIImage(named: "avatar_placeholder")
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
