# Wau Warisan — Jelajah 3D

## Buka pada Windows

Klik dua kali `Buka-Wau.cmd`. Paparan akan terbuka dalam browser. Folder `dist` mesti kekal bersama fail pembuka. Tidak memerlukan pemasangan Node.js atau Python. Server hanya menerima sambungan pada komputer sendiri dan berhenti selepas dua jam tanpa penggunaan.

Jangan buka `dist/index.html` terus melalui `file://`, kerana browser menyekat pemuatan fail model melalui kaedah tersebut.

## Cara guna

1. Pilih Wau Jala Budi, Wau Kucing, Wau Seri Bulan atau Wau Bulan.
2. Tekan **Pisahkan bahagian** untuk mengasingkan kepala, kedua-dua sayap dan ekor dengan animasi.
3. Tekan model, label atau senarai bahagian untuk membuka kad maklumat satu persatu.
4. **Corak** membuka paparan dekat motif pada permukaan.
5. Seret untuk putar; skrol atau cubit untuk zum. Butang anak panah pada kad bergerak ke bahagian sebelumnya/seterusnya.
6. Tekan **Cantumkan semula** atau butang reset untuk mengembalikan model.

## Model dan kandungan

Paparan menggunakan geometri dan tekstur daripada empat GLB yang diberikan. GLB asal tidak diubah. Model web dioptimumkan dan diasingkan secara ruang kerana setiap GLB asal mengandungi satu mesh bercantum. Pemisahan ini menghasilkan potongan terbuka pada sambungan; ia ialah visualisasi pembelajaran, bukan model komponen pembinaan yang siap untuk pembuatan.

Corak ialah tekstur permukaan, bukan komponen geometri bebas. Maklumat budaya dikekalkan daripada teks pengguna; ia tidak menunjukkan pengesahan bahawa setiap butiran yang disebut terdapat secara literal pada mesh yang dibekalkan.

Kod utama: `dist/app.js` (maklumat, animasi, interaksi), `dist/style.css` (reka bentuk), `dist/index.html` (susun atur). Geometri dan tekstur: `dist/assets/`. Three.js r170 dan OrbitControls digunakan di bawah lesen MIT. Fon Google mempunyai fon pengganti jika tiada Internet.

Untuk integrasi pada laman lain, hoskan isi `dist/` pada pelayan HTTP/HTTPS. Tiada backend atau pangkalan data diperlukan.
