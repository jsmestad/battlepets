FactoryGirl.define do
  factory :contest do
    challenger do
      { id: '1', name: 'Challenger' }
    end

    defendant do
      { id: '2', name: 'Defender' }
    end
  end
end
