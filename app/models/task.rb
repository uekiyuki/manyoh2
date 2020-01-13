class Task < ApplicationRecord
  # default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :content, presence: true
  scope :latest, -> {order(created_at: :desc)}
  scope :expired, -> {order(time_limit: :asc)}
  scope :search, -> (params) {where('(title LIKE ?) AND (status LIKE ?)',
                                  "%#{params[:title_key]}%",
                                  "%#{params[:status_key]}%")}
  scope :priority, -> {order(priority: :asc)}
  enum priority: { high: 0, medium: 1, low: 2 }

end
