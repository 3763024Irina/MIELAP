import UIKit

struct CandidateFilter {
    var ageMin: Int?
    var ageMax: Int?
    var courses: [String] = []
    var byNew: String?
}

protocol CandidateFilterDelegate: AnyObject {
    func didApplyFilter(ageMin: Int?, ageMax: Int?, courses: [String], byNew: String?)
}

final class CandidateFilterViewController: UIViewController {
    weak var delegate: CandidateFilterDelegate?

    private let ageMinField = UITextField()
    private let ageMaxField = UITextField()
    private let coursesField = UITextField()
    private let byNewSwitch = UISwitch()
    private let applyButton = UIButton(type: .system)
    private let resetButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // Настройка полей
        ageMinField.placeholder = "Мин. возраст"
        ageMinField.borderStyle = .roundedRect
        ageMinField.keyboardType = .numberPad

        ageMaxField.placeholder = "Макс. возраст"
        ageMaxField.borderStyle = .roundedRect
        ageMaxField.keyboardType = .numberPad

        coursesField.placeholder = "Курсы через запятую (например, course_rieltor_join)"
        coursesField.borderStyle = .roundedRect

        let byNewLabel = UILabel()
        byNewLabel.text = "Только новые кандидаты"
        byNewLabel.font = UIFont.systemFont(ofSize: 16)

        // Кнопка "Применить"
        applyButton.setTitle("Применить фильтр", for: .normal)
        applyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        applyButton.backgroundColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1)
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.layer.cornerRadius = 10
        applyButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        applyButton.addTarget(self, action: #selector(applyTapped), for: .touchUpInside)

        // Кнопка "Сбросить"
        resetButton.setTitle("Сбросить", for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        resetButton.backgroundColor = UIColor.systemGray6
        resetButton.setTitleColor(.systemRed, for: .normal)
        resetButton.layer.cornerRadius = 10
        resetButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)

        // Вертикальный стек для формы
        let byNewStack = UIStackView(arrangedSubviews: [byNewLabel, byNewSwitch])
        byNewStack.axis = .horizontal
        byNewStack.spacing = 16
        byNewStack.alignment = .center

        let stack = UIStackView(arrangedSubviews: [
            ageMinField,
            ageMaxField,
            coursesField,
            byNewStack,
            applyButton,
            resetButton
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }

    @objc private func applyTapped() {
        let ageMin = Int(ageMinField.text ?? "")
        let ageMax = Int(ageMaxField.text ?? "")
        let courses = (coursesField.text ?? "")
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        let byNew = byNewSwitch.isOn ? "true" : nil

        delegate?.didApplyFilter(
            ageMin: ageMin,
            ageMax: ageMax,
            courses: Array(courses),
            byNew: byNew
        )
        dismiss(animated: true)
    }

    @objc private func resetTapped() {
        ageMinField.text = ""
        ageMaxField.text = ""
        coursesField.text = ""
        byNewSwitch.isOn = false

        delegate?.didApplyFilter(ageMin: nil, ageMax: nil, courses: [], byNew: nil)
        dismiss(animated: true)
    }
}
