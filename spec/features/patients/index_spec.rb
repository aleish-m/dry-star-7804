require 'rails_helper'

RSpec.describe "Patient Index Page" do
  describe "As a visitor" do
    describe "I visit the patient index page" do
      before :each do
        @hospital = Hospital.create!(name:"St.Francis")

        @doctor_1 = @hospital.doctors.create!(name:"Dr. Kelly", specialty:"Allergy", university:"Denver University")
        @doctor_2 = @hospital.doctors.create!(name:"Dr. Patrick", specialty:"Vascular", university:"University of Colorado")

        @patient_1 = Patient.create!(name:"Anne", age: 60)
        @patient_2 = Patient.create!(name:"John", age: 12)
        @patient_3 = Patient.create!(name:"Kim", age: 20)
        @patient_4 = Patient.create!(name:"Sam", age: 45)
        @patient_5 = Patient.create!(name:"Sara", age: 5)
        @patient_6 = Patient.create!(name:"Bobby", age: 55)
      end

      it "I see the names of all adult patients (age is greater than 18)" do
        visit patients_path

        within("#all-adult-patients") do
          expect(page).to have_content(@patient_1.name)
          expect(page).to have_content(@patient_3.name)
          expect(page).to have_content(@patient_4.name)
        end

        expect(page).to_not have_content(@patient_2.name)
        expect(page).to_not have_content(@patient_5.name)
      end

      it "I see the names are in ascending alphabetical order (A - Z, you do not need to account for capitalization)" do
        visit patients_path

        expect(@patient_1.name).to appear_before(@patient_3.name)
        expect(@patient_1.name).to appear_before(@patient_4.name)
        expect(@patient_1.name).to appear_before(@patient_6.name)
        expect(@patient_6.name).to appear_before(@patient_3.name)
        expect(@patient_6.name).to appear_before(@patient_4.name)
        expect(@patient_3.name).to appear_before(@patient_4.name)
      end
    end
  end
end