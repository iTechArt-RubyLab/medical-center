module WithApplyConditions
  extend ActiveSupport::Concern

  included do
    def apply_conditions(scope, *conditions)
      applicable_conditions = conditions.compact
      scope =
        applicable_conditions
        .select { |c| c.is_a? Hash }
        .pluck(:modifier)
        .reduce(scope) { |s, modifier| apply_modifier(s, modifier) }

      arel_conditions =
        applicable_conditions.map do |condition|
          if condition.is_a? Hash
            condition[:condition]
          else
            condition
          end
        end

      arel_conditions.reduce(scope) do |s, condition|
        apply_condition s, condition
      end
    end

    private

    def apply_condition(scope, condition)
      return scope if condition.blank?

      scope.where(condition)
    end

    def apply_modifier(scope, modifier)
      return scope if modifier.blank?

      modifier.call(scope)
    end
  end
end
