import UIKit

class MovieTableViewCell: UITableViewCell {

    struct ViewState {
        let title: String
        let releaseDate: Date
        let overview: String
    }

    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        return containerView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .preferredFont(forTextStyle: .title3)
        return titleLabel
    }()

    private let releaseDateLabel: UILabel = {
        let releaseDateLabel = UILabel()
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.font = .preferredFont(forTextStyle: .subheadline)
        releaseDateLabel.textColor = .systemGray
        return releaseDateLabel
    }()

    private let overviewLabel: UILabel = {
        let overviewLabel = UILabel()
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.font = .preferredFont(forTextStyle: .subheadline)
        overviewLabel.numberOfLines = 6
        overviewLabel.textColor = .systemGray
        return overviewLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        [containerView].forEach(contentView.addSubview)
        [titleLabel, releaseDateLabel, overviewLabel].forEach(containerView.addSubview)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .mediumSpacing),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .mediumSpacing),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.mediumSpacing),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.mediumSpacing)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .mediumSpacing),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: .mediumSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.mediumSpacing)
        ])

        NSLayoutConstraint.activate([
            releaseDateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .mediumSpacing),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            releaseDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.mediumSpacing)
        ])

        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: .mediumSpacing),
            overviewLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: .mediumSpacing),
            overviewLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -.mediumSpacing),
            overviewLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -.mediumSpacing)
        ])
    }

    func updateView(_ viewState: ViewState) {
        titleLabel.text = viewState.title
        releaseDateLabel.text = DateFormatter.releaseDateDisplay.string(from: viewState.releaseDate)
        overviewLabel.text = viewState.overview
    }
}
