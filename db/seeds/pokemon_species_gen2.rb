# 第2世代 ポケモン図鑑データ（No.152〜No.251）
# db/seeds.rb から呼び出される
# タイプ・種族値・特性は公式データに基づく（第6世代以降の最新値）
# height: デシメートル単位 / weight: ヘクトグラム単位
# abilities: 通常特性のみ（隠れ特性は含まない）

POKEMON_GEN2_DATA = [
  # === No.152 チコリータ ===
  {
    national_id: 152,
    name_ja: 'チコリータ',
    name_en: 'Chikorita',
    name_kana: 'チコリータ',
    data: {
      types: ['くさ'],
      stats: { hp: 45, attack: 49, defense: 65, special_attack: 49, special_defense: 65, speed: 45 },
      abilities: ['しんりょく'],
      height: 9, weight: 64,
      generation: 2, category: 'はっぱポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.153 ベイリーフ ===
  {
    national_id: 153,
    name_ja: 'ベイリーフ',
    name_en: 'Bayleef',
    name_kana: 'ベイリーフ',
    data: {
      types: ['くさ'],
      stats: { hp: 60, attack: 62, defense: 80, special_attack: 63, special_defense: 80, speed: 60 },
      abilities: ['しんりょく'],
      height: 12, weight: 158,
      generation: 2, category: 'はっぱポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.154 メガニウム ===
  {
    national_id: 154,
    name_ja: 'メガニウム',
    name_en: 'Meganium',
    name_kana: 'メガニウム',
    data: {
      types: ['くさ'],
      stats: { hp: 80, attack: 82, defense: 100, special_attack: 83, special_defense: 100, speed: 80 },
      abilities: ['しんりょく'],
      height: 18, weight: 1005,
      generation: 2, category: 'ハーブポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.155 ヒノアラシ ===
  {
    national_id: 155,
    name_ja: 'ヒノアラシ',
    name_en: 'Cyndaquil',
    name_kana: 'ヒノアラシ',
    data: {
      types: ['ほのお'],
      stats: { hp: 39, attack: 52, defense: 43, special_attack: 60, special_defense: 50, speed: 65 },
      abilities: ['もうか'],
      height: 5, weight: 79,
      generation: 2, category: 'ひねずみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.156 マグマラシ ===
  {
    national_id: 156,
    name_ja: 'マグマラシ',
    name_en: 'Quilava',
    name_kana: 'マグマラシ',
    data: {
      types: ['ほのお'],
      stats: { hp: 58, attack: 64, defense: 58, special_attack: 80, special_defense: 65, speed: 80 },
      abilities: ['もうか'],
      height: 9, weight: 190,
      generation: 2, category: 'かざんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.157 バクフーン ===
  {
    national_id: 157,
    name_ja: 'バクフーン',
    name_en: 'Typhlosion',
    name_kana: 'バクフーン',
    data: {
      types: ['ほのお'],
      stats: { hp: 78, attack: 84, defense: 78, special_attack: 109, special_defense: 85, speed: 100 },
      abilities: ['もうか'],
      height: 17, weight: 795,
      generation: 2, category: 'かざんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.158 ワニノコ ===
  {
    national_id: 158,
    name_ja: 'ワニノコ',
    name_en: 'Totodile',
    name_kana: 'ワニノコ',
    data: {
      types: ['みず'],
      stats: { hp: 50, attack: 65, defense: 64, special_attack: 44, special_defense: 48, speed: 43 },
      abilities: ['げきりゅう'],
      height: 6, weight: 95,
      generation: 2, category: 'おおあごポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.159 アリゲイツ ===
  {
    national_id: 159,
    name_ja: 'アリゲイツ',
    name_en: 'Croconaw',
    name_kana: 'アリゲイツ',
    data: {
      types: ['みず'],
      stats: { hp: 65, attack: 80, defense: 80, special_attack: 59, special_defense: 63, speed: 58 },
      abilities: ['げきりゅう'],
      height: 11, weight: 250,
      generation: 2, category: 'おおあごポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.160 オーダイル ===
  {
    national_id: 160,
    name_ja: 'オーダイル',
    name_en: 'Feraligatr',
    name_kana: 'オーダイル',
    data: {
      types: ['みず'],
      stats: { hp: 85, attack: 105, defense: 100, special_attack: 79, special_defense: 83, speed: 78 },
      abilities: ['げきりゅう'],
      height: 23, weight: 888,
      generation: 2, category: 'おおあごポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.161 オタチ ===
  {
    national_id: 161,
    name_ja: 'オタチ',
    name_en: 'Sentret',
    name_kana: 'オタチ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 35, attack: 46, defense: 34, special_attack: 35, special_defense: 45, speed: 20 },
      abilities: ['にげあし', 'するどいめ'],
      height: 8, weight: 60,
      generation: 2, category: 'みはりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.162 オオタチ ===
  {
    national_id: 162,
    name_ja: 'オオタチ',
    name_en: 'Furret',
    name_kana: 'オオタチ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 85, attack: 76, defense: 64, special_attack: 45, special_defense: 55, speed: 90 },
      abilities: ['にげあし', 'するどいめ'],
      height: 18, weight: 325,
      generation: 2, category: 'ながいからだポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.163 ホーホー ===
  {
    national_id: 163,
    name_ja: 'ホーホー',
    name_en: 'Hoothoot',
    name_kana: 'ホーホー',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 60, attack: 30, defense: 30, special_attack: 36, special_defense: 56, speed: 50 },
      abilities: ['ふみん', 'するどいめ'],
      height: 7, weight: 212,
      generation: 2, category: 'ふくろうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.164 ヨルノズク ===
  {
    national_id: 164,
    name_ja: 'ヨルノズク',
    name_en: 'Noctowl',
    name_kana: 'ヨルノズク',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 100, attack: 50, defense: 50, special_attack: 86, special_defense: 96, speed: 70 },
      abilities: ['ふみん', 'するどいめ'],
      height: 16, weight: 408,
      generation: 2, category: 'ふくろうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.165 レディバ ===
  {
    national_id: 165,
    name_ja: 'レディバ',
    name_en: 'Ledyba',
    name_kana: 'レディバ',
    data: {
      types: ['むし', 'ひこう'],
      stats: { hp: 40, attack: 20, defense: 30, special_attack: 40, special_defense: 80, speed: 55 },
      abilities: ['むしのしらせ', 'はやおき'],
      height: 10, weight: 108,
      generation: 2, category: 'いつつぼしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.166 レディアン ===
  {
    national_id: 166,
    name_ja: 'レディアン',
    name_en: 'Ledian',
    name_kana: 'レディアン',
    data: {
      types: ['むし', 'ひこう'],
      stats: { hp: 55, attack: 35, defense: 50, special_attack: 55, special_defense: 110, speed: 85 },
      abilities: ['むしのしらせ', 'はやおき'],
      height: 14, weight: 356,
      generation: 2, category: 'いつつぼしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.167 イトマル ===
  {
    national_id: 167,
    name_ja: 'イトマル',
    name_en: 'Spinarak',
    name_kana: 'イトマル',
    data: {
      types: ['むし', 'どく'],
      stats: { hp: 40, attack: 60, defense: 40, special_attack: 40, special_defense: 40, speed: 30 },
      abilities: ['むしのしらせ', 'ふみん'],
      height: 5, weight: 85,
      generation: 2, category: 'いとはきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.168 アリアドス ===
  {
    national_id: 168,
    name_ja: 'アリアドス',
    name_en: 'Ariados',
    name_kana: 'アリアドス',
    data: {
      types: ['むし', 'どく'],
      stats: { hp: 70, attack: 90, defense: 70, special_attack: 60, special_defense: 60, speed: 40 },
      abilities: ['むしのしらせ', 'ふみん'],
      height: 11, weight: 335,
      generation: 2, category: 'あしながポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.169 クロバット ===
  {
    national_id: 169,
    name_ja: 'クロバット',
    name_en: 'Crobat',
    name_kana: 'クロバット',
    data: {
      types: ['どく', 'ひこう'],
      stats: { hp: 85, attack: 90, defense: 80, special_attack: 70, special_defense: 80, speed: 130 },
      abilities: ['せいしんりょく'],
      height: 18, weight: 750,
      generation: 2, category: 'こうもりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.170 チョンチー ===
  {
    national_id: 170,
    name_ja: 'チョンチー',
    name_en: 'Chinchou',
    name_kana: 'チョンチー',
    data: {
      types: ['みず', 'でんき'],
      stats: { hp: 75, attack: 38, defense: 38, special_attack: 56, special_defense: 56, speed: 67 },
      abilities: ['ちくでん', 'はっこう'],
      height: 5, weight: 120,
      generation: 2, category: 'あんこうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.171 ランターン ===
  {
    national_id: 171,
    name_ja: 'ランターン',
    name_en: 'Lanturn',
    name_kana: 'ランターン',
    data: {
      types: ['みず', 'でんき'],
      stats: { hp: 125, attack: 58, defense: 58, special_attack: 76, special_defense: 76, speed: 67 },
      abilities: ['ちくでん', 'はっこう'],
      height: 12, weight: 225,
      generation: 2, category: 'ライトポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.172 ピチュー ===
  {
    national_id: 172,
    name_ja: 'ピチュー',
    name_en: 'Pichu',
    name_kana: 'ピチュー',
    data: {
      types: ['でんき'],
      stats: { hp: 20, attack: 40, defense: 15, special_attack: 35, special_defense: 35, speed: 60 },
      abilities: ['せいでんき'],
      height: 3, weight: 20,
      generation: 2, category: 'こねずみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.173 ピィ ===
  {
    national_id: 173,
    name_ja: 'ピィ',
    name_en: 'Cleffa',
    name_kana: 'ピィ',
    data: {
      types: ['フェアリー'],
      stats: { hp: 50, attack: 25, defense: 28, special_attack: 45, special_defense: 55, speed: 15 },
      abilities: ['メロメロボディ', 'マジックガード'],
      height: 3, weight: 30,
      generation: 2, category: 'ほしがたポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.174 ププリン ===
  {
    national_id: 174,
    name_ja: 'ププリン',
    name_en: 'Igglybuff',
    name_kana: 'ププリン',
    data: {
      types: ['ノーマル', 'フェアリー'],
      stats: { hp: 90, attack: 30, defense: 15, special_attack: 40, special_defense: 20, speed: 15 },
      abilities: ['メロメロボディ', 'かちき'],
      height: 3, weight: 10,
      generation: 2, category: 'ふうせんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.175 トゲピー ===
  {
    national_id: 175,
    name_ja: 'トゲピー',
    name_en: 'Togepi',
    name_kana: 'トゲピー',
    data: {
      types: ['フェアリー'],
      stats: { hp: 35, attack: 20, defense: 65, special_attack: 40, special_defense: 65, speed: 20 },
      abilities: ['はりきり', 'てんのめぐみ'],
      height: 3, weight: 15,
      generation: 2, category: 'はりたまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.176 トゲチック ===
  {
    national_id: 176,
    name_ja: 'トゲチック',
    name_en: 'Togetic',
    name_kana: 'トゲチック',
    data: {
      types: ['フェアリー', 'ひこう'],
      stats: { hp: 55, attack: 40, defense: 85, special_attack: 80, special_defense: 105, speed: 40 },
      abilities: ['はりきり', 'てんのめぐみ'],
      height: 6, weight: 32,
      generation: 2, category: 'しあわせポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.177 ネイティ ===
  {
    national_id: 177,
    name_ja: 'ネイティ',
    name_en: 'Natu',
    name_kana: 'ネイティ',
    data: {
      types: ['エスパー', 'ひこう'],
      stats: { hp: 40, attack: 50, defense: 45, special_attack: 70, special_defense: 45, speed: 70 },
      abilities: ['シンクロ', 'はやおき'],
      height: 2, weight: 20,
      generation: 2, category: 'ことりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.178 ネイティオ ===
  {
    national_id: 178,
    name_ja: 'ネイティオ',
    name_en: 'Xatu',
    name_kana: 'ネイティオ',
    data: {
      types: ['エスパー', 'ひこう'],
      stats: { hp: 65, attack: 75, defense: 70, special_attack: 95, special_defense: 70, speed: 95 },
      abilities: ['シンクロ', 'はやおき'],
      height: 15, weight: 150,
      generation: 2, category: 'せいれいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.179 メリープ ===
  {
    national_id: 179,
    name_ja: 'メリープ',
    name_en: 'Mareep',
    name_kana: 'メリープ',
    data: {
      types: ['でんき'],
      stats: { hp: 55, attack: 40, defense: 40, special_attack: 65, special_defense: 45, speed: 35 },
      abilities: ['せいでんき'],
      height: 6, weight: 78,
      generation: 2, category: 'わたげポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.180 モココ ===
  {
    national_id: 180,
    name_ja: 'モココ',
    name_en: 'Flaaffy',
    name_kana: 'モココ',
    data: {
      types: ['でんき'],
      stats: { hp: 70, attack: 55, defense: 55, special_attack: 80, special_defense: 60, speed: 45 },
      abilities: ['せいでんき'],
      height: 8, weight: 133,
      generation: 2, category: 'わたげポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.181 デンリュウ ===
  {
    national_id: 181,
    name_ja: 'デンリュウ',
    name_en: 'Ampharos',
    name_kana: 'デンリュウ',
    data: {
      types: ['でんき'],
      stats: { hp: 90, attack: 75, defense: 85, special_attack: 115, special_defense: 90, speed: 55 },
      abilities: ['せいでんき'],
      height: 14, weight: 615,
      generation: 2, category: 'ライトポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.182 キレイハナ ===
  {
    national_id: 182,
    name_ja: 'キレイハナ',
    name_en: 'Bellossom',
    name_kana: 'キレイハナ',
    data: {
      types: ['くさ'],
      stats: { hp: 75, attack: 80, defense: 95, special_attack: 90, special_defense: 100, speed: 50 },
      abilities: ['ようりょくそ'],
      height: 4, weight: 58,
      generation: 2, category: 'フラワーポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.183 マリル ===
  {
    national_id: 183,
    name_ja: 'マリル',
    name_en: 'Marill',
    name_kana: 'マリル',
    data: {
      types: ['みず', 'フェアリー'],
      stats: { hp: 70, attack: 20, defense: 50, special_attack: 20, special_defense: 50, speed: 40 },
      abilities: ['あついしぼう', 'ちからもち'],
      height: 4, weight: 85,
      generation: 2, category: 'みずねずみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.184 マリルリ ===
  {
    national_id: 184,
    name_ja: 'マリルリ',
    name_en: 'Azumarill',
    name_kana: 'マリルリ',
    data: {
      types: ['みず', 'フェアリー'],
      stats: { hp: 100, attack: 50, defense: 80, special_attack: 60, special_defense: 80, speed: 50 },
      abilities: ['あついしぼう', 'ちからもち'],
      height: 8, weight: 285,
      generation: 2, category: 'みずうさぎポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.185 ウソッキー ===
  {
    national_id: 185,
    name_ja: 'ウソッキー',
    name_en: 'Sudowoodo',
    name_kana: 'ウソッキー',
    data: {
      types: ['いわ'],
      stats: { hp: 70, attack: 100, defense: 115, special_attack: 30, special_defense: 65, speed: 30 },
      abilities: ['がんじょう', 'いしあたま'],
      height: 12, weight: 380,
      generation: 2, category: 'まねポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.186 ニョロトノ ===
  {
    national_id: 186,
    name_ja: 'ニョロトノ',
    name_en: 'Politoed',
    name_kana: 'ニョロトノ',
    data: {
      types: ['みず'],
      stats: { hp: 90, attack: 75, defense: 75, special_attack: 90, special_defense: 100, speed: 70 },
      abilities: ['ちょすい', 'しめりけ'],
      height: 11, weight: 339,
      generation: 2, category: 'かえるポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.187 ハネッコ ===
  {
    national_id: 187,
    name_ja: 'ハネッコ',
    name_en: 'Hoppip',
    name_kana: 'ハネッコ',
    data: {
      types: ['くさ', 'ひこう'],
      stats: { hp: 35, attack: 35, defense: 40, special_attack: 35, special_defense: 55, speed: 50 },
      abilities: ['ようりょくそ', 'リーフガード'],
      height: 4, weight: 5,
      generation: 2, category: 'わたくさポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.188 ポポッコ ===
  {
    national_id: 188,
    name_ja: 'ポポッコ',
    name_en: 'Skiploom',
    name_kana: 'ポポッコ',
    data: {
      types: ['くさ', 'ひこう'],
      stats: { hp: 55, attack: 45, defense: 50, special_attack: 45, special_defense: 65, speed: 80 },
      abilities: ['ようりょくそ', 'リーフガード'],
      height: 6, weight: 10,
      generation: 2, category: 'わたくさポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.189 ワタッコ ===
  {
    national_id: 189,
    name_ja: 'ワタッコ',
    name_en: 'Jumpluff',
    name_kana: 'ワタッコ',
    data: {
      types: ['くさ', 'ひこう'],
      stats: { hp: 75, attack: 55, defense: 70, special_attack: 55, special_defense: 95, speed: 110 },
      abilities: ['ようりょくそ', 'リーフガード'],
      height: 8, weight: 30,
      generation: 2, category: 'わたくさポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.190 エイパム ===
  {
    national_id: 190,
    name_ja: 'エイパム',
    name_en: 'Aipom',
    name_kana: 'エイパム',
    data: {
      types: ['ノーマル'],
      stats: { hp: 55, attack: 70, defense: 55, special_attack: 40, special_defense: 55, speed: 85 },
      abilities: ['にげあし', 'ものひろい'],
      height: 8, weight: 115,
      generation: 2, category: 'おながポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.191 ヒマナッツ ===
  {
    national_id: 191,
    name_ja: 'ヒマナッツ',
    name_en: 'Sunkern',
    name_kana: 'ヒマナッツ',
    data: {
      types: ['くさ'],
      stats: { hp: 30, attack: 30, defense: 30, special_attack: 30, special_defense: 30, speed: 30 },
      abilities: ['ようりょくそ', 'サンパワー'],
      height: 3, weight: 18,
      generation: 2, category: 'たねポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.192 キマワリ ===
  {
    national_id: 192,
    name_ja: 'キマワリ',
    name_en: 'Sunflora',
    name_kana: 'キマワリ',
    data: {
      types: ['くさ'],
      stats: { hp: 75, attack: 75, defense: 55, special_attack: 105, special_defense: 85, speed: 30 },
      abilities: ['ようりょくそ', 'サンパワー'],
      height: 8, weight: 85,
      generation: 2, category: 'たいようポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.193 ヤンヤンマ ===
  {
    national_id: 193,
    name_ja: 'ヤンヤンマ',
    name_en: 'Yanma',
    name_kana: 'ヤンヤンマ',
    data: {
      types: ['むし', 'ひこう'],
      stats: { hp: 65, attack: 65, defense: 45, special_attack: 75, special_defense: 45, speed: 95 },
      abilities: ['かそく', 'ふくがん'],
      height: 12, weight: 380,
      generation: 2, category: 'うすばねポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.194 ウパー ===
  {
    national_id: 194,
    name_ja: 'ウパー',
    name_en: 'Wooper',
    name_kana: 'ウパー',
    data: {
      types: ['みず', 'じめん'],
      stats: { hp: 55, attack: 45, defense: 45, special_attack: 25, special_defense: 25, speed: 15 },
      abilities: ['しめりけ', 'ちょすい'],
      height: 4, weight: 85,
      generation: 2, category: 'みずうおポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.195 ヌオー ===
  {
    national_id: 195,
    name_ja: 'ヌオー',
    name_en: 'Quagsire',
    name_kana: 'ヌオー',
    data: {
      types: ['みず', 'じめん'],
      stats: { hp: 95, attack: 85, defense: 85, special_attack: 65, special_defense: 65, speed: 35 },
      abilities: ['しめりけ', 'ちょすい'],
      height: 14, weight: 750,
      generation: 2, category: 'みずうおポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.196 エーフィ ===
  {
    national_id: 196,
    name_ja: 'エーフィ',
    name_en: 'Espeon',
    name_kana: 'エーフィ',
    data: {
      types: ['エスパー'],
      stats: { hp: 65, attack: 65, defense: 60, special_attack: 130, special_defense: 95, speed: 110 },
      abilities: ['シンクロ'],
      height: 9, weight: 265,
      generation: 2, category: 'たいようポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.197 ブラッキー ===
  {
    national_id: 197,
    name_ja: 'ブラッキー',
    name_en: 'Umbreon',
    name_kana: 'ブラッキー',
    data: {
      types: ['あく'],
      stats: { hp: 95, attack: 65, defense: 110, special_attack: 60, special_defense: 130, speed: 65 },
      abilities: ['シンクロ'],
      height: 10, weight: 270,
      generation: 2, category: 'げっこうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.198 ヤミカラス ===
  {
    national_id: 198,
    name_ja: 'ヤミカラス',
    name_en: 'Murkrow',
    name_kana: 'ヤミカラス',
    data: {
      types: ['あく', 'ひこう'],
      stats: { hp: 60, attack: 85, defense: 42, special_attack: 85, special_defense: 42, speed: 91 },
      abilities: ['ふみん', 'きょううん'],
      height: 5, weight: 21,
      generation: 2, category: 'くらやみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.199 ヤドキング ===
  {
    national_id: 199,
    name_ja: 'ヤドキング',
    name_en: 'Slowking',
    name_kana: 'ヤドキング',
    data: {
      types: ['みず', 'エスパー'],
      stats: { hp: 95, attack: 75, defense: 80, special_attack: 100, special_defense: 110, speed: 30 },
      abilities: ['どんかん', 'マイペース'],
      height: 20, weight: 795,
      generation: 2, category: 'おうじゃポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.200 ムウマ ===
  {
    national_id: 200,
    name_ja: 'ムウマ',
    name_en: 'Misdreavus',
    name_kana: 'ムウマ',
    data: {
      types: ['ゴースト'],
      stats: { hp: 60, attack: 60, defense: 60, special_attack: 85, special_defense: 85, speed: 85 },
      abilities: ['ふゆう'],
      height: 7, weight: 10,
      generation: 2, category: 'さけびごえポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.201 アンノーン ===
  {
    national_id: 201,
    name_ja: 'アンノーン',
    name_en: 'Unown',
    name_kana: 'アンノーン',
    data: {
      types: ['エスパー'],
      stats: { hp: 48, attack: 72, defense: 48, special_attack: 72, special_defense: 48, speed: 48 },
      abilities: ['ふゆう'],
      height: 5, weight: 50,
      generation: 2, category: 'シンボルポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.202 ソーナンス ===
  {
    national_id: 202,
    name_ja: 'ソーナンス',
    name_en: 'Wobbuffet',
    name_kana: 'ソーナンス',
    data: {
      types: ['エスパー'],
      stats: { hp: 190, attack: 33, defense: 58, special_attack: 33, special_defense: 58, speed: 33 },
      abilities: ['かげふみ'],
      height: 13, weight: 285,
      generation: 2, category: 'がまんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.203 キリンリキ ===
  {
    national_id: 203,
    name_ja: 'キリンリキ',
    name_en: 'Girafarig',
    name_kana: 'キリンリキ',
    data: {
      types: ['ノーマル', 'エスパー'],
      stats: { hp: 70, attack: 80, defense: 65, special_attack: 90, special_defense: 65, speed: 85 },
      abilities: ['せいしんりょく', 'はやおき'],
      height: 15, weight: 415,
      generation: 2, category: 'くびながポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.204 クヌギダマ ===
  {
    national_id: 204,
    name_ja: 'クヌギダマ',
    name_en: 'Pineco',
    name_kana: 'クヌギダマ',
    data: {
      types: ['むし'],
      stats: { hp: 50, attack: 65, defense: 90, special_attack: 35, special_defense: 35, speed: 15 },
      abilities: ['がんじょう'],
      height: 6, weight: 72,
      generation: 2, category: 'みのむしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.205 フォレトス ===
  {
    national_id: 205,
    name_ja: 'フォレトス',
    name_en: 'Forretress',
    name_kana: 'フォレトス',
    data: {
      types: ['むし', 'はがね'],
      stats: { hp: 75, attack: 90, defense: 140, special_attack: 60, special_defense: 60, speed: 40 },
      abilities: ['がんじょう'],
      height: 12, weight: 1258,
      generation: 2, category: 'みのむしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.206 ノコッチ ===
  {
    national_id: 206,
    name_ja: 'ノコッチ',
    name_en: 'Dunsparce',
    name_kana: 'ノコッチ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 100, attack: 70, defense: 70, special_attack: 65, special_defense: 65, speed: 45 },
      abilities: ['てんのめぐみ', 'にげあし'],
      height: 15, weight: 140,
      generation: 2, category: 'つちへびポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.207 グライガー ===
  {
    national_id: 207,
    name_ja: 'グライガー',
    name_en: 'Gligar',
    name_kana: 'グライガー',
    data: {
      types: ['じめん', 'ひこう'],
      stats: { hp: 65, attack: 75, defense: 105, special_attack: 35, special_defense: 65, speed: 85 },
      abilities: ['かいりきバサミ', 'すながくれ'],
      height: 11, weight: 648,
      generation: 2, category: 'とびさそりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.208 ハガネール ===
  {
    national_id: 208,
    name_ja: 'ハガネール',
    name_en: 'Steelix',
    name_kana: 'ハガネール',
    data: {
      types: ['はがね', 'じめん'],
      stats: { hp: 75, attack: 85, defense: 200, special_attack: 55, special_defense: 65, speed: 30 },
      abilities: ['いしあたま', 'がんじょう'],
      height: 92, weight: 4000,
      generation: 2, category: 'てつへびポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.209 ブルー ===
  {
    national_id: 209,
    name_ja: 'ブルー',
    name_en: 'Snubbull',
    name_kana: 'ブルー',
    data: {
      types: ['フェアリー'],
      stats: { hp: 60, attack: 80, defense: 50, special_attack: 40, special_defense: 40, speed: 30 },
      abilities: ['いかく', 'にげあし'],
      height: 6, weight: 78,
      generation: 2, category: 'ようせいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.210 グランブル ===
  {
    national_id: 210,
    name_ja: 'グランブル',
    name_en: 'Granbull',
    name_kana: 'グランブル',
    data: {
      types: ['フェアリー'],
      stats: { hp: 90, attack: 120, defense: 75, special_attack: 60, special_defense: 60, speed: 45 },
      abilities: ['いかく', 'はやあし'],
      height: 14, weight: 487,
      generation: 2, category: 'ようせいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.211 ハリーセン ===
  {
    national_id: 211,
    name_ja: 'ハリーセン',
    name_en: 'Qwilfish',
    name_kana: 'ハリーセン',
    data: {
      types: ['みず', 'どく'],
      stats: { hp: 65, attack: 95, defense: 85, special_attack: 55, special_defense: 55, speed: 85 },
      abilities: ['どくのトゲ', 'すいすい'],
      height: 5, weight: 39,
      generation: 2, category: 'ふうせんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.212 ハッサム ===
  {
    national_id: 212,
    name_ja: 'ハッサム',
    name_en: 'Scizor',
    name_kana: 'ハッサム',
    data: {
      types: ['むし', 'はがね'],
      stats: { hp: 70, attack: 130, defense: 100, special_attack: 55, special_defense: 80, speed: 65 },
      abilities: ['むしのしらせ', 'テクニシャン'],
      height: 18, weight: 1180,
      generation: 2, category: 'はさみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.213 ツボツボ ===
  {
    national_id: 213,
    name_ja: 'ツボツボ',
    name_en: 'Shuckle',
    name_kana: 'ツボツボ',
    data: {
      types: ['むし', 'いわ'],
      stats: { hp: 20, attack: 10, defense: 230, special_attack: 10, special_defense: 230, speed: 5 },
      abilities: ['がんじょう', 'くいしんぼう'],
      height: 6, weight: 205,
      generation: 2, category: 'はっこうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.214 ヘラクロス ===
  {
    national_id: 214,
    name_ja: 'ヘラクロス',
    name_en: 'Heracross',
    name_kana: 'ヘラクロス',
    data: {
      types: ['むし', 'かくとう'],
      stats: { hp: 80, attack: 125, defense: 75, special_attack: 40, special_defense: 95, speed: 85 },
      abilities: ['むしのしらせ', 'こんじょう'],
      height: 15, weight: 540,
      generation: 2, category: '1ぽんヅノポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.215 ニューラ ===
  {
    national_id: 215,
    name_ja: 'ニューラ',
    name_en: 'Sneasel',
    name_kana: 'ニューラ',
    data: {
      types: ['あく', 'こおり'],
      stats: { hp: 55, attack: 95, defense: 55, special_attack: 35, special_defense: 75, speed: 115 },
      abilities: ['せいしんりょく', 'するどいめ'],
      height: 9, weight: 280,
      generation: 2, category: 'かぎづめポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.216 ヒメグマ ===
  {
    national_id: 216,
    name_ja: 'ヒメグマ',
    name_en: 'Teddiursa',
    name_kana: 'ヒメグマ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 60, attack: 80, defense: 50, special_attack: 50, special_defense: 50, speed: 40 },
      abilities: ['ものひろい', 'はやあし'],
      height: 6, weight: 88,
      generation: 2, category: 'こぐまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.217 リングマ ===
  {
    national_id: 217,
    name_ja: 'リングマ',
    name_en: 'Ursaring',
    name_kana: 'リングマ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 90, attack: 130, defense: 75, special_attack: 75, special_defense: 75, speed: 55 },
      abilities: ['こんじょう', 'はやあし'],
      height: 18, weight: 1258,
      generation: 2, category: 'とうみんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.218 マグマッグ ===
  {
    national_id: 218,
    name_ja: 'マグマッグ',
    name_en: 'Slugma',
    name_kana: 'マグマッグ',
    data: {
      types: ['ほのお'],
      stats: { hp: 40, attack: 40, defense: 40, special_attack: 70, special_defense: 40, speed: 20 },
      abilities: ['マグマのよろい', 'ほのおのからだ'],
      height: 7, weight: 350,
      generation: 2, category: 'ようがんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.219 マグカルゴ ===
  {
    national_id: 219,
    name_ja: 'マグカルゴ',
    name_en: 'Magcargo',
    name_kana: 'マグカルゴ',
    data: {
      types: ['ほのお', 'いわ'],
      stats: { hp: 60, attack: 50, defense: 120, special_attack: 90, special_defense: 80, speed: 30 },
      abilities: ['マグマのよろい', 'ほのおのからだ'],
      height: 8, weight: 550,
      generation: 2, category: 'ようがんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.220 ウリムー ===
  {
    national_id: 220,
    name_ja: 'ウリムー',
    name_en: 'Swinub',
    name_kana: 'ウリムー',
    data: {
      types: ['こおり', 'じめん'],
      stats: { hp: 50, attack: 50, defense: 40, special_attack: 30, special_defense: 30, speed: 50 },
      abilities: ['どんかん', 'ゆきがくれ'],
      height: 4, weight: 65,
      generation: 2, category: 'いのこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.221 イノムー ===
  {
    national_id: 221,
    name_ja: 'イノムー',
    name_en: 'Piloswine',
    name_kana: 'イノムー',
    data: {
      types: ['こおり', 'じめん'],
      stats: { hp: 100, attack: 100, defense: 80, special_attack: 60, special_defense: 60, speed: 50 },
      abilities: ['どんかん', 'ゆきがくれ'],
      height: 11, weight: 558,
      generation: 2, category: 'いのししポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.222 サニーゴ ===
  {
    national_id: 222,
    name_ja: 'サニーゴ',
    name_en: 'Corsola',
    name_kana: 'サニーゴ',
    data: {
      types: ['みず', 'いわ'],
      stats: { hp: 65, attack: 55, defense: 95, special_attack: 65, special_defense: 95, speed: 35 },
      abilities: ['はりきり', 'しぜんかいふく'],
      height: 6, weight: 50,
      generation: 2, category: 'さんごポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.223 テッポウオ ===
  {
    national_id: 223,
    name_ja: 'テッポウオ',
    name_en: 'Remoraid',
    name_kana: 'テッポウオ',
    data: {
      types: ['みず'],
      stats: { hp: 35, attack: 65, defense: 35, special_attack: 65, special_defense: 35, speed: 65 },
      abilities: ['はりきり', 'スナイパー'],
      height: 6, weight: 120,
      generation: 2, category: 'ジェットポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.224 オクタン ===
  {
    national_id: 224,
    name_ja: 'オクタン',
    name_en: 'Octillery',
    name_kana: 'オクタン',
    data: {
      types: ['みず'],
      stats: { hp: 75, attack: 105, defense: 75, special_attack: 105, special_defense: 75, speed: 45 },
      abilities: ['きゅうばん', 'スナイパー'],
      height: 9, weight: 285,
      generation: 2, category: 'ふんしゃポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.225 デリバード ===
  {
    national_id: 225,
    name_ja: 'デリバード',
    name_en: 'Delibird',
    name_kana: 'デリバード',
    data: {
      types: ['こおり', 'ひこう'],
      stats: { hp: 45, attack: 55, defense: 45, special_attack: 65, special_defense: 45, speed: 75 },
      abilities: ['やるき', 'はりきり'],
      height: 9, weight: 160,
      generation: 2, category: 'はこびやポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.226 マンタイン ===
  {
    national_id: 226,
    name_ja: 'マンタイン',
    name_en: 'Mantine',
    name_kana: 'マンタイン',
    data: {
      types: ['みず', 'ひこう'],
      stats: { hp: 85, attack: 40, defense: 70, special_attack: 80, special_defense: 140, speed: 70 },
      abilities: ['すいすい', 'ちょすい'],
      height: 21, weight: 2200,
      generation: 2, category: 'カイトポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.227 エアームド ===
  {
    national_id: 227,
    name_ja: 'エアームド',
    name_en: 'Skarmory',
    name_kana: 'エアームド',
    data: {
      types: ['はがね', 'ひこう'],
      stats: { hp: 65, attack: 80, defense: 140, special_attack: 40, special_defense: 70, speed: 70 },
      abilities: ['するどいめ', 'がんじょう'],
      height: 17, weight: 505,
      generation: 2, category: 'よろいどりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.228 デルビル ===
  {
    national_id: 228,
    name_ja: 'デルビル',
    name_en: 'Houndour',
    name_kana: 'デルビル',
    data: {
      types: ['あく', 'ほのお'],
      stats: { hp: 45, attack: 60, defense: 30, special_attack: 80, special_defense: 50, speed: 65 },
      abilities: ['はやおき', 'もらいび'],
      height: 6, weight: 108,
      generation: 2, category: 'ダークポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.229 ヘルガー ===
  {
    national_id: 229,
    name_ja: 'ヘルガー',
    name_en: 'Houndoom',
    name_kana: 'ヘルガー',
    data: {
      types: ['あく', 'ほのお'],
      stats: { hp: 75, attack: 90, defense: 50, special_attack: 110, special_defense: 80, speed: 95 },
      abilities: ['はやおき', 'もらいび'],
      height: 14, weight: 350,
      generation: 2, category: 'ダークポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.230 キングドラ ===
  {
    national_id: 230,
    name_ja: 'キングドラ',
    name_en: 'Kingdra',
    name_kana: 'キングドラ',
    data: {
      types: ['みず', 'ドラゴン'],
      stats: { hp: 75, attack: 95, defense: 95, special_attack: 95, special_defense: 95, speed: 85 },
      abilities: ['すいすい', 'スナイパー'],
      height: 18, weight: 1520,
      generation: 2, category: 'ドラゴンポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.231 ゴマゾウ ===
  {
    national_id: 231,
    name_ja: 'ゴマゾウ',
    name_en: 'Phanpy',
    name_kana: 'ゴマゾウ',
    data: {
      types: ['じめん'],
      stats: { hp: 90, attack: 60, defense: 60, special_attack: 40, special_defense: 40, speed: 40 },
      abilities: ['ものひろい'],
      height: 5, weight: 335,
      generation: 2, category: 'ながはなポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.232 ドンファン ===
  {
    national_id: 232,
    name_ja: 'ドンファン',
    name_en: 'Donphan',
    name_kana: 'ドンファン',
    data: {
      types: ['じめん'],
      stats: { hp: 90, attack: 120, defense: 120, special_attack: 60, special_defense: 60, speed: 50 },
      abilities: ['がんじょう'],
      height: 11, weight: 1200,
      generation: 2, category: 'よろいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.233 ポリゴン2 ===
  {
    national_id: 233,
    name_ja: 'ポリゴン2',
    name_en: 'Porygon2',
    name_kana: 'ポリゴンツー',
    data: {
      types: ['ノーマル'],
      stats: { hp: 85, attack: 80, defense: 90, special_attack: 105, special_defense: 95, speed: 60 },
      abilities: ['トレース', 'ダウンロード'],
      height: 6, weight: 325,
      generation: 2, category: 'バーチャルポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.234 オドシシ ===
  {
    national_id: 234,
    name_ja: 'オドシシ',
    name_en: 'Stantler',
    name_kana: 'オドシシ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 73, attack: 95, defense: 62, special_attack: 85, special_defense: 65, speed: 85 },
      abilities: ['いかく', 'おみとおし'],
      height: 14, weight: 712,
      generation: 2, category: 'おおツノポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.235 ドーブル ===
  {
    national_id: 235,
    name_ja: 'ドーブル',
    name_en: 'Smeargle',
    name_kana: 'ドーブル',
    data: {
      types: ['ノーマル'],
      stats: { hp: 55, attack: 20, defense: 35, special_attack: 20, special_defense: 45, speed: 75 },
      abilities: ['マイペース', 'テクニシャン'],
      height: 12, weight: 580,
      generation: 2, category: 'えかきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.236 バルキー ===
  {
    national_id: 236,
    name_ja: 'バルキー',
    name_en: 'Tyrogue',
    name_kana: 'バルキー',
    data: {
      types: ['かくとう'],
      stats: { hp: 35, attack: 35, defense: 35, special_attack: 35, special_defense: 35, speed: 35 },
      abilities: ['こんじょう', 'ふくつのこころ'],
      height: 7, weight: 210,
      generation: 2, category: 'けんかポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.237 カポエラー ===
  {
    national_id: 237,
    name_ja: 'カポエラー',
    name_en: 'Hitmontop',
    name_kana: 'カポエラー',
    data: {
      types: ['かくとう'],
      stats: { hp: 50, attack: 95, defense: 95, special_attack: 35, special_defense: 110, speed: 70 },
      abilities: ['いかく', 'テクニシャン'],
      height: 14, weight: 480,
      generation: 2, category: 'さかだちポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.238 ムチュール ===
  {
    national_id: 238,
    name_ja: 'ムチュール',
    name_en: 'Smoochum',
    name_kana: 'ムチュール',
    data: {
      types: ['こおり', 'エスパー'],
      stats: { hp: 45, attack: 30, defense: 15, special_attack: 85, special_defense: 65, speed: 65 },
      abilities: ['どんかん', 'よちむ'],
      height: 4, weight: 60,
      generation: 2, category: 'くちづけポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.239 エレキッド ===
  {
    national_id: 239,
    name_ja: 'エレキッド',
    name_en: 'Elekid',
    name_kana: 'エレキッド',
    data: {
      types: ['でんき'],
      stats: { hp: 45, attack: 63, defense: 37, special_attack: 65, special_defense: 55, speed: 95 },
      abilities: ['せいでんき'],
      height: 6, weight: 235,
      generation: 2, category: 'でんきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.240 ブビィ ===
  {
    national_id: 240,
    name_ja: 'ブビィ',
    name_en: 'Magby',
    name_kana: 'ブビィ',
    data: {
      types: ['ほのお'],
      stats: { hp: 45, attack: 75, defense: 37, special_attack: 70, special_defense: 55, speed: 83 },
      abilities: ['ほのおのからだ'],
      height: 7, weight: 214,
      generation: 2, category: 'ひだねポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.241 ミルタンク ===
  {
    national_id: 241,
    name_ja: 'ミルタンク',
    name_en: 'Miltank',
    name_kana: 'ミルタンク',
    data: {
      types: ['ノーマル'],
      stats: { hp: 95, attack: 80, defense: 105, special_attack: 40, special_defense: 70, speed: 100 },
      abilities: ['あついしぼう', 'きもったま'],
      height: 12, weight: 755,
      generation: 2, category: 'ちちうしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.242 ハピナス ===
  {
    national_id: 242,
    name_ja: 'ハピナス',
    name_en: 'Blissey',
    name_kana: 'ハピナス',
    data: {
      types: ['ノーマル'],
      stats: { hp: 255, attack: 10, defense: 10, special_attack: 75, special_defense: 135, speed: 55 },
      abilities: ['しぜんかいふく', 'てんのめぐみ'],
      height: 15, weight: 468,
      generation: 2, category: 'しあわせポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.243 ライコウ ===
  {
    national_id: 243,
    name_ja: 'ライコウ',
    name_en: 'Raikou',
    name_kana: 'ライコウ',
    data: {
      types: ['でんき'],
      stats: { hp: 90, attack: 85, defense: 75, special_attack: 115, special_defense: 100, speed: 115 },
      abilities: ['プレッシャー'],
      height: 19, weight: 1780,
      generation: 2, category: 'いかずちポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.244 エンテイ ===
  {
    national_id: 244,
    name_ja: 'エンテイ',
    name_en: 'Entei',
    name_kana: 'エンテイ',
    data: {
      types: ['ほのお'],
      stats: { hp: 115, attack: 115, defense: 85, special_attack: 90, special_defense: 75, speed: 100 },
      abilities: ['プレッシャー'],
      height: 21, weight: 1980,
      generation: 2, category: 'かざんポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.245 スイクン ===
  {
    national_id: 245,
    name_ja: 'スイクン',
    name_en: 'Suicune',
    name_kana: 'スイクン',
    data: {
      types: ['みず'],
      stats: { hp: 100, attack: 75, defense: 115, special_attack: 90, special_defense: 115, speed: 85 },
      abilities: ['プレッシャー'],
      height: 20, weight: 1870,
      generation: 2, category: 'オーロラポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.246 ヨーギラス ===
  {
    national_id: 246,
    name_ja: 'ヨーギラス',
    name_en: 'Larvitar',
    name_kana: 'ヨーギラス',
    data: {
      types: ['いわ', 'じめん'],
      stats: { hp: 50, attack: 64, defense: 50, special_attack: 45, special_defense: 50, speed: 41 },
      abilities: ['こんじょう'],
      height: 6, weight: 720,
      generation: 2, category: 'いわはだポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.247 サナギラス ===
  {
    national_id: 247,
    name_ja: 'サナギラス',
    name_en: 'Pupitar',
    name_kana: 'サナギラス',
    data: {
      types: ['いわ', 'じめん'],
      stats: { hp: 70, attack: 84, defense: 70, special_attack: 65, special_defense: 70, speed: 51 },
      abilities: ['だっぴ'],
      height: 12, weight: 1520,
      generation: 2, category: 'かたいからポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.248 バンギラス ===
  {
    national_id: 248,
    name_ja: 'バンギラス',
    name_en: 'Tyranitar',
    name_kana: 'バンギラス',
    data: {
      types: ['いわ', 'あく'],
      stats: { hp: 100, attack: 134, defense: 110, special_attack: 95, special_defense: 100, speed: 61 },
      abilities: ['すなおこし'],
      height: 20, weight: 2020,
      generation: 2, category: 'よろいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.249 ルギア ===
  {
    national_id: 249,
    name_ja: 'ルギア',
    name_en: 'Lugia',
    name_kana: 'ルギア',
    data: {
      types: ['エスパー', 'ひこう'],
      stats: { hp: 106, attack: 90, defense: 130, special_attack: 90, special_defense: 154, speed: 110 },
      abilities: ['プレッシャー'],
      height: 52, weight: 2160,
      generation: 2, category: 'せんすいポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.250 ホウオウ ===
  {
    national_id: 250,
    name_ja: 'ホウオウ',
    name_en: 'Ho-Oh',
    name_kana: 'ホウオウ',
    data: {
      types: ['ほのお', 'ひこう'],
      stats: { hp: 106, attack: 130, defense: 90, special_attack: 110, special_defense: 154, speed: 90 },
      abilities: ['プレッシャー'],
      height: 38, weight: 1990,
      generation: 2, category: 'にじいろポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.251 セレビィ ===
  {
    national_id: 251,
    name_ja: 'セレビィ',
    name_en: 'Celebi',
    name_kana: 'セレビィ',
    data: {
      types: ['エスパー', 'くさ'],
      stats: { hp: 100, attack: 100, defense: 100, special_attack: 100, special_defense: 100, speed: 100 },
      abilities: ['しぜんかいふく'],
      height: 6, weight: 50,
      generation: 2, category: 'ときわたりポケモン',
      is_legendary: false, is_mythical: true
    }
  }
].freeze
