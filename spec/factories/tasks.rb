FactoryGirl.define do
  factory :task do
    sequence(:title) { |i| "#{i} test news title"}
    sequence(:description) { |i| "#{i} test news description, must have minimum 30 letters"}
    user_id 1
  end
end

