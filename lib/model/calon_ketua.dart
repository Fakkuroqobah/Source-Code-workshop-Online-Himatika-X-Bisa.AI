// To parse this JSON data, do
//
//     final calonKetua = calonKetuaFromMap(jsonString);

import 'dart:convert';

class CalonKetua {
    CalonKetua({
        this.calonId,
        this.nama,
        this.vote,
        this.isActive,
    });

    final String calonId;
    final String nama;
    final int vote;
    final bool isActive;

    factory CalonKetua.fromJson(String str) => CalonKetua.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CalonKetua.fromMap(Map<String, dynamic> json) => CalonKetua(
        calonId: json["calonId"],
        nama: json["nama"],
        vote: json["vote"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toMap() => {
        "calonId": calonId,
        "nama": nama,
        "vote": vote,
        "isActive": isActive,
    };
}
