class ChargesController < ApplicationController
    
    def downgrade
        current_user.update_attributes(role:"standard")
        flash[:notice] = "You gave been cancelled, #{current_user.email}."
        redirect_to edit_user_registration_path(current_user)
    end
    
    def new
        @stripe_btn_data = {
            key: "#{ Rails.configuration.stripe[:publishable_key] }",
            description: "Better Membership - #{current_user.last_name}",
            amount: Amount.default
        }
    end
    
    def create
        @amount = 20
        
        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
        )
        
        charge = Stripe::Charge.create(
            customer: customer.id,
            amount: @amount,
            description: "Good Membership - #{current_user.email}",
            currency: 'usd'
        )
        
        flash[:notice] = "You upgraded, #{current_user.email}."
        
        current_user.update_attributes(role:"premium")
        redirect_to wikis_path
        
        rescue Stripe::CardError => e
            flash[:alert] = e.message
            redirect_to new_charge_path
        
    end
    
    class Amount
        def self.default
            15
        end
    end
end













