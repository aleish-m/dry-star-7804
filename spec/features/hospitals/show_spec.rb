require 'rails_helper'

RSpec.describe "Hospital Show Page" do
  describe "As a visitor" do
    describe "I visit a hospital's show page" do
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

      it "I see the hospital's name and I see the names of all doctors that work at this hospital" do
        visit hospital_path(@hospital)

        within("#hospital-#{@hospital.id}-info") do
          expect(page).to have_content(@hospital.name)
          within("#hospital-doctors") do
            expect(page).to have_content(@doctor_1.name)
            expect(page).to have_content(@doctor_2.name)
            expect(page).to have_content(@doctor_3.name)
          end
        end
      end

      it "Next to each doctor I see the number of patients associated with the doctor" do
        visit hospital_path(@hospital)
        within("#hospital-doctors") do
          within("#doctor-#{@doctor_1.id}") do
            expect(page).to have_content(@doctor_1.patients.count)
          end
          within("#doctor-#{@doctor_2.id}") do
            expect(page).to have_content(@doctor_2.patients.count)
          end
          within("#doctor-#{@doctor_3.id}") do
            expect(page).to have_content(@doctor_3.patients.count)
          end
        end
      end

      it "I see the list of doctors is ordered from most number of patients to least number of patients" do
        visit hospital_path(@hospital)

        within("#hospital-doctors") do
          expect(@doctor_3.name).to appear_before(@doctor_1.name)
          expect(@doctor_3.name).to appear_before(@doctor_2.name)
          expect(@doctor_1.name).to appear_before(@doctor_2.name)
        end
          
      end
    end
  end
end

      