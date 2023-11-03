class User_model{
   String email;
   int id;
   String name;
   String phone;
   int orderCount;

   User_model({
     required this.email,
     required this.phone,
     required this.name,
     required this.id,
     required this.orderCount,
   });

   factory User_model.fromJson(Map<String, dynamic> json){
     return User_model(
         email: json["email"],
         phone: json["phone"],
         name: json["f_name"],
         id: json["id"],
         orderCount: json["order_count"],
     );
   }

}