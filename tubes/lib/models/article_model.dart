import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String body;
  final String author;
  final String authorImageUrl;
  final String category;
  final String imageUrl;
  final int view;
  final DateTime createdAt;

  const Article({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.author,
    required this.authorImageUrl,
    required this.category,
    required this.imageUrl,
    required this.view,
    required this.createdAt,
  });

  static List<Article> articles = [
    Article(
        id: '1',
        title:
            '"Militer Hantu" Ukraina Bikin Tentara Rusia Tertipu Serbu Target Palsu',
        subtitle: 'test',
        body: 'Jakarta, CNN Indonesia -- Perusahaan Ukraina, Metinvest, telah memproduksi peralatan umpan untuk militer Ukraina agar tentara Rusia membuang-buang amunisinya dengan menargetkan sasaran palsu dan bukan sasaran asli.Menurut laporan dari Wall Street Journal seperti dilansir Jerusalem Post, sekitar setengah dari peralatan umpan militer tersebut telah menjadi sasaran palsu yang dihancurkan militer Rusia. Faktanya, laporan Rusia mengenai penghancuran senjata Ukraina melebihi jumlah senjata yang dimiliki Ukraina, yang menunjukkan kemanjuran peralatan umpan tersebut. Perusahaan Ukraina tersebut memproduksi peralatan militer palsu itu dari bahan yang murah dan ringan seperti busa plastik, peralatan pipa ledeng, dan besi tua. Dengan cara ini, Metinvest dapat dengan cepat membuat gudang senjata howitzer palsu, mortir, stasiun radio, dan peralatan serupa lainnya. Selain itu, karena tidak berat atau mahal, peralatan Metinvest dapat diproduksi dengan relatif cepat. Kemudian dapat diangkut dan dirakit dengan mudah dan cepat. Faksimili sempurna dari artileri berukuran besar dapat dibuat dalam waktu yang sangat singkat. Laporan Wall Street Journal mencatat bahwa replika senjata howitzer D-20 Ukraina dapat diproduksi oleh pekerja Metinvest hanya dalam waktu empat hari. Replika howitzer M777 Amerika membutuhkan waktu sekitar dua minggu. Inflatech, sebuah perusahaan Ceko, juga membuat peralatan perang umpan untuk Ukraina. Peralatan militer umpan tiup Inflatch juga dapat diproduksi dan digunakan dengan kecepatan kilat. Peralatan tersebut juga sangat mudah untuk diangkut. Laporan Wall Street Journal mengutip kepala eksekutif Inflatech, Vojtech Fresser, yang mengatakan "Anda dapat memasukkan empat tank ke dalam kendaraan sipil" dan mencatat bahwa tank Inflatech Leopard dapat dibawa ke mana-mana dalam tas ransel. Tank palsu yang ditiup itu hanya membutuhkan sepuluh menit dengan menggunakan generator untuk bisa mengembang maksimal.',
        author: 'Thoriq Hidayansyah',
        authorImageUrl: 'test',
        category: 'Internasional',
        imageUrl:
            'https://cdn.discordapp.com/attachments/1154683188594102312/1160518989659787357/tentara.png?ex=6534f488&is=65227f88&hm=aa3dac42e43a949afbf765d8a5a2ff2957f2eb467bb78a5bb918fbf70bb0bdf3&',
        view: 1204,
        createdAt: DateTime.now().subtract(const Duration(hours: 5))),
    Article(
        id: '2',
        title:
            'Drone Rusia Terjang Acara Peringatan Veteran Ukraina, 51 Orang Tewas',
        subtitle: 'test',
        body: 'Jakarta, CNN Indonesia -- Setidaknya 51 orang tewas imbas serangan drone Rusia di Kota Ukraina, Kupiansk, saat warga menggelar peringatan bagi tentara yang gugur, Kamis (5/10). Pejabat Ukraina menyebut insiden ini merupakan salah satu serangan paling mematikan selama perang berkecamuk. Pejabat militer di Kupiansk, Oleh Synehubov, mengatakan korban yang tewas mencakup anak berusia 6 tahun. Ia tertimbun di antara reruntuhan puing. Sementara itu, Menteri Dalam Negeri Ukraina Ihor Klymenko mengatakan 29 dari jumlah korban tewas berhasil diidentifikasi. Jenazah-jenazah tersebut juga dikirim ke fasilitas kesehatan di Kharkiv. Ihor mengatakan pasukan Rusia menargetkan kafe dan toko di Hroza, wilayah Kharkiv. Ada sejumlah penduduk lokal saat rudal menghantam toko itu. Rusia menyerang Hroza menggunakan drone Iskandar, demikian menurut pejabat Ukraina. Senjata ini merupakan rudal balistik dengan jarak relatif pendek. Senjata ini telah banyak digunakan Rusia untuk melawan Ukraina dan menyebabkan banyak korban tewas. Insiden ini memicu skala kehancuran yang belum pernah terjadi sebelumnya sejak serangan di stasiun kereta api di Kramatorsk pada awal 2022. Imbas insiden ini, lebih dari 60 orang meninggal. Juru bicara Kantor Kejaksaan Regional Kharkiv, Dmytro Chubenko, mengatakan saat rudal menghantam kafe itu tengah menggelar penghormatan bagi tentara Ukraina yang gugur.  Tentara Ukraina yang gugur sebelumnya dimakamkan di Kota Dipro. Namun, kerabat para tentara ini ingin mereka dimakamkan di tempat asal.',
        author: 'Linda Syifa Andara',
        authorImageUrl: 'test',
        category: 'Internasional',
        imageUrl:
            'https://cdn.discordapp.com/attachments/1154683188594102312/1160519572848390254/drone.png?ex=6534f513&is=65228013&hm=82217749d650da929332b9af6907b8b9177cc0903c130663b566f8b17c030bc6&',
        view: 1204,
        createdAt: DateTime.now().subtract(const Duration(hours: 2))),
    Article(
        id: '3',
        title:
            'Curhat Seller-Affiliate Usai TikTok Shop Dilarang Pemerintah Jualan',
        subtitle: 'test',
        body: 'Jakarta, CNN Indonesia -- Pemerintah resmi melarang TikTok Shop untuk berjualan dan melayani transaksi lewat Peraturan Menteri Perdagangan (Permendag) No 31 Tahun 2023. Seller dan affiliate TikTok Shop mengaku larangan ini akan berpengaruh besar pada pendapatan mereka. Salah satu seller TikTok Shop di Jakarta, Helena, mengklaim larangan ini akan mempengaruhi pendapatan secara keseluruhan tokonya. Ia berharap TikTok bisa memisahkan platform media sosial dengan e-commerce-nya agar ia tetap bisa mempertahankan pelanggan untuk berbelanja di tokonya. Hanya saja, ia berpendapat jika TikTok Shop ditutup secara permanen tanpa ada penggantinya, ataupun pemerintah tak memberikan solusi lain untuk seller berjualan di sosial media, hal ini akan menjadi masalah besar. "Tapi apapun regulasi dari pemerintah, menurut saya seller harus tetap selalu bisa adaptasi dengan perkembangan dan perubahan regulasi maupun teknologi," kata dia kepada CNNIndonesia.com, Selasa (3/10). Menurutnya, larangan ini akan lebih berimbas kepada seller-seller kecil yang hanya berjualan di TikTok Shop. Sebab berdasarkan pengalamannya, berjualan di TikTok Shop lebih banyak mengundang penjual dibandingkan e-commerce lainnya. "Karena memang berdasarkan pengalaman berjualan di TikTok Shop itu kayak magic saja. Toko baru saja tuh bisa cepat banget ramainya, cepat banget dikenal sama orang. Apalagi kalau ada konten yang FYP, sangat beda jauh dengan kita berjualan di platform e-commerce aja, itu effort-nya lebih banyak dan butuh waktu yang sangat lama," ungkap Helena. Namun, menurut dia, di setiap masalah tentu selalu ada solusinya. Ia berpendapat pemerintah sudah melakukan tugasnya dengan baik dan seller TikTok Shop harus berinisiatif agar bisa berinovasi mengikuti perkembangan serta tak terpaku pada satu platform saja. Nelva mengatakan dunia digital tak bisa ditekan untuk laju pertumbuhannya. Digital, lanjutnya, pasti akan terus melesat dari perkembangan manusia itu sendiri. "Kalau misalnya manusia itu enggak bisa nerima yang namanya platform digital, ya mereka bisa apa? Kalau misalnya ada pandemi lagi, enggak minta ya, kalau misalnya ada semacam pandemi kayak kemarin, apa yang bisa mereka lakukan?" ujarnya. Namun di sisi lain, ia mengatakan ada sisi positif dan negatif yang bisa diambil dari larangan ini. "Kasihan juga sama UMKM yang udah punya stan di tempat-tempat mall atau tempat swalayan. Kasihan juga, mereka juga sedih. Tetapi itu tadi, ada plus minusnya juga," pungkasnya.',
        author: 'Etti Resmini',
        authorImageUrl: 'test',
        category: 'Ekonomi',
        imageUrl:
            'https://cdn.discordapp.com/attachments/1154683188594102312/1160541411763032114/FREE_TikTok_Logo_PNG_-_MockoFUN.jpeg?ex=6535096a&is=6522946a&hm=a0e119bcad3df3a884723e612eaa426bcccd7d4ff7b726cb7b5bfd1538b420d4&',
        view: 1204,
        createdAt: DateTime.now().subtract(const Duration(hours: 3))),
        
  ];

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        body,
        author,
        authorImageUrl,
        category,
        imageUrl,
        view,
        createdAt,
      ];
}
