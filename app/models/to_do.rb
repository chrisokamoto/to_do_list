class ToDo
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :deadline, type: String
  field :finished_at, type: String
  field :status, type: Symbol, default: :pending
end
