class RentalPresenter < SimpleDelegator
  delegate :content_tag, to: :helper

  def initialize(rental)
    super(rental)
  end

  def status
    if scheduled?

      content_tag :span, class: "badge badge-primary" do
        'agendada'
      end
    end
  end

  private

  def helper
    ApplicationController.helpers
  end
end