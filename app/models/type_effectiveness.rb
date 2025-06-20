class TypeEffectiveness < ApplicationRecord
  validates :attacking_type, presence: true, inclusion: { 
    in: %w[normal fire water electric grass ice fighting poison ground flying psychic bug rock ghost dragon dark steel fairy] 
  }
  validates :defending_type, presence: true, inclusion: { 
    in: %w[normal fire water electric grass ice fighting poison ground flying psychic bug rock ghost dragon dark steel fairy] 
  }
  validates :effectiveness, presence: true, inclusion: { in: [0.0, 0.25, 0.5, 1.0, 2.0, 4.0] }
  validates :attacking_type, uniqueness: { scope: :defending_type }

  POKEMON_TYPES = %w[normal fire water electric grass ice fighting poison ground flying psychic bug rock ghost dragon dark steel fairy].freeze

  scope :super_effective, -> { where(effectiveness: [2.0, 4.0]) }
  scope :not_very_effective, -> { where(effectiveness: [0.25, 0.5]) }
  scope :no_effect, -> { where(effectiveness: 0.0) }
  scope :normal_effectiveness, -> { where(effectiveness: 1.0) }

  def self.get_effectiveness(attacking_type, defending_type)
    find_by(attacking_type: attacking_type.downcase, defending_type: defending_type.downcase)&.effectiveness || 1.0
  end

  def self.seed_type_chart!
    type_chart = {
      'normal' => { 'rock' => 0.5, 'ghost' => 0.0, 'steel' => 0.5 },
      'fire' => { 'fire' => 0.5, 'water' => 0.5, 'grass' => 2.0, 'ice' => 2.0, 'bug' => 2.0, 'rock' => 0.5, 'dragon' => 0.5, 'steel' => 2.0 },
      'water' => { 'fire' => 2.0, 'water' => 0.5, 'grass' => 0.5, 'ground' => 2.0, 'rock' => 2.0, 'dragon' => 0.5 },
      'electric' => { 'water' => 2.0, 'electric' => 0.5, 'grass' => 0.5, 'ground' => 0.0, 'flying' => 2.0, 'dragon' => 0.5 },
      'grass' => { 'fire' => 0.5, 'water' => 2.0, 'grass' => 0.5, 'poison' => 0.5, 'ground' => 2.0, 'flying' => 0.5, 'bug' => 0.5, 'rock' => 2.0, 'dragon' => 0.5, 'steel' => 0.5 },
      'ice' => { 'fire' => 0.5, 'water' => 0.5, 'grass' => 2.0, 'ice' => 0.5, 'ground' => 2.0, 'flying' => 2.0, 'dragon' => 2.0, 'steel' => 0.5 },
      'fighting' => { 'normal' => 2.0, 'ice' => 2.0, 'poison' => 0.5, 'flying' => 0.5, 'psychic' => 0.5, 'bug' => 0.5, 'rock' => 2.0, 'ghost' => 0.0, 'dark' => 2.0, 'steel' => 2.0, 'fairy' => 0.5 },
      'poison' => { 'grass' => 2.0, 'poison' => 0.5, 'ground' => 0.5, 'rock' => 0.5, 'ghost' => 0.5, 'steel' => 0.0, 'fairy' => 2.0 },
      'ground' => { 'fire' => 2.0, 'electric' => 2.0, 'grass' => 0.5, 'poison' => 2.0, 'flying' => 0.0, 'bug' => 0.5, 'rock' => 2.0, 'steel' => 2.0 },
      'flying' => { 'electric' => 0.5, 'grass' => 2.0, 'ice' => 0.5, 'fighting' => 2.0, 'bug' => 2.0, 'rock' => 0.5, 'steel' => 0.5 },
      'psychic' => { 'fighting' => 2.0, 'poison' => 2.0, 'psychic' => 0.5, 'dark' => 0.0, 'steel' => 0.5 },
      'bug' => { 'fire' => 0.5, 'grass' => 2.0, 'fighting' => 0.5, 'poison' => 0.5, 'flying' => 0.5, 'psychic' => 2.0, 'ghost' => 0.5, 'dark' => 2.0, 'steel' => 0.5, 'fairy' => 0.5 },
      'rock' => { 'fire' => 2.0, 'ice' => 2.0, 'fighting' => 0.5, 'ground' => 0.5, 'flying' => 2.0, 'bug' => 2.0, 'steel' => 0.5 },
      'ghost' => { 'normal' => 0.0, 'psychic' => 2.0, 'ghost' => 2.0, 'dark' => 0.5 },
      'dragon' => { 'dragon' => 2.0, 'steel' => 0.5, 'fairy' => 0.0 },
      'dark' => { 'fighting' => 0.5, 'psychic' => 2.0, 'ghost' => 2.0, 'dark' => 0.5, 'fairy' => 0.5 },
      'steel' => { 'fire' => 0.5, 'water' => 0.5, 'electric' => 0.5, 'ice' => 2.0, 'rock' => 2.0, 'steel' => 0.5, 'fairy' => 2.0 },
      'fairy' => { 'fire' => 0.5, 'fighting' => 2.0, 'poison' => 0.5, 'dragon' => 2.0, 'dark' => 2.0, 'steel' => 0.5 }
    }

    POKEMON_TYPES.each do |attacking_type|
      POKEMON_TYPES.each do |defending_type|
        effectiveness = type_chart.dig(attacking_type, defending_type) || 1.0
        
        create_or_update_effectiveness(attacking_type, defending_type, effectiveness)
      end
    end
  end

  private

  def self.create_or_update_effectiveness(attacking_type, defending_type, effectiveness)
    type_eff = find_or_initialize_by(attacking_type: attacking_type, defending_type: defending_type)
    type_eff.effectiveness = effectiveness
    type_eff.save!
  end
end
