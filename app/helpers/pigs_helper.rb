module PigsHelper
  def select_pig_status_field(form)
    statuses = Pig::STATUSES.map do |s, v|
      [I18n.t(s, :scope => [:view, :pigs, :status]), v]
    end

    form.select :status, statuses, :prompt => true
  end

  def show_next_expected_delivery_date
    t(
      :next_expected_delivery_date,
      :date => l(@pig.next_expected_delivery_date, :format => :long),
      :scope => [:view, :pigs]
    )
  end
end