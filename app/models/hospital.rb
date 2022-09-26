class Hospital < ApplicationRecord
  has_many :doctors

  def doctors_caseload_sort
    doctors.joins(:doctor_patients)
    .group(:id)
    .select('doctors.*, sum(doctor_patients.patient_id) as patient_count')
    .order(patient_count: :desc)
  end
end
