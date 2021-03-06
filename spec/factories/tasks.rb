FactoryBot.define do
  
  factory :task do  
    title { 'タイトル1' }
    content { 'コンテント1' }
    time_limit {'2020-01-01'}
    status {"作業中"}
    priority {'high'}
    created_at{"2019-01-01"}

  end

  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'コンテント2' }
    time_limit {'2020-01-02'}
    status {"完了"}
    priority {'medium'}
    created_at{"2019-01-02"}
  end

  factory :third_task, class: Task do
    title { 'タイトル3' }
    content { 'コンテント3' }
    time_limit {'2020-01-03'}
    status {"未着手"}
    priority {'low'}
    created_at{"2019-01-03"}
  end

end

