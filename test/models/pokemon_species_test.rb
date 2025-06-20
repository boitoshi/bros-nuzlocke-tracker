# ポケモン種族データのテスト 🐾
require "test_helper"

class PokemonSpeciesTest < ActiveSupport::TestCase
  def setup
    @pokemon_species = PokemonSpecies.new(
      national_id: 25,
      name_ja: "ピカチュウ",
      name_en: "Pikachu",
      name_kana: "ピカチュウ",
      data: {
        types: ["electric"],
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
            name: "せいでんき",
            description: "接触技を受けると30%の確率で相手をまひ状態にする。",
            is_hidden: false
          }
        ],
        moves: [
          { name: "でんきショック", type: "electric", power: 40 }
        ]
      }
    )
  end

  test "should be valid" do
    assert @pokemon_species.valid?
  end

  test "national_id should be present" do
    @pokemon_species.national_id = nil
    assert_not @pokemon_species.valid?
  end

  test "name_ja should be present" do
    @pokemon_species.name_ja = ""
    assert_not @pokemon_species.valid?
  end

  test "national_id should be unique" do
    @pokemon_species.save
    duplicate = @pokemon_species.dup
    assert_not duplicate.valid?
  end

  test "should return correct types_data" do
    expected = ["electric"]
    assert_equal expected, @pokemon_species.types_data
  end

  test "should return correct stats_data" do
    expected = {
      hp: 35,
      attack: 55,
      defense: 40,
      "special-attack": 50,
      "special-defense": 50,
      speed: 90
    }
    assert_equal expected, @pokemon_species.stats_data
  end

  test "should return correct height in meters" do
    assert_equal 0.4, @pokemon_species.height_m
  end

  test "should return correct weight in kilograms" do
    assert_equal 6.0, @pokemon_species.weight_kg
  end

  test "should return correct formatted dex number" do
    assert_equal "#025", @pokemon_species.formatted_dex_number
  end

  test "should return correct sprite URL" do
    expected = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"
    assert_equal expected, @pokemon_species.sprite_url
  end

  test "should return correct official artwork URL" do
    expected = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
    assert_equal expected, @pokemon_species.official_artwork_url
  end

  test "should return display_name preferring Japanese" do
    assert_equal "ピカチュウ", @pokemon_species.display_name
  end

  test "should return English name when Japanese is blank" do
    @pokemon_species.name_ja = ""
    assert_equal "Pikachu", @pokemon_species.display_name
  end

  test "should search by Japanese name" do
    @pokemon_species.save
    results = PokemonSpecies.search_by_name("ピカチュウ")
    assert_includes results, @pokemon_species
  end

  test "should search by English name" do
    @pokemon_species.save
    results = PokemonSpecies.search_by_name("Pikachu")
    assert_includes results, @pokemon_species
  end

  test "should filter by type" do
    @pokemon_species.save
    results = PokemonSpecies.filter_by_type("electric")
    assert_includes results, @pokemon_species
  end

  test "should filter by generation" do
    @pokemon_species.save
    results = PokemonSpecies.filter_by_generation(1)
    assert_includes results, @pokemon_species
  end

  test "should return correct type colors" do
    expected = ["#F8D030"] # electric type color
    assert_equal expected, @pokemon_species.type_colors
  end

  test "should handle missing data gracefully" do
    @pokemon_species.data = nil
    assert_equal [], @pokemon_species.types_data
    assert_equal({}, @pokemon_species.stats_data)
    assert_nil @pokemon_species.height_m
    assert_nil @pokemon_species.weight_kg
  end
end
