require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @challenge = challenges(:one)
    @pokemon = pokemons(:one)
    sign_in @user
  end

  test "should get index" do
    get challenge_pokemons_url(@challenge)
    assert_response :success
  end

  test "should get show" do
    get challenge_pokemon_url(@challenge, @pokemon)
    assert_response :success
  end

  test "should get new" do
    get new_challenge_pokemon_url(@challenge)
    assert_response :success
  end

  test "should create pokemon" do
    assert_difference("Pokemon.count") do
      post challenge_pokemons_url(@challenge), params: { 
        pokemon: { 
          nickname: "Test Pokemon", 
          species: "Pikachu", 
          level: 5,
          area_id: areas(:one).id,
          caught_at: Time.current 
        } 
      }
    end
    assert_redirected_to challenge_pokemon_url(@challenge, Pokemon.last)
  end

  test "should get edit" do
    get edit_challenge_pokemon_url(@challenge, @pokemon)
    assert_response :success
  end

  test "should update pokemon" do
    patch challenge_pokemon_url(@challenge, @pokemon), params: { 
      pokemon: { nickname: "Updated Pokemon" } 
    }
    assert_redirected_to challenge_pokemon_url(@challenge, @pokemon)
  end

  test "should destroy pokemon" do
    assert_difference("Pokemon.count", -1) do
      delete challenge_pokemon_url(@challenge, @pokemon)
    end
    assert_redirected_to challenge_pokemons_url(@challenge)
  end

  test "should get party" do
    get party_challenge_pokemons_url(@challenge)
    assert_response :success
  end
end
