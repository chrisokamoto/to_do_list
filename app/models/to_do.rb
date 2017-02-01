class ToDo
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :deadline, type: DateTime
  field :finished_at, type: DateTime
  field :status, type: Symbol, default: :pending
  field :user_id, type: String
end
