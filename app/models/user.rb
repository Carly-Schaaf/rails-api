class User < ApplicationRecord
    validates :email, :session_token, :password_digest, :user_type, presence: true
    validates :email, uniqueness: true
    validates :password, length: {minimum: 6, allow_nil: true}
    validate :passwords_match

    # has_many :plots,
    #     foreign_key: :user_id,
    #     class_name: :Plot

    # has_many :assigned_jobs,
    #     foreign_key: :applicator_id,
    #     class_name: :Job

    # has_many :booked_jobs,
    #     through: :assigned_jobs,
    #     source: :plot

    attr_reader :password, :password2
    after_initialize :ensure_session_token

    def is_password?(pw)
        BCrypt::Password.new(self.password_digest).is_password?(pw)
    end

    def password=(value)
        @password = value
        self.password_digest = BCrypt::Password.create(value)
    end

    def password2=(value)
        @password2 = value
    end

    def self.find_by_credentials(email, pw)
        @user = User.find_by(email: email)
        @user && @user.is_password?(pw) ? @user : nil
    end

    def reset_session_token!
        self.session_token = SecureRandom.urlsafe_base64
        self.save!
        self.session_token
    end

    def passwords_match
        errors[:base] << "Passwords must match" unless self.password == self.password2 
    end

    private

    def ensure_session_token
        self.session_token ||= SecureRandom.urlsafe_base64
    end

end
