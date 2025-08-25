// Map Id của icon với background tương ứng

final Map<int, String> weatherBackgrounds = {
  1: "assets/images/du_bao_thoi_tiet/troi_nang/troi_nang.webp",
  2: "assets/images/du_bao_thoi_tiet/troi_nang/troi_nang.webp",
  3: "assets/images/du_bao_thoi_tiet/troi_nang/troi_nang.webp",
  4: "assets/images/du_bao_thoi_tiet/troi_nang/troi_nang.webp",
  5: "assets/images/du_bao_thoi_tiet/troi_nang/troi_nang.webp",
  6: "assets/images/du_bao_thoi_tiet/troi_nang/troi_nang.webp",
  7: "assets/images/du_bao_thoi_tiet/troi_may/troi_may.webp",
  8: "assets/images/du_bao_thoi_tiet/troi_may/troi_may.webp",
  11: "assets/images/du_bao_thoi_tiet/troi_may/suong_mu.jpg",
  12: "assets/images/du_bao_thoi_tiet/troi_mua/mua_rao.jpg",
  13: "assets/images/du_bao_thoi_tiet/troi_mua/troi_mua_ban_ngay.jpg",
  14: "assets/images/du_bao_thoi_tiet/troi_mua/troi_mua_ban_ngay.jpg",
  15: "assets/images/du_bao_thoi_tiet/troi_mua/giong_bao.jpg",
  16: "assets/images/du_bao_thoi_tiet/troi_mua/troi_mua_ban_ngay.jpg",
  17: "assets/images/du_bao_thoi_tiet/troi_mua/troi_mua_ban_ngay.jpg",
  18: "assets/images/du_bao_thoi_tiet/troi_mua/mua_rao.jpg",
  19: "assets/images/du_bao_thoi_tiet/troi_tuyet/mua_tuyet.jpg",
  20: "assets/images/du_bao_thoi_tiet/troi_tuyet/mua_tuyet.jpg",
  21: "assets/images/du_bao_thoi_tiet/troi_tuyet/nang_kem_tuyet.jpg",
  22: "assets/images/du_bao_thoi_tiet/troi_tuyet/tuyet.jpg",
  23: "assets/images/du_bao_thoi_tiet/troi_tuyet/mua_tuyet.jpg",
  24: "assets/images/du_bao_thoi_tiet/troi_tuyet/bang_gia.jpg",
  25: "assets/images/du_bao_thoi_tiet/troi_tuyet/mua_tuyet.jpg",
  26: "assets/images/du_bao_thoi_tiet/troi_tuyet/mua_tuyet.jpg",
  29: "assets/images/du_bao_thoi_tiet/troi_tuyet/mua_tuyet.jpg",
  30: "assets/images/du_bao_thoi_tiet/troi_nang/troi_nong.jpg",
  31: "assets/images/du_bao_thoi_tiet/troi_tuyet/troi_lanh.jpg",
  32: "assets/images/du_bao_thoi_tiet/troi_may/gio.gif",
  33: "assets/images/du_bao_thoi_tiet/troi_may/ban_dem.jpg",
  34: "assets/images/du_bao_thoi_tiet/troi_may/ban_dem.jpg",
  35: "assets/images/du_bao_thoi_tiet/troi_may/ban_dem.jpg",
  36: "assets/images/du_bao_thoi_tiet/troi_may/ban_dem.jpg",
  37: "assets/images/du_bao_thoi_tiet/troi_may/ban_dem.jpg",
  38: "assets/images/du_bao_thoi_tiet/troi_may/ban_dem.jpg",
  39: "assets/images/du_bao_thoi_tiet/troi_mua/mua_rao.jpg",
  40: "assets/images/du_bao_thoi_tiet/troi_mua/mua_rao.jpg",
  41: "assets/images/du_bao_thoi_tiet/troi_mua/giong_bao.jpg",
  42: "assets/images/du_bao_thoi_tiet/troi_mua/giong_bao.jpg",
  43: "assets/images/du_bao_thoi_tiet/troi_tuyet/tuyet_ban_dem.jpg",
  44: "assets/images/du_bao_thoi_tiet/troi_tuyet/tuyet_ban_dem.jpg",
};

String getWeatherBackground(int code) {
  return weatherBackgrounds[code] ??
      "Không load được ảnh, vui lòng thử lại"; // fallback nếu không có code
}

