FactoryGirl.define do
  factory :to_do do
    title "Testes"
    description 'Escrever testes unitários'
    deadline '01/02/2017 23:00'
  end

  factory :finished_to_do, parent: :to_do do
    status :finished
    finished_at '01/02/2017 17:00'
  end
end
