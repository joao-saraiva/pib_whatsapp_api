# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    number { 'MyString' }
    name { 'Jeff' }
    pib_priority { false }

    trait :inveted_friend do
      number { nil }
      player_friend_id { FactoryBot.create(:player).id }
    end

    trait :pib_priority do
      pib_priority { true }
    end
  end
end
