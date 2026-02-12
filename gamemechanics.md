# GAME_MECHANICS.md

**Version:** 1.6.0 (Production Candidate)
**Status:** Feature Complete
**Last Updated:** 2026-01-15
**Purpose:** Defines the strict rules, scoring algorithms, and flow logic for the "Word & Number" game.

---

## 1. GLOBAL RULES (GENEL KURALLAR)

Bu kurallar oyunun genel akışı ve yapısı için geçerlidir.

* **Oyun Yapısı (Game Session Structure):**
    * Bir standart oyun (Maç) toplam **6 Turdan** oluşur.
    * Sıralama ardışık ve değişmezdir:
        1.  **Tur 1:** Kelime Oyunu
        2.  **Tur 2:** İşlem Oyunu
        3.  **Tur 3:** Kelime Oyunu
        4.  **Tur 4:** İşlem Oyunu
        5.  **Tur 5:** Kelime Oyunu
        6.  **Tur 6:** İşlem Oyunu
    * **Toplam Süre:** Bir maç, ara geçişler dahil yaklaşık 6-8 dakika sürer.

* **Kazanma Koşulu (Winning Condition):**
    * 6. turun sonunda `TotalScore` (Toplam Puan) en yüksek olan kazanır.
    * **Beraberlik (Tie-Breaker):** Puanlar eşitse, 6 tur boyunca harcanan **Toplam Süreye** bakılır. Daha az süre harcayan (daha hızlı çözen) kazanır.

* **Süre Mekaniği:**
    * Her tur için düşünme süresi **60 saniyedir**.
    * Kullanıcı "Tamam/Gönder" butonuna bastığı an süre durur.
    * **Time Bonus:** Sadece cevap **geçerliyse** verilir.
        * Formül: `Kalan Saniye x 1 Puan`.
        * Cevap yanlışsa veya boşsa Time Bonus = 0.

* **Oyun Terk (Disconnect/Resign):**
    * Maç bitmeden oyundan çıkan veya internet bağlantısı 30 saniyeden uzun süre kopan oyuncu **Hükmen Mağlup** sayılır (Puanı 0 olur).

---

## 2. KELİME OYUNU (WORD GAME)

### 2.1. Envanter ve Üretim
Kullanıcıya toplam **8 Harf** verilir. Ayrıca her zaman kullanılabilir **1 Joker** hakkı vardır.

* **Havuz:** Türk alfabesi frekanslarına göre ağırlıklandırılmış harf torbası.
* **Dağıtım Modları:**
    * **Manuel Seçim:** Kullanıcı tek tek "Sesli" veya "Sessiz" butonuna basar.
    * **Rastgele (Hepsini Getir):** Sistem 8 harfi otomatik çeker.
        * *Kısıtlama:* Çekilen 8 harfin içinde **En az 3**, **En fazla 4** sesli harf olmak zorundadır.

### 2.2. Geçerlilik Kuralları (Validation)
Bir kelimenin puan alabilmesi için şu şartları sağlaması gerekir:

1.  **Uzunluk:** En az 3 harfli olmalıdır.
2.  **Sözlük:** Referans alınan TDK bazlı veri tabanında bulunmalıdır.
3.  **Morfoloji Kuralları (Kritik):**
    * 🔴 **YASAK:** Çekim ekleri (İyelik, çokluk, hal ekleri, zaman ekleri).
        * *Örn:* "KALEMLER", "GELİYOR", "EVİM" (Geçersiz).
    * 🟢 **SERBEST:** Yapım ekleri (Kelimenin anlamını değiştirenler) ve Mastar halleri.
        * *Örn:* "KALEMLİK", "GELMEK", "OYUNCU" (Geçerli).
4.  **Joker Kullanımı:**
    * Joker, istenilen herhangi bir harfin yerine geçer.
    * Sistem, Joker kullanıldığında oluşabilecek en yüksek puanlı kelimeyi varsayar.

### 2.3. Puanlama (Scoring Formula)
Puan hesaplaması şu formülle yapılır:

`TotalScore = BaseScore + LengthBonus + TimeBonus`

* **Standart Harf:** 10 Puan.
* **Joker Harf:** 5 Puan.
* **Tam Puan Bonusu:** Eğer kullanıcı verilen **8 harfin tamamını** ve **Joker'i** kullanarak **9 harfli** geçerli bir kelime türetirse:
    * Normal hesaplama yapılmaz, sabit **120 Puan** verilir (+ Time Bonus).

---

## 3. İŞLEM OYUNU (NUMBER GAME)

### 3.1. Envanter ve Üretim
Kullanıcıya **6 Sayı** ve **1 Hedef Sayı** verilir.

* **Sayı Havuzu:**
    * **Küçükler (1-9):** Her sayıdan en fazla 2 adet olabilir.
    * **Büyükler (10, 25, 40, 50, 60, 75):** Tam olarak 1 tane bulunur.
* **Dağıtım Kuralı:** Sistem rastgele 6 sayı seçer.
    * **Zorunluluk:** Büyükler havuzundan **tam olarak 1 tane** bulunur (ulaşılabilirlik garantisi için).
    * **Kalan 5 sayı:** Küçükler havuzundan seçilir (her küçük sayıdan max 2 adet).
    * *Örn:* `[75, 3, 5, 8, 2, 9]`, `[10, 1, 1, 4, 7, 6]`
* **Hedef Sayı:**
    * Aralık: 100 - 999.
    * **Kısıtlama:** Asal sayı (Prime Number) **OLAMAZ**.
    * **Ulaşılabilirlik Garantisi:** `generateValidatedGameSet()` metodu kullanılarak hedef sayıya ±9 mesafe içinde ulaşılabilirlik garanti edilir.

### 3.2. Matematik Kuralları (Math Engine)
Kullanıcı 4 işlem (+, -, *, /) kullanabilir.

1.  **Tek Kullanım:** Her verilen sayı en fazla 1 kez kullanılabilir.
2.  **Ara Sonuçlar:** İşlem sonucu oluşan yeni sayılar tekrar kullanılabilir.
3.  **Negatif/Sıfır Yasağı:** İşlem sonucu pozitif tam sayı (>0) olmalıdır.
4.  **Bölme Kuralı:** Sadece kalansız bölme (tam sayı sonucu) geçerlidir.

### 3.3. Puanlama (Scoring Formula)
Kullanıcının bulduğu sayıya `UserResult`, hedefe `Target` diyelim.

* **Mesafe (Distance):** `|Target - UserResult|`
* **Geçerli Aralık:** Mesafe en fazla 10 olabilir. Mesafe > 10 ise puan 0'dır.

| Mesafe (Fark) | İşlem Puanı |
| :--- | :--- |
| 0 (Tam Eşleşme) | **100 Puan** |
| 1 (±1 Yaklaşık) | 90 Puan |
| 2 (±2 Yaklaşık) | 80 Puan |
| 3 (±3 Yaklaşık) | 70 Puan |
| ... | ... |
| 9 (±9 Yaklaşık) | 10 Puan |
| ≥10 (±10+)      | 0 Puan  |

* **Ulaşılabilirlik Garantisi:** `generateValidatedGameSet()` metodu ile her oyunda hedef sayıya **±9 mesafe** içinde ulaşılabilirlik garanti edilir. Algoritma: Sayı ve hedef üret → Solver ile kontrol et → Geçersizse tekrar üret (max 10 deneme). Ortalama 1-2 denemede başarılı (~5ms).
* **Time Bonus:** Sadece puan > 0 ise eklenir. `Kalan Saniye x 1`.

---

## 4. UI/UX ETKİLEŞİM MEKANİĞİ

### 4.1. İşlem Oyunu Giriş Yöntemi (Step-by-Step)
Kullanıcı metin yazmaz, interaktif butonlara tıklar. Bu yöntem validasyon hatasını minimize eder.

* **Akış:** `[Sayı A]` -> `[İşlem]` -> `[Sayı B]` -> `[Sonuç]`
* **Görsel:** `[Sayı A]` ve `[Sayı B]` envanterden silinir, `[Sonuç]` envantere eklenir.
* **Undo (Geri Al):** Son işlemi geri alır. `[Sonuç]` silinir, kullanılan sayılar geri gelir.

### 4.2. Tur Sonu (Round Summary)
Her tur sonunda (Kelime veya İşlem) şu bilgiler gösterilir:

1.  **Kullanıcının Cevabı ve Puanı.**
2.  **Server'ın Çözümü (Best Solution):**
    * *Kelime:* O harflerle yazılabilecek en uzun kelime.
    * *İşlem:* Hedefe giden en kısa matematiksel yol.
3.  **Kelime Anlamı:** Bulunan kelimenin TDK anlamı (Sadece Kelime turunda).

---

## 5. TEKNİK NOTLAR

* **Data Structure:** `WordGameEngine` ve `NumberGameEngine` sınıfları pure Dart (UI'sız) olmalı.
* **Testing:** Unit testler yazılırken bu dökümandaki puanlama tabloları ve yasaklı durumlar (negatif sonuç, çekim eki vb.) %100 kapsanmalıdır.
* **Security:** Client-side puan hesaplaması sadece gösterim amaçlıdır. Nihai puan her zaman Server tarafından bu kurallar setine göre hesaplanır.

---

## 6. İMPLEMENTASYON DURUMU

### 6.1. Tamamlanan Özellikler (Number Game)

| Özellik | Dosya | Durum |
|---------|-------|-------|
| Sayı Üreteci | `number_generator.dart` | ✅ |
| 4 İşlem (Operation) | `operation.dart` | ✅ |
| Oyun Durumu (State) | `number_game_state.dart` (Freezed) | ✅ |
| Adım Geçmişi | `game_step.dart` | ✅ |
| Puanlama Motoru | `scoring_utils.dart` | ✅ |
| Oyun Kontrolcüsü | `number_game_controller.dart` (Riverpod) | ✅ |
| Timer Sistemi | `number_game_controller.dart` | ✅ |
| UI Ekranı | `number_game_screen.dart` | ✅ |
| Undo/Reset | `game_controls_bar.dart` | ✅ |
| Number Solver Engine | `solver/backtracking_solver.dart` | ✅ |

### 6.2. Test Kapsamı

| Test | Dosya | Sonuç |
|------|-------|-------|
| Puanlama Hesaplama | `scoring_utils_test.dart` | ✅ PASS |
| Sayı Üreteci | `number_generator_test.dart` | ✅ PASS |
| İşlem Doğruluğu | `operation_test.dart` | ✅ PASS |
| Ulaşılabilirlik | `quick_reachability_test.dart` | ✅ PASS |
| Solver Engine | `solver_test.dart` | ✅ PASS (20 test) |

### 6.3. Tamamlanan Özellikler (Word Game)

| Özellik | Dosya | Durum |
|---------|-------|-------|
| Harf Üreteci | `letter_generator.dart` | ✅ |
| Oyun Durumu (State) | `word_game_state.dart` (Freezed) | ✅ |
| Puanlama Motoru | `word_scoring_utils.dart` | ✅ |
| Harf Doğrulama | `letter_validation.dart` | ✅ |
| Sözlük Interface | `word_dictionary.dart` | ✅ |
| Mock Sözlük | `mock_dictionary.dart` (~600 kelime) | ✅ |
| Word Solver | `word_solver.dart` | ✅ |
| Oyun Kontrolcüsü | `word_game_controller.dart` (Riverpod) | ✅ |
| Timer Sistemi | `word_game_controller.dart` | ✅ |
| Word Game UI | `word_game_screen.dart` | ✅ |

### 6.4. Word Game Test Kapsamı

| Test | Dosya | Sonuç |
|------|-------|-------|
| Harf Üreteci | `letter_generator_test.dart` | ✅ PASS (18 test) |
| Puanlama | `word_scoring_test.dart` | ✅ PASS (22 test) |
| Harf Doğrulama | `letter_validation_test.dart` | ✅ PASS (17 test) |
| Mock Sözlük | `mock_dictionary_test.dart` | ✅ PASS (15 test) |
| Word Solver | `word_solver_test.dart` | ✅ PASS (14 test) |
| Oyun Kontrolcüsü | `word_game_controller_test.dart` | ✅ PASS (24 test) |

### 6.5. Tamamlanan Özellikler (Shared/UI)

| Özellik | Dosya | Durum |
|---------|-------|-------|
| Round Result Screen | `round_result_screen.dart` | ✅ |
| Final Result Screen | `final_result_screen.dart` | ✅ |
| Home Screen | `home_screen.dart` | ✅ |
| Navigation | `app_router.dart` | ✅ |
| How To Play Screens | `how_to_play_*.dart` | ✅ |

### 6.6. Number Solver Engine Performans Metrikleri

| Metrik | Değer |
|--------|-------|
| 100 oyun çözüm süresi | ~520ms |
| 1000 oyunda exact match oranı | %94.4 |
| 1000 oyunda geçerli sonuç oranı (≤9 mesafe) | %99.8 |

---

## 7. DEĞİŞİKLİK GEÇMİŞİ

| Versiyon | Tarih | Değişiklik |
|----------|-------|------------|
| 1.0.0 | - | İlk sürüm |
| 1.1.0 | - | Final Scope onayı |
| 1.2.0 | 2026-01-13 | Büyük sayı zorunlu hale getirildi (önceden isteğe bağlıydı). Ulaşılabilirlik testi eklendi (%0 ulaşılamaz garanti). İmplementasyon durumu eklendi. |
| 1.3.0 | 2026-01-15 | Number Solver Engine eklendi. Backtracking + pruning algoritması ile hedefe ulaşan en kısa yol bulunur. %94.4 exact match, %99.8 geçerli sonuç oranı. |
| 1.3.1 | 2026-01-15 | `generateValidatedGameSet()` eklendi: Ulaşılabilirlik garantili oyun seti üretimi. Geçersiz set üretilirse otomatik yeniden deneme (max 10). %100 geçerli garanti. |
| 1.4.0 | 2026-01-15 | Word Game Domain katmanı eklendi: Harf üreteci (Türkçe frekanslar, 3-4 sesli garantisi), puanlama motoru (10 puan/harf, 5 puan joker, 120 puan 9 harfli bonus), harf doğrulama, mock sözlük (~600 kelime), word solver. 86 unit test geçti. |
| 1.5.0 | 2026-01-15 | Word Game Application katmanı eklendi: WordGameController (Riverpod Notifier), Timer sistemi, manuel harf seçimi (sesli/sessiz), kelime validasyonu, submit/reset. 110 word game testi (86 domain + 24 controller) geçti. |
| 1.6.0 | 2026-01-15 | UI Implementasyonu tamamlandı: Word Game Screen, Result Screens (Round & Final), Home Screen ve Navigation yapısı entegre edildi. Proje Feature Complete statüsünde. |