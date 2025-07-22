import OpenAPIClient

extension Invitation {
    init(
        candidate: Int,
        name: String,
        surname: String,
        patronymic: String? = nil,
        city: String? = nil,
        age: Int,
        photo: String? = nil,
        status: String? = nil,
        updatedAt: String? = nil
    ) {
        self.init(
            id: 0,  // или -1, если id не нужен, главное — Int!
            candidate: candidate,
            name: name,
            surname: surname,
            patronymic: patronymic ?? "", // заменяем nil на ""
            city: city ?? "",
            age: age,
            photo: photo ?? "",
            status: status ?? "",
            updatedAt: updatedAt ?? ""
        )
    }
}
