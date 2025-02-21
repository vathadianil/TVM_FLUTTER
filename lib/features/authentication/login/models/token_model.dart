class TokenModel {
  String accessToken;
  int? expiresIn;
  String tokenType;
  String refreshToken;

  TokenModel(
      {required this.accessToken,
      this.expiresIn,
      required this.refreshToken,
      required this.tokenType});

  static TokenModel empty() => TokenModel(
      accessToken: '', expiresIn: null, refreshToken: '', tokenType: '');

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'expiresIn': expiresIn,
      'refreshToken': refreshToken,
      'tokenType': tokenType
    };
  }

  factory TokenModel.fromJson(Map<String, dynamic>? data) {
    if (data != null) {
      return TokenModel(
        accessToken: data['access_token'] ?? '',
        expiresIn: data['expires_in'],
        refreshToken: data['refresh_token'] ?? '',
        tokenType: data['token_type'] ?? '',
      );
    } else {
      return TokenModel.empty();
    }
  }
}
