class Event < ApplicationRecord

	AVAILABLE_STATUSES = %w(new ongoing finished)

	validates_datetime :end_at, on_or_after: :start_at, on_or_after_message: 'can not be before start date'
	validates :name, :place, length: { maximum: 250 }, presence: true
	validates :type, length: { maximum: 50 }, presence: true
	validates :status, inclusion: { in: AVAILABLE_STATUSES }

	validate :past_start_at

	def finished?
		status.to_sym == :finished
	end


	private

	def past_start_at
		return true if start_at > DateTime.now || finished? 
		errors.add(:start_at, 'can not be past')
	end
end
