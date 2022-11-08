abstract class JsonSerializer<Type> {
  Type fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(Type value);
}
