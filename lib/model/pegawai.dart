class Pegawai {
  String? id;
  String namaPegawai;
  String nipPegawai;
  String tgllahir;
  String notelp;
  String email;

  Pegawai({
    this.id,
    required this.namaPegawai,
    required this.nipPegawai,
    required this.tgllahir,
    required this.notelp,
    required this.email,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json["id"],
      namaPegawai:
          json["nama_pegawai"] ?? "", // Provide a default value if null
      nipPegawai: json["nip_pegawai"] ?? "", // Provide a default value if null
      tgllahir: json["tgl_lahir"] ?? "", // Provide a default value if null
      notelp: json["no_telp"] ?? "", // Provide a default value if null
      email: json["email"] ?? "", // Provide a default value if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama_pegawai": namaPegawai,
      "nip_pegawai": nipPegawai,
      "tgl_lahir": tgllahir,
      "no_telp": notelp,
      "email": email,
    };
  }
}
