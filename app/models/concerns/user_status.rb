module UserStatus
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: 'status' do
      state :working, initial: true
      state :on_vacation
      state :blocked
      state :fired

      event :block do
        transitions from: %i[working on_vacation], to: :blocked
      end

      event :work do
        transitions from: %i[on_vacation blocked], to: :working
      end

      event :vacation do
        transitions from: :working, to: :on_vacation
      end

      event :fire do
        transitions from: %i[on_vacation blocked working], to: :fired
      end
    end
  end
end
