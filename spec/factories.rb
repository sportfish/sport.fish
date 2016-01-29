FactoryGirl.define do  factory :participant do
    
  end
  factory :admin do
    
  end
  factory :tournament_participation do
    user nil
tournament nil
  end
  factory :tournament do
    
  end
  factory :role do
    
  end

  factory :user do
    name "MyString"
email "MyString"
  end

end
