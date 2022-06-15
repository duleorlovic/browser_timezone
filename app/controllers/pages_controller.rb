class PagesController < ApplicationController
  def index
    @change_timezone_form = ChangeTimezoneForm.new user: current_user
  end

  def sign_in_development
    return unless Rails.env.development?

    user = User.find params[:id]
    sign_in :user, user, bypass: true
    redirect_to params[:redirect_to] || root_path
  end

  def update_timezone
    @change_timezone_form = ChangeTimezoneForm.new _change_timezone_form_params
    if @change_timezone_form.save
      redirect_to root_path, notice: "Successfully updated"
    else
      redirect_to root_path, alert: "Failed to update #{@change_timezone_form.errors.full_messages.to_sentence}"
    end
  end

  def _change_timezone_form_params
    params.require(:change_timezone_form).permit(
      *ChangeTimezoneForm::FIELDS,
    ).merge(
      user: current_user,
    )
  end
end
