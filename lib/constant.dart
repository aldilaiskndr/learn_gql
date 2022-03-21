class Constant {
  static String fetchOtp = """
  subscription todoSubs{
  todos(order_by: {created_at: desc}, limit: 10) {
    id
    title
  }
}
  """;

  static String simpleQuery = """
  query myQuery{
  px_platform_otp(limit: 10){
    id
    is_active
  }
}""";

}