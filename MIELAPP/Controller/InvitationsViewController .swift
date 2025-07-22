import UIKit
import OpenAPIClient
import AnyCodable

final class InvitationsViewController: UIViewController, UINavigationControllerDelegate, UIScrollViewDelegate {

    private let headerView = SupervisorHeaderView()
    private let filterContainer = UIView()
    private let headerScrollView = UIScrollView()
    private let horizontalScrollView = UIScrollView()
    private let headerContainer = UIView()
    private let containerView = UIView()
    private let tableView = UITableView()

    private var invitations: [Invitation] = []
    private var filteredInvitations: [Invitation] = []

    private let yearPicker = UIPickerView()
    private let monthPicker = UIPickerView()
    private let statusPicker = UIPickerView()
    private let searchButton = UIButton(type: .system)
    private let months = Calendar.current.monthSymbols
    private let years: [Int] = {
        let current = Calendar.current.component(.year, from: Date())
        return (current-2...current+1).map { $0 }
    }()
    private let statuses = ["", "invited", "accepted", "rejected", "self_rejected"]

    private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    private var selectedStatus: String?

    private let monthField = UITextField()
    private let yearField = UITextField()
    private let statusField = UITextField()

    private var isSyncingScroll = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupUI()
        setupHeader()
        setupFilters()
        fetchInvitations()
        navigationController?.setNavigationBarHidden(true, animated: false)

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func setupUI() {
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        // --- Блок "Статистика квот" с кнопкой "Запросить квоты" ---
        let titleLabel = UILabel()
        titleLabel.text = "Статистика приглашений"
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

        // --- Фильтры ---
        filterContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterContainer)

        let fieldsStack = UIStackView(arrangedSubviews: [monthField, yearField, statusField])
        fieldsStack.axis = .horizontal
        fieldsStack.spacing = 8
        fieldsStack.distribution = .fillEqually
        fieldsStack.translatesAutoresizingMaskIntoConstraints = false

        [monthField, yearField, statusField].forEach { field in
            field.borderStyle = .roundedRect
            field.font = UIFont.systemFont(ofSize: 12)
            field.heightAnchor.constraint(equalToConstant: 22).isActive = true
        }

        searchButton.setTitle("Искать", for: .normal)
        searchButton.backgroundColor = UIColor(red: 150/255, green: 0, blue: 71/255, alpha: 1)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        searchButton.layer.cornerRadius = 4
        searchButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)

        let filterStack = UIStackView(arrangedSubviews: [fieldsStack, searchButton])
        filterStack.axis = .horizontal
        filterStack.spacing = 8
        filterStack.alignment = .center
        filterStack.translatesAutoresizingMaskIntoConstraints = false

        filterContainer.addSubview(filterStack)
        NSLayoutConstraint.activate([
            filterStack.topAnchor.constraint(equalTo: filterContainer.topAnchor),
            filterStack.bottomAnchor.constraint(equalTo: filterContainer.bottomAnchor),
            filterStack.leadingAnchor.constraint(equalTo: filterContainer.leadingAnchor, constant: 8),
            filterStack.trailingAnchor.constraint(equalTo: filterContainer.trailingAnchor, constant: -8),
            filterContainer.topAnchor.constraint(equalTo: headerRowContainer.bottomAnchor, constant: 16),
            filterContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            filterContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            filterContainer.heightAnchor.constraint(equalToConstant: 44)
        ])

        let statusLegend = makeStatusLegend()
        view.addSubview(statusLegend)
        NSLayoutConstraint.activate([
            statusLegend.topAnchor.constraint(equalTo: filterContainer.bottomAnchor, constant: 23),
            statusLegend.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusLegend.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            statusLegend.heightAnchor.constraint(equalToConstant: 22)
        ])

        // --- Шапка таблицы со скроллом ---
        headerScrollView.translatesAutoresizingMaskIntoConstraints = false
        headerScrollView.showsHorizontalScrollIndicator = false
        headerScrollView.delegate = self
        view.addSubview(headerScrollView)
        NSLayoutConstraint.activate([
            headerScrollView.topAnchor.constraint(equalTo: statusLegend.bottomAnchor, constant: 10),
            headerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerScrollView.heightAnchor.constraint(equalToConstant: 30)
        ])

        headerContainer.translatesAutoresizingMaskIntoConstraints = false
        headerScrollView.addSubview(headerContainer)
        NSLayoutConstraint.activate([
            headerContainer.leadingAnchor.constraint(equalTo: headerScrollView.leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: headerScrollView.trailingAnchor),
            headerContainer.topAnchor.constraint(equalTo: headerScrollView.topAnchor),
            headerContainer.bottomAnchor.constraint(equalTo: headerScrollView.bottomAnchor),
            headerContainer.widthAnchor.constraint(equalToConstant: 460) // 
        ])

        // --- Хедер: Фото, ФИО, Город, Возраст, Статус, Дата ---
        let photoHeader = makeHeaderLabel(text: "", alignment: .center)
        let fioHeader = makeHeaderLabel(text: "ФИО")
        let cityHeader = makeHeaderLabel(text: "Город")
        let ageHeader = makeHeaderLabel(text: "Возраст")
        let statusHeader = makeHeaderLabel(text: "Статус", alignment: .center)
        let dateHeader = makeHeaderLabel(text: "Дата")

        let headerStack = UIStackView(arrangedSubviews: [
            makeHeaderContainer(photoHeader, width: 40),
            makeHeaderContainer(fioHeader, width: 130),
            makeHeaderContainer(cityHeader, width: 80),
            makeHeaderContainer(ageHeader, width: 70),
            makeHeaderContainer(statusHeader, width: 50),
            makeHeaderContainer(dateHeader, width: 90)
        ])
        headerStack.axis = .horizontal
        headerStack.spacing = 0
        headerStack.alignment = .center
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerContainer.addSubview(headerStack)

        NSLayoutConstraint.activate([
            headerStack.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor),
            headerStack.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor),
            headerStack.topAnchor.constraint(equalTo: headerContainer.topAnchor),
            headerStack.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor)
        ])

        // --- Таблица под шапкой ---
        horizontalScrollView.translatesAutoresizingMaskIntoConstraints = false
        horizontalScrollView.showsHorizontalScrollIndicator = true
        horizontalScrollView.delegate = self
        view.addSubview(horizontalScrollView)
        NSLayoutConstraint.activate([
            horizontalScrollView.topAnchor.constraint(equalTo: headerScrollView.bottomAnchor),
            horizontalScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        containerView.translatesAutoresizingMaskIntoConstraints = false
        horizontalScrollView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: horizontalScrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: horizontalScrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: horizontalScrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: horizontalScrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 460),
            containerView.heightAnchor.constraint(equalTo: horizontalScrollView.heightAnchor)
        ])

        tableView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])

        tableView.register(InvitationCell.self, forCellReuseIdentifier: InvitationCell.reuseId)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .white
    }

    // --- Хедер-обёртка для фиксированной ширины ---
    private func makeHeaderContainer(_ label: UILabel, width: CGFloat) -> UIView {
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

    private func makeHeaderLabel(text: String, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = alignment
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }

    private func setupHeader() {
        SupervisorHelper.fetch(headerView: headerView)
    }

    private func setupFilters() {
        yearPicker.dataSource = self
        yearPicker.delegate = self
        monthPicker.dataSource = self
        monthPicker.delegate = self
        statusPicker.dataSource = self
        statusPicker.delegate = self

        monthField.inputView = monthPicker
        yearField.inputView = yearPicker
        statusField.inputView = statusPicker

        monthField.text = months[selectedMonth - 1]
        yearField.text = "\(selectedYear)"
        statusField.text = "Любой"
    }

    @objc private func searchTapped() {
        fetchInvitations()
        view.endEditing(true)
    }

    private func fetchInvitations() {
        let startDate = String(format: "%04d-%02d-01", selectedYear, selectedMonth)
        let endDate = String(format: "%04d-%02d-31", selectedYear, selectedMonth)

        ApiAPI.apiSupervisorInvitationsRetrieve(endDate: endDate, startDate: startDate, status: selectedStatus) { [weak self] data, error in
            DispatchQueue.main.async {
                if let data = data {
                    self?.invitations = data
                    self?.filteredInvitations = data
                    self?.tableView.reloadData()
                }
            }
        }
    }

    // --- Синхронизация скролла между шапкой и таблицей ---
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isSyncingScroll else { return }
        isSyncingScroll = true
        if scrollView == headerScrollView {
            horizontalScrollView.contentOffset.x = headerScrollView.contentOffset.x
        } else if scrollView == horizontalScrollView {
            headerScrollView.contentOffset.x = horizontalScrollView.contentOffset.x
        }
        isSyncingScroll = false
    }

    private func makeStatusLegend() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .clear
        container.heightAnchor.constraint(equalToConstant: 22).isActive = true
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        let items: [(UIColor, String)] = [
            (UIColor(red: 1.00, green: 0.53, blue: 0.07, alpha: 1), "Приглашён(а)"),
            (UIColor(red: 0.94, green: 0.07, blue: 0.45, alpha: 1), "Отказ"),
            (UIColor(red: 0.22, green: 0.82, blue: 0.89, alpha: 1), "Трудоустроен(а)")
        ]
        for (color, title) in items {
            let hStack = UIStackView()
            hStack.axis = .horizontal
            hStack.spacing = 4
            hStack.alignment = .center
            let dot = UIView()
            dot.backgroundColor = color
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.layer.cornerRadius = 3
            NSLayoutConstraint.activate([
                dot.widthAnchor.constraint(equalToConstant: 14),
                dot.heightAnchor.constraint(equalToConstant: 14)
            ])
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = UIColor(red: 0.38, green: 0.39, blue: 0.43, alpha: 1)
            hStack.addArrangedSubview(dot)
            hStack.addArrangedSubview(label)
            stack.addArrangedSubview(hStack)
        }
        container.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        return container
    }
    @objc private func requestQuotaTapped() {
        // TODO: переход на экран квот или вызов API
        print("Запросить квоты нажат")
    }

}

extension InvitationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredInvitations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvitationCell.reuseId, for: indexPath) as! InvitationCell
        let invitation = filteredInvitations[indexPath.row]
        cell.configure(with: invitation)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50 // Чуть выше аватара, чтобы было красиво
    }
}

extension InvitationsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case yearPicker: return years.count
        case monthPicker: return months.count
        case statusPicker: return statuses.count
        default: return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case yearPicker: return "\(years[row])"
        case monthPicker: return months[row]
        case statusPicker:
            return statuses[row].isEmpty ? "Любой" : statuses[row]
        default: return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == yearPicker {
            selectedYear = years[row]
            yearField.text = "\(selectedYear)"
        } else if pickerView == monthPicker {
            selectedMonth = row + 1
            monthField.text = months[row]
        } else if pickerView == statusPicker {
            selectedStatus = statuses[row].isEmpty ? nil : statuses[row]
            statusField.text = statuses[row].isEmpty ? "Любой" : statuses[row]
        }
    }
}
