class Account < ApplicationRecord

    # use has_secure_password
    has_secure_password

    has_many :contacts, class_name: "Account", foreign_key: "contact_link_id"
    belongs_to :contact_link, class_name: "Account"

    #Validations
    validates :username, presence: true, uniqueness: { case_sensitive: false}
    validates_presence_of :password, on: :create 
    validates_presence_of :password_confirmation, on: :create 
    validates_confirmation_of :password, on: :create, message: "does not match"
    validates_length_of :password, minimum: 4, message: "must be at least 4 characters long", allow_blank: true


    def add_contact(new_contact)
        self.contacts << new_contact unless self.contacts.include?(new_contact) || new_contact == self
    end

    private
    def self.authenticate(email,password)
        find_by_email(email).try(:authenticate, password)
    end

end
