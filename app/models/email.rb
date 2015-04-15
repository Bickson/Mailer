class Email < ActiveRecord::Base
  attr_accessible :content, :subject
end
