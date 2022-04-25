import '../EntityLayer/Concrete/GiderTip.dart';

class GiderTipleri{
  GiderTipleri._();
  static List<GiderTip> getir=<GiderTip>[
  GiderTip.set(),
  GiderTip.set(sNo: 1, ad: "Elektirik", aciklama: "Elektrik faturası"),
  GiderTip.set(sNo: 2, ad: "Doğalgaz", aciklama: "Doğalgaz faturası"),
  GiderTip.set(sNo: 3, ad: "Su", aciklama: "Su faturası"),
  GiderTip.set(sNo: 4, ad: "Bakım", aciklama: "Doğlagaz bakımı")
  ];
}