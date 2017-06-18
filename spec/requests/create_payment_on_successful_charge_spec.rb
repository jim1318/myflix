require 'spec_helper'

describe "Create payment on successful charge", :vcr do
  let(:event_data) do
    {
      "object"=> {
        "id"=> "ch_1AW947LtUmfCvvw0prHhKvBh",
        "object"=> "charge",
        "amount"=> 999,
        "amount_refunded"=> 0,
        "application"=> nil,
        "application_fee"=> nil,
        "balance_transaction"=> "txn_1AW947LtUmfCvvw0KSDpFDmQ",
        "captured"=> true,
        "created"=> 1497814087,
        "currency"=> "usd",
        "customer"=> "cus_ArspDj2GhJrNZ6",
        "description"=> nil,
        "destination"=> nil,
        "dispute"=> nil,
        "failure_code"=> nil,
        "failure_message"=> nil,
        "fraud_details"=> {
        },
        "invoice"=> "in_1AW947LtUmfCvvw0tf78ymil",
        "livemode"=> false,
        "metadata"=> {
        },
        "on_behalf_of"=> nil,
        "order"=> nil,
        "outcome"=> {
          "network_status"=> "approved_by_network",
          "reason"=> nil,
          "risk_level"=> "normal",
          "seller_message"=> "Payment complete.",
          "type"=> "authorized"
        },
        "paid"=> true,
        "receipt_email"=> nil,
        "receipt_number"=> nil,
        "refunded"=> false,
        "refunds"=> {
          "object"=> "list",
          "data"=> [
          ],
          "has_more"=> false,
          "total_count"=> 0,
          "url"=> "/v1/charges/ch_1AW947LtUmfCvvw0prHhKvBh/refunds"
        },
        "review"=> nil,
        "shipping"=> nil,
        "source"=> {
          "id"=> "card_1AW945LtUmfCvvw0adfyI6jn",
          "object"=> "card",
          "address_city"=> nil,
          "address_country"=> nil,
          "address_line1"=> nil,
          "address_line1_check"=> nil,
          "address_line2"=> nil,
          "address_state"=> nil,
          "address_zip"=> "21321",
          "address_zip_check"=> "pass",
          "brand"=> "Visa",
          "country"=> "US",
          "customer"=> "cus_ArspDj2GhJrNZ6",
          "cvc_check"=> "pass",
          "dynamic_last4"=> nil,
          "exp_month"=> 4,
          "exp_year"=> 2024,
          "fingerprint"=> "SzhLE0ATgPling4i",
          "funding"=> "credit",
          "last4"=> "4242",
          "metadata"=> {
          },
          "name"=> nil,
          "tokenization_method"=> nil
        },
        "source_transfer"=> nil,
        "statement_descriptor"=> nil,
        "status"=> "succeeded",
        "transfer_group"=> nil
      }
    }
  end

  it "creates a payment with the webhook from stripe for charge succeeded", :vcr do
    response = post "/stripe_events", event_data
    binding.pry
    expect(Payment.count).to eq(1)
  end

  it "creates the payment associated wth user", :vcr do
    alice = Fabricate(:user, customer_token: "cus_ArspDj2GhJrNZ6")
    post "/stripe_events", event_data
    expect(Payment.first.user).to be(alice)
  end


end