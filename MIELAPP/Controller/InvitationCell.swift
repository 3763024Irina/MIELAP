import UIKit
import SnapKit
import OpenAPIClient

final class InvitationCell: UITableViewCell {
    static let reuseId = "InvitationCell"
    
    private let avatar = UIImageView()
    private let fioLabel = UILabel()
    private let cityLabel = UILabel()
    private let ageLabel = UILabel()
    private let statusDot = UIView()
    private let dateLabel = UILabel()
    private let stack = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        selectionStyle = .none
        contentView.backgroundColor = .white
        
        // --- Аватар ---
        avatar.layer.cornerRadius = 20
        avatar.clipsToBounds = true
        avatar.backgroundColor = .systemGray5
        avatar.contentMode = .scaleAspectFill
        contentView.addSubview(avatar)
        avatar.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)   // только для иконки!
        }
        
        // --- Горизонтальный стек ---
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        contentView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.leading.equalTo(avatar.snp.trailing)
            make.top.bottom.trailing.equalToSuperview()
        }

        fioLabel.font = .boldSystemFont(ofSize: 14)
        fioLabel.numberOfLines = 2
        cityLabel.font = .systemFont(ofSize: 14)
        cityLabel.numberOfLines = 2
        ageLabel.font = .systemFont(ofSize: 14)
        dateLabel.font = .systemFont(ofSize: 14)

        // --- Статус (точка) ---
        statusDot.layer.cornerRadius = 5
        let statusContainer = UIView()
        statusContainer.addSubview(statusDot)
        statusContainer.snp.makeConstraints { make in
            make.width.equalTo(50) // только ширина
        }
        statusDot.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(10) // маленький кружок
        }

        // --- Добавление колонок ---
        stack.addArrangedSubview(makeLabelContainer(fioLabel, width: 130))
        stack.addArrangedSubview(makeLabelContainer(cityLabel, width: 80))
        stack.addArrangedSubview(makeLabelContainer(ageLabel, width: 70))
        stack.addArrangedSubview(statusContainer)
        stack.addArrangedSubview(makeLabelContainer(dateLabel, width: 90))
    }

    private func makeLabelContainer(_ label: UILabel, width: CGFloat) -> UIView {
        let container = UIView()
        container.snp.makeConstraints { make in
            make.width.equalTo(width)   // ширина фиксирована
        }
        container.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return container
    }

    func configure(with invitation: Invitation) {
        fioLabel.text = [invitation.surname, invitation.name, invitation.patronymic]
            .compactMap { $0 }
            .joined(separator: " ")
        cityLabel.text = invitation.city ?? "-"
        ageLabel.text = "\(invitation.age)"
        statusDot.backgroundColor = color(for: invitation.status ?? "invited")
        dateLabel.text = invitation.updatedAt.flatMap { formattedDate($0) } ?? "-"
        
        if let photo = invitation.photo, !photo.isEmpty, let url = URL(string: photo) {
            avatar.image = UIImage(systemName: "person.crop.circle")
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let img = UIImage(data: data) {
                    DispatchQueue.main.async { self?.avatar.image = img }
                }
            }.resume()
        } else {
            avatar.image = UIImage(systemName: "person.crop.circle")
        }
    }

    private func formattedDate(_ dateStr: String?) -> String {
        guard let dateStr = dateStr else { return "-" }
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateStr) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "dd.MM.yyyy"
            return displayFormatter.string(from: date)
        }
        return "-"
    }

    private func color(for status: String) -> UIColor {
        switch status {
        case "invited": return UIColor(red: 1.00, green: 0.53, blue: 0.07, alpha: 1)
        case "accepted": return UIColor(red: 0.22, green: 0.82, blue: 0.89, alpha: 1)
        case "rejected": return UIColor(red: 0.94, green: 0.07, blue: 0.45, alpha: 1)
        case "self_rejected": return .systemGray
        default: return .systemGray
        }
    }
}
