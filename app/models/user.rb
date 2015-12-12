class User < ActiveRecord::Base
    before_save { self.email = email.downcase }
    validates :name, presence: true ,length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence:true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    has_secure_password
    
    has_many :microposts
    
    has_many :following_relationship, class_name: "Relationship",
                                      foreign_key: "follower_id",
                                      dependent: :destroy
                                      
    has_many :following_users, through: :following_relationship, source: :followed
                                      
end
