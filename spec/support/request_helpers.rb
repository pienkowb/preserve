module RequestHelpers
  def json_response
    @json_response ||= begin
      JSON.parse(response.body).with_indifferent_access
    end
  end
end
