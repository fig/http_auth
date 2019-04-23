# frozen_string_literal: true

class ReadingsController < ApplicationController
  skip_forgery_protection only: :create

  # For security, credentials should be read from ENV or
  # Rails.application.credentials. Additionally, HTTP Basic Authentication, as
  # with any type of authentication, should only be used with a secure
  # connection (https).
  http_basic_authenticate_with name: "pi",
                               password: "THBPBPTHPT!",
                               only: :create

  def index
    @readings = Reading.all
  end

  def show
    @reading = Reading.find(params[:id])
  end

  # See end of this file for an example request
  def create
    Reading.create! reading_params
    head :created
  rescue ActiveRecord::RecordInvalid
    head :bad_request
  end

  def reading_params
    params.require(:reading).permit(:raspberry_id, :temperature)
  end
end

__END__
example request(copy and paste the lines below into a terminal)

curl \
--url     http://localhost:3000/readings \
--header  'Content-Type: application/json' \
--user    pi:THBPBPTHPT! \
--data    '{"reading": {"raspberry_id": "1", "temperature":"21"}}' \
