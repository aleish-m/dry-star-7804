require 'rails_helper'

RSpec.describe Patient do

  describe 'relationships' do
    it { should have_many(:doctor_patients) }
    it { should have_many(:doctors).through :doctor_patients }
  end

  describe 'class methods' do
    before :each do
      @patient_1 = Patient.create!(name:"Anne", age: 60)
      @patient_2 = Patient.create!(name:"John", age: 12)
      @patient_3 = Patient.create!(name:"Sara", age: 5)
      @patient_4 = Patient.create!(name:"Sam", age: 45)
      @patient_5 = Patient.create!(name:"Kim", age: 20)
      @patient_6 = Patient.create!(name:"Bobby", age: 55)
    end

    describe "#adults" do
      it "returns all adult patients (age is greater than 18)" do
        # require "pry"; binding.pry
        expect(Patient.adults.sort).to eq([@patient_1, @patient_4, @patient_5, @patient_6].sort)
      end
    end

    describe "#alpha_sort" do
      it "returns all patient names in ascending alphabetical order (A - Z)" do
        expect(Patient.alpha_sort).to eq([@patient_1, @patient_6, @patient_2, @patient_5, @patient_4, @patient_3])
      end
    end
  end
end