# frozen_string_literal: true

# サンプルポケモンデータの作成タスク 🐾
# 図鑑のテスト用に有名なポケモンのデータを作成

namespace :pokemon do
  desc 'サンプルポケモンデータを作成'
  task create_sample_data: :environment do
    puts '🎮 サンプルポケモンデータを作成中...'

    sample_pokemon = [
      {
        national_id: 1,
        name_ja: 'フシギダネ',
        name_en: 'Bulbasaur',
        name_kana: 'フシギダネ',
        data: {
          types: %w[grass poison],
          generation: 1,
          height: 7, # dm
          weight: 69, # hg
          stats: {
            hp: 45,
            attack: 49,
            defense: 49,
            "special-attack": 65,
            "special-defense": 65,
            speed: 45
          },
          abilities: [
            {
              name: 'しんりょく',
              description: 'HPが減ったとき、くさタイプの技の威力が上がる。',
              is_hidden: false
            },
            {
              name: 'ようりょくそ',
              description: '天気が晴れのとき、素早さが2倍になる。',
              is_hidden: true
            }
          ],
          moves: [
            { name: 'はっぱカッター', type: 'grass', power: 55 },
            { name: 'つるのムチ', type: 'grass', power: 45 },
            { name: 'やどりぎのタネ', type: 'grass', power: nil },
            { name: 'せいちょう', type: 'normal', power: nil }
          ]
        }
      },
      {
        national_id: 4,
        name_ja: 'ヒトカゲ',
        name_en: 'Charmander',
        name_kana: 'ヒトカゲ',
        data: {
          types: ['fire'],
          generation: 1,
          height: 6,
          weight: 85,
          stats: {
            hp: 39,
            attack: 52,
            defense: 43,
            "special-attack": 60,
            "special-defense": 50,
            speed: 65
          },
          abilities: [
            {
              name: 'もうか',
              description: 'HPが減ったとき、ほのおタイプの技の威力が上がる。',
              is_hidden: false
            },
            {
              name: 'サンパワー',
              description: '天気が晴れのとき、特攻が1.5倍になるがHPが減る。',
              is_hidden: true
            }
          ],
          moves: [
            { name: 'ひのこ', type: 'fire', power: 40 },
            { name: 'かえんほうしゃ', type: 'fire', power: 90 },
            { name: 'きりさく', type: 'normal', power: 70 },
            { name: 'えんまく', type: 'normal', power: nil }
          ]
        }
      },
      {
        national_id: 7,
        name_ja: 'ゼニガメ',
        name_en: 'Squirtle',
        name_kana: 'ゼニガメ',
        data: {
          types: ['water'],
          generation: 1,
          height: 5,
          weight: 90,
          stats: {
            hp: 44,
            attack: 48,
            defense: 65,
            "special-attack": 50,
            "special-defense": 64,
            speed: 43
          },
          abilities: [
            {
              name: 'げきりゅう',
              description: 'HPが減ったとき、みずタイプの技の威力が上がる。',
              is_hidden: false
            },
            {
              name: 'あめうけざら',
              description: '天気が雨のとき、毎ターンHPが回復する。',
              is_hidden: true
            }
          ],
          moves: [
            { name: 'みずでっぽう', type: 'water', power: 40 },
            { name: 'ハイドロポンプ', type: 'water', power: 110 },
            { name: 'からにこもる', type: 'water', power: nil },
            { name: 'たいあたり', type: 'normal', power: 40 }
          ]
        }
      },
      {
        national_id: 25,
        name_ja: 'ピカチュウ',
        name_en: 'Pikachu',
        name_kana: 'ピカチュウ',
        data: {
          types: ['electric'],
          generation: 1,
          height: 4,
          weight: 60,
          stats: {
            hp: 35,
            attack: 55,
            defense: 40,
            "special-attack": 50,
            "special-defense": 50,
            speed: 90
          },
          abilities: [
            {
              name: 'せいでんき',
              description: '接触技を受けると30%の確率で相手をまひ状態にする。',
              is_hidden: false
            },
            {
              name: 'ひらいしん',
              description: 'でんきタイプの技を受けると特攻が上がる。',
              is_hidden: true
            }
          ],
          moves: [
            { name: 'でんきショック', type: 'electric', power: 40 },
            { name: '10まんボルト', type: 'electric', power: 90 },
            { name: 'かみなり', type: 'electric', power: 110 },
            { name: 'でんこうせっか', type: 'normal', power: 40 }
          ]
        }
      },
      {
        national_id: 150,
        name_ja: 'ミュウツー',
        name_en: 'Mewtwo',
        name_kana: 'ミュウツー',
        data: {
          types: ['psychic'],
          generation: 1,
          height: 20,
          weight: 1220,
          stats: {
            hp: 106,
            attack: 110,
            defense: 90,
            "special-attack": 154,
            "special-defense": 90,
            speed: 130
          },
          abilities: [
            {
              name: 'プレッシャー',
              description: '相手の技のPPを多く減らす。',
              is_hidden: false
            },
            {
              name: 'きんちょうかん',
              description: '相手はきのみを使えなくなる。',
              is_hidden: true
            }
          ],
          moves: [
            { name: 'サイコキネシス', type: 'psychic', power: 90 },
            { name: 'はかいこうせん', type: 'normal', power: 150 },
            { name: 'れいとうビーム', type: 'ice', power: 90 },
            { name: '10まんボルト', type: 'electric', power: 90 }
          ]
        }
      },
      {
        national_id: 144,
        name_ja: 'フリーザー',
        name_en: 'Articuno',
        name_kana: 'フリーザー',
        data: {
          types: %w[ice flying],
          generation: 1,
          height: 17,
          weight: 554,
          stats: {
            hp: 90,
            attack: 85,
            defense: 100,
            "special-attack": 95,
            "special-defense": 125,
            speed: 85
          },
          abilities: [
            {
              name: 'プレッシャー',
              description: '相手の技のPPを多く減らす。',
              is_hidden: false
            },
            {
              name: 'ゆきがくれ',
              description: 'あられのとき回避率が上がる。',
              is_hidden: true
            }
          ],
          moves: [
            { name: 'ふぶき', type: 'ice', power: 110 },
            { name: 'ぼうふう', type: 'flying', power: 110 },
            { name: 'れいとうビーム', type: 'ice', power: 90 },
            { name: 'エアスラッシュ', type: 'flying', power: 75 }
          ]
        }
      }
    ]

    created_count = 0

    sample_pokemon.each do |pokemon_data|
      existing = PokemonSpecies.find_by(national_id: pokemon_data[:national_id])

      if existing
        puts "⚠️  #{pokemon_data[:name_ja]} (No.#{pokemon_data[:national_id]}) は既に存在します"
      else
        PokemonSpecies.create!(pokemon_data)
        puts "✅ #{pokemon_data[:name_ja]} (No.#{pokemon_data[:national_id]}) を作成しました"
        created_count += 1
      end
    end

    puts "\n🎉 サンプルデータの作成が完了しました！"
    puts "📊 作成されたポケモン: #{created_count}匹"
    puts "📖 総登録数: #{PokemonSpecies.count}匹"
    puts "\n🌐 ポケモン図鑑をチェック: http://localhost:3000/pokedex"
  end

  desc '全ポケモンデータを削除'
  task clear_data: :environment do
    puts '🗑️ 全ポケモンデータを削除中...'

    count = PokemonSpecies.count
    PokemonSpecies.destroy_all

    puts "✅ #{count}匹のポケモンデータを削除しました"
  end
end
