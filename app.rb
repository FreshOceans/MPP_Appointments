# ======= requires =======
require "sinatra"
require 'sinatra/activerecord'
require "sinatra/reloader" if development?
require './models'
require "sinatra/flash"

# ======= database =======
set :database, "sqlite3:appointments.db"

# =======  sessions =======
enable :sessions


# ======= home =======
get '/' do
	puts "\n******* home *******"
	erb :home
end
# ===== Profile =====
get '/profile' do
	puts "\n******* profile *******"
	erb :profile
end

# ===== Sign IN =====
# == Doctors
get '/doctor_sign_in' do
	puts "\n******* doctor_sign_in *******"
	erb :doctor_sign_in
end
post '/doctor_sign_in' do
	puts "\n******* doctor_sign_in *******"
    @doctor = Doctor.where(name: params[:name]).first
	if @doctor
		if @doctor.clinic_id == params[:clinic_id]
			session[:doctor_id] = @doctor.id
            @current_user = get_current_user
			flash[:notice] = "You've been signed in successfully."
			redirect '/'
		else
			flash[:notice] = "Please check your clinic id and name and try again."
			redirect "/doctor_sign_in"
		end
	else
		flash[:notice] = "Please check your clinic id and name and try again."
		redirect "/doctor_sign_in"
	end
end
# ======= get_current_user =======
def get_current_user
    puts "\n******* get_current_user *******"
    if session[:doctor_id]
        return Doctor.find(session[:doctor_id])
    else
        puts "** NO CURRENT DOCTOR **"
    end
end


# ===== Clinic =====
get '/clinic' do
	puts "\n******* clinic *******"
	erb :clinic
end
# == Create Clinic
get '/clinic_form' do
	puts "\n******* clinic *******"
	erb :clinic_form
end
post '/clinic' do
    puts "params: #{params.inspect}"
	Clinic.create(
		name: params[:name],
		address: params[:address]
	)
	@clinic = Clinic.order("created_at").last
	session[:clinic_id] = @clinic.id
	puts "session[:clinic_id], #{session[:clinic_id]}"
	puts "@clinic:, #{@clinic}"
	redirect '/profile'
end
# == Update Clinic Info
get '/update_clinic_form' do
	puts "\n******* update_clinic_form *******"
	erb :update_clinic_form
end
get '/update_clinic_form/:id' do
	puts "\n******* update clinic form *******"
	puts "params.inspect: #{params.inspect}"
	@clinic = Clinic.find params[:id]
	erb :update
end
post '/update' do
	puts "\n******* update *******"
	puts "params.inspect: #{params.inspect}"
	@clinic = Clinic.find(params[:id]).update_attributes(params)
	erb :profile
end
get '/profile/:id' do
	puts "\n******* profile *******"
	puts "session[:clinic_id]: #{session[:clinic_id]}"
	@clinic = Clinic.find params[:id]
	erb :profile
end

# == Delete Clinic
get '/delete_clinic' do
	puts "\n******* delete_clinic *******"
	erb :delete_clinic
end
get '/delete_clinic/:id' do
	puts "\n******* delete_clinic *******"
	puts "params.inspect: #{params.inspect}"
	@clinic = Clinic.find params[:id].destroy
	redirect '/profile'
end


# ===== EMR =====
get '/emr' do
	puts "\n******* emr *******"
	erb :emr
end
# post '/EMR' do
#     puts "params: #{params.inspect}"
# 	Emr.create(
# 		diagnosis: params[:diagnosis],
# 		prognosis: params[:prognosis]
# 	)
# 	@emr = Emr.order("created_at").last
# 	puts "@emr:, #{@emr}"
# 	redirect '/Patients'
# end

# ===== Doctors =====
get '/doctors' do
	puts "\n******* doctors *******"
	erb :doctors
end
get '/doctors_form' do
	puts "\n******* doctors *******"
	erb :doctors_form
end
post '/doctors' do
    puts "params: #{params.inspect}"
	Doctor.create(
		clinic_id: params[:clinic_id],
		name: params[:name],
		speciality: params[:speciality]
	)
	@doctors = Doctor.order("created_at").last
	puts "@doctors:, #{@doctors}"
	redirect '/profile'
end

# ===== Patients =====
get '/patients' do
	puts "\n******* patients *******"
	erb :patients
end
get '/patients_form' do
	puts "\n******* patients *******"
	erb :patients_form
end
post '/patients' do
    puts "params: #{params.inspect}"
	Patient.create(
		emr_id: params[:emr_id],
		firstname: params[:firstname],
		lastname: params[:lastname]
	)
	@patients = Patient.order("created_at").last
	puts "@patients:, #{@patients}"
	redirect '/profile'
end

# ===== Appointments =====
get '/appointments' do
	puts "\n******* appointments *******"
	erb :appointments
end
# post '/Appointments' do
#     puts "params: #{params.inspect}"
# 	Appointment.create(
# 		doctor_id: params[:doctor_id]
# 		patient_id: params[:patient_id],
# 		start_datetime: params[:start_datetime],
# 		end_datetime: params[:end_datetime]
# 	)
# 	@appointments = Appointment.order("created_at").last
# 	puts "@appointments:, #{@appointments}"
# 	redirect '/'
# end
