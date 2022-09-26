require 'rails_helper'

RSpec.describe "Remove a Patient from a Doctor" do
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

      it "Next to each patient's name, I see a button to remove that patient from that doctor's caseload" do
        visit doctor_path(@doctor_1)

        within("#doctor-#{@doctor_1.id}-patients") do
          within("#patient-#{@patient_1.id}") do
            expect(page).to have_button("Remove for Caseload")
          end
          within("#patient-#{@patient_2.id}") do
            expect(page).to have_button("Remove for Caseload")
          end
          within("#patient-#{@patient_3.id}") do
            expect(page).to have_button("Remove for Caseload")
          end
        end

        it "When I click that button for one patient I'm brought back to the Doctor's show page" do
          visit doctor_path(@doctor_1)

          within("#doctor-#{@doctor_1.id}-patients") do
            within("#patient-#{@patient_1.id}") do
              click_button"Remove for Caseload"
            end
          end

          expect(current_path).to eq(doctor_path(@doctor_1))
        end

        it "I no longer see that patient's name listed"

          visit doctor_path(@doctor_1)

          expect(page).to have_content(@patient_1.name)
            within("#patient-#{@patient_1.id}") do
              click_button"Remove for Caseload"
            end
          expect(page).to_not have_content(@patient_1.name)
      end
    end
  end
end
