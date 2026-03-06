class PriceTierInfoDTO {
  final double q1;
  final double median;
  final double q3;

  const PriceTierInfoDTO({
    required this.q1,
    required this.median,
    required this.q3,
  });

  factory PriceTierInfoDTO.fromJson(Map<String, dynamic> json) =>
      PriceTierInfoDTO(
        q1: (json['q1'] as num).toDouble(),
        median: (json['median'] as num).toDouble(),
        q3: (json['q3'] as num).toDouble(),
      );
}
