module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
  	return @json if @json
  	@json = JSON.parse(response.body)
    return @json unless @json.present? 
    if @json.is_a? Array
    	@json.map!(&:with_indifferent_access)
    else
    	@json = json.try(:with_indifferent_access)
    end
  end
end