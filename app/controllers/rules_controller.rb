class RulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge
  before_action :set_rule, only: [ :show, :edit, :update, :destroy ]

  def index
    @rules = @challenge.rules.ordered
    @rules_by_type = @rules.group_by(&:rule_type)
    @violations_summary = @challenge.rule_violations_summary
  end

  def show
    # 個別ルールの詳細表示
  end

  def edit
    # ルール編集フォーム
  end

  def update
    if @rule.update(rule_params)
      redirect_to challenge_rules_path(@challenge),
                  notice: "ルール「#{@rule.name}」を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_multiple
    success_count = 0
    error_rules = []

    rules_params.each do |rule_id, rule_attributes|
      rule = @challenge.rules.find(rule_id)
      if rule.update(rule_attributes)
        success_count += 1
      else
        error_rules << rule
      end
    end

    if error_rules.empty?
      redirect_to challenge_rules_path(@challenge),
                  notice: t("rules.notices.updated_multiple", count: success_count)
    else
      redirect_to challenge_rules_path(@challenge),
                  alert: t("rules.notices.update_failed")
    end
  end

  def create_custom
    @rule = @challenge.rules.build(custom_rule_params)
    @rule.rule_type = "custom"
    @rule.sort_order = @challenge.rules.maximum(:sort_order).to_i + 1

    if @rule.save
      redirect_to challenge_rules_path(@challenge),
                  notice: t("rules.notices.created", name: @rule.name)
    else
      redirect_to challenge_rules_path(@challenge),
                  alert: t("rules.notices.create_failed")
    end
  end

  def destroy
    rule_name = @rule.name
    @rule.destroy
    redirect_to challenge_rules_path(@challenge),
                notice: "ルール「#{rule_name}」を削除しました。"
  end

  def violations_check
    @violations_summary = @challenge.rule_violations_summary
    render json: {
      violations: @violations_summary,
      total_violations: @violations_summary.values.flatten.size
    }
  end

  private

  def set_challenge
    @challenge = current_user.challenges.find(params[:challenge_id])
  end

  def set_rule
    @rule = @challenge.rules.find(params[:id])
  end

  def rule_params
    params.expect(rule: [ :enabled, :custom_value, :description ])
  end

  def rules_params
    params.expect(rules: [ rules: [ :enabled, :custom_value, :description ] ])
  end

  def custom_rule_params
    params.expect(rule: [ :name, :description, :default_value, :enabled ])
  end
end
