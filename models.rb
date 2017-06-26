class Emr < ActiveRecord::Base
    belongs_to :patient
end

class Clinic < ActiveRecord::Base
    has_many :doctors
end

class Patient < ActiveRecord::Base
    has_many :appointments
    has_many :doctors, through: :appointments
    has_one :emr
end

class Doctor < ActiveRecord::Base
    has_many :appointments
    has_many :patients, through: :appointments
    belongs_to :clinic
end

class Appointment < ActiveRecord::Base
    belongs_to :patient
    belongs_to :doctor
end
