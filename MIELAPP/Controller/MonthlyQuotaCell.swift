import UIKit
import OpenAPIClient
import AnyCodable

final class MonthlyQuotaCell: UITableViewCell {
    private var labels: [UILabel] = []
    
    // Пропорции ширины колонок (макет: 70, 44, 66, 33, 40, 33 = 286)
    static let columnProportions: [CGFloat] = [60/286, 54/286, 66/286, 33/286, 40/286, 33/286]
    static let columnsCount = 6
    
    // Чтобы не дублировать constraints
    private var widthConstraints: [NSLayoutConstraint] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor(red: 0.945, green: 0.984, blue: 0.992, alpha: 1)
        selectionStyle = .none
        
        let font = UIFont(name: "PTSans-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
        let lineHeight: CGFloat = 32
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 0
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let alignments: [NSTextAlignment] = [.left, .center, .center, .center, .center, .center]
        
        for i in 0..<Self.columnsCount {
            let label = UILabel()
            label.font = font
            label.textAlignment = alignments[i]
            label.textColor = UIColor(red: 0.12, green: 0.13, blue: 0.22, alpha: 1)
            label.numberOfLines = 1
            label.backgroundColor = .clear
            label.minimumScaleFactor = 0.7
            label.adjustsFontSizeToFitWidth = true
            label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            label.translatesAutoresizingMaskIntoConstraints = false
            stack.addArrangedSubview(label)
            labels.append(label)
        }
        
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
            stack.topAnchor.constraint(equalTo: contentView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: lineHeight)
        ])
        
        // Бордеры (верх и низ)
        let borderColor = UIColor(red: 0.792, green: 0.796, blue: 0.804, alpha: 1)
        let topLine = UIView()
        topLine.backgroundColor = borderColor
        topLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topLine)
        NSLayoutConstraint.activate([
            topLine.topAnchor.constraint(equalTo: contentView.topAnchor),
            topLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        let bottomLine = UIView()
        bottomLine.backgroundColor = borderColor
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Удаляем старые widthAnchor (если были)
        NSLayoutConstraint.deactivate(widthConstraints)
        widthConstraints.removeAll()
        
        // Пропорционально растягиваем колонки
        let fullWidth = contentView.bounds.width - 34 // 17 + 17 отступы
        for (i, label) in labels.enumerated() {
            let width = fullWidth * Self.columnProportions[i]
            let constraint = label.widthAnchor.constraint(equalToConstant: width)
            constraint.isActive = true
            widthConstraints.append(constraint)
        }
    }
    
    func configure(with stat: MonthlyStatistic) {
        // Только месяц (без года)
        let monthOnly = stat.month.components(separatedBy: " ").first ?? stat.month
        labels[0].text = monthOnly
        labels[1].text = "\(stat.issued)"
        labels[2].text = "\(stat.invited)"
        labels[3].text = "\(stat.accepted)"
        labels[4].text = "\(stat.rejected)"
        labels[5].text = "\(stat.subtracted)"
    }
}
