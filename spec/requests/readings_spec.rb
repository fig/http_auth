# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Readings", type: :request do
  before(:context) do
    Raspberry.create! unless Raspberry.any?
  end

  let(:raspberry_id) { Raspberry.first.id }
  let(:password) { "THBPBPTHPT!" }
  let(:headers) do
    {
      CONTENT_TYPE:
        "application/json",
      HTTP_AUTHORIZATION:
        ActionController::HttpAuthentication::Basic.encode_credentials(
          "pi",
          password
        )
    }
  end
  let(:params) do
    JSON.generate(reading: { raspberry_id: raspberry_id, temperature: 21 })
  end
  let(:make_request) { request }

  describe "POST /readings" do
    subject(:request) { post "/readings", headers: headers, params: params }

    context "when properly authenticated" do
      it "is successfull" do
        make_request
        expect(response).to have_http_status(200)
      end

      it "creates a new record" do
        expect { request }.to change { Reading.count }.by(1)
      end
    end

    context "when not authenticated" do
      let(:password) { "wrong!" }

      it "is denied" do
        make_request
        expect(response).to have_http_status(401)
      end

      it "doesn't create a new record" do
        expect { request }.not_to(change { Reading.count })
      end
    end

    context "with invalid data" do
      let(:params) do
        JSON.generate(reading: { raspberry_id: "missing" })
      end

      it "is denied" do
        make_request
        expect(response).to have_http_status(400)
      end

      it "doesn't create a new record" do
        expect { request }.not_to(change { Reading.count })
      end
    end
  end
end
