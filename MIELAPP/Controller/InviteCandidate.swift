import OpenAPIClient
import OpenAPIClient

extension Invitation {
    /// Удобный инициализатор для создания приглашения из модели кандидата
    init(from candidate: CandidateInfo) {
        self.init(
            id: 0,                                // id присваивается сервером
            candidate: candidate.id,
            name: candidate.name,
            surname: candidate.surname,
            patronymic: candidate.patronymic ?? "",
            city: candidate.city ?? "",
            age: candidate.age,
            photo: candidate.photo ?? "",
            status: "pending",                    // начальный статус
            updatedAt: ""                         // сервер заполнит
        )
    }
}
