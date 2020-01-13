class Task < ApplicationRecord
  # default_scope -> { order(created_at: :desc) }
  validates :title, presence: true
  validates :content, presence: true
  scope :latest, -> {order(created_at: :desc)}
  scope :expired, -> {order(time_limit: :asc)}
  scope :search, -> (params) {where('(title LIKE ?) AND (status LIKE ?)',
                                  "%#{params[:title]}%",
                                  "%#{params[:status]}%")}

end
