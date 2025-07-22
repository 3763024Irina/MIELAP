import UIKit
import OpenAPIClient
import AnyCodable

final class SupervisorHeaderView: UIView {
    // MARK: — UI Elements
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let officeLabel = UILabel()
    private let dateLabel = UILabel()
    private let notifyButton = UIButton(type: .system)
    private let logoutButton = UIButton(type: .system)
    private let quotasButton = UIButton(type: .system)
    private let invitesButton = UIButton(type: .system)
    
    // MARK: — Счётчики квот и приглашений
    private var quotasCount: Int = 0
    private var invitationsCount: Int = 0

    // MARK: — Callbacks (оставлены если нужно расширить)
    public var onNotifications: (() -> Void)?
    public var onLogout: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }

    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 18
        layer.shadowColor = UIColor.black.withAlphaComponent(0.08).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .boldSystemFont(ofSize: 15)
        nameLabel.textColor = .label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        officeLabel.font = .systemFont(ofSize: 13, weight: .medium)
        officeLabel.textColor = .black
        officeLabel.translatesAutoresizingMaskIntoConstraints = false
        officeLabel.isHidden = true
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .secondaryLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        notifyButton.setImage(UIImage(systemName: "bell"), for: .normal)
        notifyButton.tintColor = .black
        notifyButton.addTarget(self, action: #selector(notifyTapped), for: .touchUpInside)
        notifyButton.translatesAutoresizingMaskIntoConstraints = false
        
        logoutButton.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        logoutButton.tintColor = .black
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        quotasButton.layer.cornerRadius = 7
        quotasButton.layer.borderWidth = 2
        quotasButton.layer.borderColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1).cgColor
        quotasButton.backgroundColor = .white
        quotasButton.setTitleColor(UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1), for: .normal)
        quotasButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        quotasButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 28, bottom: 4, right: 28)
        quotasButton.translatesAutoresizingMaskIntoConstraints = false
        quotasButton.addTarget(self, action: #selector(quotasTapped), for: .touchUpInside)

        invitesButton.layer.cornerRadius = 7
        invitesButton.backgroundColor = .white
        invitesButton.setTitleColor(UIColor(red: 156/255, green: 199/255, blue: 0/255, alpha: 1), for: .normal)
        invitesButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        invitesButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 28, bottom: 4, right: 28)
        invitesButton.translatesAutoresizingMaskIntoConstraints = false
        invitesButton.addTarget(self, action: #selector(invitesTapped), for: .touchUpInside)
        invitesButton.layer.borderWidth = 1
        invitesButton.layer.borderColor = UIColor(red: 156/255, green: 199/255, blue: 0/255, alpha: 1).cgColor

        let infoStack = UIStackView(arrangedSubviews: [nameLabel, officeLabel, dateLabel])
        infoStack.axis = .vertical
        infoStack.alignment = .leading
        infoStack.spacing = 2
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        
        let headerRow = UIStackView(arrangedSubviews: [imageView, infoStack, notifyButton, logoutButton])
        headerRow.axis = .horizontal
        headerRow.alignment = .center
        headerRow.spacing = 12
        headerRow.translatesAutoresizingMaskIntoConstraints = false
        
        let countersStack = UIStackView(arrangedSubviews: [quotasButton, invitesButton])
        countersStack.axis = .horizontal
        countersStack.spacing = 10
        countersStack.distribution = .fillEqually
        countersStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerRow)
        addSubview(countersStack)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 44),
            imageView.heightAnchor.constraint(equalToConstant: 44),
            
            headerRow.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            headerRow.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerRow.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            countersStack.topAnchor.constraint(equalTo: headerRow.bottomAnchor, constant: 10),
            countersStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            countersStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            countersStack.heightAnchor.constraint(equalToConstant: 38),
            countersStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }

    func configure(fullName: String, date: String, photoURL: URL?, office: String = "", quotas: Int = 0, invitations: Int = 0) {
        nameLabel.text = fullName
        dateLabel.text = date
        quotasCount = quotas
        invitationsCount = invitations
        quotasButton.setTitle("Квоты \(quotas)", for: .normal)
        invitesButton.setTitle("Приглашения \(invitations)", for: .normal)
        officeLabel.text = office
        officeLabel.isHidden = office.isEmpty

        if let url = photoURL {
            let key = url.absoluteString
            if let cachedImage = Self.avatarCache[key] {
                imageView.image = cachedImage
            } else {
                imageView.image = UIImage(systemName: "person.crop.circle")
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    guard let data = data, let image = UIImage(data: data) else { return }
                    Self.avatarCache[key] = image
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }.resume()
            }
        } else {
            imageView.image = UIImage(systemName: "person.crop.circle")
        }
    }

    @objc private func notifyTapped() { onNotifications?() }
    @objc private func logoutTapped() { onLogout?() }

    @objc private func quotasTapped() {
        showInfoAlert(title: "Квоты", message: "Доступно квот: \(quotasCount)")
    }

    @objc private func invitesTapped() {
        showInfoAlert(title: "Приглашения", message: "Отправлено приглашений: \(invitationsCount)")
    }

    private func showInfoAlert(title: String, message: String) {
        guard let vc = self.parentViewController else { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }

    private static var avatarCache = [String: UIImage]()
}

private extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let vc = parentResponder as? UIViewController {
                return vc
            }
        }
        return nil
    }
}
