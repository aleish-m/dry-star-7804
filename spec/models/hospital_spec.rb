require 'rails_helper'

RSpec.describe Hospital do
  describe 'relationships' do
    it {should have_many :doctors}
  end

  describe 'instance methods' do
    before :each do
      @hospital = Hospital.create!(name:"St.Francis")

      @doctor_1 = @hospital.doctors.create!(name:"Dr. Kelly", specialty:"Allergy", university:"Denver University")
      @doctor_2 = @hospital.doctors.create!(name:"Dr. Patrick", specialty:"Vascular", university:"University of Colorado")
      @doctor_3 = @hospital.doctors.create!(name: "Meredith Grey", specialty: "General Surgery", university: "Harvard University")

      @patient_1 = Patient.create!(name:"Anne", age: 60)
      @patient_2 = Patient.create!(name:"John", age: 12)
      @patient_3 = Patient.create!(name:"Kim", age: 20)
      @patient_4 = Patient.create!(name:"Sam", age: 45)
      @patient_5 = Patient.create!(name:"Sara", age: 5)
      @patient_6 = Patient.create!(name:"Bobby", age: 55)

      @doctor_1.patients << @patient_1
      @doctor_1.patients << @patient_2
      @doctor_1.patients << @patient_5

      @doctor_2.patients << @patient_1
      @doctor_2.patients << @patient_4

      @doctor_3.patients << @patient_2
      @doctor_3.patients << @patient_3
      @doctor_3.patients << @patient_4
      @doctor_3.patients << @patient_6
    end

    describe "#doctors_caseload_sort" do
      it "doctors is ordered from most number of patients to least number of patients" do
        expect(@hospital.doctors_caseload_sort).to eq([@doctor_3, @doctor_1, @doctor_2])
      end
    end
  end
end
