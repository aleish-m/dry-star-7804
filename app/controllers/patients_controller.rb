class PatientsController < ApplicationController 
  def index
    @patients = Patient.all
  end

  def destroy
    doctor = Doctor.find(params[:doctor_id])
    doctor_patient = doctor.doctor_patients.find_by(patient_id: params[:id])
    doctor_patient.destroy
    redirect_to doctor_path(doctor)
  end
end