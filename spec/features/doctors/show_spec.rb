require 'rails_helper'

RSpec.describe "Doctors Show Page" do
  describe "As a visitor" do
    describe "I visit a doctor's show page" do
      before :each do
        @hospital = Hospital.create!(name:"St.Francis")

        @doctor_1 = @hospital.doctors.create!(name:"Dr. Kelly", specialty:"Allergy", university:"Denver University")
        @doctor_2 = @hospital.doctors.create!(name:"Dr. Patrick", specialty:"Vascular", university:"University of Colorado")

        @patient_1 = Patient.create!(name:"Anne", age: 60)
        @patient_2 = Patient.create!(name:"John", age: 12)
        @patient_3 = Patient.create!(name:"Kim", age: 20)
        @patient_4 = Patient.create!(name:"Sam", age: 45)

        @doctor_1.patients << @patient_1
        @doctor_1.patients << @patient_2
        @doctor_1.patients << @patient_3

        @doctor_2.patients << @patient_1
        @doctor_2.patients << @patient_4
      end

      it "I see all of that doctor's information including: name, specialty, university" do
        visit doctor_path(@doctor_1)

        within("#doctor_info") do
          expect(page).to have_content(@doctor_1.name)
          expect(page).to have_content(@doctor_1.specialty)
          expect(page).to have_content(@doctor_1.university)
        end

        expect(page).to_not have_content(@doctor_2.name)
        expect(page).to_not have_content(@doctor_2.specialty)
        expect(page).to_not have_content(@doctor_2.university)
      end
    end
  end
end