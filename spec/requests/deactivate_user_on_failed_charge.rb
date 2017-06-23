require 'spec_helper'

describe "Deactivate user on failed charge" do
  let(:event_data) do
    {
      "id"=> "evt_1AWTktLtUmfCvvw0i3TDg2ai",
      "object"=> "event",
      "api_version"=> "2017-06-05",
      "created"=> 1497893619,
      "data"=> {
        "object"=> {
          "id"=> "ch_1AWTksLtUmfCvvw0g9tp2X2h",
          "object"=> "charge",
          "amount"=> 999,
          "amount_refunded"=> 0,
          "application"=> nil,
          "application_fee"=> nil,
          "balance_transaction"=> nil,
          "captured"=> false,
          "created"=> 1497893618,
          "currency"=> "usd",
          "customer"=> "cus_Arx4MmmVbtO6go",
          "description"=> "payment to fail",
          "destination"=> nil,
          "dispute"=> nil,
          "failure_code"=> "card_declined",
          "failure_message"=> "Your card was declined.",
          "fraud_details"=> {
          },
          "invoice"=> nil,
          "livemode"=> false,
          "metadata"=> {
          },
          "on_behalf_of"=> nil,
          "order"=> nil,
          "outcome"=> {
            "network_status"=> "declined_by_network",
            "reason"=> "generic_decline",
            "risk_level"=> "normal",
            "seller_message"=> "The bank did not return any further details with this decline.",
            "type"=> "issuer_declined"
          },
          "paid"=> false,
          "receipt_email"=> nil,
          "receipt_number"=> nil,
          "refunded"=> false,
          "refunds"=> {
            "object"=> "list",
            "data"=> [

            ],
            "has_more"=> false,
            "total_count"=> 0,
            "url"=> "/v1/charges/ch_1AWTksLtUmfCvvw0g9tp2X2h/refunds"
          },
          "review"=> nil,
          "shipping"=> nil,
          "source"=> {
            "id"=> "card_1AWTkDLtUmfCvvw08o49fyon",
            "object"=> "card",
            "address_city"=> nil,
            "address_country"=> nil,
            "address_line1"=> nil,
            "address_line1_check"=> nil,
            "address_line2"=> nil,
            "address_state"=> nil,
            "address_zip"=> nil,
            "address_zip_check"=> nil,
            "brand"=> "Visa",
            "country"=> "US",
            "customer"=> "cus_Arx4MmmVbtO6go",
            "cvc_check"=> "pass",
            "dynamic_last4"=> nil,
            "exp_month"=> 11,
            "exp_year"=> 2018,
            "fingerprint"=> "3G6tvZJH1xGpx9e3",
            "funding"=> "credit",
            "last4"=> "0341",
            "metadata"=> {
            },
            "name"=> nil,
            "tokenization_method"=> nil
          },
          "source_transfer"=> nil,
          "statement_descriptor"=> nil,
          "status"=> "failed",
          "transfer_group"=> nil
        }
      },
      "livemode"=> false,
      "pending_webhooks"=> 1,
      "request"=> {
        "id"=> "req_AsEDfj7qKBPY90",
        "idempotency_key"=> nil
      },
      "type"=> "charge.failed"
    }
  end

  it "deactives a user with webhool from failed stripe charge", :vcr do
    alice = Fabricate(:user, customer_token: "cus_Arx4MmmVbtO6go")
    post "/stripe_events", event_data
    expect(alice.reload).not_to be_active
  end



end
