# 第3世代 ポケモン図鑑データ（No.252〜No.386）
# db/seeds.rb から呼び出される
# タイプ・種族値・特性は公式データに基づく（第6世代以降の最新値）
# height: デシメートル単位 / weight: ヘクトグラム単位
# abilities: 通常特性のみ（隠れ特性は含まない）

POKEMON_GEN3_DATA = [
  # === No.252 キモリ ===
  {
    national_id: 252,
    name_ja: 'キモリ',
    name_en: 'Treecko',
    name_kana: 'キモリ',
    data: {
      types: ['くさ'],
      stats: { hp: 40, attack: 45, defense: 35, special_attack: 65, special_defense: 55, speed: 70 },
      abilities: ['しんりょく'],
      height: 5, weight: 50,
      generation: 3, category: 'もりトカゲポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.253 ジュプトル ===
  {
    national_id: 253,
    name_ja: 'ジュプトル',
    name_en: 'Grovyle',
    name_kana: 'ジュプトル',
    data: {
      types: ['くさ'],
      stats: { hp: 50, attack: 65, defense: 45, special_attack: 85, special_defense: 65, speed: 95 },
      abilities: ['しんりょく'],
      height: 9, weight: 216,
      generation: 3, category: 'もりトカゲポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.254 ジュカイン ===
  {
    national_id: 254,
    name_ja: 'ジュカイン',
    name_en: 'Sceptile',
    name_kana: 'ジュカイン',
    data: {
      types: ['くさ'],
      stats: { hp: 70, attack: 85, defense: 65, special_attack: 105, special_defense: 85, speed: 120 },
      abilities: ['しんりょく'],
      height: 17, weight: 522,
      generation: 3, category: 'みつりんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.255 アチャモ ===
  {
    national_id: 255,
    name_ja: 'アチャモ',
    name_en: 'Torchic',
    name_kana: 'アチャモ',
    data: {
      types: ['ほのお'],
      stats: { hp: 45, attack: 60, defense: 40, special_attack: 70, special_defense: 50, speed: 45 },
      abilities: ['もうか'],
      height: 4, weight: 25,
      generation: 3, category: 'ひよこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.256 ワカシャモ ===
  {
    national_id: 256,
    name_ja: 'ワカシャモ',
    name_en: 'Combusken',
    name_kana: 'ワカシャモ',
    data: {
      types: ['ほのお', 'かくとう'],
      stats: { hp: 60, attack: 85, defense: 60, special_attack: 85, special_defense: 60, speed: 55 },
      abilities: ['もうか'],
      height: 9, weight: 195,
      generation: 3, category: 'わかどりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.257 バシャーモ ===
  {
    national_id: 257,
    name_ja: 'バシャーモ',
    name_en: 'Blaziken',
    name_kana: 'バシャーモ',
    data: {
      types: ['ほのお', 'かくとう'],
      stats: { hp: 80, attack: 120, defense: 70, special_attack: 110, special_defense: 70, speed: 80 },
      abilities: ['もうか'],
      height: 19, weight: 520,
      generation: 3, category: 'もうかポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.258 ミズゴロウ ===
  {
    national_id: 258,
    name_ja: 'ミズゴロウ',
    name_en: 'Mudkip',
    name_kana: 'ミズゴロウ',
    data: {
      types: ['みず'],
      stats: { hp: 50, attack: 70, defense: 50, special_attack: 50, special_defense: 50, speed: 40 },
      abilities: ['げきりゅう'],
      height: 4, weight: 76,
      generation: 3, category: 'ぬまうおポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.259 ヌマクロー ===
  {
    national_id: 259,
    name_ja: 'ヌマクロー',
    name_en: 'Marshtomp',
    name_kana: 'ヌマクロー',
    data: {
      types: ['みず', 'じめん'],
      stats: { hp: 70, attack: 85, defense: 70, special_attack: 60, special_defense: 70, speed: 50 },
      abilities: ['げきりゅう'],
      height: 7, weight: 280,
      generation: 3, category: 'ぬまうおポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.260 ラグラージ ===
  {
    national_id: 260,
    name_ja: 'ラグラージ',
    name_en: 'Swampert',
    name_kana: 'ラグラージ',
    data: {
      types: ['みず', 'じめん'],
      stats: { hp: 100, attack: 110, defense: 90, special_attack: 85, special_defense: 90, speed: 60 },
      abilities: ['げきりゅう'],
      height: 15, weight: 819,
      generation: 3, category: 'ぬまうおポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.261 ポチエナ ===
  {
    national_id: 261,
    name_ja: 'ポチエナ',
    name_en: 'Poochyena',
    name_kana: 'ポチエナ',
    data: {
      types: ['あく'],
      stats: { hp: 35, attack: 55, defense: 35, special_attack: 30, special_defense: 30, speed: 35 },
      abilities: ['にげあし', 'はやあし'],
      height: 5, weight: 136,
      generation: 3, category: 'かみつきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.262 グラエナ ===
  {
    national_id: 262,
    name_ja: 'グラエナ',
    name_en: 'Mightyena',
    name_kana: 'グラエナ',
    data: {
      types: ['あく'],
      stats: { hp: 70, attack: 90, defense: 70, special_attack: 60, special_defense: 60, speed: 70 },
      abilities: ['いかく', 'はやあし'],
      height: 10, weight: 370,
      generation: 3, category: 'かみつきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.263 ジグザグマ ===
  {
    national_id: 263,
    name_ja: 'ジグザグマ',
    name_en: 'Zigzagoon',
    name_kana: 'ジグザグマ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 38, attack: 30, defense: 41, special_attack: 30, special_defense: 41, speed: 60 },
      abilities: ['ものひろい', 'くいしんぼう'],
      height: 4, weight: 175,
      generation: 3, category: 'まめだぬきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.264 マッスグマ ===
  {
    national_id: 264,
    name_ja: 'マッスグマ',
    name_en: 'Linoone',
    name_kana: 'マッスグマ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 78, attack: 70, defense: 61, special_attack: 50, special_defense: 61, speed: 100 },
      abilities: ['ものひろい', 'くいしんぼう'],
      height: 5, weight: 325,
      generation: 3, category: 'とっしんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.265 ケムッソ ===
  {
    national_id: 265,
    name_ja: 'ケムッソ',
    name_en: 'Wurmple',
    name_kana: 'ケムッソ',
    data: {
      types: ['むし'],
      stats: { hp: 45, attack: 45, defense: 35, special_attack: 20, special_defense: 30, speed: 20 },
      abilities: ['りんぷん'],
      height: 3, weight: 36,
      generation: 3, category: 'けむしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.266 カラサリス ===
  {
    national_id: 266,
    name_ja: 'カラサリス',
    name_en: 'Silcoon',
    name_kana: 'カラサリス',
    data: {
      types: ['むし'],
      stats: { hp: 50, attack: 35, defense: 55, special_attack: 25, special_defense: 25, speed: 15 },
      abilities: ['だっぴ'],
      height: 6, weight: 100,
      generation: 3, category: 'まゆポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.267 アゲハント ===
  {
    national_id: 267,
    name_ja: 'アゲハント',
    name_en: 'Beautifly',
    name_kana: 'アゲハント',
    data: {
      types: ['むし', 'ひこう'],
      stats: { hp: 60, attack: 70, defense: 50, special_attack: 100, special_defense: 50, speed: 65 },
      abilities: ['むしのしらせ'],
      height: 10, weight: 284,
      generation: 3, category: 'てふてふポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.268 マユルド ===
  {
    national_id: 268,
    name_ja: 'マユルド',
    name_en: 'Cascoon',
    name_kana: 'マユルド',
    data: {
      types: ['むし'],
      stats: { hp: 50, attack: 35, defense: 55, special_attack: 25, special_defense: 25, speed: 15 },
      abilities: ['だっぴ'],
      height: 7, weight: 115,
      generation: 3, category: 'まゆポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.269 ドクケイル ===
  {
    national_id: 269,
    name_ja: 'ドクケイル',
    name_en: 'Dustox',
    name_kana: 'ドクケイル',
    data: {
      types: ['むし', 'どく'],
      stats: { hp: 60, attack: 50, defense: 70, special_attack: 50, special_defense: 90, speed: 65 },
      abilities: ['りんぷん'],
      height: 12, weight: 316,
      generation: 3, category: 'どくがポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.270 ハスボー ===
  {
    national_id: 270,
    name_ja: 'ハスボー',
    name_en: 'Lotad',
    name_kana: 'ハスボー',
    data: {
      types: ['みず', 'くさ'],
      stats: { hp: 40, attack: 30, defense: 30, special_attack: 40, special_defense: 50, speed: 30 },
      abilities: ['すいすい', 'あめうけざら'],
      height: 5, weight: 26,
      generation: 3, category: 'みずくさポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.271 ハスブレロ ===
  {
    national_id: 271,
    name_ja: 'ハスブレロ',
    name_en: 'Lombre',
    name_kana: 'ハスブレロ',
    data: {
      types: ['みず', 'くさ'],
      stats: { hp: 60, attack: 50, defense: 50, special_attack: 60, special_defense: 70, speed: 50 },
      abilities: ['すいすい', 'あめうけざら'],
      height: 12, weight: 326,
      generation: 3, category: 'ようきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.272 ルンパッパ ===
  {
    national_id: 272,
    name_ja: 'ルンパッパ',
    name_en: 'Ludicolo',
    name_kana: 'ルンパッパ',
    data: {
      types: ['みず', 'くさ'],
      stats: { hp: 80, attack: 70, defense: 70, special_attack: 90, special_defense: 100, speed: 70 },
      abilities: ['すいすい', 'あめうけざら'],
      height: 15, weight: 550,
      generation: 3, category: 'のうてんきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.273 タネボー ===
  {
    national_id: 273,
    name_ja: 'タネボー',
    name_en: 'Seedot',
    name_kana: 'タネボー',
    data: {
      types: ['くさ'],
      stats: { hp: 40, attack: 40, defense: 50, special_attack: 30, special_defense: 30, speed: 30 },
      abilities: ['ようりょくそ', 'はやおき'],
      height: 5, weight: 40,
      generation: 3, category: 'どんぐりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.274 コノハナ ===
  {
    national_id: 274,
    name_ja: 'コノハナ',
    name_en: 'Nuzleaf',
    name_kana: 'コノハナ',
    data: {
      types: ['くさ', 'あく'],
      stats: { hp: 70, attack: 70, defense: 40, special_attack: 60, special_defense: 40, speed: 60 },
      abilities: ['ようりょくそ', 'はやおき'],
      height: 10, weight: 280,
      generation: 3, category: 'ずるがしこいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.275 ダーテング ===
  {
    national_id: 275,
    name_ja: 'ダーテング',
    name_en: 'Shiftry',
    name_kana: 'ダーテング',
    data: {
      types: ['くさ', 'あく'],
      stats: { hp: 90, attack: 100, defense: 60, special_attack: 90, special_defense: 60, speed: 80 },
      abilities: ['ようりょくそ', 'はやおき'],
      height: 13, weight: 596,
      generation: 3, category: 'よこしまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.276 スバメ ===
  {
    national_id: 276,
    name_ja: 'スバメ',
    name_en: 'Taillow',
    name_kana: 'スバメ',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 40, attack: 55, defense: 30, special_attack: 30, special_defense: 30, speed: 85 },
      abilities: ['こんじょう'],
      height: 3, weight: 23,
      generation: 3, category: 'こツバメポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.277 オオスバメ ===
  {
    national_id: 277,
    name_ja: 'オオスバメ',
    name_en: 'Swellow',
    name_kana: 'オオスバメ',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 60, attack: 85, defense: 60, special_attack: 75, special_defense: 50, speed: 125 },
      abilities: ['こんじょう'],
      height: 7, weight: 198,
      generation: 3, category: 'ツバメポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.278 キャモメ ===
  {
    national_id: 278,
    name_ja: 'キャモメ',
    name_en: 'Wingull',
    name_kana: 'キャモメ',
    data: {
      types: ['みず', 'ひこう'],
      stats: { hp: 40, attack: 30, defense: 30, special_attack: 55, special_defense: 30, speed: 85 },
      abilities: ['するどいめ', 'うるおいボディ'],
      height: 6, weight: 95,
      generation: 3, category: 'うみねこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.279 ペリッパー ===
  {
    national_id: 279,
    name_ja: 'ペリッパー',
    name_en: 'Pelipper',
    name_kana: 'ペリッパー',
    data: {
      types: ['みず', 'ひこう'],
      stats: { hp: 60, attack: 50, defense: 100, special_attack: 95, special_defense: 70, speed: 65 },
      abilities: ['するどいめ', 'あめふらし'],
      height: 12, weight: 280,
      generation: 3, category: 'みずどりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.280 ラルトス ===
  {
    national_id: 280,
    name_ja: 'ラルトス',
    name_en: 'Ralts',
    name_kana: 'ラルトス',
    data: {
      types: ['エスパー', 'フェアリー'],
      stats: { hp: 28, attack: 25, defense: 25, special_attack: 45, special_defense: 35, speed: 40 },
      abilities: ['シンクロ', 'トレース'],
      height: 4, weight: 66,
      generation: 3, category: 'きもちポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.281 キルリア ===
  {
    national_id: 281,
    name_ja: 'キルリア',
    name_en: 'Kirlia',
    name_kana: 'キルリア',
    data: {
      types: ['エスパー', 'フェアリー'],
      stats: { hp: 38, attack: 35, defense: 35, special_attack: 65, special_defense: 55, speed: 50 },
      abilities: ['シンクロ', 'トレース'],
      height: 8, weight: 202,
      generation: 3, category: 'かんじょうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.282 サーナイト ===
  {
    national_id: 282,
    name_ja: 'サーナイト',
    name_en: 'Gardevoir',
    name_kana: 'サーナイト',
    data: {
      types: ['エスパー', 'フェアリー'],
      stats: { hp: 68, attack: 65, defense: 65, special_attack: 125, special_defense: 115, speed: 80 },
      abilities: ['シンクロ', 'トレース'],
      height: 16, weight: 484,
      generation: 3, category: 'ほうようポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.283 アメタマ ===
  {
    national_id: 283,
    name_ja: 'アメタマ',
    name_en: 'Surskit',
    name_kana: 'アメタマ',
    data: {
      types: ['むし', 'みず'],
      stats: { hp: 40, attack: 30, defense: 32, special_attack: 50, special_defense: 52, speed: 65 },
      abilities: ['すいすい'],
      height: 5, weight: 17,
      generation: 3, category: 'あめんぼポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.284 アメモース ===
  {
    national_id: 284,
    name_ja: 'アメモース',
    name_en: 'Masquerain',
    name_kana: 'アメモース',
    data: {
      types: ['むし', 'ひこう'],
      stats: { hp: 70, attack: 60, defense: 62, special_attack: 100, special_defense: 82, speed: 80 },
      abilities: ['いかく'],
      height: 8, weight: 36,
      generation: 3, category: 'めだまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.285 キノココ ===
  {
    national_id: 285,
    name_ja: 'キノココ',
    name_en: 'Shroomish',
    name_kana: 'キノココ',
    data: {
      types: ['くさ'],
      stats: { hp: 60, attack: 40, defense: 60, special_attack: 40, special_defense: 60, speed: 35 },
      abilities: ['ほうし', 'ポイズンヒール'],
      height: 4, weight: 45,
      generation: 3, category: 'きのこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.286 キノガッサ ===
  {
    national_id: 286,
    name_ja: 'キノガッサ',
    name_en: 'Breloom',
    name_kana: 'キノガッサ',
    data: {
      types: ['くさ', 'かくとう'],
      stats: { hp: 60, attack: 130, defense: 80, special_attack: 60, special_defense: 60, speed: 70 },
      abilities: ['ほうし', 'ポイズンヒール'],
      height: 12, weight: 392,
      generation: 3, category: 'きのこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.287 ナマケロ ===
  {
    national_id: 287,
    name_ja: 'ナマケロ',
    name_en: 'Slakoth',
    name_kana: 'ナマケロ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 60, attack: 60, defense: 60, special_attack: 35, special_defense: 35, speed: 30 },
      abilities: ['なまけ'],
      height: 8, weight: 240,
      generation: 3, category: 'なまけものポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.288 ヤルキモノ ===
  {
    national_id: 288,
    name_ja: 'ヤルキモノ',
    name_en: 'Vigoroth',
    name_kana: 'ヤルキモノ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 80, attack: 80, defense: 80, special_attack: 55, special_defense: 55, speed: 90 },
      abilities: ['やるき'],
      height: 14, weight: 465,
      generation: 3, category: 'あばれざるポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.289 ケッキング ===
  {
    national_id: 289,
    name_ja: 'ケッキング',
    name_en: 'Slaking',
    name_kana: 'ケッキング',
    data: {
      types: ['ノーマル'],
      stats: { hp: 150, attack: 160, defense: 100, special_attack: 95, special_defense: 65, speed: 100 },
      abilities: ['なまけ'],
      height: 20, weight: 1305,
      generation: 3, category: 'ものぐさポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.290 ツチニン ===
  {
    national_id: 290,
    name_ja: 'ツチニン',
    name_en: 'Nincada',
    name_kana: 'ツチニン',
    data: {
      types: ['むし', 'じめん'],
      stats: { hp: 31, attack: 45, defense: 90, special_attack: 30, special_defense: 30, speed: 40 },
      abilities: ['ふくがん'],
      height: 5, weight: 55,
      generation: 3, category: 'みならいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.291 テッカニン ===
  {
    national_id: 291,
    name_ja: 'テッカニン',
    name_en: 'Ninjask',
    name_kana: 'テッカニン',
    data: {
      types: ['むし', 'ひこう'],
      stats: { hp: 61, attack: 90, defense: 45, special_attack: 50, special_defense: 50, speed: 160 },
      abilities: ['かそく'],
      height: 8, weight: 120,
      generation: 3, category: 'しのびポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.292 ヌケニン ===
  {
    national_id: 292,
    name_ja: 'ヌケニン',
    name_en: 'Shedinja',
    name_kana: 'ヌケニン',
    data: {
      types: ['むし', 'ゴースト'],
      stats: { hp: 1, attack: 90, defense: 45, special_attack: 30, special_defense: 30, speed: 40 },
      abilities: ['ふしぎなまもり'],
      height: 8, weight: 12,
      generation: 3, category: 'ぬけがらポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.293 ゴニョニョ ===
  {
    national_id: 293,
    name_ja: 'ゴニョニョ',
    name_en: 'Whismur',
    name_kana: 'ゴニョニョ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 64, attack: 51, defense: 23, special_attack: 51, special_defense: 23, speed: 28 },
      abilities: ['ぼうおん'],
      height: 6, weight: 163,
      generation: 3, category: 'ささやきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.294 ドゴーム ===
  {
    national_id: 294,
    name_ja: 'ドゴーム',
    name_en: 'Loudred',
    name_kana: 'ドゴーム',
    data: {
      types: ['ノーマル'],
      stats: { hp: 84, attack: 71, defense: 43, special_attack: 71, special_defense: 43, speed: 48 },
      abilities: ['ぼうおん'],
      height: 10, weight: 405,
      generation: 3, category: 'おおごえポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.295 バクオング ===
  {
    national_id: 295,
    name_ja: 'バクオング',
    name_en: 'Exploud',
    name_kana: 'バクオング',
    data: {
      types: ['ノーマル'],
      stats: { hp: 104, attack: 91, defense: 63, special_attack: 91, special_defense: 73, speed: 68 },
      abilities: ['ぼうおん'],
      height: 15, weight: 840,
      generation: 3, category: 'ばくおんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.296 マクノシタ ===
  {
    national_id: 296,
    name_ja: 'マクノシタ',
    name_en: 'Makuhita',
    name_kana: 'マクノシタ',
    data: {
      types: ['かくとう'],
      stats: { hp: 72, attack: 60, defense: 30, special_attack: 20, special_defense: 30, speed: 25 },
      abilities: ['あついしぼう', 'こんじょう'],
      height: 10, weight: 864,
      generation: 3, category: 'ガッツポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.297 ハリテヤマ ===
  {
    national_id: 297,
    name_ja: 'ハリテヤマ',
    name_en: 'Hariyama',
    name_kana: 'ハリテヤマ',
    data: {
      types: ['かくとう'],
      stats: { hp: 144, attack: 120, defense: 60, special_attack: 40, special_defense: 60, speed: 50 },
      abilities: ['あついしぼう', 'こんじょう'],
      height: 23, weight: 2538,
      generation: 3, category: 'つっぱりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.298 ルリリ ===
  {
    national_id: 298,
    name_ja: 'ルリリ',
    name_en: 'Azurill',
    name_kana: 'ルリリ',
    data: {
      types: ['ノーマル', 'フェアリー'],
      stats: { hp: 50, attack: 20, defense: 40, special_attack: 20, special_defense: 40, speed: 20 },
      abilities: ['あついしぼう', 'ちからもち'],
      height: 2, weight: 20,
      generation: 3, category: 'みずたまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.299 ノズパス ===
  {
    national_id: 299,
    name_ja: 'ノズパス',
    name_en: 'Nosepass',
    name_kana: 'ノズパス',
    data: {
      types: ['いわ'],
      stats: { hp: 30, attack: 45, defense: 135, special_attack: 45, special_defense: 90, speed: 30 },
      abilities: ['がんじょう', 'じりょく'],
      height: 10, weight: 970,
      generation: 3, category: 'コンパスポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.300 エネコ ===
  {
    national_id: 300,
    name_ja: 'エネコ',
    name_en: 'Skitty',
    name_kana: 'エネコ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 50, attack: 45, defense: 45, special_attack: 35, special_defense: 35, speed: 50 },
      abilities: ['メロメロボディ', 'ノーマルスキン'],
      height: 6, weight: 110,
      generation: 3, category: 'こねこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.301 エネコロロ ===
  {
    national_id: 301,
    name_ja: 'エネコロロ',
    name_en: 'Delcatty',
    name_kana: 'エネコロロ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 70, attack: 65, defense: 65, special_attack: 55, special_defense: 55, speed: 90 },
      abilities: ['メロメロボディ', 'ノーマルスキン'],
      height: 11, weight: 326,
      generation: 3, category: 'おすましポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.302 ヤミラミ ===
  {
    national_id: 302,
    name_ja: 'ヤミラミ',
    name_en: 'Sableye',
    name_kana: 'ヤミラミ',
    data: {
      types: ['あく', 'ゴースト'],
      stats: { hp: 50, attack: 75, defense: 75, special_attack: 65, special_defense: 65, speed: 50 },
      abilities: ['するどいめ', 'あとだし'],
      height: 5, weight: 110,
      generation: 3, category: 'くらやみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.303 クチート ===
  {
    national_id: 303,
    name_ja: 'クチート',
    name_en: 'Mawile',
    name_kana: 'クチート',
    data: {
      types: ['はがね', 'フェアリー'],
      stats: { hp: 50, attack: 85, defense: 85, special_attack: 55, special_defense: 55, speed: 50 },
      abilities: ['かいりきバサミ', 'いかく'],
      height: 6, weight: 115,
      generation: 3, category: 'あざむきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.304 ココドラ ===
  {
    national_id: 304,
    name_ja: 'ココドラ',
    name_en: 'Aron',
    name_kana: 'ココドラ',
    data: {
      types: ['はがね', 'いわ'],
      stats: { hp: 50, attack: 70, defense: 100, special_attack: 40, special_defense: 40, speed: 30 },
      abilities: ['がんじょう', 'いしあたま'],
      height: 4, weight: 600,
      generation: 3, category: 'てつヨロイポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.305 コドラ ===
  {
    national_id: 305,
    name_ja: 'コドラ',
    name_en: 'Lairon',
    name_kana: 'コドラ',
    data: {
      types: ['はがね', 'いわ'],
      stats: { hp: 60, attack: 90, defense: 140, special_attack: 50, special_defense: 50, speed: 40 },
      abilities: ['がんじょう', 'いしあたま'],
      height: 9, weight: 1200,
      generation: 3, category: 'てつヨロイポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.306 ボスゴドラ ===
  {
    national_id: 306,
    name_ja: 'ボスゴドラ',
    name_en: 'Aggron',
    name_kana: 'ボスゴドラ',
    data: {
      types: ['はがね', 'いわ'],
      stats: { hp: 70, attack: 110, defense: 180, special_attack: 60, special_defense: 60, speed: 50 },
      abilities: ['がんじょう', 'いしあたま'],
      height: 21, weight: 3600,
      generation: 3, category: 'てつヨロイポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.307 アサナン ===
  {
    national_id: 307,
    name_ja: 'アサナン',
    name_en: 'Meditite',
    name_kana: 'アサナン',
    data: {
      types: ['かくとう', 'エスパー'],
      stats: { hp: 30, attack: 40, defense: 55, special_attack: 40, special_defense: 55, speed: 60 },
      abilities: ['ヨガパワー'],
      height: 6, weight: 112,
      generation: 3, category: 'めいそうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.308 チャーレム ===
  {
    national_id: 308,
    name_ja: 'チャーレム',
    name_en: 'Medicham',
    name_kana: 'チャーレム',
    data: {
      types: ['かくとう', 'エスパー'],
      stats: { hp: 60, attack: 60, defense: 75, special_attack: 60, special_defense: 75, speed: 80 },
      abilities: ['ヨガパワー'],
      height: 13, weight: 315,
      generation: 3, category: 'めいそうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.309 ラクライ ===
  {
    national_id: 309,
    name_ja: 'ラクライ',
    name_en: 'Electrike',
    name_kana: 'ラクライ',
    data: {
      types: ['でんき'],
      stats: { hp: 40, attack: 45, defense: 40, special_attack: 65, special_defense: 40, speed: 65 },
      abilities: ['せいでんき', 'ひらいしん'],
      height: 6, weight: 152,
      generation: 3, category: 'かみなりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.310 ライボルト ===
  {
    national_id: 310,
    name_ja: 'ライボルト',
    name_en: 'Manectric',
    name_kana: 'ライボルト',
    data: {
      types: ['でんき'],
      stats: { hp: 70, attack: 75, defense: 60, special_attack: 105, special_defense: 60, speed: 105 },
      abilities: ['せいでんき', 'ひらいしん'],
      height: 15, weight: 402,
      generation: 3, category: 'ほうでんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.311 プラスル ===
  {
    national_id: 311,
    name_ja: 'プラスル',
    name_en: 'Plusle',
    name_kana: 'プラスル',
    data: {
      types: ['でんき'],
      stats: { hp: 60, attack: 50, defense: 40, special_attack: 85, special_defense: 75, speed: 95 },
      abilities: ['プラス'],
      height: 4, weight: 42,
      generation: 3, category: 'おうえんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.312 マイナン ===
  {
    national_id: 312,
    name_ja: 'マイナン',
    name_en: 'Minun',
    name_kana: 'マイナン',
    data: {
      types: ['でんき'],
      stats: { hp: 60, attack: 40, defense: 50, special_attack: 75, special_defense: 85, speed: 95 },
      abilities: ['マイナス'],
      height: 4, weight: 42,
      generation: 3, category: 'おうえんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.313 バルビート ===
  {
    national_id: 313,
    name_ja: 'バルビート',
    name_en: 'Volbeat',
    name_kana: 'バルビート',
    data: {
      types: ['むし'],
      stats: { hp: 65, attack: 73, defense: 75, special_attack: 47, special_defense: 85, speed: 85 },
      abilities: ['はっこう', 'むしのしらせ'],
      height: 7, weight: 177,
      generation: 3, category: 'ほたるポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.314 イルミーゼ ===
  {
    national_id: 314,
    name_ja: 'イルミーゼ',
    name_en: 'Illumise',
    name_kana: 'イルミーゼ',
    data: {
      types: ['むし'],
      stats: { hp: 65, attack: 47, defense: 75, special_attack: 73, special_defense: 85, speed: 85 },
      abilities: ['どんかん', 'いろめがね'],
      height: 6, weight: 177,
      generation: 3, category: 'ほたるポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.315 ロゼリア ===
  {
    national_id: 315,
    name_ja: 'ロゼリア',
    name_en: 'Roselia',
    name_kana: 'ロゼリア',
    data: {
      types: ['くさ', 'どく'],
      stats: { hp: 50, attack: 60, defense: 45, special_attack: 100, special_defense: 80, speed: 65 },
      abilities: ['しぜんかいふく', 'どくのトゲ'],
      height: 3, weight: 20,
      generation: 3, category: 'いばらポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.316 ゴクリン ===
  {
    national_id: 316,
    name_ja: 'ゴクリン',
    name_en: 'Gulpin',
    name_kana: 'ゴクリン',
    data: {
      types: ['どく'],
      stats: { hp: 70, attack: 43, defense: 53, special_attack: 43, special_defense: 53, speed: 40 },
      abilities: ['ヘドロえき', 'ねんちゃく'],
      height: 4, weight: 103,
      generation: 3, category: 'いぶくろポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.317 マルノーム ===
  {
    national_id: 317,
    name_ja: 'マルノーム',
    name_en: 'Swalot',
    name_kana: 'マルノーム',
    data: {
      types: ['どく'],
      stats: { hp: 100, attack: 73, defense: 83, special_attack: 73, special_defense: 83, speed: 55 },
      abilities: ['ヘドロえき', 'ねんちゃく'],
      height: 17, weight: 800,
      generation: 3, category: 'どくぶくろポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.318 キバニア ===
  {
    national_id: 318,
    name_ja: 'キバニア',
    name_en: 'Carvanha',
    name_kana: 'キバニア',
    data: {
      types: ['みず', 'あく'],
      stats: { hp: 45, attack: 90, defense: 20, special_attack: 65, special_defense: 20, speed: 65 },
      abilities: ['さめはだ'],
      height: 8, weight: 208,
      generation: 3, category: 'どうもうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.319 サメハダー ===
  {
    national_id: 319,
    name_ja: 'サメハダー',
    name_en: 'Sharpedo',
    name_kana: 'サメハダー',
    data: {
      types: ['みず', 'あく'],
      stats: { hp: 70, attack: 120, defense: 40, special_attack: 95, special_defense: 40, speed: 95 },
      abilities: ['さめはだ'],
      height: 18, weight: 888,
      generation: 3, category: 'きょうぼうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.320 ホエルコ ===
  {
    national_id: 320,
    name_ja: 'ホエルコ',
    name_en: 'Wailmer',
    name_kana: 'ホエルコ',
    data: {
      types: ['みず'],
      stats: { hp: 130, attack: 70, defense: 35, special_attack: 70, special_defense: 35, speed: 60 },
      abilities: ['みずのベール', 'どんかん'],
      height: 20, weight: 1300,
      generation: 3, category: 'たまくじらポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.321 ホエルオー ===
  {
    national_id: 321,
    name_ja: 'ホエルオー',
    name_en: 'Wailord',
    name_kana: 'ホエルオー',
    data: {
      types: ['みず'],
      stats: { hp: 170, attack: 90, defense: 45, special_attack: 90, special_defense: 45, speed: 60 },
      abilities: ['みずのベール', 'どんかん'],
      height: 145, weight: 3980,
      generation: 3, category: 'うきくじらポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.322 ドンメル ===
  {
    national_id: 322,
    name_ja: 'ドンメル',
    name_en: 'Numel',
    name_kana: 'ドンメル',
    data: {
      types: ['ほのお', 'じめん'],
      stats: { hp: 60, attack: 60, defense: 40, special_attack: 65, special_defense: 45, speed: 35 },
      abilities: ['どんかん', 'たんじゅん'],
      height: 7, weight: 240,
      generation: 3, category: 'どんかんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.323 バクーダ ===
  {
    national_id: 323,
    name_ja: 'バクーダ',
    name_en: 'Camerupt',
    name_kana: 'バクーダ',
    data: {
      types: ['ほのお', 'じめん'],
      stats: { hp: 70, attack: 100, defense: 70, special_attack: 105, special_defense: 75, speed: 40 },
      abilities: ['マグマのよろい', 'ハードロック'],
      height: 19, weight: 2200,
      generation: 3, category: 'ふんかポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.324 コータス ===
  {
    national_id: 324,
    name_ja: 'コータス',
    name_en: 'Torkoal',
    name_kana: 'コータス',
    data: {
      types: ['ほのお'],
      stats: { hp: 70, attack: 85, defense: 140, special_attack: 85, special_defense: 70, speed: 20 },
      abilities: ['しろいけむり', 'ひでり'],
      height: 5, weight: 804,
      generation: 3, category: 'せきたんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.325 バネブー ===
  {
    national_id: 325,
    name_ja: 'バネブー',
    name_en: 'Spoink',
    name_kana: 'バネブー',
    data: {
      types: ['エスパー'],
      stats: { hp: 60, attack: 25, defense: 35, special_attack: 70, special_defense: 80, speed: 60 },
      abilities: ['あついしぼう', 'マイペース'],
      height: 7, weight: 306,
      generation: 3, category: 'はねブタポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.326 ブーピッグ ===
  {
    national_id: 326,
    name_ja: 'ブーピッグ',
    name_en: 'Grumpig',
    name_kana: 'ブーピッグ',
    data: {
      types: ['エスパー'],
      stats: { hp: 80, attack: 45, defense: 65, special_attack: 90, special_defense: 110, speed: 80 },
      abilities: ['あついしぼう', 'マイペース'],
      height: 9, weight: 715,
      generation: 3, category: 'あやつりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.327 パッチール ===
  {
    national_id: 327,
    name_ja: 'パッチール',
    name_en: 'Spinda',
    name_kana: 'パッチール',
    data: {
      types: ['ノーマル'],
      stats: { hp: 60, attack: 60, defense: 60, special_attack: 60, special_defense: 60, speed: 60 },
      abilities: ['マイペース', 'ちどりあし'],
      height: 11, weight: 50,
      generation: 3, category: 'ぶちパンダポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.328 ナックラー ===
  {
    national_id: 328,
    name_ja: 'ナックラー',
    name_en: 'Trapinch',
    name_kana: 'ナックラー',
    data: {
      types: ['じめん'],
      stats: { hp: 45, attack: 100, defense: 45, special_attack: 45, special_defense: 45, speed: 10 },
      abilities: ['かいりきバサミ', 'ありじごく'],
      height: 7, weight: 150,
      generation: 3, category: 'ありじごくポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.329 ビブラーバ ===
  {
    national_id: 329,
    name_ja: 'ビブラーバ',
    name_en: 'Vibrava',
    name_kana: 'ビブラーバ',
    data: {
      types: ['じめん', 'ドラゴン'],
      stats: { hp: 50, attack: 70, defense: 50, special_attack: 50, special_defense: 50, speed: 70 },
      abilities: ['ふゆう'],
      height: 11, weight: 153,
      generation: 3, category: 'しんどうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.330 フライゴン ===
  {
    national_id: 330,
    name_ja: 'フライゴン',
    name_en: 'Flygon',
    name_kana: 'フライゴン',
    data: {
      types: ['じめん', 'ドラゴン'],
      stats: { hp: 80, attack: 100, defense: 80, special_attack: 80, special_defense: 80, speed: 100 },
      abilities: ['ふゆう'],
      height: 20, weight: 820,
      generation: 3, category: 'せいれいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.331 サボネア ===
  {
    national_id: 331,
    name_ja: 'サボネア',
    name_en: 'Cacnea',
    name_kana: 'サボネア',
    data: {
      types: ['くさ'],
      stats: { hp: 50, attack: 85, defense: 40, special_attack: 85, special_defense: 40, speed: 35 },
      abilities: ['すながくれ'],
      height: 4, weight: 513,
      generation: 3, category: 'サボテンポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.332 ノクタス ===
  {
    national_id: 332,
    name_ja: 'ノクタス',
    name_en: 'Cacturne',
    name_kana: 'ノクタス',
    data: {
      types: ['くさ', 'あく'],
      stats: { hp: 70, attack: 115, defense: 60, special_attack: 115, special_defense: 60, speed: 55 },
      abilities: ['すながくれ'],
      height: 13, weight: 774,
      generation: 3, category: 'かかしぐさポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.333 チルット ===
  {
    national_id: 333,
    name_ja: 'チルット',
    name_en: 'Swablu',
    name_kana: 'チルット',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 45, attack: 40, defense: 60, special_attack: 40, special_defense: 75, speed: 50 },
      abilities: ['しぜんかいふく'],
      height: 4, weight: 12,
      generation: 3, category: 'わたどりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.334 チルタリス ===
  {
    national_id: 334,
    name_ja: 'チルタリス',
    name_en: 'Altaria',
    name_kana: 'チルタリス',
    data: {
      types: ['ドラゴン', 'ひこう'],
      stats: { hp: 75, attack: 70, defense: 90, special_attack: 70, special_defense: 105, speed: 80 },
      abilities: ['しぜんかいふく'],
      height: 11, weight: 206,
      generation: 3, category: 'ハミングポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.335 ザングース ===
  {
    national_id: 335,
    name_ja: 'ザングース',
    name_en: 'Zangoose',
    name_kana: 'ザングース',
    data: {
      types: ['ノーマル'],
      stats: { hp: 73, attack: 115, defense: 60, special_attack: 60, special_defense: 60, speed: 90 },
      abilities: ['めんえき'],
      height: 13, weight: 403,
      generation: 3, category: 'ネコイタチポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.336 ハブネーク ===
  {
    national_id: 336,
    name_ja: 'ハブネーク',
    name_en: 'Seviper',
    name_kana: 'ハブネーク',
    data: {
      types: ['どく'],
      stats: { hp: 73, attack: 100, defense: 60, special_attack: 100, special_defense: 60, speed: 65 },
      abilities: ['だっぴ'],
      height: 27, weight: 525,
      generation: 3, category: 'キバヘビポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.337 ルナトーン ===
  {
    national_id: 337,
    name_ja: 'ルナトーン',
    name_en: 'Lunatone',
    name_kana: 'ルナトーン',
    data: {
      types: ['いわ', 'エスパー'],
      stats: { hp: 90, attack: 55, defense: 65, special_attack: 95, special_defense: 85, speed: 70 },
      abilities: ['ふゆう'],
      height: 10, weight: 1680,
      generation: 3, category: 'いんせきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.338 ソルロック ===
  {
    national_id: 338,
    name_ja: 'ソルロック',
    name_en: 'Solrock',
    name_kana: 'ソルロック',
    data: {
      types: ['いわ', 'エスパー'],
      stats: { hp: 90, attack: 95, defense: 85, special_attack: 55, special_defense: 65, speed: 70 },
      abilities: ['ふゆう'],
      height: 12, weight: 1540,
      generation: 3, category: 'いんせきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.339 ドジョッチ ===
  {
    national_id: 339,
    name_ja: 'ドジョッチ',
    name_en: 'Barboach',
    name_kana: 'ドジョッチ',
    data: {
      types: ['みず', 'じめん'],
      stats: { hp: 50, attack: 48, defense: 43, special_attack: 46, special_defense: 41, speed: 60 },
      abilities: ['どんかん', 'きけんよち'],
      height: 4, weight: 19,
      generation: 3, category: 'ひげうおポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.340 ナマズン ===
  {
    national_id: 340,
    name_ja: 'ナマズン',
    name_en: 'Whiscash',
    name_kana: 'ナマズン',
    data: {
      types: ['みず', 'じめん'],
      stats: { hp: 110, attack: 78, defense: 73, special_attack: 76, special_defense: 71, speed: 60 },
      abilities: ['どんかん', 'きけんよち'],
      height: 9, weight: 236,
      generation: 3, category: 'ひげうおポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.341 ヘイガニ ===
  {
    national_id: 341,
    name_ja: 'ヘイガニ',
    name_en: 'Corphish',
    name_kana: 'ヘイガニ',
    data: {
      types: ['みず'],
      stats: { hp: 43, attack: 80, defense: 65, special_attack: 50, special_defense: 35, speed: 35 },
      abilities: ['かいりきバサミ', 'シェルアーマー'],
      height: 6, weight: 115,
      generation: 3, category: 'ならずものポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.342 シザリガー ===
  {
    national_id: 342,
    name_ja: 'シザリガー',
    name_en: 'Crawdaunt',
    name_kana: 'シザリガー',
    data: {
      types: ['みず', 'あく'],
      stats: { hp: 63, attack: 120, defense: 85, special_attack: 90, special_defense: 55, speed: 55 },
      abilities: ['かいりきバサミ', 'シェルアーマー'],
      height: 11, weight: 328,
      generation: 3, category: 'ならずものポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.343 ヤジロン ===
  {
    national_id: 343,
    name_ja: 'ヤジロン',
    name_en: 'Baltoy',
    name_kana: 'ヤジロン',
    data: {
      types: ['じめん', 'エスパー'],
      stats: { hp: 40, attack: 40, defense: 55, special_attack: 40, special_defense: 70, speed: 55 },
      abilities: ['ふゆう'],
      height: 5, weight: 215,
      generation: 3, category: 'つちにんぎょうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.344 ネンドール ===
  {
    national_id: 344,
    name_ja: 'ネンドール',
    name_en: 'Claydol',
    name_kana: 'ネンドール',
    data: {
      types: ['じめん', 'エスパー'],
      stats: { hp: 60, attack: 70, defense: 105, special_attack: 70, special_defense: 120, speed: 75 },
      abilities: ['ふゆう'],
      height: 15, weight: 1080,
      generation: 3, category: 'ねんどポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.345 リリーラ ===
  {
    national_id: 345,
    name_ja: 'リリーラ',
    name_en: 'Lileep',
    name_kana: 'リリーラ',
    data: {
      types: ['いわ', 'くさ'],
      stats: { hp: 66, attack: 41, defense: 77, special_attack: 61, special_defense: 87, speed: 23 },
      abilities: ['きゅうばん'],
      height: 10, weight: 238,
      generation: 3, category: 'ウミユリポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.346 ユレイドル ===
  {
    national_id: 346,
    name_ja: 'ユレイドル',
    name_en: 'Cradily',
    name_kana: 'ユレイドル',
    data: {
      types: ['いわ', 'くさ'],
      stats: { hp: 86, attack: 81, defense: 97, special_attack: 81, special_defense: 107, speed: 43 },
      abilities: ['きゅうばん'],
      height: 15, weight: 604,
      generation: 3, category: 'ウミユリポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.347 アノプス ===
  {
    national_id: 347,
    name_ja: 'アノプス',
    name_en: 'Anorith',
    name_kana: 'アノプス',
    data: {
      types: ['いわ', 'むし'],
      stats: { hp: 45, attack: 95, defense: 50, special_attack: 40, special_defense: 50, speed: 75 },
      abilities: ['カブトアーマー'],
      height: 7, weight: 125,
      generation: 3, category: 'むかしエビポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.348 アーマルド ===
  {
    national_id: 348,
    name_ja: 'アーマルド',
    name_en: 'Armaldo',
    name_kana: 'アーマルド',
    data: {
      types: ['いわ', 'むし'],
      stats: { hp: 75, attack: 125, defense: 100, special_attack: 70, special_defense: 80, speed: 45 },
      abilities: ['カブトアーマー'],
      height: 15, weight: 682,
      generation: 3, category: 'かっちゅうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.349 ヒンバス ===
  {
    national_id: 349,
    name_ja: 'ヒンバス',
    name_en: 'Feebas',
    name_kana: 'ヒンバス',
    data: {
      types: ['みず'],
      stats: { hp: 20, attack: 15, defense: 20, special_attack: 10, special_defense: 55, speed: 80 },
      abilities: ['すいすい', 'どんかん'],
      height: 6, weight: 74,
      generation: 3, category: 'さかなポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.350 ミロカロス ===
  {
    national_id: 350,
    name_ja: 'ミロカロス',
    name_en: 'Milotic',
    name_kana: 'ミロカロス',
    data: {
      types: ['みず'],
      stats: { hp: 95, attack: 60, defense: 79, special_attack: 100, special_defense: 125, speed: 81 },
      abilities: ['ふしぎなうろこ', 'かちき'],
      height: 62, weight: 1620,
      generation: 3, category: 'いつくしみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.351 ポワルン ===
  {
    national_id: 351,
    name_ja: 'ポワルン',
    name_en: 'Castform',
    name_kana: 'ポワルン',
    data: {
      types: ['ノーマル'],
      stats: { hp: 70, attack: 70, defense: 70, special_attack: 70, special_defense: 70, speed: 70 },
      abilities: ['てんきや'],
      height: 3, weight: 8,
      generation: 3, category: 'てんきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.352 カクレオン ===
  {
    national_id: 352,
    name_ja: 'カクレオン',
    name_en: 'Kecleon',
    name_kana: 'カクレオン',
    data: {
      types: ['ノーマル'],
      stats: { hp: 60, attack: 90, defense: 70, special_attack: 60, special_defense: 120, speed: 40 },
      abilities: ['へんしょく'],
      height: 10, weight: 220,
      generation: 3, category: 'いろへんげポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.353 カゲボウズ ===
  {
    national_id: 353,
    name_ja: 'カゲボウズ',
    name_en: 'Shuppet',
    name_kana: 'カゲボウズ',
    data: {
      types: ['ゴースト'],
      stats: { hp: 44, attack: 75, defense: 35, special_attack: 63, special_defense: 33, speed: 45 },
      abilities: ['ふみん', 'おみとおし'],
      height: 6, weight: 23,
      generation: 3, category: 'にんぎょうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.354 ジュペッタ ===
  {
    national_id: 354,
    name_ja: 'ジュペッタ',
    name_en: 'Banette',
    name_kana: 'ジュペッタ',
    data: {
      types: ['ゴースト'],
      stats: { hp: 64, attack: 115, defense: 65, special_attack: 83, special_defense: 63, speed: 65 },
      abilities: ['ふみん', 'おみとおし'],
      height: 11, weight: 125,
      generation: 3, category: 'ぬいぐるみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.355 ヨマワル ===
  {
    national_id: 355,
    name_ja: 'ヨマワル',
    name_en: 'Duskull',
    name_kana: 'ヨマワル',
    data: {
      types: ['ゴースト'],
      stats: { hp: 20, attack: 40, defense: 90, special_attack: 30, special_defense: 90, speed: 25 },
      abilities: ['ふゆう'],
      height: 8, weight: 150,
      generation: 3, category: 'おむかえポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.356 サマヨール ===
  {
    national_id: 356,
    name_ja: 'サマヨール',
    name_en: 'Dusclops',
    name_kana: 'サマヨール',
    data: {
      types: ['ゴースト'],
      stats: { hp: 40, attack: 70, defense: 130, special_attack: 60, special_defense: 130, speed: 25 },
      abilities: ['プレッシャー'],
      height: 16, weight: 306,
      generation: 3, category: 'てまねきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.357 トロピウス ===
  {
    national_id: 357,
    name_ja: 'トロピウス',
    name_en: 'Tropius',
    name_kana: 'トロピウス',
    data: {
      types: ['くさ', 'ひこう'],
      stats: { hp: 99, attack: 68, defense: 83, special_attack: 72, special_defense: 87, speed: 51 },
      abilities: ['ようりょくそ', 'サンパワー'],
      height: 20, weight: 1000,
      generation: 3, category: 'フルーツポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.358 チリーン ===
  {
    national_id: 358,
    name_ja: 'チリーン',
    name_en: 'Chimecho',
    name_kana: 'チリーン',
    data: {
      types: ['エスパー'],
      stats: { hp: 75, attack: 50, defense: 80, special_attack: 95, special_defense: 90, speed: 65 },
      abilities: ['ふゆう'],
      height: 6, weight: 10,
      generation: 3, category: 'ふうりんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.359 アブソル ===
  {
    national_id: 359,
    name_ja: 'アブソル',
    name_en: 'Absol',
    name_kana: 'アブソル',
    data: {
      types: ['あく'],
      stats: { hp: 65, attack: 130, defense: 60, special_attack: 75, special_defense: 60, speed: 75 },
      abilities: ['プレッシャー', 'きょううん'],
      height: 12, weight: 470,
      generation: 3, category: 'わざわいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.360 ソーナノ ===
  {
    national_id: 360,
    name_ja: 'ソーナノ',
    name_en: 'Wynaut',
    name_kana: 'ソーナノ',
    data: {
      types: ['エスパー'],
      stats: { hp: 95, attack: 23, defense: 48, special_attack: 23, special_defense: 48, speed: 23 },
      abilities: ['かげふみ'],
      height: 6, weight: 140,
      generation: 3, category: 'あかるいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.361 ユキワラシ ===
  {
    national_id: 361,
    name_ja: 'ユキワラシ',
    name_en: 'Snorunt',
    name_kana: 'ユキワラシ',
    data: {
      types: ['こおり'],
      stats: { hp: 50, attack: 50, defense: 50, special_attack: 50, special_defense: 50, speed: 50 },
      abilities: ['せいしんりょく', 'アイスボディ'],
      height: 7, weight: 168,
      generation: 3, category: 'ゆきかさポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.362 オニゴーリ ===
  {
    national_id: 362,
    name_ja: 'オニゴーリ',
    name_en: 'Glalie',
    name_kana: 'オニゴーリ',
    data: {
      types: ['こおり'],
      stats: { hp: 80, attack: 80, defense: 80, special_attack: 80, special_defense: 80, speed: 80 },
      abilities: ['せいしんりょく', 'アイスボディ'],
      height: 15, weight: 2565,
      generation: 3, category: 'フェイスポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.363 タマザラシ ===
  {
    national_id: 363,
    name_ja: 'タマザラシ',
    name_en: 'Spheal',
    name_kana: 'タマザラシ',
    data: {
      types: ['こおり', 'みず'],
      stats: { hp: 70, attack: 40, defense: 50, special_attack: 55, special_defense: 50, speed: 25 },
      abilities: ['あついしぼう', 'アイスボディ'],
      height: 8, weight: 395,
      generation: 3, category: 'てたたきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.364 トドグラー ===
  {
    national_id: 364,
    name_ja: 'トドグラー',
    name_en: 'Sealeo',
    name_kana: 'トドグラー',
    data: {
      types: ['こおり', 'みず'],
      stats: { hp: 90, attack: 60, defense: 70, special_attack: 75, special_defense: 70, speed: 45 },
      abilities: ['あついしぼう', 'アイスボディ'],
      height: 11, weight: 876,
      generation: 3, category: 'たまころがしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.365 トドゼルガ ===
  {
    national_id: 365,
    name_ja: 'トドゼルガ',
    name_en: 'Walrein',
    name_kana: 'トドゼルガ',
    data: {
      types: ['こおり', 'みず'],
      stats: { hp: 110, attack: 80, defense: 90, special_attack: 95, special_defense: 90, speed: 65 },
      abilities: ['あついしぼう', 'アイスボディ'],
      height: 14, weight: 1506,
      generation: 3, category: 'こおりわりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.366 パールル ===
  {
    national_id: 366,
    name_ja: 'パールル',
    name_en: 'Clamperl',
    name_kana: 'パールル',
    data: {
      types: ['みず'],
      stats: { hp: 35, attack: 64, defense: 85, special_attack: 74, special_defense: 55, speed: 32 },
      abilities: ['シェルアーマー'],
      height: 4, weight: 525,
      generation: 3, category: 'にまいがいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.367 ハンテール ===
  {
    national_id: 367,
    name_ja: 'ハンテール',
    name_en: 'Huntail',
    name_kana: 'ハンテール',
    data: {
      types: ['みず'],
      stats: { hp: 55, attack: 104, defense: 105, special_attack: 94, special_defense: 75, speed: 52 },
      abilities: ['すいすい'],
      height: 17, weight: 270,
      generation: 3, category: 'しんかいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.368 サクラビス ===
  {
    national_id: 368,
    name_ja: 'サクラビス',
    name_en: 'Gorebyss',
    name_kana: 'サクラビス',
    data: {
      types: ['みず'],
      stats: { hp: 55, attack: 84, defense: 105, special_attack: 114, special_defense: 75, speed: 52 },
      abilities: ['すいすい'],
      height: 18, weight: 226,
      generation: 3, category: 'なんかいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.369 ジーランス ===
  {
    national_id: 369,
    name_ja: 'ジーランス',
    name_en: 'Relicanth',
    name_kana: 'ジーランス',
    data: {
      types: ['みず', 'いわ'],
      stats: { hp: 100, attack: 90, defense: 130, special_attack: 45, special_defense: 65, speed: 55 },
      abilities: ['すいすい', 'いしあたま'],
      height: 10, weight: 234,
      generation: 3, category: 'ちょうじゅポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.370 ラブカス ===
  {
    national_id: 370,
    name_ja: 'ラブカス',
    name_en: 'Luvdisc',
    name_kana: 'ラブカス',
    data: {
      types: ['みず'],
      stats: { hp: 43, attack: 30, defense: 55, special_attack: 40, special_defense: 65, speed: 97 },
      abilities: ['すいすい'],
      height: 6, weight: 87,
      generation: 3, category: 'ランデブーポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.371 タツベイ ===
  {
    national_id: 371,
    name_ja: 'タツベイ',
    name_en: 'Bagon',
    name_kana: 'タツベイ',
    data: {
      types: ['ドラゴン'],
      stats: { hp: 45, attack: 75, defense: 60, special_attack: 40, special_defense: 30, speed: 50 },
      abilities: ['いしあたま'],
      height: 6, weight: 421,
      generation: 3, category: 'いわあたまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.372 コモルー ===
  {
    national_id: 372,
    name_ja: 'コモルー',
    name_en: 'Shelgon',
    name_kana: 'コモルー',
    data: {
      types: ['ドラゴン'],
      stats: { hp: 65, attack: 95, defense: 100, special_attack: 60, special_defense: 50, speed: 50 },
      abilities: ['いしあたま'],
      height: 11, weight: 1105,
      generation: 3, category: 'にんたいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.373 ボーマンダ ===
  {
    national_id: 373,
    name_ja: 'ボーマンダ',
    name_en: 'Salamence',
    name_kana: 'ボーマンダ',
    data: {
      types: ['ドラゴン', 'ひこう'],
      stats: { hp: 95, attack: 135, defense: 80, special_attack: 110, special_defense: 80, speed: 100 },
      abilities: ['いかく'],
      height: 15, weight: 1026,
      generation: 3, category: 'ドラゴンポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.374 ダンバル ===
  {
    national_id: 374,
    name_ja: 'ダンバル',
    name_en: 'Beldum',
    name_kana: 'ダンバル',
    data: {
      types: ['はがね', 'エスパー'],
      stats: { hp: 40, attack: 55, defense: 80, special_attack: 35, special_defense: 60, speed: 30 },
      abilities: ['クリアボディ'],
      height: 6, weight: 952,
      generation: 3, category: 'てっきゅうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.375 メタング ===
  {
    national_id: 375,
    name_ja: 'メタング',
    name_en: 'Metang',
    name_kana: 'メタング',
    data: {
      types: ['はがね', 'エスパー'],
      stats: { hp: 60, attack: 75, defense: 100, special_attack: 55, special_defense: 80, speed: 50 },
      abilities: ['クリアボディ'],
      height: 12, weight: 2025,
      generation: 3, category: 'てつツメポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.376 メタグロス ===
  {
    national_id: 376,
    name_ja: 'メタグロス',
    name_en: 'Metagross',
    name_kana: 'メタグロス',
    data: {
      types: ['はがね', 'エスパー'],
      stats: { hp: 80, attack: 135, defense: 130, special_attack: 95, special_defense: 90, speed: 70 },
      abilities: ['クリアボディ'],
      height: 16, weight: 5500,
      generation: 3, category: 'てつあしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.377 レジロック ===
  {
    national_id: 377,
    name_ja: 'レジロック',
    name_en: 'Regirock',
    name_kana: 'レジロック',
    data: {
      types: ['いわ'],
      stats: { hp: 80, attack: 100, defense: 200, special_attack: 50, special_defense: 100, speed: 50 },
      abilities: ['クリアボディ'],
      height: 17, weight: 2300,
      generation: 3, category: 'いわやまポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.378 レジアイス ===
  {
    national_id: 378,
    name_ja: 'レジアイス',
    name_en: 'Regice',
    name_kana: 'レジアイス',
    data: {
      types: ['こおり'],
      stats: { hp: 80, attack: 50, defense: 100, special_attack: 100, special_defense: 200, speed: 50 },
      abilities: ['クリアボディ'],
      height: 18, weight: 1750,
      generation: 3, category: 'ひょうざんポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.379 レジスチル ===
  {
    national_id: 379,
    name_ja: 'レジスチル',
    name_en: 'Registeel',
    name_kana: 'レジスチル',
    data: {
      types: ['はがね'],
      stats: { hp: 80, attack: 75, defense: 150, special_attack: 75, special_defense: 150, speed: 50 },
      abilities: ['クリアボディ'],
      height: 19, weight: 2050,
      generation: 3, category: 'くろがねポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.380 ラティアス ===
  {
    national_id: 380,
    name_ja: 'ラティアス',
    name_en: 'Latias',
    name_kana: 'ラティアス',
    data: {
      types: ['ドラゴン', 'エスパー'],
      stats: { hp: 80, attack: 80, defense: 90, special_attack: 110, special_defense: 130, speed: 110 },
      abilities: ['ふゆう'],
      height: 14, weight: 400,
      generation: 3, category: 'むげんポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.381 ラティオス ===
  {
    national_id: 381,
    name_ja: 'ラティオス',
    name_en: 'Latios',
    name_kana: 'ラティオス',
    data: {
      types: ['ドラゴン', 'エスパー'],
      stats: { hp: 80, attack: 90, defense: 80, special_attack: 130, special_defense: 110, speed: 110 },
      abilities: ['ふゆう'],
      height: 20, weight: 600,
      generation: 3, category: 'むげんポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.382 カイオーガ ===
  {
    national_id: 382,
    name_ja: 'カイオーガ',
    name_en: 'Kyogre',
    name_kana: 'カイオーガ',
    data: {
      types: ['みず'],
      stats: { hp: 100, attack: 100, defense: 90, special_attack: 150, special_defense: 140, speed: 90 },
      abilities: ['あめふらし'],
      height: 45, weight: 3520,
      generation: 3, category: 'かいていポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.383 グラードン ===
  {
    national_id: 383,
    name_ja: 'グラードン',
    name_en: 'Groudon',
    name_kana: 'グラードン',
    data: {
      types: ['じめん'],
      stats: { hp: 100, attack: 150, defense: 140, special_attack: 100, special_defense: 90, speed: 90 },
      abilities: ['ひでり'],
      height: 35, weight: 9500,
      generation: 3, category: 'たいりくポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.384 レックウザ ===
  {
    national_id: 384,
    name_ja: 'レックウザ',
    name_en: 'Rayquaza',
    name_kana: 'レックウザ',
    data: {
      types: ['ドラゴン', 'ひこう'],
      stats: { hp: 105, attack: 150, defense: 90, special_attack: 150, special_defense: 90, speed: 95 },
      abilities: ['エアロック'],
      height: 70, weight: 2065,
      generation: 3, category: 'てんくうポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.385 ジラーチ ===
  {
    national_id: 385,
    name_ja: 'ジラーチ',
    name_en: 'Jirachi',
    name_kana: 'ジラーチ',
    data: {
      types: ['はがね', 'エスパー'],
      stats: { hp: 100, attack: 100, defense: 100, special_attack: 100, special_defense: 100, speed: 100 },
      abilities: ['てんのめぐみ'],
      height: 3, weight: 11,
      generation: 3, category: 'ねがいごとポケモン',
      is_legendary: false, is_mythical: true
    }
  },
  # === No.386 デオキシス ===
  {
    national_id: 386,
    name_ja: 'デオキシス',
    name_en: 'Deoxys',
    name_kana: 'デオキシス',
    data: {
      types: ['エスパー'],
      stats: { hp: 50, attack: 150, defense: 50, special_attack: 150, special_defense: 50, speed: 150 },
      abilities: ['プレッシャー'],
      height: 17, weight: 608,
      generation: 3, category: 'DNAポケモン',
      is_legendary: false, is_mythical: true
    }
  }
].freeze
