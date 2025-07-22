import UIKit
import OpenAPIClient
import AnyCodable

final class QuotasViewController: UIViewController, UINavigationControllerDelegate {
    private let headerView = SupervisorHeaderView()
    private let actionsStack = UIStackView()
    private let quotasButton = UIButton(type: .system)
    private let invitesButton = UIButton(type: .system)
    private let statLabel = UILabel()
    private let yearField = UITextField()
    private let yearPicker = UIPickerView()
    private let searchButton = UIButton(type: .system)
    private let requestQuotaButton = UIButton(type: .system)
    private let tableView = UITableView()
    private var quotaStats: [MonthlyStatistic] = []
    private let years = Array(2022...2025).map { "\($0)" }
    private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    
    enum QuotaColumn: CaseIterable {
        case period, issued, invited, accepted, rejected, subtracted
        
        var title: String {
            switch self {
            case .period: return "Период"
            case .issued: return "Выдано"
            case .invited: return "Приглашено"
            case .accepted: return "Найм"
            case .rejected: return "Отказы"
            case .subtracted: return "Снято"
            }
        }
        
        var width: CGFloat {
            switch self {
            case .period: return 50
            case .issued: return 64
            case .invited: return 66
            case .accepted: return 33
            case .rejected: return 40
            case .subtracted: return 33
            }
        }
        
        var alignment: NSTextAlignment {
            switch self {
            case .period: return .left
            default: return .center
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupUI()
        setupHeaderCallbacks()
        SupervisorHelper.fetch(headerView: headerView)
        fetchQuotas(for: selectedYear)
        navigationController?.setNavigationBarHidden(true, animated: false)

    }
    
    private func setupUI() {
        // Header
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        // --- Блок "Статистика квот" с кнопкой "Запросить квоты" ---
        let titleLabel = UILabel()
        titleLabel.text = "Статистика квот"
        if let ptSansBold = UIFont(name: "PTSans-Bold", size: 20) {
            titleLabel.font = ptSansBold
        } else {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        }
        titleLabel.textColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1) // #960047
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
        requestQuotaButton.addTarget(self, action: #selector(requestQuotaTapped), for: .touchUpInside)

        let headerRowStack = UIStackView(arrangedSubviews: [titleLabel, UIView(), requestQuotaButton])
        headerRowStack.axis = .horizontal
        headerRowStack.alignment = .center
        headerRowStack.spacing = 8
        headerRowStack.translatesAutoresizingMaskIntoConstraints = false

        let headerRowContainer = UIView()
        headerRowContainer.backgroundColor = .white
        headerRowContainer.translatesAutoresizingMaskIntoConstraints = false
        headerRowContainer.addSubview(headerRowStack)
        view.addSubview(headerRowContainer)

        NSLayoutConstraint.activate([
            headerRowContainer.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            headerRowContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerRowContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerRowContainer.heightAnchor.constraint(equalToConstant: 40),

            headerRowStack.topAnchor.constraint(equalTo: headerRowContainer.topAnchor, constant: 0),
            headerRowStack.bottomAnchor.constraint(equalTo: headerRowContainer.bottomAnchor, constant: 0),
            headerRowStack.leadingAnchor.constraint(equalTo: headerRowContainer.leadingAnchor, constant: 16),
            headerRowStack.trailingAnchor.constraint(equalTo: headerRowContainer.trailingAnchor, constant: -16)
        ])
        
        // Селектор года + "Искать"
        yearField.borderStyle = .roundedRect
        yearField.font = .systemFont(ofSize: 16)
        yearField.text = "\(selectedYear)"
        yearField.inputView = yearPicker
        yearField.textAlignment = .center
        yearField.widthAnchor.constraint(equalToConstant: 80).isActive = true
        yearField.translatesAutoresizingMaskIntoConstraints = false
        yearPicker.dataSource = self
        yearPicker.delegate = self
        searchButton.widthAnchor.constraint(equalToConstant: 100).isActive = true  // ширина кнопки 100
        searchButton.heightAnchor.constraint(equalToConstant: 44).isActive = true // высота кнопки 44

        searchButton.setTitle("Искать", for: .normal)
        searchButton.backgroundColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.layer.cornerRadius = 6
        searchButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        let filterStack = UIStackView(arrangedSubviews: [yearField, searchButton])
        filterStack.axis = .horizontal
        filterStack.spacing = 8
        filterStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterStack)
        NSLayoutConstraint.activate([
            filterStack.topAnchor.constraint(equalTo: headerRowContainer.bottomAnchor, constant: 8),
            filterStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12)
        ])
        
        // Таблица
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(MonthlyQuotaCell.self, forCellReuseIdentifier: "MonthlyQuotaCell")
        tableView.tableHeaderView = makeTableHeader()
        tableView.separatorStyle = .singleLine
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: filterStack.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupHeaderCallbacks() {
        headerView.onLogout = { [weak self] in }
        headerView.onNotifications = { }
    }
    
    @objc private func searchTapped() {
        fetchQuotas(for: selectedYear)
        yearField.resignFirstResponder()
    }
    
    private func fetchQuotas(for year: Int) {
        ApiAPI.apiSupervisorStatisticQuotasList(year: year) { [weak self] data, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showAlert(title: "Ошибка", message: error.localizedDescription)
                }
                self?.quotaStats = data ?? []
                self?.tableView.reloadData()
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    private func makeTableHeader() -> UIView {
        let screenWidth = UIScreen.main.bounds.width
        let paddingLeft: CGFloat = 17
        let paddingRight: CGFloat = 0
        let headerHeight: CGFloat = 36
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: headerHeight))
        headerView.backgroundColor = UIColor(red: 0.945, green: 0.984, blue: 0.992, alpha: 1)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Бордеры
        let borderColor = UIColor(red: 0.792, green: 0.796, blue: 0.804, alpha: 1)
        let topBorder = UIView()
        topBorder.backgroundColor = borderColor
        topBorder.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(topBorder)
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = borderColor
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(bottomBorder)
        
        // StackView для колонок
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(stack)
        
        let font = UIFont(name: "PTSans-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let lineHeight: CGFloat = 18
        
        // Пропорции ширины колонок (примерно как в макете, сумма — 1.0)
        let columnPercents: [CGFloat] = [0.17, 0.17, 0.25, 0.11, 0.15, 0.15]
        let columns: [(String, NSTextAlignment)] = [
            ("Период", .left),
            ("Выдано", .center),
            ("Приглашено", .center),
            ("Найм", .center),
            ("Отказы", .center),
            ("Снято", .center)
        ]
        
        for i in 0..<columns.count {
            let (title, alignment) = columns[i]
            let width = (screenWidth - paddingLeft - paddingRight) * columnPercents[i]
            let style = NSMutableParagraphStyle()
            style.alignment = alignment
            style.minimumLineHeight = lineHeight
            style.maximumLineHeight = lineHeight
            
            let label = UILabel()
            label.attributedText = NSAttributedString(
                string: title,
                attributes: [
                    .font: font,
                    .paragraphStyle: style
                ]
            )
            label.textAlignment = alignment
            label.textColor = UIColor(red: 0.12, green: 0.13, blue: 0.22, alpha: 1)
            label.backgroundColor = .clear
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalToConstant: width).isActive = true
            label.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true
            stack.addArrangedSubview(label)
        }
        
        NSLayoutConstraint.activate([
            // StackView
            stack.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: paddingLeft),
            stack.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -paddingRight),
            stack.topAnchor.constraint(equalTo: headerView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            // Top border
            topBorder.topAnchor.constraint(equalTo: headerView.topAnchor),
            topBorder.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            topBorder.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            topBorder.heightAnchor.constraint(equalToConstant: 1),
            
            // Bottom border
            bottomBorder.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            bottomBorder.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),
            
            // Высота
            headerView.heightAnchor.constraint(equalToConstant: headerHeight)
        ])
        // Обязательная установка frame!
        headerView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: headerHeight)
        return headerView
    }
    @objc private func requestQuotaTapped() {
        // TODO: переход на экран квот или вызов API
        print("Запросить квоты нажат")
    }

}
// MARK: - DataSource
extension QuotasViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotaStats.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MonthlyQuotaCell", for: indexPath) as? MonthlyQuotaCell else {
            return UITableViewCell()
        }
        let stat = quotaStats[indexPath.row]
        cell.configure(with: stat)
        return cell
    }
}

// MARK: - Year Picker
extension QuotasViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { years.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { years[row] }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        yearField.text = years[row]
        selectedYear = Int(years[row]) ?? Calendar.current.component(.year, from: Date())
    }
}
