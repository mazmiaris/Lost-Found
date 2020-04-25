class Post < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
    scope :most_recent, -> {order(id: :desc)}
    belongs_to :category, optional: true 
    belongs_to :author, optional: true  
    

    mount_uploader :thumb, ThumbUploader

    def should_generate_new_friendly_id?
        title_changed?
    end 

    def display_day_published  
        "Published #{created_at.strftime('%-b %-d, %Y')}"
    end
end
