class FormQuestion {
  String id;
  String namePerson;
  String dateCompleted;
  String question1;
  String question2;
  String question3;
  String question4;
  String question5;
  String question6;
  List<dynamic> question7;
  FormQuestion(
      {this.id,
      this.namePerson,
      this.dateCompleted,
      this.question1,
      this.question2,
      this.question3,
      this.question4,
      this.question5,
      this.question6,
      this.question7});

  factory FormQuestion.fromJson(dynamic json) {
    return new FormQuestion(id:json["id"],namePerson: json["name"]as String, );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "namePerson": this.namePerson,
      "dateCompleted": this.dateCompleted,
      "question1": this.question1,
      "question2": this.question2,
      "question3": this.question3,
      "question4": this.question4,
      "question5": this.question5,
      "question6": this.question6,
      "question7": this.question7,
    };
  }
}