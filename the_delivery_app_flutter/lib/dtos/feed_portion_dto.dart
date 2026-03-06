class FeedPortionDTO {
  final List<String> foodIds;
  final String portionToken;

  const FeedPortionDTO({
    required this.foodIds,
    required this.portionToken,
  });

  factory FeedPortionDTO.fromJson(Map<String, dynamic> json) => FeedPortionDTO(
    foodIds: (json['food_ids'] as List<dynamic>).cast<String>(),
    portionToken: json['portion_token'] as String,
  );
}
