import UIKit
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

        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 20
        avatar.clipsToBounds = true
        avatar.backgroundColor = .systemGray5
        avatar.contentMode = .scaleAspectFill
        contentView.addSubview(avatar)
        NSLayoutConstraint.activate([
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            avatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatar.widthAnchor.constraint(equalToConstant: 40),
            avatar.heightAnchor.constraint(equalToConstant: 40)
        ])

        // Горизонтальный стек: ФИО, ГОРОД, ВОЗРАСТ, СТАТУС, ДАТА
        stack.axis = .horizontal
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: avatar.trailingAnchor),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        fioLabel.font = .boldSystemFont(ofSize: 14)
        fioLabel.numberOfLines = 2
        cityLabel.font = .systemFont(ofSize: 14)
        cityLabel.numberOfLines = 2
        ageLabel.font = .systemFont(ofSize: 14)
        dateLabel.font = .systemFont(ofSize: 14)

        let statusContainer = UIView()
        statusDot.translatesAutoresizingMaskIntoConstraints = false
        statusDot.layer.cornerRadius = 5
        statusDot.widthAnchor.constraint(equalToConstant: 10).isActive = true
        statusDot.heightAnchor.constraint(equalToConstant: 10).isActive = true
        statusContainer.addSubview(statusDot)
        NSLayoutConstraint.activate([
            statusDot.centerXAnchor.constraint(equalTo: statusContainer.centerXAnchor),
            statusDot.centerYAnchor.constraint(equalTo: statusContainer.centerYAnchor),
            statusContainer.widthAnchor.constraint(equalToConstant: 50)
        ])

        // ⚡️ Колонки идут сразу друг за другом, без лишних отступов
        stack.addArrangedSubview(makeLabelContainer(fioLabel, width: 130))
        stack.addArrangedSubview(makeLabelContainer(cityLabel, width: 80))
        stack.addArrangedSubview(makeLabelContainer(ageLabel, width: 70))
        stack.addArrangedSubview(statusContainer)
        stack.addArrangedSubview(makeLabelContainer(dateLabel, width: 90))
    }

    private func makeLabelContainer(_ label: UILabel, width: CGFloat) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalToConstant: width).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0)
        ])
        return container
    }
    
   


    private func makeLabelContainer(label: UILabel, width: CGFloat) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalToConstant: width).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.topAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
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
