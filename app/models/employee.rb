class Employee < ApplicationRecord

before_save :clean_phone

#validation
def clean_phone
 self.phone = self.phone.gsub(/[^0-9]/i, '')
end


end
