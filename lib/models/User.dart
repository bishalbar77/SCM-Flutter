class User {
  int ID;
  String name;
  String email;

  User ({
    this.ID,
    this.name,
    this.email
  });

  factory User.fromJson(Map<String, dynamic> item) {
    return User(
        ID: item['id'],
        name: item['name'],
        email: item['email']
    );
  }
}