class RecurringDonationsController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :load_recurring_donation, only: [:edit, :update, :destroy]

  def edit
    render 'donations/edit'
  end

  def destroy
    @donation.destroy

    flash[:success] = t('.destroy_success')

    redirect_to :back
  end

  private

  def load_recurring_donation
    @donation = current_user.recurring_donations.find(params[:id])
  end
end
