class AddIndexesForPerformance < ActiveRecord::Migration[8.0]
  def change
    # StatisticsService用のパフォーマンス改善インデックス
    
    # イベントログ用（統計計算で頻繁に使用）
    add_index :event_logs, [:challenge_id, :occurred_at], 
              name: 'index_event_logs_on_challenge_and_date'
    add_index :event_logs, [:challenge_id, :event_type], 
              name: 'index_event_logs_on_challenge_and_type'
    
    # ポケモン用（ステータス別の統計に使用）
    add_index :pokemons, [:challenge_id, :status], 
              name: 'index_pokemons_on_challenge_and_status'
    add_index :pokemons, [:species, :status], 
              name: 'index_pokemons_on_species_and_status'
    add_index :pokemons, [:caught_at], 
              name: 'index_pokemons_on_caught_at'
    add_index :pokemons, [:died_at], 
              name: 'index_pokemons_on_died_at'
    
    # バトル記録用（バトル統計で使用）
    add_index :battle_records, [:challenge_id, :battle_date], 
              name: 'index_battle_records_on_challenge_and_date'
    add_index :battle_records, [:challenge_id, :result], 
              name: 'index_battle_records_on_challenge_and_result'
    
    # バトル参加者用（most_active_battle_pokemon用）
    add_index :battle_participants, [:battle_record_id, :pokemon_id], 
              name: 'index_battle_participants_on_battle_and_pokemon',
              unique: true
    
    # チャレンジ用（ゲーム別統計用）
    add_index :challenges, [:user_id, :status], 
              name: 'index_challenges_on_user_and_status'
    add_index :challenges, [:game_title, :status], 
              name: 'index_challenges_on_game_and_status'
    
    # マイルストーン用（進捗計算用）
    add_index :milestones, [:challenge_id, :completed_at], 
              name: 'index_milestones_on_challenge_and_completed'
    
    # エリア用（危険度統計用）
    add_index :areas, [:game_title, :area_type], 
              name: 'index_areas_on_game_and_type'
  end
end
