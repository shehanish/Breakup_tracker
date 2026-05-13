//
//  OpenAIInsightService.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 12.05.26.
//


import Foundation

struct OpenAIInsightService: AIInsightService {
    let apiKey: String
    let model: String

    /// Recommended default model for cost-effective text generation.
    init(apiKey: String, model: String = "gpt-4o-mini") {
        self.apiKey = apiKey
        self.model = model
    }

    // MARK: - API Types

    private struct ChatCompletionsRequest: Encodable {
        struct Message: Encodable {
            let role: String   // "system" | "user"
            let content: String
        }

        let model: String
        let messages: [Message]
        let temperature: Double
    }

    private struct ChatCompletionsResponse: Decodable {
        struct Choice: Decodable {
            struct Message: Decodable {
                let role: String
                let content: String
            }
            let message: Message
        }

        let choices: [Choice]
    }

    // MARK: - Public API

    func generateMoodInsight(from input: MoodInsightInput) async throws -> String {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!

        // Privacy-first: only aggregated counts and date range.
        let prompt = """
        Write 1–3 short sentences about today's mood check-in based only on the mood counts provided.
        Tone: supportive, neutral, non-judgmental.
        Do NOT diagnose, do NOT mention mental disorders, do NOT give medical instructions.
        Include at most one gentle suggestion.
        End the message with: "(Not medical advice.)"

        Time range: \(iso8601(input.startDate)) to \(iso8601(input.endDate))
        Mood counts: \(input.moodCounts)

        If there is no data, encourage the user to log their mood.
        """

        let body = ChatCompletionsRequest(
            model: model,
            messages: [
                .init(role: "system", content: "You write safe, brief, supportive mood insights."),
                .init(role: "user", content: prompt)
            ],
            temperature: 0.6
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(http.statusCode) else {
            // Include response body for debugging (often contains useful error JSON).
            let bodyText = String(data: data, encoding: .utf8) ?? "<no response body>"
            throw NSError(
                domain: "OpenAIInsightService",
                code: http.statusCode,
                userInfo: [NSLocalizedDescriptionKey: bodyText]
            )
        }

        let decoded = try JSONDecoder().decode(ChatCompletionsResponse.self, from: data)
        let text = decoded.choices.first?.message.content.trimmingCharacters(in: .whitespacesAndNewlines)

        return text?.isEmpty == false ? text! : "No insight returned. (Not medical advice.)"
    }

    // MARK: - Helpers

    private func iso8601(_ date: Date) -> String {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withInternetDateTime]
        return f.string(from: date)
    }
}