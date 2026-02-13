# 第1世代 ポケモン図鑑データ（No.1〜No.151）
# db/seeds.rb から呼び出される
# タイプ・種族値・特性は公式データに基づく（第6世代以降の最新値）
# height: デシメートル単位 / weight: ヘクトグラム単位
# abilities: 通常特性のみ（隠れ特性は含まない）

POKEMON_GEN1_DATA = [
  # === No.1 フシギダネ ===
  {
    national_id: 1,
    name_ja: 'フシギダネ',
    name_en: 'Bulbasaur',
    name_kana: 'フシギダネ',
    data: {
      types: ['くさ', 'どく'],
      stats: { hp: 45, attack: 49, defense: 49, special_attack: 65, special_defense: 65, speed: 45 },
      abilities: ['しんりょく'],
      height: 7, weight: 69,
      generation: 1, category: 'たねポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.2 フシギソウ ===
  {
    national_id: 2,
    name_ja: 'フシギソウ',
    name_en: 'Ivysaur',
    name_kana: 'フシギソウ',
    data: {
      types: ['くさ', 'どく'],
      stats: { hp: 60, attack: 62, defense: 63, special_attack: 80, special_defense: 80, speed: 60 },
      abilities: ['しんりょく'],
      height: 10, weight: 130,
      generation: 1, category: 'たねポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.3 フシギバナ ===
  {
    national_id: 3,
    name_ja: 'フシギバナ',
    name_en: 'Venusaur',
    name_kana: 'フシギバナ',
    data: {
      types: ['くさ', 'どく'],
      stats: { hp: 80, attack: 82, defense: 83, special_attack: 100, special_defense: 100, speed: 80 },
      abilities: ['しんりょく'],
      height: 20, weight: 1000,
      generation: 1, category: 'たねポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.4 ヒトカゲ ===
  {
    national_id: 4,
    name_ja: 'ヒトカゲ',
    name_en: 'Charmander',
    name_kana: 'ヒトカゲ',
    data: {
      types: ['ほのお'],
      stats: { hp: 39, attack: 52, defense: 43, special_attack: 60, special_defense: 50, speed: 65 },
      abilities: ['もうか'],
      height: 6, weight: 85,
      generation: 1, category: 'とかげポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.5 リザード ===
  {
    national_id: 5,
    name_ja: 'リザード',
    name_en: 'Charmeleon',
    name_kana: 'リザード',
    data: {
      types: ['ほのお'],
      stats: { hp: 58, attack: 64, defense: 58, special_attack: 80, special_defense: 65, speed: 80 },
      abilities: ['もうか'],
      height: 11, weight: 190,
      generation: 1, category: 'かえんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.6 リザードン ===
  {
    national_id: 6,
    name_ja: 'リザードン',
    name_en: 'Charizard',
    name_kana: 'リザードン',
    data: {
      types: ['ほのお', 'ひこう'],
      stats: { hp: 78, attack: 84, defense: 78, special_attack: 109, special_defense: 85, speed: 100 },
      abilities: ['もうか'],
      height: 17, weight: 905,
      generation: 1, category: 'かえんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.7 ゼニガメ ===
  {
    national_id: 7,
    name_ja: 'ゼニガメ',
    name_en: 'Squirtle',
    name_kana: 'ゼニガメ',
    data: {
      types: ['みず'],
      stats: { hp: 44, attack: 48, defense: 65, special_attack: 50, special_defense: 64, speed: 43 },
      abilities: ['げきりゅう'],
      height: 5, weight: 90,
      generation: 1, category: 'かめのこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.8 カメール ===
  {
    national_id: 8,
    name_ja: 'カメール',
    name_en: 'Wartortle',
    name_kana: 'カメール',
    data: {
      types: ['みず'],
      stats: { hp: 59, attack: 63, defense: 80, special_attack: 65, special_defense: 80, speed: 58 },
      abilities: ['げきりゅう'],
      height: 10, weight: 225,
      generation: 1, category: 'かめポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.9 カメックス ===
  {
    national_id: 9,
    name_ja: 'カメックス',
    name_en: 'Blastoise',
    name_kana: 'カメックス',
    data: {
      types: ['みず'],
      stats: { hp: 79, attack: 83, defense: 100, special_attack: 85, special_defense: 105, speed: 78 },
      abilities: ['げきりゅう'],
      height: 16, weight: 855,
      generation: 1, category: 'こうらポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.10 キャタピー ===
  {
    national_id: 10,
    name_ja: 'キャタピー',
    name_en: 'Caterpie',
    name_kana: 'キャタピー',
    data: {
      types: ['むし'],
      stats: { hp: 45, attack: 30, defense: 35, special_attack: 20, special_defense: 20, speed: 45 },
      abilities: ['りんぷん'],
      height: 3, weight: 29,
      generation: 1, category: 'いもむしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.11 トランセル ===
  {
    national_id: 11,
    name_ja: 'トランセル',
    name_en: 'Metapod',
    name_kana: 'トランセル',
    data: {
      types: ['むし'],
      stats: { hp: 50, attack: 20, defense: 55, special_attack: 25, special_defense: 25, speed: 30 },
      abilities: ['だっぴ'],
      height: 7, weight: 99,
      generation: 1, category: 'さなぎポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.12 バタフリー ===
  {
    national_id: 12,
    name_ja: 'バタフリー',
    name_en: 'Butterfree',
    name_kana: 'バタフリー',
    data: {
      types: ['むし', 'ひこう'],
      stats: { hp: 60, attack: 45, defense: 50, special_attack: 90, special_defense: 80, speed: 70 },
      abilities: ['ふくがん'],
      height: 11, weight: 320,
      generation: 1, category: 'ちょうちょポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.13 ビードル ===
  {
    national_id: 13,
    name_ja: 'ビードル',
    name_en: 'Weedle',
    name_kana: 'ビードル',
    data: {
      types: ['むし', 'どく'],
      stats: { hp: 40, attack: 35, defense: 30, special_attack: 20, special_defense: 20, speed: 50 },
      abilities: ['りんぷん'],
      height: 3, weight: 32,
      generation: 1, category: 'けむしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.14 コクーン ===
  {
    national_id: 14,
    name_ja: 'コクーン',
    name_en: 'Kakuna',
    name_kana: 'コクーン',
    data: {
      types: ['むし', 'どく'],
      stats: { hp: 45, attack: 25, defense: 50, special_attack: 25, special_defense: 25, speed: 35 },
      abilities: ['だっぴ'],
      height: 6, weight: 100,
      generation: 1, category: 'さなぎポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.15 スピアー ===
  {
    national_id: 15,
    name_ja: 'スピアー',
    name_en: 'Beedrill',
    name_kana: 'スピアー',
    data: {
      types: ['むし', 'どく'],
      stats: { hp: 65, attack: 90, defense: 40, special_attack: 45, special_defense: 80, speed: 75 },
      abilities: ['むしのしらせ'],
      height: 10, weight: 295,
      generation: 1, category: 'どくばちポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.16 ポッポ ===
  {
    national_id: 16,
    name_ja: 'ポッポ',
    name_en: 'Pidgey',
    name_kana: 'ポッポ',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 40, attack: 45, defense: 40, special_attack: 35, special_defense: 35, speed: 56 },
      abilities: ['するどいめ', 'ちどりあし'],
      height: 3, weight: 18,
      generation: 1, category: 'ことりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.17 ピジョン ===
  {
    national_id: 17,
    name_ja: 'ピジョン',
    name_en: 'Pidgeotto',
    name_kana: 'ピジョン',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 63, attack: 60, defense: 55, special_attack: 50, special_defense: 50, speed: 71 },
      abilities: ['するどいめ', 'ちどりあし'],
      height: 11, weight: 300,
      generation: 1, category: 'とりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.18 ピジョット ===
  {
    national_id: 18,
    name_ja: 'ピジョット',
    name_en: 'Pidgeot',
    name_kana: 'ピジョット',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 83, attack: 80, defense: 75, special_attack: 70, special_defense: 70, speed: 101 },
      abilities: ['するどいめ', 'ちどりあし'],
      height: 15, weight: 395,
      generation: 1, category: 'とりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.19 コラッタ ===
  {
    national_id: 19,
    name_ja: 'コラッタ',
    name_en: 'Rattata',
    name_kana: 'コラッタ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 30, attack: 56, defense: 35, special_attack: 25, special_defense: 35, speed: 72 },
      abilities: ['にげあし', 'こんじょう'],
      height: 3, weight: 35,
      generation: 1, category: 'ねずみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.20 ラッタ ===
  {
    national_id: 20,
    name_ja: 'ラッタ',
    name_en: 'Raticate',
    name_kana: 'ラッタ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 55, attack: 81, defense: 60, special_attack: 50, special_defense: 70, speed: 97 },
      abilities: ['にげあし', 'こんじょう'],
      height: 7, weight: 185,
      generation: 1, category: 'ねずみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.21 オニスズメ ===
  {
    national_id: 21,
    name_ja: 'オニスズメ',
    name_en: 'Spearow',
    name_kana: 'オニスズメ',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 40, attack: 60, defense: 30, special_attack: 31, special_defense: 31, speed: 70 },
      abilities: ['するどいめ'],
      height: 3, weight: 20,
      generation: 1, category: 'ことりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.22 オニドリル ===
  {
    national_id: 22,
    name_ja: 'オニドリル',
    name_en: 'Fearow',
    name_kana: 'オニドリル',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 65, attack: 90, defense: 65, special_attack: 61, special_defense: 61, speed: 100 },
      abilities: ['するどいめ'],
      height: 12, weight: 380,
      generation: 1, category: 'くちばしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.23 アーボ ===
  {
    national_id: 23,
    name_ja: 'アーボ',
    name_en: 'Ekans',
    name_kana: 'アーボ',
    data: {
      types: ['どく'],
      stats: { hp: 35, attack: 60, defense: 44, special_attack: 40, special_defense: 54, speed: 55 },
      abilities: ['いかく', 'だっぴ'],
      height: 20, weight: 69,
      generation: 1, category: 'へびポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.24 アーボック ===
  {
    national_id: 24,
    name_ja: 'アーボック',
    name_en: 'Arbok',
    name_kana: 'アーボック',
    data: {
      types: ['どく'],
      stats: { hp: 60, attack: 95, defense: 69, special_attack: 65, special_defense: 79, speed: 80 },
      abilities: ['いかく', 'だっぴ'],
      height: 35, weight: 650,
      generation: 1, category: 'コブラポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.25 ピカチュウ ===
  {
    national_id: 25,
    name_ja: 'ピカチュウ',
    name_en: 'Pikachu',
    name_kana: 'ピカチュウ',
    data: {
      types: ['でんき'],
      stats: { hp: 35, attack: 55, defense: 40, special_attack: 50, special_defense: 50, speed: 90 },
      abilities: ['せいでんき'],
      height: 4, weight: 60,
      generation: 1, category: 'ねずみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.26 ライチュウ ===
  {
    national_id: 26,
    name_ja: 'ライチュウ',
    name_en: 'Raichu',
    name_kana: 'ライチュウ',
    data: {
      types: ['でんき'],
      stats: { hp: 60, attack: 90, defense: 55, special_attack: 90, special_defense: 80, speed: 110 },
      abilities: ['せいでんき'],
      height: 8, weight: 300,
      generation: 1, category: 'ねずみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.27 サンド ===
  {
    national_id: 27,
    name_ja: 'サンド',
    name_en: 'Sandshrew',
    name_kana: 'サンド',
    data: {
      types: ['じめん'],
      stats: { hp: 50, attack: 75, defense: 85, special_attack: 20, special_defense: 30, speed: 40 },
      abilities: ['すながくれ'],
      height: 6, weight: 120,
      generation: 1, category: 'ねずみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.28 サンドパン ===
  {
    national_id: 28,
    name_ja: 'サンドパン',
    name_en: 'Sandslash',
    name_kana: 'サンドパン',
    data: {
      types: ['じめん'],
      stats: { hp: 75, attack: 100, defense: 110, special_attack: 45, special_defense: 55, speed: 65 },
      abilities: ['すながくれ'],
      height: 10, weight: 295,
      generation: 1, category: 'ねずみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.29 ニドラン♀ ===
  {
    national_id: 29,
    name_ja: 'ニドラン♀',
    name_en: 'Nidoran♀',
    name_kana: 'ニドラン♀',
    data: {
      types: ['どく'],
      stats: { hp: 55, attack: 47, defense: 52, special_attack: 40, special_defense: 40, speed: 41 },
      abilities: ['どくのトゲ', 'とうそうしん'],
      height: 4, weight: 70,
      generation: 1, category: 'どくばりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.30 ニドリーナ ===
  {
    national_id: 30,
    name_ja: 'ニドリーナ',
    name_en: 'Nidorina',
    name_kana: 'ニドリーナ',
    data: {
      types: ['どく'],
      stats: { hp: 70, attack: 62, defense: 67, special_attack: 55, special_defense: 55, speed: 56 },
      abilities: ['どくのトゲ', 'とうそうしん'],
      height: 8, weight: 200,
      generation: 1, category: 'どくばりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.31 ニドクイン ===
  {
    national_id: 31,
    name_ja: 'ニドクイン',
    name_en: 'Nidoqueen',
    name_kana: 'ニドクイン',
    data: {
      types: ['どく', 'じめん'],
      stats: { hp: 90, attack: 92, defense: 87, special_attack: 75, special_defense: 85, speed: 76 },
      abilities: ['どくのトゲ', 'とうそうしん'],
      height: 13, weight: 600,
      generation: 1, category: 'ドリルポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.32 ニドラン♂ ===
  {
    national_id: 32,
    name_ja: 'ニドラン♂',
    name_en: 'Nidoran♂',
    name_kana: 'ニドラン♂',
    data: {
      types: ['どく'],
      stats: { hp: 46, attack: 57, defense: 40, special_attack: 40, special_defense: 40, speed: 50 },
      abilities: ['どくのトゲ', 'とうそうしん'],
      height: 5, weight: 90,
      generation: 1, category: 'どくばりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.33 ニドリーノ ===
  {
    national_id: 33,
    name_ja: 'ニドリーノ',
    name_en: 'Nidorino',
    name_kana: 'ニドリーノ',
    data: {
      types: ['どく'],
      stats: { hp: 61, attack: 72, defense: 57, special_attack: 55, special_defense: 55, speed: 65 },
      abilities: ['どくのトゲ', 'とうそうしん'],
      height: 9, weight: 195,
      generation: 1, category: 'どくばりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.34 ニドキング ===
  {
    national_id: 34,
    name_ja: 'ニドキング',
    name_en: 'Nidoking',
    name_kana: 'ニドキング',
    data: {
      types: ['どく', 'じめん'],
      stats: { hp: 81, attack: 102, defense: 77, special_attack: 85, special_defense: 75, speed: 85 },
      abilities: ['どくのトゲ', 'とうそうしん'],
      height: 14, weight: 620,
      generation: 1, category: 'ドリルポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.35 ピッピ ===
  {
    national_id: 35,
    name_ja: 'ピッピ',
    name_en: 'Clefairy',
    name_kana: 'ピッピ',
    data: {
      types: ['フェアリー'],
      stats: { hp: 70, attack: 45, defense: 48, special_attack: 60, special_defense: 65, speed: 35 },
      abilities: ['メロメロボディ', 'マジックガード'],
      height: 6, weight: 75,
      generation: 1, category: 'ようせいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.36 ピクシー ===
  {
    national_id: 36,
    name_ja: 'ピクシー',
    name_en: 'Clefable',
    name_kana: 'ピクシー',
    data: {
      types: ['フェアリー'],
      stats: { hp: 95, attack: 70, defense: 73, special_attack: 95, special_defense: 90, speed: 60 },
      abilities: ['メロメロボディ', 'マジックガード'],
      height: 13, weight: 400,
      generation: 1, category: 'ようせいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.37 ロコン ===
  {
    national_id: 37,
    name_ja: 'ロコン',
    name_en: 'Vulpix',
    name_kana: 'ロコン',
    data: {
      types: ['ほのお'],
      stats: { hp: 38, attack: 41, defense: 40, special_attack: 50, special_defense: 65, speed: 65 },
      abilities: ['もらいび'],
      height: 6, weight: 99,
      generation: 1, category: 'きつねポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.38 キュウコン ===
  {
    national_id: 38,
    name_ja: 'キュウコン',
    name_en: 'Ninetales',
    name_kana: 'キュウコン',
    data: {
      types: ['ほのお'],
      stats: { hp: 73, attack: 76, defense: 75, special_attack: 81, special_defense: 100, speed: 100 },
      abilities: ['もらいび'],
      height: 11, weight: 199,
      generation: 1, category: 'きつねポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.39 プリン ===
  {
    national_id: 39,
    name_ja: 'プリン',
    name_en: 'Jigglypuff',
    name_kana: 'プリン',
    data: {
      types: ['ノーマル', 'フェアリー'],
      stats: { hp: 115, attack: 45, defense: 20, special_attack: 45, special_defense: 25, speed: 20 },
      abilities: ['メロメロボディ', 'かちき'],
      height: 5, weight: 55,
      generation: 1, category: 'ふうせんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.40 プクリン ===
  {
    national_id: 40,
    name_ja: 'プクリン',
    name_en: 'Wigglytuff',
    name_kana: 'プクリン',
    data: {
      types: ['ノーマル', 'フェアリー'],
      stats: { hp: 140, attack: 70, defense: 45, special_attack: 85, special_defense: 50, speed: 45 },
      abilities: ['メロメロボディ', 'かちき'],
      height: 10, weight: 120,
      generation: 1, category: 'ふうせんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.41 ズバット ===
  {
    national_id: 41,
    name_ja: 'ズバット',
    name_en: 'Zubat',
    name_kana: 'ズバット',
    data: {
      types: ['どく', 'ひこう'],
      stats: { hp: 40, attack: 45, defense: 35, special_attack: 30, special_defense: 40, speed: 55 },
      abilities: ['せいしんりょく'],
      height: 8, weight: 75,
      generation: 1, category: 'こうもりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.42 ゴルバット ===
  {
    national_id: 42,
    name_ja: 'ゴルバット',
    name_en: 'Golbat',
    name_kana: 'ゴルバット',
    data: {
      types: ['どく', 'ひこう'],
      stats: { hp: 75, attack: 80, defense: 70, special_attack: 65, special_defense: 75, speed: 90 },
      abilities: ['せいしんりょく'],
      height: 16, weight: 550,
      generation: 1, category: 'こうもりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.43 ナゾノクサ ===
  {
    national_id: 43,
    name_ja: 'ナゾノクサ',
    name_en: 'Oddish',
    name_kana: 'ナゾノクサ',
    data: {
      types: ['くさ', 'どく'],
      stats: { hp: 45, attack: 50, defense: 55, special_attack: 75, special_defense: 65, speed: 30 },
      abilities: ['ようりょくそ'],
      height: 5, weight: 54,
      generation: 1, category: 'ざっそうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.44 クサイハナ ===
  {
    national_id: 44,
    name_ja: 'クサイハナ',
    name_en: 'Gloom',
    name_kana: 'クサイハナ',
    data: {
      types: ['くさ', 'どく'],
      stats: { hp: 60, attack: 65, defense: 70, special_attack: 85, special_defense: 75, speed: 40 },
      abilities: ['ようりょくそ'],
      height: 8, weight: 86,
      generation: 1, category: 'ざっそうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.45 ラフレシア ===
  {
    national_id: 45,
    name_ja: 'ラフレシア',
    name_en: 'Vileplume',
    name_kana: 'ラフレシア',
    data: {
      types: ['くさ', 'どく'],
      stats: { hp: 75, attack: 80, defense: 85, special_attack: 110, special_defense: 90, speed: 50 },
      abilities: ['ようりょくそ'],
      height: 12, weight: 186,
      generation: 1, category: 'フラワーポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.46 パラス ===
  {
    national_id: 46,
    name_ja: 'パラス',
    name_en: 'Paras',
    name_kana: 'パラス',
    data: {
      types: ['むし', 'くさ'],
      stats: { hp: 35, attack: 70, defense: 55, special_attack: 45, special_defense: 55, speed: 25 },
      abilities: ['ほうし', 'かんそうはだ'],
      height: 3, weight: 54,
      generation: 1, category: 'きのこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.47 パラセクト ===
  {
    national_id: 47,
    name_ja: 'パラセクト',
    name_en: 'Parasect',
    name_kana: 'パラセクト',
    data: {
      types: ['むし', 'くさ'],
      stats: { hp: 60, attack: 95, defense: 80, special_attack: 60, special_defense: 80, speed: 30 },
      abilities: ['ほうし', 'かんそうはだ'],
      height: 10, weight: 295,
      generation: 1, category: 'きのこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.48 コンパン ===
  {
    national_id: 48,
    name_ja: 'コンパン',
    name_en: 'Venonat',
    name_kana: 'コンパン',
    data: {
      types: ['むし', 'どく'],
      stats: { hp: 60, attack: 55, defense: 50, special_attack: 40, special_defense: 55, speed: 45 },
      abilities: ['ふくがん', 'いろめがね'],
      height: 10, weight: 300,
      generation: 1, category: 'こんちゅうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.49 モルフォン ===
  {
    national_id: 49,
    name_ja: 'モルフォン',
    name_en: 'Venomoth',
    name_kana: 'モルフォン',
    data: {
      types: ['むし', 'どく'],
      stats: { hp: 70, attack: 65, defense: 60, special_attack: 90, special_defense: 75, speed: 90 },
      abilities: ['りんぷん', 'いろめがね'],
      height: 15, weight: 125,
      generation: 1, category: 'どくがポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.50 ディグダ ===
  {
    national_id: 50,
    name_ja: 'ディグダ',
    name_en: 'Diglett',
    name_kana: 'ディグダ',
    data: {
      types: ['じめん'],
      stats: { hp: 10, attack: 55, defense: 25, special_attack: 35, special_defense: 45, speed: 95 },
      abilities: ['すながくれ', 'ありじごく'],
      height: 2, weight: 8,
      generation: 1, category: 'もぐらポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.51 ダグトリオ ===
  {
    national_id: 51,
    name_ja: 'ダグトリオ',
    name_en: 'Dugtrio',
    name_kana: 'ダグトリオ',
    data: {
      types: ['じめん'],
      stats: { hp: 35, attack: 100, defense: 50, special_attack: 50, special_defense: 70, speed: 120 },
      abilities: ['すながくれ', 'ありじごく'],
      height: 7, weight: 333,
      generation: 1, category: 'もぐらポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.52 ニャース ===
  {
    national_id: 52,
    name_ja: 'ニャース',
    name_en: 'Meowth',
    name_kana: 'ニャース',
    data: {
      types: ['ノーマル'],
      stats: { hp: 40, attack: 45, defense: 35, special_attack: 40, special_defense: 40, speed: 90 },
      abilities: ['ものひろい', 'テクニシャン'],
      height: 4, weight: 42,
      generation: 1, category: 'ばけねこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.53 ペルシアン ===
  {
    national_id: 53,
    name_ja: 'ペルシアン',
    name_en: 'Persian',
    name_kana: 'ペルシアン',
    data: {
      types: ['ノーマル'],
      stats: { hp: 65, attack: 70, defense: 60, special_attack: 65, special_defense: 65, speed: 115 },
      abilities: ['じゅうなん', 'テクニシャン'],
      height: 10, weight: 320,
      generation: 1, category: 'シャムネコポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.54 コダック ===
  {
    national_id: 54,
    name_ja: 'コダック',
    name_en: 'Psyduck',
    name_kana: 'コダック',
    data: {
      types: ['みず'],
      stats: { hp: 50, attack: 52, defense: 48, special_attack: 65, special_defense: 50, speed: 55 },
      abilities: ['しめりけ', 'ノーてんき'],
      height: 8, weight: 196,
      generation: 1, category: 'あひるポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.55 ゴルダック ===
  {
    national_id: 55,
    name_ja: 'ゴルダック',
    name_en: 'Golduck',
    name_kana: 'ゴルダック',
    data: {
      types: ['みず'],
      stats: { hp: 80, attack: 82, defense: 78, special_attack: 95, special_defense: 80, speed: 85 },
      abilities: ['しめりけ', 'ノーてんき'],
      height: 17, weight: 766,
      generation: 1, category: 'あひるポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.56 マンキー ===
  {
    national_id: 56,
    name_ja: 'マンキー',
    name_en: 'Mankey',
    name_kana: 'マンキー',
    data: {
      types: ['かくとう'],
      stats: { hp: 40, attack: 80, defense: 35, special_attack: 35, special_defense: 45, speed: 70 },
      abilities: ['やるき', 'いかりのつぼ'],
      height: 5, weight: 280,
      generation: 1, category: 'ぶたざるポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.57 オコリザル ===
  {
    national_id: 57,
    name_ja: 'オコリザル',
    name_en: 'Primeape',
    name_kana: 'オコリザル',
    data: {
      types: ['かくとう'],
      stats: { hp: 65, attack: 105, defense: 60, special_attack: 60, special_defense: 70, speed: 95 },
      abilities: ['やるき', 'いかりのつぼ'],
      height: 10, weight: 320,
      generation: 1, category: 'ぶたざるポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.58 ガーディ ===
  {
    national_id: 58,
    name_ja: 'ガーディ',
    name_en: 'Growlithe',
    name_kana: 'ガーディ',
    data: {
      types: ['ほのお'],
      stats: { hp: 55, attack: 70, defense: 45, special_attack: 70, special_defense: 50, speed: 60 },
      abilities: ['いかく', 'もらいび'],
      height: 7, weight: 190,
      generation: 1, category: 'こいぬポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.59 ウインディ ===
  {
    national_id: 59,
    name_ja: 'ウインディ',
    name_en: 'Arcanine',
    name_kana: 'ウインディ',
    data: {
      types: ['ほのお'],
      stats: { hp: 90, attack: 110, defense: 80, special_attack: 100, special_defense: 80, speed: 95 },
      abilities: ['いかく', 'もらいび'],
      height: 19, weight: 1550,
      generation: 1, category: 'でんせつポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.60 ニョロモ ===
  {
    national_id: 60,
    name_ja: 'ニョロモ',
    name_en: 'Poliwag',
    name_kana: 'ニョロモ',
    data: {
      types: ['みず'],
      stats: { hp: 40, attack: 50, defense: 40, special_attack: 40, special_defense: 40, speed: 90 },
      abilities: ['ちょすい', 'しめりけ'],
      height: 6, weight: 124,
      generation: 1, category: 'おたまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.61 ニョロゾ ===
  {
    national_id: 61,
    name_ja: 'ニョロゾ',
    name_en: 'Poliwhirl',
    name_kana: 'ニョロゾ',
    data: {
      types: ['みず'],
      stats: { hp: 65, attack: 65, defense: 65, special_attack: 50, special_defense: 50, speed: 90 },
      abilities: ['ちょすい', 'しめりけ'],
      height: 10, weight: 200,
      generation: 1, category: 'おたまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.62 ニョロボン ===
  {
    national_id: 62,
    name_ja: 'ニョロボン',
    name_en: 'Poliwrath',
    name_kana: 'ニョロボン',
    data: {
      types: ['みず', 'かくとう'],
      stats: { hp: 90, attack: 95, defense: 95, special_attack: 70, special_defense: 90, speed: 70 },
      abilities: ['ちょすい', 'しめりけ'],
      height: 13, weight: 540,
      generation: 1, category: 'おたまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.63 ケーシィ ===
  {
    national_id: 63,
    name_ja: 'ケーシィ',
    name_en: 'Abra',
    name_kana: 'ケーシィ',
    data: {
      types: ['エスパー'],
      stats: { hp: 25, attack: 20, defense: 15, special_attack: 105, special_defense: 55, speed: 90 },
      abilities: ['シンクロ', 'せいしんりょく'],
      height: 9, weight: 195,
      generation: 1, category: 'ねんりきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.64 ユンゲラー ===
  {
    national_id: 64,
    name_ja: 'ユンゲラー',
    name_en: 'Kadabra',
    name_kana: 'ユンゲラー',
    data: {
      types: ['エスパー'],
      stats: { hp: 40, attack: 35, defense: 30, special_attack: 120, special_defense: 70, speed: 105 },
      abilities: ['シンクロ', 'せいしんりょく'],
      height: 13, weight: 565,
      generation: 1, category: 'ねんりきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.65 フーディン ===
  {
    national_id: 65,
    name_ja: 'フーディン',
    name_en: 'Alakazam',
    name_kana: 'フーディン',
    data: {
      types: ['エスパー'],
      stats: { hp: 55, attack: 50, defense: 45, special_attack: 135, special_defense: 95, speed: 120 },
      abilities: ['シンクロ', 'せいしんりょく'],
      height: 15, weight: 480,
      generation: 1, category: 'ねんりきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.66 ワンリキー ===
  {
    national_id: 66,
    name_ja: 'ワンリキー',
    name_en: 'Machop',
    name_kana: 'ワンリキー',
    data: {
      types: ['かくとう'],
      stats: { hp: 70, attack: 80, defense: 50, special_attack: 35, special_defense: 35, speed: 35 },
      abilities: ['こんじょう', 'ノーガード'],
      height: 8, weight: 195,
      generation: 1, category: 'かいりきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.67 ゴーリキー ===
  {
    national_id: 67,
    name_ja: 'ゴーリキー',
    name_en: 'Machoke',
    name_kana: 'ゴーリキー',
    data: {
      types: ['かくとう'],
      stats: { hp: 80, attack: 100, defense: 70, special_attack: 50, special_defense: 60, speed: 45 },
      abilities: ['こんじょう', 'ノーガード'],
      height: 15, weight: 705,
      generation: 1, category: 'かいりきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.68 カイリキー ===
  {
    national_id: 68,
    name_ja: 'カイリキー',
    name_en: 'Machamp',
    name_kana: 'カイリキー',
    data: {
      types: ['かくとう'],
      stats: { hp: 90, attack: 130, defense: 80, special_attack: 65, special_defense: 85, speed: 55 },
      abilities: ['こんじょう', 'ノーガード'],
      height: 16, weight: 1300,
      generation: 1, category: 'かいりきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.69 マダツボミ ===
  {
    national_id: 69,
    name_ja: 'マダツボミ',
    name_en: 'Bellsprout',
    name_kana: 'マダツボミ',
    data: {
      types: ['くさ', 'どく'],
      stats: { hp: 50, attack: 75, defense: 35, special_attack: 70, special_defense: 30, speed: 40 },
      abilities: ['ようりょくそ'],
      height: 7, weight: 40,
      generation: 1, category: 'フラワーポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.70 ウツドン ===
  {
    national_id: 70,
    name_ja: 'ウツドン',
    name_en: 'Weepinbell',
    name_kana: 'ウツドン',
    data: {
      types: ['くさ', 'どく'],
      stats: { hp: 65, attack: 90, defense: 50, special_attack: 85, special_defense: 45, speed: 55 },
      abilities: ['ようりょくそ'],
      height: 10, weight: 64,
      generation: 1, category: 'ハエとりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.71 ウツボット ===
  {
    national_id: 71,
    name_ja: 'ウツボット',
    name_en: 'Victreebel',
    name_kana: 'ウツボット',
    data: {
      types: ['くさ', 'どく'],
      stats: { hp: 80, attack: 105, defense: 65, special_attack: 100, special_defense: 70, speed: 70 },
      abilities: ['ようりょくそ'],
      height: 17, weight: 155,
      generation: 1, category: 'ハエとりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.72 メノクラゲ ===
  {
    national_id: 72,
    name_ja: 'メノクラゲ',
    name_en: 'Tentacool',
    name_kana: 'メノクラゲ',
    data: {
      types: ['みず', 'どく'],
      stats: { hp: 40, attack: 40, defense: 35, special_attack: 50, special_defense: 100, speed: 70 },
      abilities: ['クリアボディ', 'ヘドロえき'],
      height: 9, weight: 455,
      generation: 1, category: 'くらげポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.73 ドククラゲ ===
  {
    national_id: 73,
    name_ja: 'ドククラゲ',
    name_en: 'Tentacruel',
    name_kana: 'ドククラゲ',
    data: {
      types: ['みず', 'どく'],
      stats: { hp: 80, attack: 70, defense: 65, special_attack: 80, special_defense: 120, speed: 100 },
      abilities: ['クリアボディ', 'ヘドロえき'],
      height: 16, weight: 550,
      generation: 1, category: 'くらげポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.74 イシツブテ ===
  {
    national_id: 74,
    name_ja: 'イシツブテ',
    name_en: 'Geodude',
    name_kana: 'イシツブテ',
    data: {
      types: ['いわ', 'じめん'],
      stats: { hp: 40, attack: 80, defense: 100, special_attack: 30, special_defense: 30, speed: 20 },
      abilities: ['いしあたま', 'がんじょう'],
      height: 4, weight: 200,
      generation: 1, category: 'がんせきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.75 ゴローン ===
  {
    national_id: 75,
    name_ja: 'ゴローン',
    name_en: 'Graveler',
    name_kana: 'ゴローン',
    data: {
      types: ['いわ', 'じめん'],
      stats: { hp: 55, attack: 95, defense: 115, special_attack: 45, special_defense: 45, speed: 35 },
      abilities: ['いしあたま', 'がんじょう'],
      height: 10, weight: 1050,
      generation: 1, category: 'がんせきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.76 ゴローニャ ===
  {
    national_id: 76,
    name_ja: 'ゴローニャ',
    name_en: 'Golem',
    name_kana: 'ゴローニャ',
    data: {
      types: ['いわ', 'じめん'],
      stats: { hp: 80, attack: 120, defense: 130, special_attack: 55, special_defense: 65, speed: 45 },
      abilities: ['いしあたま', 'がんじょう'],
      height: 14, weight: 3000,
      generation: 1, category: 'メガトンポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.77 ポニータ ===
  {
    national_id: 77,
    name_ja: 'ポニータ',
    name_en: 'Ponyta',
    name_kana: 'ポニータ',
    data: {
      types: ['ほのお'],
      stats: { hp: 50, attack: 85, defense: 55, special_attack: 65, special_defense: 65, speed: 90 },
      abilities: ['にげあし', 'もらいび'],
      height: 10, weight: 300,
      generation: 1, category: 'ひのうまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.78 ギャロップ ===
  {
    national_id: 78,
    name_ja: 'ギャロップ',
    name_en: 'Rapidash',
    name_kana: 'ギャロップ',
    data: {
      types: ['ほのお'],
      stats: { hp: 65, attack: 100, defense: 70, special_attack: 80, special_defense: 80, speed: 105 },
      abilities: ['にげあし', 'もらいび'],
      height: 17, weight: 950,
      generation: 1, category: 'ひのうまポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.79 ヤドン ===
  {
    national_id: 79,
    name_ja: 'ヤドン',
    name_en: 'Slowpoke',
    name_kana: 'ヤドン',
    data: {
      types: ['みず', 'エスパー'],
      stats: { hp: 90, attack: 65, defense: 65, special_attack: 40, special_defense: 40, speed: 15 },
      abilities: ['どんかん', 'マイペース'],
      height: 12, weight: 360,
      generation: 1, category: 'まぬけポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.80 ヤドラン ===
  {
    national_id: 80,
    name_ja: 'ヤドラン',
    name_en: 'Slowbro',
    name_kana: 'ヤドラン',
    data: {
      types: ['みず', 'エスパー'],
      stats: { hp: 95, attack: 75, defense: 110, special_attack: 100, special_defense: 80, speed: 30 },
      abilities: ['どんかん', 'マイペース'],
      height: 16, weight: 785,
      generation: 1, category: 'やどかりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.81 コイル ===
  {
    national_id: 81,
    name_ja: 'コイル',
    name_en: 'Magnemite',
    name_kana: 'コイル',
    data: {
      types: ['でんき', 'はがね'],
      stats: { hp: 25, attack: 35, defense: 70, special_attack: 95, special_defense: 55, speed: 45 },
      abilities: ['じりょく', 'がんじょう'],
      height: 3, weight: 60,
      generation: 1, category: 'じしゃくポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.82 レアコイル ===
  {
    national_id: 82,
    name_ja: 'レアコイル',
    name_en: 'Magneton',
    name_kana: 'レアコイル',
    data: {
      types: ['でんき', 'はがね'],
      stats: { hp: 50, attack: 60, defense: 95, special_attack: 120, special_defense: 70, speed: 70 },
      abilities: ['じりょく', 'がんじょう'],
      height: 10, weight: 600,
      generation: 1, category: 'じしゃくポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.83 カモネギ ===
  {
    national_id: 83,
    name_ja: 'カモネギ',
    name_en: "Farfetch'd",
    name_kana: 'カモネギ',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 52, attack: 90, defense: 55, special_attack: 58, special_defense: 62, speed: 60 },
      abilities: ['するどいめ', 'せいしんりょく'],
      height: 8, weight: 150,
      generation: 1, category: 'かるがもポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.84 ドードー ===
  {
    national_id: 84,
    name_ja: 'ドードー',
    name_en: 'Doduo',
    name_kana: 'ドードー',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 35, attack: 85, defense: 45, special_attack: 35, special_defense: 35, speed: 75 },
      abilities: ['にげあし', 'はやおき'],
      height: 14, weight: 392,
      generation: 1, category: 'ふたごどりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.85 ドードリオ ===
  {
    national_id: 85,
    name_ja: 'ドードリオ',
    name_en: 'Dodrio',
    name_kana: 'ドードリオ',
    data: {
      types: ['ノーマル', 'ひこう'],
      stats: { hp: 60, attack: 110, defense: 70, special_attack: 60, special_defense: 60, speed: 110 },
      abilities: ['にげあし', 'はやおき'],
      height: 18, weight: 852,
      generation: 1, category: 'みつごどりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.86 パウワウ ===
  {
    national_id: 86,
    name_ja: 'パウワウ',
    name_en: 'Seel',
    name_kana: 'パウワウ',
    data: {
      types: ['みず'],
      stats: { hp: 65, attack: 45, defense: 55, special_attack: 45, special_defense: 70, speed: 45 },
      abilities: ['あついしぼう', 'うるおいボディ'],
      height: 11, weight: 900,
      generation: 1, category: 'あしかポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.87 ジュゴン ===
  {
    national_id: 87,
    name_ja: 'ジュゴン',
    name_en: 'Dewgong',
    name_kana: 'ジュゴン',
    data: {
      types: ['みず', 'こおり'],
      stats: { hp: 90, attack: 70, defense: 80, special_attack: 70, special_defense: 95, speed: 70 },
      abilities: ['あついしぼう', 'うるおいボディ'],
      height: 17, weight: 1200,
      generation: 1, category: 'あしかポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.88 ベトベター ===
  {
    national_id: 88,
    name_ja: 'ベトベター',
    name_en: 'Grimer',
    name_kana: 'ベトベター',
    data: {
      types: ['どく'],
      stats: { hp: 80, attack: 80, defense: 50, special_attack: 40, special_defense: 50, speed: 25 },
      abilities: ['あくしゅう', 'ねんちゃく'],
      height: 9, weight: 300,
      generation: 1, category: 'ヘドロポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.89 ベトベトン ===
  {
    national_id: 89,
    name_ja: 'ベトベトン',
    name_en: 'Muk',
    name_kana: 'ベトベトン',
    data: {
      types: ['どく'],
      stats: { hp: 105, attack: 105, defense: 75, special_attack: 65, special_defense: 100, speed: 50 },
      abilities: ['あくしゅう', 'ねんちゃく'],
      height: 12, weight: 300,
      generation: 1, category: 'ヘドロポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.90 シェルダー ===
  {
    national_id: 90,
    name_ja: 'シェルダー',
    name_en: 'Shellder',
    name_kana: 'シェルダー',
    data: {
      types: ['みず'],
      stats: { hp: 30, attack: 65, defense: 100, special_attack: 45, special_defense: 25, speed: 40 },
      abilities: ['シェルアーマー', 'スキルリンク'],
      height: 3, weight: 40,
      generation: 1, category: '2まいがいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.91 パルシェン ===
  {
    national_id: 91,
    name_ja: 'パルシェン',
    name_en: 'Cloyster',
    name_kana: 'パルシェン',
    data: {
      types: ['みず', 'こおり'],
      stats: { hp: 50, attack: 95, defense: 180, special_attack: 85, special_defense: 45, speed: 70 },
      abilities: ['シェルアーマー', 'スキルリンク'],
      height: 15, weight: 1325,
      generation: 1, category: '2まいがいポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.92 ゴース ===
  {
    national_id: 92,
    name_ja: 'ゴース',
    name_en: 'Gastly',
    name_kana: 'ゴース',
    data: {
      types: ['ゴースト', 'どく'],
      stats: { hp: 30, attack: 35, defense: 30, special_attack: 100, special_defense: 35, speed: 80 },
      abilities: ['ふゆう'],
      height: 13, weight: 1,
      generation: 1, category: 'ガスじょうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.93 ゴースト ===
  {
    national_id: 93,
    name_ja: 'ゴースト',
    name_en: 'Haunter',
    name_kana: 'ゴースト',
    data: {
      types: ['ゴースト', 'どく'],
      stats: { hp: 45, attack: 50, defense: 45, special_attack: 115, special_defense: 55, speed: 95 },
      abilities: ['ふゆう'],
      height: 16, weight: 1,
      generation: 1, category: 'ガスじょうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.94 ゲンガー ===
  {
    national_id: 94,
    name_ja: 'ゲンガー',
    name_en: 'Gengar',
    name_kana: 'ゲンガー',
    data: {
      types: ['ゴースト', 'どく'],
      stats: { hp: 60, attack: 65, defense: 60, special_attack: 130, special_defense: 75, speed: 110 },
      abilities: ['のろわれボディ'],
      height: 15, weight: 405,
      generation: 1, category: 'シャドーポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.95 イワーク ===
  {
    national_id: 95,
    name_ja: 'イワーク',
    name_en: 'Onix',
    name_kana: 'イワーク',
    data: {
      types: ['いわ', 'じめん'],
      stats: { hp: 35, attack: 45, defense: 160, special_attack: 30, special_defense: 45, speed: 70 },
      abilities: ['いしあたま', 'がんじょう'],
      height: 88, weight: 2100,
      generation: 1, category: 'いわへびポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.96 スリープ ===
  {
    national_id: 96,
    name_ja: 'スリープ',
    name_en: 'Drowzee',
    name_kana: 'スリープ',
    data: {
      types: ['エスパー'],
      stats: { hp: 60, attack: 48, defense: 45, special_attack: 43, special_defense: 90, speed: 42 },
      abilities: ['ふみん', 'よちむ'],
      height: 10, weight: 324,
      generation: 1, category: 'さいみんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.97 スリーパー ===
  {
    national_id: 97,
    name_ja: 'スリーパー',
    name_en: 'Hypno',
    name_kana: 'スリーパー',
    data: {
      types: ['エスパー'],
      stats: { hp: 85, attack: 73, defense: 70, special_attack: 73, special_defense: 115, speed: 67 },
      abilities: ['ふみん', 'よちむ'],
      height: 16, weight: 756,
      generation: 1, category: 'さいみんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.98 クラブ ===
  {
    national_id: 98,
    name_ja: 'クラブ',
    name_en: 'Krabby',
    name_kana: 'クラブ',
    data: {
      types: ['みず'],
      stats: { hp: 30, attack: 105, defense: 90, special_attack: 25, special_defense: 25, speed: 50 },
      abilities: ['かいりきバサミ', 'シェルアーマー'],
      height: 4, weight: 65,
      generation: 1, category: 'さわがにポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.99 キングラー ===
  {
    national_id: 99,
    name_ja: 'キングラー',
    name_en: 'Kingler',
    name_kana: 'キングラー',
    data: {
      types: ['みず'],
      stats: { hp: 55, attack: 130, defense: 115, special_attack: 50, special_defense: 50, speed: 75 },
      abilities: ['かいりきバサミ', 'シェルアーマー'],
      height: 13, weight: 600,
      generation: 1, category: 'はさみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.100 ビリリダマ ===
  {
    national_id: 100,
    name_ja: 'ビリリダマ',
    name_en: 'Voltorb',
    name_kana: 'ビリリダマ',
    data: {
      types: ['でんき'],
      stats: { hp: 40, attack: 30, defense: 50, special_attack: 55, special_defense: 55, speed: 100 },
      abilities: ['ぼうおん', 'せいでんき'],
      height: 5, weight: 104,
      generation: 1, category: 'ボールポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.101 マルマイン ===
  {
    national_id: 101,
    name_ja: 'マルマイン',
    name_en: 'Electrode',
    name_kana: 'マルマイン',
    data: {
      types: ['でんき'],
      stats: { hp: 60, attack: 50, defense: 70, special_attack: 80, special_defense: 80, speed: 150 },
      abilities: ['ぼうおん', 'せいでんき'],
      height: 12, weight: 666,
      generation: 1, category: 'ボールポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.102 タマタマ ===
  {
    national_id: 102,
    name_ja: 'タマタマ',
    name_en: 'Exeggcute',
    name_kana: 'タマタマ',
    data: {
      types: ['くさ', 'エスパー'],
      stats: { hp: 60, attack: 40, defense: 80, special_attack: 60, special_defense: 45, speed: 40 },
      abilities: ['ようりょくそ'],
      height: 4, weight: 25,
      generation: 1, category: 'たまごポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.103 ナッシー ===
  {
    national_id: 103,
    name_ja: 'ナッシー',
    name_en: 'Exeggutor',
    name_kana: 'ナッシー',
    data: {
      types: ['くさ', 'エスパー'],
      stats: { hp: 95, attack: 95, defense: 85, special_attack: 125, special_defense: 75, speed: 55 },
      abilities: ['ようりょくそ'],
      height: 20, weight: 1200,
      generation: 1, category: 'やしのみポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.104 カラカラ ===
  {
    national_id: 104,
    name_ja: 'カラカラ',
    name_en: 'Cubone',
    name_kana: 'カラカラ',
    data: {
      types: ['じめん'],
      stats: { hp: 50, attack: 50, defense: 95, special_attack: 40, special_defense: 50, speed: 35 },
      abilities: ['いしあたま', 'ひらいしん'],
      height: 4, weight: 65,
      generation: 1, category: 'こどくポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.105 ガラガラ ===
  {
    national_id: 105,
    name_ja: 'ガラガラ',
    name_en: 'Marowak',
    name_kana: 'ガラガラ',
    data: {
      types: ['じめん'],
      stats: { hp: 60, attack: 80, defense: 110, special_attack: 50, special_defense: 80, speed: 45 },
      abilities: ['いしあたま', 'ひらいしん'],
      height: 10, weight: 450,
      generation: 1, category: 'ほねずきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.106 サワムラー ===
  {
    national_id: 106,
    name_ja: 'サワムラー',
    name_en: 'Hitmonlee',
    name_kana: 'サワムラー',
    data: {
      types: ['かくとう'],
      stats: { hp: 50, attack: 120, defense: 53, special_attack: 35, special_defense: 110, speed: 87 },
      abilities: ['じゅうなん', 'すてみ'],
      height: 15, weight: 498,
      generation: 1, category: 'キックポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.107 エビワラー ===
  {
    national_id: 107,
    name_ja: 'エビワラー',
    name_en: 'Hitmonchan',
    name_kana: 'エビワラー',
    data: {
      types: ['かくとう'],
      stats: { hp: 50, attack: 105, defense: 79, special_attack: 35, special_defense: 110, speed: 76 },
      abilities: ['するどいめ', 'てつのこぶし'],
      height: 14, weight: 502,
      generation: 1, category: 'パンチポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.108 ベロリンガ ===
  {
    national_id: 108,
    name_ja: 'ベロリンガ',
    name_en: 'Lickitung',
    name_kana: 'ベロリンガ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 90, attack: 55, defense: 75, special_attack: 60, special_defense: 75, speed: 30 },
      abilities: ['マイペース', 'どんかん'],
      height: 12, weight: 655,
      generation: 1, category: 'なめまわしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.109 ドガース ===
  {
    national_id: 109,
    name_ja: 'ドガース',
    name_en: 'Koffing',
    name_kana: 'ドガース',
    data: {
      types: ['どく'],
      stats: { hp: 40, attack: 65, defense: 95, special_attack: 60, special_defense: 45, speed: 35 },
      abilities: ['ふゆう'],
      height: 6, weight: 10,
      generation: 1, category: 'どくガスポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.110 マタドガス ===
  {
    national_id: 110,
    name_ja: 'マタドガス',
    name_en: 'Weezing',
    name_kana: 'マタドガス',
    data: {
      types: ['どく'],
      stats: { hp: 65, attack: 90, defense: 120, special_attack: 85, special_defense: 70, speed: 60 },
      abilities: ['ふゆう'],
      height: 12, weight: 95,
      generation: 1, category: 'どくガスポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.111 サイホーン ===
  {
    national_id: 111,
    name_ja: 'サイホーン',
    name_en: 'Rhyhorn',
    name_kana: 'サイホーン',
    data: {
      types: ['じめん', 'いわ'],
      stats: { hp: 80, attack: 85, defense: 95, special_attack: 30, special_defense: 30, speed: 25 },
      abilities: ['ひらいしん', 'いしあたま'],
      height: 10, weight: 1150,
      generation: 1, category: 'とげとげポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.112 サイドン ===
  {
    national_id: 112,
    name_ja: 'サイドン',
    name_en: 'Rhydon',
    name_kana: 'サイドン',
    data: {
      types: ['じめん', 'いわ'],
      stats: { hp: 105, attack: 130, defense: 120, special_attack: 45, special_defense: 45, speed: 40 },
      abilities: ['ひらいしん', 'いしあたま'],
      height: 19, weight: 1200,
      generation: 1, category: 'ドリルポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.113 ラッキー ===
  {
    national_id: 113,
    name_ja: 'ラッキー',
    name_en: 'Chansey',
    name_kana: 'ラッキー',
    data: {
      types: ['ノーマル'],
      stats: { hp: 250, attack: 5, defense: 5, special_attack: 35, special_defense: 105, speed: 50 },
      abilities: ['しぜんかいふく', 'てんのめぐみ'],
      height: 11, weight: 346,
      generation: 1, category: 'たまごポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.114 モンジャラ ===
  {
    national_id: 114,
    name_ja: 'モンジャラ',
    name_en: 'Tangela',
    name_kana: 'モンジャラ',
    data: {
      types: ['くさ'],
      stats: { hp: 65, attack: 55, defense: 115, special_attack: 100, special_defense: 40, speed: 60 },
      abilities: ['ようりょくそ', 'リーフガード'],
      height: 10, weight: 350,
      generation: 1, category: 'つるじょうポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.115 ガルーラ ===
  {
    national_id: 115,
    name_ja: 'ガルーラ',
    name_en: 'Kangaskhan',
    name_kana: 'ガルーラ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 105, attack: 95, defense: 80, special_attack: 40, special_defense: 80, speed: 90 },
      abilities: ['はやおき', 'きもったま'],
      height: 22, weight: 800,
      generation: 1, category: 'おやこポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.116 タッツー ===
  {
    national_id: 116,
    name_ja: 'タッツー',
    name_en: 'Horsea',
    name_kana: 'タッツー',
    data: {
      types: ['みず'],
      stats: { hp: 30, attack: 40, defense: 70, special_attack: 70, special_defense: 25, speed: 60 },
      abilities: ['すいすい', 'スナイパー'],
      height: 4, weight: 80,
      generation: 1, category: 'ドラゴンポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.117 シードラ ===
  {
    national_id: 117,
    name_ja: 'シードラ',
    name_en: 'Seadra',
    name_kana: 'シードラ',
    data: {
      types: ['みず'],
      stats: { hp: 55, attack: 65, defense: 95, special_attack: 95, special_defense: 45, speed: 85 },
      abilities: ['どくのトゲ', 'スナイパー'],
      height: 12, weight: 250,
      generation: 1, category: 'ドラゴンポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.118 トサキント ===
  {
    national_id: 118,
    name_ja: 'トサキント',
    name_en: 'Goldeen',
    name_kana: 'トサキント',
    data: {
      types: ['みず'],
      stats: { hp: 45, attack: 67, defense: 60, special_attack: 35, special_defense: 50, speed: 63 },
      abilities: ['すいすい', 'みずのベール'],
      height: 6, weight: 150,
      generation: 1, category: 'きんぎょポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.119 アズマオウ ===
  {
    national_id: 119,
    name_ja: 'アズマオウ',
    name_en: 'Seaking',
    name_kana: 'アズマオウ',
    data: {
      types: ['みず'],
      stats: { hp: 80, attack: 92, defense: 65, special_attack: 65, special_defense: 80, speed: 68 },
      abilities: ['すいすい', 'みずのベール'],
      height: 13, weight: 390,
      generation: 1, category: 'きんぎょポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.120 ヒトデマン ===
  {
    national_id: 120,
    name_ja: 'ヒトデマン',
    name_en: 'Staryu',
    name_kana: 'ヒトデマン',
    data: {
      types: ['みず'],
      stats: { hp: 30, attack: 45, defense: 55, special_attack: 70, special_defense: 55, speed: 85 },
      abilities: ['はっこう', 'しぜんかいふく'],
      height: 8, weight: 345,
      generation: 1, category: 'ほしがたポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.121 スターミー ===
  {
    national_id: 121,
    name_ja: 'スターミー',
    name_en: 'Starmie',
    name_kana: 'スターミー',
    data: {
      types: ['みず', 'エスパー'],
      stats: { hp: 60, attack: 75, defense: 85, special_attack: 100, special_defense: 85, speed: 115 },
      abilities: ['はっこう', 'しぜんかいふく'],
      height: 11, weight: 800,
      generation: 1, category: 'なぞのポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.122 バリヤード ===
  {
    national_id: 122,
    name_ja: 'バリヤード',
    name_en: 'Mr. Mime',
    name_kana: 'バリヤード',
    data: {
      types: ['エスパー', 'フェアリー'],
      stats: { hp: 40, attack: 45, defense: 65, special_attack: 100, special_defense: 120, speed: 90 },
      abilities: ['ぼうおん', 'フィルター'],
      height: 13, weight: 545,
      generation: 1, category: 'バリアーポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.123 ストライク ===
  {
    national_id: 123,
    name_ja: 'ストライク',
    name_en: 'Scyther',
    name_kana: 'ストライク',
    data: {
      types: ['むし', 'ひこう'],
      stats: { hp: 70, attack: 110, defense: 80, special_attack: 55, special_defense: 80, speed: 105 },
      abilities: ['むしのしらせ', 'テクニシャン'],
      height: 15, weight: 560,
      generation: 1, category: 'かまきりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.124 ルージュラ ===
  {
    national_id: 124,
    name_ja: 'ルージュラ',
    name_en: 'Jynx',
    name_kana: 'ルージュラ',
    data: {
      types: ['こおり', 'エスパー'],
      stats: { hp: 65, attack: 50, defense: 35, special_attack: 115, special_defense: 95, speed: 95 },
      abilities: ['どんかん', 'よちむ'],
      height: 14, weight: 406,
      generation: 1, category: 'ひとがたポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.125 エレブー ===
  {
    national_id: 125,
    name_ja: 'エレブー',
    name_en: 'Electabuzz',
    name_kana: 'エレブー',
    data: {
      types: ['でんき'],
      stats: { hp: 65, attack: 83, defense: 57, special_attack: 95, special_defense: 85, speed: 105 },
      abilities: ['せいでんき'],
      height: 11, weight: 300,
      generation: 1, category: 'でんげきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.126 ブーバー ===
  {
    national_id: 126,
    name_ja: 'ブーバー',
    name_en: 'Magmar',
    name_kana: 'ブーバー',
    data: {
      types: ['ほのお'],
      stats: { hp: 65, attack: 95, defense: 57, special_attack: 100, special_defense: 85, speed: 93 },
      abilities: ['ほのおのからだ'],
      height: 13, weight: 445,
      generation: 1, category: 'ひふきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.127 カイロス ===
  {
    national_id: 127,
    name_ja: 'カイロス',
    name_en: 'Pinsir',
    name_kana: 'カイロス',
    data: {
      types: ['むし'],
      stats: { hp: 65, attack: 125, defense: 100, special_attack: 55, special_defense: 70, speed: 85 },
      abilities: ['かいりきバサミ', 'かたやぶり'],
      height: 15, weight: 550,
      generation: 1, category: 'くわがたポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.128 ケンタロス ===
  {
    national_id: 128,
    name_ja: 'ケンタロス',
    name_en: 'Tauros',
    name_kana: 'ケンタロス',
    data: {
      types: ['ノーマル'],
      stats: { hp: 75, attack: 100, defense: 95, special_attack: 40, special_defense: 70, speed: 110 },
      abilities: ['いかく', 'いかりのつぼ'],
      height: 14, weight: 884,
      generation: 1, category: 'あばれうしポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.129 コイキング ===
  {
    national_id: 129,
    name_ja: 'コイキング',
    name_en: 'Magikarp',
    name_kana: 'コイキング',
    data: {
      types: ['みず'],
      stats: { hp: 20, attack: 10, defense: 55, special_attack: 15, special_defense: 20, speed: 80 },
      abilities: ['すいすい'],
      height: 9, weight: 100,
      generation: 1, category: 'さかなポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.130 ギャラドス ===
  {
    national_id: 130,
    name_ja: 'ギャラドス',
    name_en: 'Gyarados',
    name_kana: 'ギャラドス',
    data: {
      types: ['みず', 'ひこう'],
      stats: { hp: 95, attack: 125, defense: 79, special_attack: 60, special_defense: 100, speed: 81 },
      abilities: ['いかく'],
      height: 65, weight: 2350,
      generation: 1, category: 'きょうあくポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.131 ラプラス ===
  {
    national_id: 131,
    name_ja: 'ラプラス',
    name_en: 'Lapras',
    name_kana: 'ラプラス',
    data: {
      types: ['みず', 'こおり'],
      stats: { hp: 130, attack: 85, defense: 80, special_attack: 85, special_defense: 95, speed: 60 },
      abilities: ['ちょすい', 'シェルアーマー'],
      height: 25, weight: 2200,
      generation: 1, category: 'のりものポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.132 メタモン ===
  {
    national_id: 132,
    name_ja: 'メタモン',
    name_en: 'Ditto',
    name_kana: 'メタモン',
    data: {
      types: ['ノーマル'],
      stats: { hp: 48, attack: 48, defense: 48, special_attack: 48, special_defense: 48, speed: 48 },
      abilities: ['じゅうなん'],
      height: 3, weight: 40,
      generation: 1, category: 'へんしんポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.133 イーブイ ===
  {
    national_id: 133,
    name_ja: 'イーブイ',
    name_en: 'Eevee',
    name_kana: 'イーブイ',
    data: {
      types: ['ノーマル'],
      stats: { hp: 55, attack: 55, defense: 50, special_attack: 45, special_defense: 65, speed: 55 },
      abilities: ['にげあし', 'てきおうりょく'],
      height: 3, weight: 65,
      generation: 1, category: 'しんかポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.134 シャワーズ ===
  {
    national_id: 134,
    name_ja: 'シャワーズ',
    name_en: 'Vaporeon',
    name_kana: 'シャワーズ',
    data: {
      types: ['みず'],
      stats: { hp: 130, attack: 65, defense: 60, special_attack: 110, special_defense: 95, speed: 65 },
      abilities: ['ちょすい'],
      height: 10, weight: 290,
      generation: 1, category: 'あわはきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.135 サンダース ===
  {
    national_id: 135,
    name_ja: 'サンダース',
    name_en: 'Jolteon',
    name_kana: 'サンダース',
    data: {
      types: ['でんき'],
      stats: { hp: 65, attack: 65, defense: 60, special_attack: 110, special_defense: 95, speed: 130 },
      abilities: ['ちくでん'],
      height: 8, weight: 245,
      generation: 1, category: 'かみなりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.136 ブースター ===
  {
    national_id: 136,
    name_ja: 'ブースター',
    name_en: 'Flareon',
    name_kana: 'ブースター',
    data: {
      types: ['ほのお'],
      stats: { hp: 65, attack: 130, defense: 60, special_attack: 95, special_defense: 110, speed: 65 },
      abilities: ['もらいび'],
      height: 9, weight: 250,
      generation: 1, category: 'ほのおポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.137 ポリゴン ===
  {
    national_id: 137,
    name_ja: 'ポリゴン',
    name_en: 'Porygon',
    name_kana: 'ポリゴン',
    data: {
      types: ['ノーマル'],
      stats: { hp: 65, attack: 60, defense: 70, special_attack: 85, special_defense: 75, speed: 40 },
      abilities: ['トレース', 'ダウンロード'],
      height: 8, weight: 365,
      generation: 1, category: 'バーチャルポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.138 オムナイト ===
  {
    national_id: 138,
    name_ja: 'オムナイト',
    name_en: 'Omanyte',
    name_kana: 'オムナイト',
    data: {
      types: ['いわ', 'みず'],
      stats: { hp: 35, attack: 40, defense: 100, special_attack: 90, special_defense: 55, speed: 35 },
      abilities: ['すいすい', 'シェルアーマー'],
      height: 4, weight: 75,
      generation: 1, category: 'うずまきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.139 オムスター ===
  {
    national_id: 139,
    name_ja: 'オムスター',
    name_en: 'Omastar',
    name_kana: 'オムスター',
    data: {
      types: ['いわ', 'みず'],
      stats: { hp: 70, attack: 60, defense: 125, special_attack: 115, special_defense: 70, speed: 55 },
      abilities: ['すいすい', 'シェルアーマー'],
      height: 10, weight: 350,
      generation: 1, category: 'うずまきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.140 カブト ===
  {
    national_id: 140,
    name_ja: 'カブト',
    name_en: 'Kabuto',
    name_kana: 'カブト',
    data: {
      types: ['いわ', 'みず'],
      stats: { hp: 30, attack: 80, defense: 90, special_attack: 55, special_defense: 45, speed: 55 },
      abilities: ['すいすい', 'カブトアーマー'],
      height: 5, weight: 115,
      generation: 1, category: 'こうらポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.141 カブトプス ===
  {
    national_id: 141,
    name_ja: 'カブトプス',
    name_en: 'Kabutops',
    name_kana: 'カブトプス',
    data: {
      types: ['いわ', 'みず'],
      stats: { hp: 60, attack: 115, defense: 105, special_attack: 65, special_defense: 70, speed: 80 },
      abilities: ['すいすい', 'カブトアーマー'],
      height: 13, weight: 405,
      generation: 1, category: 'こうらポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.142 プテラ ===
  {
    national_id: 142,
    name_ja: 'プテラ',
    name_en: 'Aerodactyl',
    name_kana: 'プテラ',
    data: {
      types: ['いわ', 'ひこう'],
      stats: { hp: 80, attack: 105, defense: 65, special_attack: 60, special_defense: 75, speed: 130 },
      abilities: ['いしあたま', 'プレッシャー'],
      height: 18, weight: 590,
      generation: 1, category: 'かせきポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.143 カビゴン ===
  {
    national_id: 143,
    name_ja: 'カビゴン',
    name_en: 'Snorlax',
    name_kana: 'カビゴン',
    data: {
      types: ['ノーマル'],
      stats: { hp: 160, attack: 110, defense: 65, special_attack: 65, special_defense: 110, speed: 30 },
      abilities: ['めんえき', 'あついしぼう'],
      height: 21, weight: 4600,
      generation: 1, category: 'いねむりポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.144 フリーザー ===
  {
    national_id: 144,
    name_ja: 'フリーザー',
    name_en: 'Articuno',
    name_kana: 'フリーザー',
    data: {
      types: ['こおり', 'ひこう'],
      stats: { hp: 90, attack: 85, defense: 100, special_attack: 95, special_defense: 125, speed: 85 },
      abilities: ['プレッシャー'],
      height: 17, weight: 554,
      generation: 1, category: 'れいとうポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.145 サンダー ===
  {
    national_id: 145,
    name_ja: 'サンダー',
    name_en: 'Zapdos',
    name_kana: 'サンダー',
    data: {
      types: ['でんき', 'ひこう'],
      stats: { hp: 90, attack: 90, defense: 85, special_attack: 125, special_defense: 90, speed: 100 },
      abilities: ['プレッシャー'],
      height: 16, weight: 526,
      generation: 1, category: 'でんげきポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.146 ファイヤー ===
  {
    national_id: 146,
    name_ja: 'ファイヤー',
    name_en: 'Moltres',
    name_kana: 'ファイヤー',
    data: {
      types: ['ほのお', 'ひこう'],
      stats: { hp: 90, attack: 100, defense: 90, special_attack: 125, special_defense: 85, speed: 90 },
      abilities: ['プレッシャー'],
      height: 20, weight: 600,
      generation: 1, category: 'かえんポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.147 ミニリュウ ===
  {
    national_id: 147,
    name_ja: 'ミニリュウ',
    name_en: 'Dratini',
    name_kana: 'ミニリュウ',
    data: {
      types: ['ドラゴン'],
      stats: { hp: 41, attack: 64, defense: 45, special_attack: 50, special_defense: 50, speed: 50 },
      abilities: ['だっぴ'],
      height: 18, weight: 33,
      generation: 1, category: 'ドラゴンポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.148 ハクリュー ===
  {
    national_id: 148,
    name_ja: 'ハクリュー',
    name_en: 'Dragonair',
    name_kana: 'ハクリュー',
    data: {
      types: ['ドラゴン'],
      stats: { hp: 61, attack: 84, defense: 65, special_attack: 70, special_defense: 70, speed: 70 },
      abilities: ['だっぴ'],
      height: 40, weight: 165,
      generation: 1, category: 'ドラゴンポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.149 カイリュー ===
  {
    national_id: 149,
    name_ja: 'カイリュー',
    name_en: 'Dragonite',
    name_kana: 'カイリュー',
    data: {
      types: ['ドラゴン', 'ひこう'],
      stats: { hp: 91, attack: 134, defense: 95, special_attack: 100, special_defense: 100, speed: 80 },
      abilities: ['せいしんりょく'],
      height: 22, weight: 2100,
      generation: 1, category: 'ドラゴンポケモン',
      is_legendary: false, is_mythical: false
    }
  },
  # === No.150 ミュウツー ===
  {
    national_id: 150,
    name_ja: 'ミュウツー',
    name_en: 'Mewtwo',
    name_kana: 'ミュウツー',
    data: {
      types: ['エスパー'],
      stats: { hp: 106, attack: 110, defense: 90, special_attack: 154, special_defense: 90, speed: 130 },
      abilities: ['プレッシャー'],
      height: 20, weight: 1220,
      generation: 1, category: 'いでんしポケモン',
      is_legendary: true, is_mythical: false
    }
  },
  # === No.151 ミュウ ===
  {
    national_id: 151,
    name_ja: 'ミュウ',
    name_en: 'Mew',
    name_kana: 'ミュウ',
    data: {
      types: ['エスパー'],
      stats: { hp: 100, attack: 100, defense: 100, special_attack: 100, special_defense: 100, speed: 100 },
      abilities: ['シンクロ'],
      height: 4, weight: 40,
      generation: 1, category: 'しんしゅポケモン',
      is_legendary: false, is_mythical: true
    }
  }
].freeze
