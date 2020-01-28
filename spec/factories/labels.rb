FactoryBot.define do
  factory :label do
    name { "sample１" }
  end

  factory :label2, class: Label do 
    name { "sample2" }
  end
end
