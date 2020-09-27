 import 'package:firebase_database/firebase_database.dart';

class Need {
 String ph, name,email,key;
  Need({
    this.email,
    this.name,
    this.ph,
  });

  Map<String, dynamic> tomap(){
    return{
      "name":this.name,
      "Eemail":this.email,
      "ph":this.ph,

    };
  }
}